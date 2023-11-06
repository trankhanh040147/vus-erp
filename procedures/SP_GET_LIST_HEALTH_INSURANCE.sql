create or replace PROCEDURE "SP_GET_LIST_HEALTH_INSURANCE"
is
l_token_type NVARCHAR2(2000);
l_access_token NVARCHAR2(2000);
l_body NVARCHAR2(2000);
l_response_clob clob;
l_authorization NVARCHAR2(2000);
l_response clob;
l_numrow number;
l_count_idemp number;
l_count_iduser number;
l_body_json clob;

n_id NUMBER;
n_employee_id NUMBER;
n_PrimaryEducation NUMBER;
n_code NVARCHAR2(100 CHAR);
n_HealthInsuFacility NVARCHAR2(100);
n_Description NVARCHAR2(200);

p_token NVARCHAR2(10000);
BEGIN
    SP_GET_TOKEN(p_token);

    apex_web_service.g_request_headers.delete();
    apex_web_service.g_request_headers(1).name := 'Content-Type';
    apex_web_service.g_request_headers(1).value := 'application/json';
    apex_web_service.g_request_headers(2).name := 'Content-Length';
    apex_web_service.g_request_headers(2).value := 0;
    apex_web_service.g_request_headers(3).name := 'Authorization';
    apex_web_service.g_request_headers(3).value := 'Bearer '|| p_token;
    --apex_web_service.g_request_headers(4).name := 'Content-Type';
    --apex_web_service.g_request_headers(4).value := 'application/json';
    APEX_JSON.parse(

    apex_web_service.make_rest_request(
            p_url => global_vars.get_resource_url || '/api/services/HRPortalServices/EmployeeProfileService/getHealthInsurance',
            p_http_method => 'POST',
            p_transfer_timeout => 3600
            ) --;
    );

    l_numrow := APEX_JSON.get_count (p_path =>'.'); --Đếm tổng số chuỗi trả về
    
    FOR i IN 1 .. l_numrow
    LOOP
        n_id := TO_NUMBER(apex_json.get_varchar2('[%d].$id', i));
        n_Description := apex_json.get_varchar2('[%d].Description', i);
        n_HealthInsuFacility := apex_json.get_varchar2('[%d].HealthInsuFacility', i);

        SELECT COUNT(HEALTH_INSU_FACILITY_CODE) INTO l_count_idemp FROM HEALTH_INSURANCE_ESTABLISHMENT 
        WHERE  HEALTH_INSU_FACILITY_CODE = n_HealthInsuFacility;
        
        If l_count_idemp > 0 Then
            UPDATE
                HEALTH_INSURANCE_ESTABLISHMENT
            SET
                DESCRIPTION = n_Description
            WHERE
                HEALTH_INSU_FACILITY_CODE = n_HealthInsuFacility;
        Else
            INSERT INTO
                HEALTH_INSURANCE_ESTABLISHMENT(
                    DESCRIPTION,
                    HEALTH_INSU_FACILITY_CODE
                )
            VALUES
            (
                n_Description,
                n_HealthInsuFacility
                );
        End If;

        COMMIT; 
         
    END LOOP;
    --DBMS_OUTPUT.put_line(TO_CHAR(n_id)||n_name||TO_CHAR(n_managerPosition));
    
END;
/