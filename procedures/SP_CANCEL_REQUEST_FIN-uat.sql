create or replace PROCEDURE "SP_CANCEL_REQUEST_FIN"
(
p_employeeCode nvarchar2,
p_request_id number
)
is
l_token_type NVARCHAR2(2000);
l_body NVARCHAR2(2000);
l_response clob;
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
n_approve_date NVARCHAR2(200);
n_carry_forward_code nvarchar2(200);
n_employee_email NVARCHAR2(200);     -- email để send
n_full_name NVARCHAR2(200);

rsp_status NVARCHAR2(10);

BEGIN
    SELECT TO_CHAR(SYSDATE, 'MM/DD/YYYY') INTO n_approve_date FROM DUAL;
    SELECT VALUE INTO n_token_value FROM APPLICATIONS_CONFIGS WHERE KEY = 'TOKEN' AND ROWNUM = 1;
    SP_GET_TOKEN(n_token);
    apex_web_service.g_request_headers.delete();    
    apex_web_service.g_request_headers(1).name := 'Authorization';
    apex_web_service.g_request_headers(1).value := 'Bearer '|| n_token;
    
    apex_web_service.g_request_headers(2).name := 'Content-Type';
    apex_web_service.g_request_headers(2).value := 'application/json; charset=utf-8';
    
    for rec in (select er.*,emp.DATAAREA,age.DAY_APPROVE,age.BENEFIT_ACCRUAL_PLAN,age.HRM_ABSENCE_CODE_GROUP_ID,age.HRM_ABSENCE_CODE_ID,age.CARRY_FORWORD_EXP_DATE,age.CARRY_FORWARD_CODE,
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
        end as ALLDAY
        from EMPLOYEE_REQUESTS er join ABSENCE_GROUP_EMPLOYEE age on er.EMPLOYEE_CODE_REQ = age.EMPLOYEE_CODE
        join EMPLOYEES emp on emp.EMPLOYEE_CODE = age.EMPLOYEE_CODE
        where er.ID = p_request_id and emp.EMPLOYEE_CODE = p_employeeCode -- and EXPIRATION_DATE >= to_char(sysdate,'MM/DD/YYYY')
        AND (er.BENEFIT_CODE = age.BENEFIT_ACCRUAL_PLAN or er.BENEFIT_CODE = age.CF_BENEFIT_ACCRUAL_PLAN)
    )loop

    if rec.CARRY_FORWORD_EXP_DATE >= to_char(sysdate,'MM/DD/YYYY') then
        n_carry_forward_code := rec.CARRY_FORWARD_CODE;
    else
        n_carry_forward_code := rec.HRM_ABSENCE_CODE_ID;
    end if;

    l_body := '{
    "_jsonRequest":{
        "LegalEntityID": "'||rec.DATAAREA||'",
        "AdjustedHours": "'||to_char(rec.TOTAL_DAYS,'90.9')||'",
        "AdjustmentType": "'||rec.ADJUSTMENTTYPE||'",
        "TransactionDate": "'||rec.FROM_DATE||'",
        "Description": "'||rec.NOTE||'",
        "EmployeeCode": "'||p_employeeCode||'", 
        "AccrualId": "'||rec.BENEFIT_CODE ||'", 
        "IDStrPortal": "'||rec.ID||'",
        "FromDate": "'||rec.FROM_DATE||'",
        "ToDate": "'||rec.END_DATE||'",
        "NumberDayOff": "'||to_char(rec.TOTAL_DAYS,'90.9')||'",
        "StartTime": "'|| CASE when (rec.START_TIME is null or rec.START_TIME = '') THEN '' ELSE (rec.START_TIME||':00') END || '",
        "EndTime": "'|| CASE when (rec.END_TIME is null or rec.END_TIME = '') THEN '' ELSE (rec.END_TIME||':00') END || '",
        "HRMAbsenceCodeGroupId": "'|| CASE WHEN rec.LEAVE_TYPE = 'APL' Then 'Leave' else rec.LEAVE_TYPE END ||'",
        "HRMAbsenceCodeId": "'|| CASE WHEN lower(rec.BENEFIT_CODE) not like 'alcf%' THEN rec.HRM_ABSENCE_CODE_ID ELSE rec.CARRY_FORWARD_CODE END  ||'",
        "AllDay": "'||rec.ALLDAY||'"
    }}';
    -- l_body := '{
    -- "_jsonRequest":{
    --     "LegalEntityID": "'||rec.DATAAREA||'",
    --     "AdjustedHours": "'||to_char(rec.TOTAL_DAYS,'90.9')||'",
    --     "AdjustmentType": "'||rec.ADJUSTMENTTYPE||'",
    --     "TransactionDate": "'||rec.FROM_DATE||'",
    --     "Description": "'||rec.NOTE||'",
    --     "EmployeeCode": "'||p_employeeCode||'", 
    --     "AccrualId": "'||rec.BENEFIT_CODE ||'", 
    --     "IDStrPortal": "'||rec.ID||'",
    --     "FromDate": "'||rec.FROM_DATE||'",
    --     "ToDate": "'||rec.END_DATE||'",
    --     "NumberDayOff": "'||to_char(rec.TOTAL_DAYS,'90.9')||'",
    --     "StartTime": "'||rec.START_TIME||':00",
    --     "EndTime": "'||rec.END_TIME||':00",
    --     "HRMAbsenceCodeGroupId": "'|| CASE WHEN rec.HRM_ABSENCE_CODE_GROUP_ID = 'APL' Then 'Leave' else rec.HRM_ABSENCE_CODE_GROUP_ID END ||'",
    --     "HRMAbsenceCodeId": "'||n_carry_forward_code||'",
    --     "AllDay": "'||rec.ALLDAY||'"
    -- }}';

    end loop;

/*
        "LegalEntityID": "V01",
        "AdjustedHours": "1",
        "AdjustmentType": "Amount used",
        "TransactionDate": "8/21/2023",
        "Description": "Test API 5823",
        "EmployeeCode": "488", 
        "AccrualId": "ALCF12 2022 Jan", // ALPL12 2023 (thuoc goi loai phep)
        "IDPortal": "15",
        "FromDate": "8/21/2023",
        "ToDate": "8/21/2023",
        "NumberDayOff": "1",
        "StartTime": "00:00:00",
        "EndTime": "00:00:00",
        "HRMAbsenceCodeGroupId": "APL",
        "HRMAbsenceCodeId": "AL12",
        "AllDay": "Yes"
*/       
        DBMS_OUTPUT.put_line(l_body);
        --APEX_JSON.parse(

        l_response := apex_web_service.make_rest_request(
                p_url => global_vars.get_resource_url || '//api/services/VUSTC_AbsenceGroupEmployeeServiceGroup/AbsenceGroupEmployeeService/CancelLeaverequest',
                p_http_method => 'POST',
                p_body => l_body,
                p_transfer_timeout => 3600
                ) ;

    -- print response 
    DBMS_OUTPUT.put_line('');
    DBMS_OUTPUT.put_line(l_response);
    APEX_JSON.parse(l_response);

    -- Get the value of the response Status 
    rsp_status := apex_json.get_varchar2('Status', 1);
    
    -- update status of request 
    UPDATE EMPLOYEE_REQUESTS SET INSERTED_STATUS = TO_NUMBER(rsp_status) WHERE ID = p_request_id;
    UPDATE EMPLOYEE_REQUESTS SET EMP_REQ_STATUS = 5 WHERE ID = p_request_id and rsp_status = '1';

    -- SP_GET_ONE_ABSENCE_GROUP_EMPLOYEE(p_employeeCode);
    SELECT USER_NAME, FULL_NAME INTO n_employee_email, n_full_name FROM EMPLOYEES WHERE EMPLOYEE_CODE = p_employeeCode;
    
    -- Restore balance days, update used day
    IF rsp_status = '1' THEN
        FOR REC IN (SELECT 
                        CRF_DAY_TEMP, ANNUAL_DAY_TEMP, EMPLOYEE_CODE_REQ, BENEFIT_CODE, TOTAL_DAYS, FROM_DATE,
                        case 
                            when ALL_DAY like 'N' then FROM_DATE -- Set END_DATE to FROM_DATE if ALLDAY is 'N'
                            else END_DATE
                        end as MODIFIED_END_DATE 
                    FROM 
                        EMPLOYEE_REQUESTS ER 
                    WHERE 
                        ID = p_request_id
                    )LOOP

            UPDATE ABSENCE_GROUP_EMPLOYEE AGE
            SET
                CARRY_FORWARD_USED = CARRY_FORWARD_USED - REC.CRF_DAY_TEMP,
                CARRY_FORWARD_AVALABLE = CARRY_FORWARD_AVALABLE + REC.CRF_DAY_TEMP,
                AVAILABLE = AVAILABLE + REC.ANNUAL_DAY_TEMP,
                PLAN_YEAR_USED = PLAN_YEAR_USED - REC.ANNUAL_DAY_TEMP
            WHERE
                EMPLOYEE_CODE = REC.EMPLOYEE_CODE_REQ
                AND AGE.BENEFIT_ACCRUAL_PLAN = REC.BENEFIT_CODE;

            SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', n_employee_email, 'Leave Request Approved', '<p> Dear '|| n_full_name ||', </p>' ||
            -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'thviet615@gmail.com', 'Leave Request Approved', '<p> Dear '|| n_full_name ||', </p>' ||
                                '<p>Your leave request has been canceled. Here are the details:</p>' ||
                                '<p> Employee Code: '|| p_employeeCode ||' </p>' ||
                                '<p> Total Days: '|| CASE
                                                    WHEN REC.TOTAL_DAYS < 1 THEN to_char(REC.TOTAL_DAYS, '9.9')
                                                    ELSE REC.TOTAL_DAYS
                                                    END ||' </p>' ||
                                '<p> From Date: '|| rec.FROM_DATE ||' </p>' ||
                                '<p> To Date: '|| rec.MODIFIED_END_DATE ||' </p>' ||
                                -- '<br>' || 
                                -- '<p>Feel free to proceed with your leave plans accordingly.</p>' ||
                                -- '<br>' || 
                                '<p> If you have any questions or need further assistance, please feel free to reach out to the HR department. </p>' ||
                                '<br>' || 
                                '<p> Thank you, </p>' ||
                                '<p> VUS </p>');
        END LOOP;
    END IF;

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
        'CancelLeaverequest', -- Endpoint you just called
        apex_web_service.g_request_headers(1).value, -- This is a simplification, you may need to concatenate all headers
        l_body, -- The request body you sent
        apex_web_service.g_status_code, -- Response status code
        l_response, -- The response body you received
        SYSDATE, -- The current timestamp
        'id=' || p_request_id || ' employeeCode=' || p_employeeCode || ' status=' || rsp_status -- Any additional notes
    );

    COMMIT; -- Commit the transaction to save the log

END;
/