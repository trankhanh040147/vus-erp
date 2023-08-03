create or replace PROCEDURE "SP_GET_TOKEN" IS
    l_body NVARCHAR2(2000);
    l_response_clob CLOB;
    l_authorization NVARCHAR2(2000);
    l_response CLOB;
    l_numrow NUMBER;
    l_count_idemp NUMBER;
    l_count_iduser NUMBER;
    l_body_json CLOB;
    n_id NUMBER;
    access_token NVARCHAR2(2000);
    n_code NVARCHAR2(200);
BEGIN


    apex_web_service.g_request_headers.delete();
    apex_web_service.g_request_headers(1).name := 'Content-Type';
    apex_web_service.g_request_headers(1).value := 'application/json';
    apex_web_service.g_request_headers(2).name := 'Content-Length';
    apex_web_service.g_request_headers(2).value := 0;


    l_body := '{"tenant_id":"d1005fc5-bff9-42d5-81e5-1f3fcb089799",
        "grant_type":"client_credentials"
        ,"client_id":"6f663eae-a6cc-4d0d-80ff-73251258d544",
        "client_secret":"Irl8Q~cT2m3opVHwo-iQWkCzaVD7~l1bTb8qfaoR",
        "resource":"https://hra.sandbox.operations.dynamics.com"}';
    DBMS_OUTPUT.put_line(TO_CHAR(l_body));

    APEX_JSON.parse(
        apex_web_service.make_rest_request(
            p_url => 'https://login.microsoftonline.com/d1005fc5-bff9-42d5-81e5-1f3fcb089799/oauth2/token',
            p_http_method => 'POST',
            -- p_body => l_body,
            p_transfer_timeout => 3600
        )
    );

    


    l_numrow := APEX_JSON.get_count(p_path => '.'); --Đếm tổng số chuỗi trả về
    
    FOR i IN 1 .. l_numrow LOOP
        access_token := apex_json.get_varchar2('[%d].access_token', i);
    END LOOP;

    DBMS_OUTPUT.put_line(access_token);
END;
/