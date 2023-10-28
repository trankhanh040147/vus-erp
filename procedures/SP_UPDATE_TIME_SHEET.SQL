create or replace PROCEDURE "SP_UPDATE_TIME_SHEET"
(
    p_ts_header_id number
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


leave_id nvarchar2(100);
leave_groupid nvarchar2(100);
transaction_date nvarchar2(100);

rsp_status nvarchar2(50);
BEGIN

    SP_GET_TOKEN(n_token);

    apex_web_service.g_request_headers.delete();    
    apex_web_service.g_request_headers(1).name := 'Authorization';
    apex_web_service.g_request_headers(1).value := 'Bearer '|| n_token;
    
    apex_web_service.g_request_headers(2).name := 'Content-Type';
    apex_web_service.g_request_headers(2).value := 'application/json; charset=utf-8';

    -- Update values from P_TIME_SHEET_DETAIL to EMP_TIME_SHEET_LINE

    -- Body value template
    -- {
    --     "_jsonRequest": {
    --         "LegalEntityID": "V01",
    --         "TimeSheetHeader": [
    --             {
    --                 "ProfileDate": "09-20-2023",
    --                 "Profile": "Office 1",
    --                 "Worker": 5637213576,
    --                 "TimeSheetLine": [
    --                 {
    --                     "TimeSheetLineRecId": 5637185838,
    --                     "RegType": "Clock in",
    --                     "JobRef": "System",
    --                     "JobId": "V01-001181",
    --                     "StartTime": "09:00:00 am",
    --                     "EndTime": "09:00:00 am",
    --                     "Description": "Clock in",
    --                     "TransId": "1",
    --                     "Time": "00.00"
    --                 }
    --                 ]
    --             }
    --         ]
    --     }
    -- }

    l_body := '
    {
        "_jsonRequest": {
            "LegalEntityID": ' || n_legal_entity || ',
            "TimeSheetHeader": [
                {
                    "ProfileDate": "' || n_profile_date || '",
                    "Profile": "' || n_profile || '",
                    "Worker": ' || n_worker || ',
                    "TimeSheetLine": [
                    {
                        "TimeSheetLineRecId": 5637185838,
                        "RegType": "Clock in",
                        "JobRef": "System",
                        "JobId": "V01-001181",
                        "StartTime": "09:00:00 am",
                        "EndTime": "09:00:00 am",
                        "Description": "Clock in",
                        "TransId": "1",
                        "Time": "00.00"
                    ';
            
    -- Query values from Time_Sheet
    SELECT USER_NAME, FULL_NAME INTO n_company_email, n_full_name FROM EMPLOYEES WHERE EMPLOYEE_CODE = p_employeeCode;
    SELECT BENEFIT_CODE, LEAVE_TYPE INTO leave_id, leave_groupid FROM EMPLOYEE_REQUESTS WHERE ID = p_request_id;

    -- Output values
    DBMS_OUTPUT.put_line('id: ' || leave_id);
    DBMS_OUTPUT.put_line('group_id: ' || leave_groupid);
    DBMS_OUTPUT.put_line('trans_date: ' || transaction_date);

    
    for rec in (SELECT * FROM EMP_TIME_SHEET ets
                JOIN EMP_TIME_SHEET_LINE etsl on ets.TS_HEADER_REC_ID = etsl.TS_HEADER_REC_ID 
                WHERE ets.TS_HEADER_REC_ID = :p_ts_header_id)loop
    
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

    -- Set value for body
        -- l_body := '{
        -- "_jsonRequest":{
        --     "LegalEntityID": "'||rec.DATAAREA||'",
        --     "AdjustedHours": "'||to_char(n_total_day,'90.9')||'",
        --     "AdjustmentType": "'||rec.ADJUSTMENTTYPE||'",
        --     "TransactionDate": "'||rec.FROM_DATE||'",
        --     "Description": "'||rec.NOTE||'",
        --     "EmployeeCode": "'||p_employeeCode||'", 
        --     "AccrualId": "'||n_accrual_id||'", 
        --     "IDPortal": "'||rec.ID||'",
        --     "IDStrPortal": "'||rec.ID||'",
        --     "FromDate": "'||rec.FROM_DATE||'",
        --     "ToDate": "'||rec.MODIFIED_END_DATE||'",
        --     "NumberDayOff": "'||to_char(n_total_day,'90.9')||'",
        --     "StartTime": "'||rec.START_TIME||':00",
        --     "EndTime": "'||rec.END_TIME||':00",
        --     "HRMAbsenceCodeGroupId": "'||rec.CONVERTED_HRM_ABSENCE_CODE_GROUP_ID||'",
        --     "HRMAbsenceCodeId": "'||n_carry_forward_code||'",
        --     "AllDay": "'||rec.ALLDAY||'",
        --     "AttachmentURL": "'||rec.ATTATCH_FILE||'"
        -- }}';


    end loop;

    
    DBMS_OUTPUT.put_line('body: ');
    DBMS_OUTPUT.put_line(l_body);
    --APEX_JSON.parse(

        l_response := apex_web_service.make_rest_request(
                p_url => global_vars.get_resource_url || '//api/services/VUSTC_AbsenceGroupEmployeeServiceGroup/AbsenceGroupEmployeeService/CreateLeaverequest',
                p_http_method => 'POST',
                p_body => l_body,
                p_transfer_timeout => 3600
                ) ;


    DBMS_OUTPUT.put_line(l_response);
    APEX_JSON.parse(l_response);

    -- Status = 1 inserted successfully on D365, otherwise Status = 0
    rsp_status := apex_json.get_varchar2('Status', 1);
    -- DBMS_OUTPUT.put_line('STATUS: ' || rsp_status);

    -- Update request status
    UPDATE EMPLOYEE_REQUESTS SET INSERTED_STATUS = TO_NUMBER(rsp_status) WHERE ID = p_request_id;
    UPDATE EMPLOYEE_REQUESTS SET EMP_REQ_STATUS = 3 WHERE ID = p_request_id and rsp_status = '1';

    l_body := l_body || '
                    }
                    ]
                }
            ]
        }
    }
    ';
    
    DBMS_OUTPUT.put_line(l_response);
    
END;
/