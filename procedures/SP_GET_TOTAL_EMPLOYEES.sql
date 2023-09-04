create or replace procedure "SP_GET_TOTAL_EMPLOYEES"
(p_total_emp OUT NUMBER)
IS
    l_token NVARCHAR2(10000);
    l_response CLOB;
    l_method_url CLOB;
    l_blob BLOB;

    r_TotalRow NUMBER;
BEGIN
    SP_GET_TOKEN(l_token);    
    apex_web_service.g_request_headers.delete();

    apex_web_service.g_request_headers(1).name := 'Content-Type';  
    apex_web_service.g_request_headers(1).value := 'application/json'; 
    apex_web_service.g_request_headers(2).name := 'Content-Length';
    apex_web_service.g_request_headers(2).value := 0;
    apex_web_service.g_request_headers(3).name := 'Authorization';  
    apex_web_service.g_request_headers(3).value := 'Bearer ' || l_token ;  

    APEX_JSON.parse(
        apex_web_service.make_rest_request(
                p_url => 'https://hra.sandbox.operations.dynamics.com/api/services/HRPortalServices/EmployeeProfileService/getTotalRowEmployee',
                p_http_method => 'POST',
                p_transfer_timeout => 3600
        ) 
    );

    -- l_numrow := APEX_JSON.get_count (p_path =>'.'); --Đếm tổng số chuỗi trả về

    r_TotalRow := TO_NUMBER(apex_json.get_clob('[%d].TotalRow',1));

    DBMS_OUTPUT.put_line(r_TotalRow);
END;
/