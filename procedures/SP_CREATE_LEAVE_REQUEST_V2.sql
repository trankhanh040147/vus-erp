create or replace PROCEDURE "SP_CREATE_LEAVE_REQUEST_V2"
(p_adjustedhours varchar,
p_adjustmenttype varchar,
p_transactiondate varchar,
p_description varchar,
p_employeeCode varchar,
p_hrmabsencecodeid varchar,
p_portalID varchar)
is
--
l_token_type NVARCHAR2(2000);
l_body NVARCHAR2(2000);
l_response clob;
l_response_clob clob;
l_numrow number;
l_rowsub number;
l_body_mail NVARCHAR2(2000);
-- API body params
n_id number;
n_EmployeeCode NVARCHAR2(200);
n_legal_entity NVARCHAR2(200);
n_request_type_name NVARCHAR2(200);
n_personal_email NVARCHAR2(200);
n_token NVARCHAR2(5000);
--
n_TotalRows number;
n_HRMAbsenceCodeGroupId NVARCHAR2(100);
n_Status NVARCHAR2(50);
n_FromDate date;
n_ToDate date;
n_NumberDayOff number;
n_StartTime date;
n_EndTime date;
n_AccrualId NVARCHAR2(100);
n_AllDay NVARCHAR2(100);

BEGIN
    SP_GET_TOKEN(n_token);
    apex_web_service.g_request_headers.delete();    
    apex_web_service.g_request_headers(1).name := 'Authorization';
    apex_web_service.g_request_headers(1).value := 'Bearer '|| n_token;
    
    apex_web_service.g_request_headers(2).name := 'Content-Type';
    apex_web_service.g_request_headers(2).value := 'application/json; charset=utf-8';
    
    --------> Get values for BODY <---------
    -- Get employee LegalEntityID --
    SELECT DATAAREA INTO n_legal_entity FROM EMPLOYEES WHERE EMPLOYEE_CODE = p_employeeCode; 
    
    -- SELECT NAME INTO n_request_type_name FROM REQUEST_TYPE WHERE ID = p_hrmabsencecodeid;

    --------> Set BODY <---------
    l_body := '{"_jsonRequest":
        {
        "LegalEntityID":"'||n_legal_entity||'",
        "TotalRows":"'||n_TotalRows||'",
        "AdjustedHours":"'||p_adjustedhours||'",
        "AdjustmentType":"'||p_adjustmenttype||'",
        "Description":"'||p_description||'",
        "TransactionDate":"'||p_transactiondate||'",
        "EmployeeCode":"'||n_EmployeeCode||'",
        "HRMAbsenceCodeId":"'||p_hrmabsencecodeid||'",
        "HRMAbsenceCodeGroupId":"'||n_HRMAbsenceCodeGroupId||'",
        "IDPortal":"'||p_portalID||'",
        "Status":"'||n_Status||'",
        "FromDate":"'||n_FromDate||'",
        "ToDate":"'||n_ToDate||'",
        "NumberDayOff":"'||n_NumberDayOff||'",
        "StartTime":"'||n_StartTime||'",
        "EndTime":"'||n_EndTime||'",
        "AccrualId":"'||n_AccrualId||'",
        "AllDay":"'||n_AllDay||'"
        }
    }';
        
    DBMS_OUTPUT.put_line(l_body);
    --APEX_JSON.parse(

    l_response := apex_web_service.make_rest_request(
                p_url => 'https://hra.sandbox.operations.dynamics.com//api/services/VUSTC_AbsenceGroupEmployeeServiceGroup/AbsenceGroupEmployeeService/CreateLeaverequest',
                p_http_method => 'POST',
                p_body => l_body,
                p_transfer_timeout => 3600
    ) ;
        
    --------> SEND EMAIL <---------
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
    --);
    --l_numrow := APEX_JSON.get_count (p_path =>'.');
    --l_rowsub := apex_json.get_count(p_path =>'[1].Benefit accrual');
    --DBMS_OUTPUT.put_line('đếm số chuỗi trả về :' ||to_char(l_numrow) ||' Benefit accrual: '||to_char(l_rowsub));
    
END;
/