-- API RESPONSE:
-- [
--     {
--         "$id": "1",
--         "InstitutionId": "001",
--         "NameOfSchool": "Đại học Canberra - Úc",
--         "Phone": ""
--     },
-- ]
-- TABLE: LIST_EDUCATION_INSTITUTION
-- LEI_ID	NUMBER(4,0)
-- LEI_INSTITUTION_ID	NVARCHAR2(10 CHAR)
-- LEI_NAME_OF_SCHOOL	NVARCHAR2(100 CHAR)
-- LEI_PHONE	NVARCHAR2(20 CHAR)

create or replace PROCEDURE "SP_GET_LIST_EDUCATION_INSTITUTION"
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
n_InstitutionId NVARCHAR2(100);
n_NameOfSchool NVARCHAR2(100);
n_Phone NVARCHAR2(100);


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
            p_url => global_vars.get_resource_url || '/api/services/HRPortalServices/EmployeeProfileService/getListEducationInstitution',
            p_http_method => 'POST',
            p_transfer_timeout => 3600
            ) --;
    );

    l_numrow := APEX_JSON.get_count (p_path =>'.'); --Đếm tổng số chuỗi trả về
    
    FOR i IN 1 .. l_numrow
    LOOP
        n_InstitutionId := apex_json.get_varchar2('[%d].InstitutionId',i);
        n_NameOfSchool := apex_json.get_varchar2('[%d].NameOfSchool',i);
        n_Phone := apex_json.get_varchar2('[%d].Phone',i);

        SELECT COUNT(*) INTO l_count_idemp FROM LIST_EDUCATION_INSTITUTION WHERE LEI_INSTITUTION_ID = n_InstitutionId;
        
        If l_count_idemp > 0 Then
            UPDATE LIST_EDUCATION_INSTITUTION SET
                LEI_NAME_OF_SCHOOL = n_NameOfSchool,
                LEI_PHONE = n_Phone
            WHERE LEI_INSTITUTION_ID = n_InstitutionId;
        Else
            INSERT INTO LIST_EDUCATION_INSTITUTION(LEI_INSTITUTION_ID, LEI_NAME_OF_SCHOOL, LEI_PHONE)
            VALUES (n_InstitutionId, n_NameOfSchool, n_Phone);
        End If;

        COMMIT; 
         
    END LOOP;
    --DBMS_OUTPUT.put_line(TO_CHAR(n_id)||n_name||TO_CHAR(n_managerPosition));
    
END;
/