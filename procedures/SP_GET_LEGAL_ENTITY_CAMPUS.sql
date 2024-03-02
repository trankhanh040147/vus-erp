create or replace PROCEDURE "SP_GET_LEGAL_ENTITY_CAMPUS"
is
l_method_url VARCHAR2(255);
l_num_row number;
l_count_row number;
n_DataArea nvarchar2(50);
n_CompanyName nvarchar2(200);
p_token nvarchar2(10000);
BEGIN
    l_method_url := global_vars.get_resource_url || '/api/services/VUSTC_AbsenceGroupEmployeeServiceGroup/AbsenceGroupEmployeeService/GetLegalEntity';
    SP_GET_TOKEN(p_token);
    apex_web_service.g_request_headers.delete();
    apex_web_service.g_request_headers(1).name := 'Content-Type';
    apex_web_service.g_request_headers(1).value := 'application/json';
    apex_web_service.g_request_headers(2).name := 'Content-Length';
    apex_web_service.g_request_headers(2).value := 0;
    apex_web_service.g_request_headers(3).name := 'Authorization';
    apex_web_service.g_request_headers(3).value := 'Bearer ' || p_token;
    
    APEX_JSON.parse(
        apex_web_service.make_rest_request(
            p_url => l_method_url,
            p_http_method => 'POST',
            p_transfer_timeout => 3600
        )
    );

    l_num_row := APEX_JSON.get_count (p_path => '.');
    --DBMS_OUTPUT.put_line(TO_CHAR(l_num_row));
    FOR i IN 1 .. l_num_row
    LOOP
        n_DataArea := apex_json.get_varchar2('[%d].DataArea', i);       
        n_CompanyName := apex_json.get_varchar2('[%d].CompanyName', i); 
        
        SELECT COUNT(ID) INTO l_count_row FROM LEGAL_ENTITY_CAMPUS WHERE DATA_AREA = n_DataArea;

        If l_count_row > 0 Then
            UPDATE LEGAL_ENTITY_CAMPUS 
            SET     
                COMPANY_NAME = n_CompanyName
            WHERE DATA_AREA = n_DataArea;            

        Else
            INSERT INTO LEGAL_ENTITY_CAMPUS (DATA_AREA, COMPANY_NAME) 
            VALUES (n_DataArea, n_CompanyName);
        End If;

        COMMIT; 

    END LOOP;
END "SP_GET_LEGAL_ENTITY_CAMPUS";
