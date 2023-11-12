create or replace PROCEDURE "SP_CREATE_REQUEST_FIN_BOTH"
(
p_employeeCode nvarchar2,
p_request_id number
)
is
l_token_type NVARCHAR2(2000);
l_body_annual NVARCHAR2(2000);
l_response_annual clob;
l_response_crf clob;
l_response_clob clob;
l_numrow number;
l_rowsub number;
l_body_mail NVARCHAR2(2000);
n_id number;
n_employeeCode NVARCHAR2(200);
n_legal_entity NVARCHAR2(200);
n_request_type_name NVARCHAR2(200);
n_personal_email NVARCHAR2(200);
n_token_value NVARCHAR2(2000);
n_token NVARCHAR2(5000);
n_approve_date nvarchar2(200);
n_carry_forward_code nvarchar2(200);
n_accrual_id nvarchar2(100);
n_total_day number:= 0;
n_extra_id number;
l_body_crf nvarchar2(2000);
l_job_name VARCHAR2(30);
rsp_status VARCHAR2(30);

BEGIN

    SELECT TO_CHAR(SYSDATE, 'MM/DD/YYYY') INTO n_approve_date FROM DUAL;
    SELECT VALUE INTO n_token_value FROM APPLICATIONS_CONFIGS WHERE KEY = 'TOKEN' AND ROWNUM = 1;
    SP_GET_TOKEN(n_token);
    apex_web_service.g_request_headers.delete();    
    apex_web_service.g_request_headers(1).name := 'Authorization';
    apex_web_service.g_request_headers(1).value := 'Bearer '|| n_token;
    
    apex_web_service.g_request_headers(2).name := 'Content-Type';
    apex_web_service.g_request_headers(2).value := 'application/json; charset=utf-8';

    n_extra_id := p_request_id + 1;

    
    for rec in (select er.*,emp.DATAAREA,age.DAY_APPROVE,age.BENEFIT_ACCRUAL_PLAN,age.HRM_ABSENCE_CODE_GROUP_ID,
    age.HRM_ABSENCE_CODE_ID,age.CARRY_FORWORD_EXP_DATE,age.CARRY_FORWARD_CODE,age.CF_BENEFIT_ACCRUAL_PLAN,age.CARRY_FORWARD_AVALABLE,
        case 
        when age.HRM_ABSENCE_CODE_ID like 'ALPL%' then
            'Amount Used'
        when age.HRM_ABSENCE_CODE_ID like 'ALCF%' then
            'Amount Used'
        else
            null
        end as ADJUSTMENTTYPE,
        case 
        when er.ALL_DAY like 'Y' then
            'Yes'
        else
            'No'
        end as ALLDAY,
        case 
            when age.HRM_ABSENCE_CODE_GROUP_ID = 'APL' then
                'Leave'
        end as CONVERTED_HRM_ABSENCE_CODE_GROUP_ID,
        case 
            when er.ALL_DAY like 'N' then er.FROM_DATE -- Set END_DATE to FROM_DATE if ALLDAY is 'N'
            else er.END_DATE
        end as MODIFIED_END_DATE

        from EMPLOYEE_REQUESTS er join ABSENCE_GROUP_EMPLOYEE age on er.EMPLOYEE_CODE_REQ = age.EMPLOYEE_CODE
        join EMPLOYEES emp on emp.EMPLOYEE_CODE = age.EMPLOYEE_CODE
        where er.REQUEST_ID = p_request_id and emp.EMPLOYEE_CODE = p_employeeCode and EXPIRATION_DATE >= to_char(sysdate,'MM/DD/YYYY')
    )loop

l_body_annual := '{
    "_jsonRequest":{
        "LegalEntityID": "'||rec.DATAAREA||'",
        "AdjustedHours": "'||to_char(rec.ANNUAL_DAY_TEMP,'90.9')||'",
        "AdjustmentType": "'||rec.ADJUSTMENTTYPE||'",
        "TransactionDate": "'||rec.FROM_DATE||'",
        "Description": "'||rec.NOTE||'",
        "EmployeeCode": "'||p_employeeCode||'", 
        "AccrualId": "'||rec.BENEFIT_ACCRUAL_PLAN||'", 
        "IDPortal": "'||n_extra_id||'",
        "IDStrPortal": "'||rec.REQUEST_ID|| 'PL' ||'",
        "FromDate": "'||rec.FROM_DATE||'",
        "ToDate": "'||rec.MODIFIED_END_DATE||'",
        "NumberDayOff": "'||to_char(rec.ANNUAL_DAY_TEMP,'90.9')||'",
        "StartTime": "'||rec.START_TIME||':00",
        "EndTime": "'||rec.END_TIME||':00",
        "HRMAbsenceCodeGroupId": "'||rec.CONVERTED_HRM_ABSENCE_CODE_GROUP_ID||'",
        "HRMAbsenceCodeId": "'||rec.HRM_ABSENCE_CODE_ID||'",
        "AllDay": "'||rec.ALLDAY||'",
        "AttachmentURL": "'||rec.ATTATCH_FILE||'"

    }}';

l_body_crf := '{
    "_jsonRequest":{
        "LegalEntityID": "'||rec.DATAAREA||'",
        "AdjustedHours": "'||to_char(rec.CRF_DAY_TEMP,'90.9')||'",
        "AdjustmentType": "'||rec.ADJUSTMENTTYPE||'",
        "TransactionDate": "'||rec.FROM_DATE||'",
        "Description": "'||rec.NOTE||'",
        "EmployeeCode": "'||p_employeeCode||'", 
        "AccrualId": "'||rec.CF_BENEFIT_ACCRUAL_PLAN||'", 
        "IDPortal": "'||rec.REQUEST_ID||'",
        "IDStrPortal": "'||rec.REQUEST_ID||'",
        "FromDate": "'||rec.FROM_DATE||'",
        "ToDate": "'||rec.MODIFIED_END_DATE||'",
        "NumberDayOff": "'||to_char(rec.CRF_DAY_TEMP,'90.9')||'",
        "StartTime": "'||rec.START_TIME||':00",
        "EndTime": "'||rec.END_TIME||':00",
        "HRMAbsenceCodeGroupId": "'||rec.CONVERTED_HRM_ABSENCE_CODE_GROUP_ID||'",
        "HRMAbsenceCodeId": "'||rec.CARRY_FORWARD_CODE||'",
        "AllDay": "'||rec.ALLDAY||'",
        "AttachmentURL": "'||rec.ATTATCH_FILE||'"
    }}';
    end loop;


    -- Create an extra leave
    -- INSERT INTO EMPLOYEE_REQUESTS(IS_EXTRA) VALUES(1);
    INSERT INTO EMPLOYEE_REQUESTS
    (
        ID,
        REQUESTOR_ID,
        REQUEST_ID,
        EMPLOYEE_CODE_REQ,
        EMPLOYEE_NAME,
        FROM_DATE,
        END_DATE,
        ALL_DAY,
        NOTE,
        TOTAL_DAYS,
        EMP_REQ_STATUS,
        TYPE,
        IS_DEL,
        MAN_RES_STATUS,
        RESPONSER_ID,
        LEAVE_TYPE,
        TARGET_CODE,
        START_TIME,
        END_TIME,
        SUBMIT_DATE,
        BENEFIT_CODE,
        CRF_DAY_TEMP,
        ANNUAL_DAY_TEMP,
        ATTACH_NAME,
        ATTATCH_FILE,
        ID_ROOT,
        IS_D365,
        LEAVE_BALANCE,
        INSERTED_STATUS
    )
    SELECT NULL,
           REQUESTOR_ID,
           REQUEST_ID + 1,
           EMPLOYEE_CODE_REQ,
           EMPLOYEE_NAME,
           FROM_DATE,
           END_DATE,
           ALL_DAY,
           NOTE,
           TOTAL_DAYS,
        --    EMP_REQ_STATUS,
           3,
           TYPE,
           IS_DEL,
           MAN_RES_STATUS,
           RESPONSER_ID,
           LEAVE_TYPE,
           TARGET_CODE,
           START_TIME,
           END_TIME,
           SUBMIT_DATE,
           BENEFIT_CODE,
           CRF_DAY_TEMP,
           ANNUAL_DAY_TEMP,
           ATTACH_NAME,
           ATTATCH_FILE, 
           'EX',
           IS_D365,
           LEAVE_BALANCE,
           INSERTED_STATUS
    FROM EMPLOYEE_REQUESTS
    WHERE ID = p_request_id;

    -- UPDATE EMPLOYEE_REQUESTS SET EMP_REQ_STATUS = 3 WHERE ID = p_request_id;
    -- Set status the extra leave too

    
    COMMIT;
     
        DBMS_OUTPUT.put_line('body crf: ');
        DBMS_OUTPUT.put_line(l_body_crf);
        DBMS_OUTPUT.put_line('body annual: ');
        DBMS_OUTPUT.put_line(l_body_annual);

        l_response_crf := apex_web_service.make_rest_request(
                p_url => 'https://hra.sandbox.operations.dynamics.com//api/services/VUSTC_AbsenceGroupEmployeeServiceGroup/AbsenceGroupEmployeeService/CreateLeaverequest',
                p_http_method => 'POST',
                p_body => l_body_crf,
                p_transfer_timeout => 3600
        ) ;

        l_response_annual := apex_web_service.make_rest_request(
                p_url => 'https://hra.sandbox.operations.dynamics.com//api/services/VUSTC_AbsenceGroupEmployeeServiceGroup/AbsenceGroupEmployeeService/CreateLeaverequest',
                p_http_method => 'POST',
                p_body => l_body_annual,
                p_transfer_timeout => 3600
        );

        DBMS_OUTPUT.put_line('');
        DBMS_OUTPUT.put_line(l_response_crf);

        DBMS_OUTPUT.put_line('');
        DBMS_OUTPUT.put_line(l_response_annual);

        APEX_JSON.parse(l_response_crf);
        rsp_status := apex_json.get_varchar2('Status', 1);

        UPDATE EMPLOYEE_REQUESTS SET INSERTED_STATUS = TO_NUMBER(rsp_status) WHERE ID = p_request_id;
        UPDATE EMPLOYEE_REQUESTS SET EMP_REQ_STATUS = 3 WHERE ID = p_request_id and rsp_status = '1';
        UPDATE EMPLOYEE_REQUESTS SET EMP_REQ_STATUS = 3 WHERE ID = p_request_id + 1 and rsp_status = '1';

        -- Write API Logs
        -- Insert the log entry after you receive the response
        INSERT INTO LOGS_API_RESPONSE (
            API_ENDPOINT,
            REQUEST_HEADERS,
            REQUEST_BODY,
            RESPONSE_CODE,
            RESPONSE_BODY,
            CALL_TIMESTAMP,
            NOTE
        ) VALUES (
            'CreateLeaverequest_BOTH', -- Endpoint you just called
            apex_web_service.g_request_headers(1).value, -- This is a simplification, you may need to concatenate all headers
            l_body_crf, -- The request body you sent
            apex_web_service.g_status_code, -- Response status code
            l_response_crf, -- The response body you received
            SYSDATE, -- The current timestamp
            'leave_cf | id=' || p_request_id || ' employeeCode=' || p_employeeCode || ' status=' || rsp_status -- Any additional notes
        );

        APEX_JSON.parse(l_response_annual);
        rsp_status := apex_json.get_varchar2('Status', 1);

        -- Log for annual leave
        INSERT INTO LOGS_API_RESPONSE (
            API_ENDPOINT,
            REQUEST_HEADERS,
            REQUEST_BODY,
            RESPONSE_CODE,
            RESPONSE_BODY,
            CALL_TIMESTAMP,
            NOTE
        ) VALUES (
            'CreateLeaverequest_BOTH', -- Endpoint you just called
            apex_web_service.g_request_headers(1).value, -- This is a simplification, you may need to concatenate all headers
            l_body_annual, -- The request body you sent
            apex_web_service.g_status_code, -- Response status code
            l_response_annual, -- The response body you received
            SYSDATE, -- The current timestamp
            'leave_al | id=' || p_request_id || ' employeeCode=' || p_employeeCode || ' status=' || rsp_status -- Any additional notes
        );

        COMMIT; -- Commit the transaction to save the log


    /*
        SELECT USER_NAME INTO n_personal_email FROM EMPLOYEES WHERE EMPLOYEE_CODE = (SELECT MANAGER_ID FROM EMPLOYEES WHERE EMPLOYEE_CODE = p_employeeCode) AND NVL(USER_NAME, '0') <> '0';
        --n_personal_email := email của e;
        -- "To":"'||n_personal_email||'"
        If n_personal_email IS not null Then
            l_body_mail := ' {
                            "Subject":"Approved your Leave",
                            "Body":"New leave request from Portal",
                            "To":"'||n_personal_email||'"
                        }';
            --TYPE_ID = 1  send email & MS Team
            apex_web_service.g_request_headers.delete();    
            apex_web_service.g_request_headers(1).name := 'Content-Type';
            apex_web_service.g_request_headers(1).value := 'application/json';
            l_response_clob :=  apex_web_service.make_rest_request(
                p_url => 'https://prod-28.southeastasia.logic.azure.com:443/workflows/19209291fb794176bf9eb96962a61e43/triggers/manual/paths/invoke?api-version=2016-06-01&sp=%2Ftriggers%2Fmanual%2Frun&sv=1.0&sig=QJkv0x-JiuX5wV0UWIonmF0ZG_9IWKE1kfO5J81DhrU',
                p_http_method => 'POST',
                p_body => l_body_mail,
                p_transfer_timeout => 3600
                );
        End If;
    */  
END;
/