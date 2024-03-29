-- API RESPONSE:
-- [
    -- {
    --     "$id": "1",
    --     "DisciplineId": "Phổ thông",
    --     "Description": "Phổ thông"
    -- },
-- ]
-- TABLE: LIST_ISSUING_AGENCY
-- LIA_ID	NUMBER(4,0)
-- LIA_ISSUING_AGENCY_ID	NVARCHAR2(20 CHAR)
-- LIA_NAME	NVARCHAR2(50 CHAR)
-- LIA_EMAIL	NVARCHAR2(50 CHAR)
-- LIA_PHONE	NVARCHAR2(20 CHAR)

create or replace PROCEDURE "SP_GET_LIST_EDUCATION_DISCIPLINE"
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

n_DisciplineId NVARCHAR2(20);
n_Description NVARCHAR2(50);

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
            p_url => global_vars.get_resource_url || '/api/services/HRPortalServices/EmployeeProfileService/getEducationDiscipline',
            p_http_method => 'POST',
            p_transfer_timeout => 3600
            ) --;
    );

    l_numrow := APEX_JSON.get_count (p_path =>'.'); --Đếm tổng số chuỗi trả về
    
    FOR i IN 1 .. l_numrow
    LOOP
        n_DisciplineId := apex_json.get_varchar2('[%d].DisciplineId',i);
        n_Description := apex_json.get_varchar2('[%d].Description',i);

        SELECT COUNT(*) INTO l_count_idemp FROM LIST_EDUCATION_DISCIPLINE WHERE LED_DISCIPLINE_ID = n_DisciplineId;

        If l_count_idemp > 0 Then
            UPDATE
                LIST_EDUCATION_DISCIPLINE
            SET
                LED_DESCRIPTION = n_Description
            WHERE
                LED_DISCIPLINE_ID = n_DisciplineId;
        Else
            INSERT INTO
                LIST_EDUCATION_DISCIPLINE
                (LED_DISCIPLINE_ID, LED_DESCRIPTION)
            VALUES
                (n_DisciplineId, n_Description);
        End If;

        COMMIT; 
         
    END LOOP;
    --DBMS_OUTPUT.put_line(TO_CHAR(n_id)||n_name||TO_CHAR(n_managerPosition));
    
END;
/