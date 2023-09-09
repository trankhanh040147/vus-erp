create or replace PROCEDURE "SP_CREATE_REQUEST_FIN"
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
n_company_email NVARCHAR2(200);
n_full_name NVARCHAR2(200);
n_token_value NVARCHAR2(2000);
n_token NVARCHAR2(5000);
n_approve_date nvarchar2(200);
n_carry_forward_code nvarchar2(200);
n_accrual_id nvarchar2(100);
n_total_day number:= 0;
leave_id nvarchar2(100);
leave_groupid nvarchar2(100);
transaction_date nvarchar2(100);
BEGIN

    SELECT TO_CHAR(SYSDATE, 'MM/DD/YYYY') INTO n_approve_date FROM DUAL;
    SELECT VALUE INTO n_token_value FROM APPLICATIONS_CONFIGS WHERE KEY = 'TOKEN' AND ROWNUM = 1;
    SP_GET_TOKEN(n_token);
    apex_web_service.g_request_headers.delete();    
    apex_web_service.g_request_headers(1).name := 'Authorization';
    apex_web_service.g_request_headers(1).value := 'Bearer '|| n_token;
    
    apex_web_service.g_request_headers(2).name := 'Content-Type';
    apex_web_service.g_request_headers(2).value := 'application/json; charset=utf-8';

            
    -- SELECT USER_NAME INTO n_manager_company_email FROM EMPLOYEES WHERE EMPLOYEE_CODE = (SELECT MANAGER_ID FROM EMPLOYEES WHERE EMPLOYEE_CODE = p_employeeCode) AND NVL(USER_NAME, '0') <> '0';
    SELECT USER_NAME, FULL_NAME INTO n_company_email, n_full_name FROM EMPLOYEES WHERE EMPLOYEE_CODE = p_employeeCode;

    SELECT BENEFIT_CODE, LEAVE_TYPE INTO leave_id, leave_groupid FROM EMPLOYEE_REQUESTS WHERE ID = p_request_id;
    SELECT TO_CHAR(SYSDATE, 'MM/DD/YYYY') INTO transaction_date  FROM DUAL;

    DBMS_OUTPUT.put_line('id: ' || leave_id);
    DBMS_OUTPUT.put_line('group_id: ' || leave_groupid);
    DBMS_OUTPUT.put_line('trans_date: ' || transaction_date);


    
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
        where er.ID = p_request_id and emp.EMPLOYEE_CODE = p_employeeCode and EXPIRATION_DATE >= to_char(sysdate,'MM/DD/YYYY')
    )loop
    
            if rec.CARRY_FORWORD_EXP_DATE >= to_char(sysdate,'MM/DD/YYYY') then
                if rec.CARRY_FORWARD_AVALABLE > 0 then
                    n_carry_forward_code := rec.CARRY_FORWARD_CODE;
                    n_accrual_id := rec.CF_BENEFIT_ACCRUAL_PLAN;
                    n_total_day := rec.TOTAL_DAYS;
                else
                    n_carry_forward_code := rec.HRM_ABSENCE_CODE_ID;
                    n_accrual_id := rec.BENEFIT_ACCRUAL_PLAN;
                    n_total_day := rec.TOTAL_DAYS;
                end if;
                    
            else
                    n_carry_forward_code := rec.HRM_ABSENCE_CODE_ID;
                    n_accrual_id := rec.BENEFIT_ACCRUAL_PLAN;
                    n_total_day := rec.TOTAL_DAYS;
            end if;

    if leave_groupid = 'APL' then
        l_body := '{
        "_jsonRequest":{
            "LegalEntityID": "'||rec.DATAAREA||'",
            "AdjustedHours": "'||to_char(n_total_day,'90.9')||'",
            "AdjustmentType": "'||rec.ADJUSTMENTTYPE||'",
            "TransactionDate": "'||transaction_date||'",
            "Description": "'||rec.NOTE||'",
            "EmployeeCode": "'||p_employeeCode||'", 
            "AccrualId": "'||n_accrual_id||'", 
            "IDPortal": "'||rec.ID||'",
            "IDStrPortal": "'||rec.ID||'",
            "FromDate": "'||rec.FROM_DATE||'",
            "ToDate": "'||rec.MODIFIED_END_DATE||'",
            "NumberDayOff": "'||to_char(n_total_day,'90.9')||'",
            "StartTime": "'||rec.START_TIME||':00",
            "EndTime": "'||rec.END_TIME||':00",
            "HRMAbsenceCodeGroupId": "'||rec.CONVERTED_HRM_ABSENCE_CODE_GROUP_ID||'",
            "HRMAbsenceCodeId": "'||n_carry_forward_code||'",
            "AllDay": "'||rec.ALLDAY||'"
        }}';
    else 
        l_body := '{
        "_jsonRequest":{
            "LegalEntityID": "'||rec.DATAAREA||'",
            "AdjustedHours": "'||to_char(n_total_day,'90.9')||'",
            "AdjustmentType": "'||rec.ADJUSTMENTTYPE||'",
            "TransactionDate": "'||transaction_date||'",
            "Description": "'||rec.NOTE||'",
            "EmployeeCode": "'||p_employeeCode||'", 
            "AccrualId": "'||leave_id||'", 
            "IDStrPortal": "'||rec.ID||'",
            "FromDate": "'||rec.FROM_DATE||'",
            "ToDate": "'||rec.MODIFIED_END_DATE||'",
            "NumberDayOff": "'||to_char(n_total_day,'90.9')||'",
            "StartTime": "'||rec.START_TIME||':00",
            "EndTime": "'||rec.END_TIME||':00",
            "HRMAbsenceCodeGroupId": "'||leave_groupid||'",
            "HRMAbsenceCodeId": "'||leave_id||'",
            "AllDay": "'||rec.ALLDAY||'",
            "AttachmentURL": "'||rec.ATTATCH_FILE||'"
        }}';
    end if;


    -- Send mail
    -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', n_company_email, 'Leave Request Approved', '<p> Dear '|| n_full_name ||', </p>' ||
    --     '<p>Your leave request has been approved. Here are the details:</p>' ||
    --     '<p> Employee Code: '|| p_employeeCode ||' </p>' ||
    --     '<p> Total Days: '|| n_total_day ||' </p>' ||
    --     '<p> From Date: '|| rec.FROM_DATE ||' </p>' ||
    --     '<p> To Date: '|| rec.MODIFIED_END_DATE ||' </p>' ||
    --     '<br>' || 
    --     '<p>Feel free to proceed with your leave plans accordingly.</p>' ||
    --     '<br>' || 
    --     '<p> If you have any questions or need further assistance, please feel free to reach out to the HR department. </p>' ||
    --     '<br>' || 
    --     '<p> Thank you, </p>' ||
    --     '<p> VUS </p>');

    end loop;

/*
{
    "_jsonRequest":{
        "LegalEntityID": "V01",
        "AdjustedHours": "  1.0",
        "AdjustmentType": "Amount Used",
        "TransactionDate": "08/23/2023",
        "Description": "TEST LEAVEREQUEST 01",
        "EmployeeCode": "000053", 
        "AccrualId": "ALPL18 2023", 
        "IDPortal": "437",
        "IDStrPortal": "437a",
        "FromDate": "08/23/2023",
        "ToDate": "08/23/2023",
        "NumberDayOff": "  1.0",
        "StartTime": "00:00:00",
        "EndTime": "00:00:00",
        "HRMAbsenceCodeGroupId": "Leave",
        "HRMAbsenceCodeId": "ALPL18",
        "AllDay": "Yes"
    }}
*/       
        DBMS_OUTPUT.put_line('body: ');
        DBMS_OUTPUT.put_line(l_body);
        --APEX_JSON.parse(

        l_response := apex_web_service.make_rest_request(
                p_url => 'https://hra.sandbox.operations.dynamics.com//api/services/VUSTC_AbsenceGroupEmployeeServiceGroup/AbsenceGroupEmployeeService/CreateLeaverequest',
                p_http_method => 'POST',
                p_body => l_body,
                p_transfer_timeout => 3600
                ) ;
    
END;
/