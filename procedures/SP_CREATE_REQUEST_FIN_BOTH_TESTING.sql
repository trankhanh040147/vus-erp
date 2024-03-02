create or replace PROCEDURE "SP_CREATE_REQUEST_FIN_BOTH_TESTING"
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
n_full_name NVARCHAR2(200);
n_company_email NVARCHAR2(200);
n_request_type_name NVARCHAR2(200);
n_personal_email NVARCHAR2(200);
n_token_value NVARCHAR2(2000);
n_token NVARCHAR2(5000);
n_approve_date nvarchar2(200);
n_carry_forward_code nvarchar2(200);
n_accrual_id nvarchar2(100);
n_total_day number:= 0;
n_extra_id number;
n_from_date_pl date;
n_to_date_pl date;
n_from_date_crf date;
n_to_date_crf date;
l_body_crf nvarchar2(2000);
l_job_name VARCHAR2(30);
rsp_status VARCHAR2(30);

v_body clob := ''; -- body of mail


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
            -- null     cũ
            'Amount Used'       -- 29/2/24-Viet
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

        from EMPLOYEE_REQUESTS er 
        join ABSENCE_GROUP_EMPLOYEE age on er.EMPLOYEE_CODE_REQ = age.EMPLOYEE_CODE
        join EMPLOYEES emp on emp.EMPLOYEE_CODE = age.EMPLOYEE_CODE
        where er.ID = p_request_id and emp.EMPLOYEE_CODE = p_employeeCode 
        and lower(er.LEAVE_TYPE) = lower(age.HRM_ABSENCE_CODE_GROUP_ID)
    )loop

        -- calculate from date and end date of both leave
        n_from_date_crf := rec.FROM_DATE;
        n_to_date_pl := rec.MODIFIED_END_DATE;

        n_to_date_crf := n_from_date_crf + INTERVAL '1' DAY * (rec.CRF_DAY_TEMP-1);
        n_from_date_pl := n_to_date_crf + INTERVAL '1' DAY;

l_body_annual := '{
    "_jsonRequest":{
        "LegalEntityID": "'||rec.DATAAREA||'",
        "AdjustedHours": "'||TRIM(to_char(rec.ANNUAL_DAY_TEMP,'90.9'))||'",
        "AdjustmentType": "'||rec.ADJUSTMENTTYPE||'",
        "TransactionDate": "'||n_from_date_pl||'",
        "Description": "'||rec.NOTE || ' PL' ||'",
        "EmployeeCode": "'||p_employeeCode||'", 
        "AccrualId": "'||rec.BENEFIT_ACCRUAL_PLAN||'", 
        "IDStrPortal": "'||rec.ID|| 'PL' ||'",
        "FromDate": "'||n_from_date_pl||'",
        "ToDate": "'||n_to_date_pl||'",
        "NumberDayOff": "'||TRIM(to_char(rec.ANNUAL_DAY_TEMP,'90.9'))||'",
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
        "AdjustedHours": "'||TRIM(to_char(rec.CRF_DAY_TEMP,'90.9'))||'",
        "AdjustmentType": "'||rec.ADJUSTMENTTYPE||'",
        "TransactionDate": "'||n_from_date_crf||'",
        "Description": "'||rec.NOTE||'",
        "EmployeeCode": "'||p_employeeCode||'", 
        "AccrualId": "'||rec.CF_BENEFIT_ACCRUAL_PLAN||'", 
        "IDStrPortal": "'||rec.ID||'",
        "FromDate": "'||n_from_date_crf||'",
        "ToDate": "'||n_to_date_crf||'",
        "NumberDayOff": "'||TRIM(to_char(rec.CRF_DAY_TEMP,'90.9'))||'",
        "StartTime": "'||rec.START_TIME||':00",
        "EndTime": "'||rec.END_TIME||':00",
        "HRMAbsenceCodeGroupId": "'||rec.CONVERTED_HRM_ABSENCE_CODE_GROUP_ID||'",
        "HRMAbsenceCodeId": "'||rec.CARRY_FORWARD_CODE||'",
        "AllDay": "'||rec.ALLDAY||'",
        "AttachmentURL": "'||rec.ATTATCH_FILE||'"
    }}';
    -- -- tesst
    -- dbms_output.put_line(rec.ADJUSTMENTTYPE);
    -- dbms_output.put_line(rec.DATAAREA);
    end loop;


    -- Create an extra leave
    -- INSERT INTO EMPLOYEE_REQUESTS(IS_EXTRA) VALUES(1);
    
    -- INSERT INTO EMPLOYEE_REQUESTS
    -- (
    --     ID,
    --     REQUESTOR_ID,
    --     REQUEST_ID,
    --     EMPLOYEE_CODE_REQ,
    --     EMPLOYEE_NAME,
    --     FROM_DATE,
    --     END_DATE,
    --     ALL_DAY,
    --     NOTE,
    --     TOTAL_DAYS,
    --     EMP_REQ_STATUS,
    --     TYPE,
    --     IS_DEL,
    --     MAN_RES_STATUS,
    --     RESPONSER_ID,
    --     LEAVE_TYPE,
    --     TARGET_CODE,
    --     START_TIME,
    --     END_TIME,
    --     SUBMIT_DATE,
    --     BENEFIT_CODE,
    --     CRF_DAY_TEMP,
    --     ANNUAL_DAY_TEMP,
    --     ATTACH_NAME,
    --     ATTATCH_FILE,
    --     ID_ROOT,
    --     IS_D365,
    --     LEAVE_BALANCE,
    --     INSERTED_STATUS
    -- )
    -- SELECT NULL,
    --        REQUESTOR_ID,
    --        REQUEST_ID + 1,
    --        EMPLOYEE_CODE_REQ,
    --        EMPLOYEE_NAME,
    --        FROM_DATE,
    --        END_DATE,
    --        ALL_DAY,
    --        NOTE,
    --        TOTAL_DAYS,
    --     --    EMP_REQ_STATUS,
    --        3,
    --        TYPE,
    --        IS_DEL,
    --        MAN_RES_STATUS,
    --        RESPONSER_ID,
    --        LEAVE_TYPE,
    --        TARGET_CODE,
    --        START_TIME,
    --        END_TIME,
    --        SUBMIT_DATE,
    --        BENEFIT_CODE,
    --        CRF_DAY_TEMP,
    --        ANNUAL_DAY_TEMP,
    --        ATTACH_NAME,
    --        ATTATCH_FILE, 
    --        'EX',
    --        IS_D365,
    --        LEAVE_BALANCE,
    --        INSERTED_STATUS
    -- FROM EMPLOYEE_REQUESTS
    -- WHERE ID = p_request_id;

    -- UPDATE EMPLOYEE_REQUESTS SET EMP_REQ_STATUS = 3 WHERE ID = p_request_id;
    -- Set status the extra leave too

    
    COMMIT;
     
        DBMS_OUTPUT.put_line('body crf: ');
        DBMS_OUTPUT.put_line(l_body_crf);
        DBMS_OUTPUT.put_line('body annual: ');
        DBMS_OUTPUT.put_line(l_body_annual);

END;
/