-- API RESPONSE:
-- [
--     {
-- {
--     "$id": "1",
--     "HcmEducationLevelId": "BA",
--     "Description": "BA"
-- }
--     },
-- ]
-- TABLE: LIST_EDUCATION_LEVEL
-- LEV_ID	NUMBER(4,0)
-- LEV_HCM_EDUCATION_LEVEL_ID	NVARCHAR2(30 CHAR)
-- LEV_DESCRIPTION	NVARCHAR2(100 CHAR)

create or replace PROCEDURE "SP_GET_LIST_EDUCATION_LEVEL"
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

n_HcmEducationLevelId NVARCHAR2(30);
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
            -- p_url => global_vars.get_resource_url || '/api/services/HRPortalServices/EmployeeProfileService/getHealthInsurance',
            p_url => global_vars.get_resource_url || '/api/services/HRPortalServices/EmployeeProfileService/getEducationLevel',
            p_http_method => 'POST',
            p_transfer_timeout => 3600
            ) --;
    );

    l_numrow := APEX_JSON.get_count (p_path =>'.'); --Đếm tổng số chuỗi trả về
    
    FOR i IN 1 .. l_numrow
    LOOP
        n_HcmEducationLevelId := apex_json.get_varchar2('[%d].HcmEducationLevelId',i);
        n_Description := apex_json.get_varchar2('[%d].Description',i);

        SELECT COUNT(*) INTO l_count_idemp FROM LIST_EDUCATION_LEVEL WHERE LEV_HCM_EDUCATION_LEVEL_ID = n_HcmEducationLevelId;
        
        If l_count_idemp > 0 Then
            UPDATE LIST_EDUCATION_LEVEL
                SET LEV_DESCRIPTION = n_Description
            WHERE LEV_HCM_EDUCATION_LEVEL_ID = n_HcmEducationLevelId;
        Else
            INSERT INTO LIST_EDUCATION_LEVEL(LEV_HCM_EDUCATION_LEVEL_ID, LEV_DESCRIPTION)
            VALUES (n_HcmEducationLevelId, n_Description);
        End If;

        COMMIT; 
         
    END LOOP;
    --DBMS_OUTPUT.put_line(TO_CHAR(n_id)||n_name||TO_CHAR(n_managerPosition));
    
END;
/