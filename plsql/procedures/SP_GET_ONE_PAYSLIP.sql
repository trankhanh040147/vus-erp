create or replace procedure "SP_GET_ONE_PAYSLIP"
(
    p_legal_entity NVARCHAR2,
    p_worker_id NVARCHAR2,
    p_year NUMBER,
    p_month NUMBER,
    o_
)
is
-- Declare variables
    p_token NVARCHAR2(10000);

    l_token_type NVARCHAR2(2000);
    l_access_token NVARCHAR2(2000);
    l_body NVARCHAR2(2000);
    l_response_clob CLOB;
    l_authorization NVARCHAR2(2000);
    l_response CLOB;
    l_numrow NUMBER;
    l_trans_numrow NUMBER;
    l_rowsub NUMBER;
    l_count_idemp NUMBER;
    l_max NUMBER;
    l_body_json CLOB;
    l_list CLOB;

BEGIN
    SP_GET_TOKEN(p_token);
    apex_web_service.g_request_headers.delete();

    apex_web_service.g_request_headers(1).name := 'Authorization';
    apex_web_service.g_request_headers(1).value := 'Bearer ' || p_token;

    apex_web_service.g_request_headers(2).name := 'Content-Type';
    apex_web_service.g_request_headers(2).value := 'application/json';
    
    l_body := '{"_jsonRequest":{
        "Legal_entity":"' || p_legal_entity || '",
        "Worker":"' || p_worker_id || '",
        "Year":"' || to_char(p_year) || '",
        "Months":"' || to_char(p_month) || '"
    } }';

    DBMS_OUTPUT.put_line(l_body);

    l_response := apex_web_service.make_rest_request(
        p_url => 'https://hra.sandbox.operations.dynamics.com/api/services/VUSTC_AbsenceGroupEmployeeServiceGroup/AbsenceGroupEmployeeService/GetEmpPaySlip',
        p_http_method => 'POST',
        p_body => l_body,
        p_transfer_timeout => 3600
    );

    APEX_JSON.parse(l_response);

    DBMS_OUTPUT.put_line(l_response);

END;