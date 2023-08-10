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
BEGIN
    SELECT VALUE INTO n_token_value FROM APPLICATIONS_CONFIGS WHERE KEY = 'TOKEN' AND ROWNUM = 1;
    SP_GET_TOKEN(n_token);
    apex_web_service.g_request_headers.delete();    
    apex_web_service.g_request_headers(1).name := 'Authorization';
    apex_web_service.g_request_headers(1).value := 'Bearer '|| n_token;
    
    apex_web_service.g_request_headers(2).name := 'Content-Type';
    apex_web_service.g_request_headers(2).value := 'application/json; charset=utf-8';
    
    for rec in (select er.*,emp.DATAAREA,age.DAY_APPROVE,age.BENEFIT_ACCRUAL_PLAN,age.HRM_ABSENCE_CODE_GROUP_ID,age.HRM_ABSENCE_CODE_ID,
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
        where er.REQUEST_ID = p_request_id and emp.EMPLOYEE_CODE = p_employeeCode and EXPIRATION_DATE >= to_char(sysdate,'MM/DD/YYYY')
    )loop

    l_body := '{
    "_jsonRequest":{
        "LegalEntityID": "'||rec.DATAAREA||'",
        "AdjustedHours": "'||to_char(rec.TOTAL_DAYS,'90.9')||'",
        "AdjustmentType": "'||rec.ADJUSTMENTTYPE||'",
        "TransactionDate": "'||rec.DAY_APPROVE||'",
        "Description": "'||rec.NOTE||'",
        "EmployeeCode": "'||p_employeeCode||'", 
        "AccrualId": "'||rec.BENEFIT_ACCRUAL_PLAN||'", 
        "IDPortal": "'||rec.REQUEST_ID||'",
        "FromDate": "'||rec.FROM_DATE||'",
        "ToDate": "'||rec.END_DATE||'",
        "NumberDayOff": "'||to_char(rec.TOTAL_DAYS,'90.9')||'",
        "StartTime": "'||rec.START_TIME||':00",
        "EndTime": "'||rec.END_TIME||':00",
        "HRMAbsenceCodeGroupId": "'||rec.HRM_ABSENCE_CODE_GROUP_ID||'",
        "HRMAbsenceCodeId": "'||rec.HRM_ABSENCE_CODE_ID||'",
        "AllDay": "'||rec.ALLDAY||'"
    }}';

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
                p_url => 'https://hra.sandbox.operations.dynamics.com//api/services/VUSTC_AbsenceGroupEmployeeServiceGroup/AbsenceGroupEmployeeService/CancelLeaverequest',
                p_http_method => 'POST',
                p_body => l_body,
                p_transfer_timeout => 3600
                ) ;
        /*
        SELECT PERSONAL_EMAIL INTO n_personal_email FROM EMPLOYEES WHERE EMPLOYEE_CODE = p_employeeCode AND NVL(PERSONAL_EMAIL, '0') <> '0';
        --n_personal_email := email của e;
        If n_personal_email IS not null Then
            l_body_mail := ' {
                            "Subject":"Approved your Leave",
                            "Body":"Portal",
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