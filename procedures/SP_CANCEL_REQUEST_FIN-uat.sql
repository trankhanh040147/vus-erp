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
        "StartTime": "'||rec.START_TIME||':00",
        "EndTime": "'||rec.END_TIME||':00",
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

        -- l_response := apex_web_service.make_rest_request(
        --         p_url => global_vars.get_resource_url || '//api/services/VUSTC_AbsenceGroupEmployeeServiceGroup/AbsenceGroupEmployeeService/CancelLeaverequest',
        --         p_http_method => 'POST',
        --         p_body => l_body,
        --         p_transfer_timeout => 3600
        --         ) ;

    -- SP_GET_ONE_ABSENCE_GROUP_EMPLOYEE(p_employeeCode);
    
    -- Restore balance days, update used day
    FOR REC IN (SELECT CRF_DAY_TEMP, ANNUAL_DAY_TEMP, EMPLOYEE_CODE_REQ, BENEFIT_CODE FROM EMPLOYEE_REQUESTS ER WHERE ID = p_request_id)LOOP

    UPDATE ABSENCE_GROUP_EMPLOYEE AGE
    SET
        CARRY_FORWARD_USED = CARRY_FORWARD_USED - REC.CRF_DAY_TEMP,
        CARRY_FORWARD_AVALABLE = CARRY_FORWARD_AVALABLE + REC.CRF_DAY_TEMP,
        AVAILABLE = AVAILABLE + REC.ANNUAL_DAY_TEMP,
        PLAN_YEAR_USED = PLAN_YEAR_USED - REC.ANNUAL_DAY_TEMP
    WHERE
        EMPLOYEE_CODE = REC.EMPLOYEE_CODE_REQ
        AND AGE.BENEFIT_ACCRUAL_PLAN = REC.BENEFIT_CODE;
    END LOOP;

END;
/