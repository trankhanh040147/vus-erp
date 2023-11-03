create or replace PROCEDURE "SP_ABSENCE_CODE_GROUP_LIST"
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
n_id number;
n_group_id nvarchar2(2000);
n_name nvarchar2(2000);
n_registration boolean;
p_token nvarchar2(10000);
BEGIN
    SP_GET_TOKEN(p_token);
    apex_web_service.g_request_headers.delete();
    apex_web_service.g_request_headers(1).name := 'Content-Type';
    apex_web_service.g_request_headers(1).value := 'application/json';
    apex_web_service.g_request_headers(2).name := 'Content-Length';
    apex_web_service.g_request_headers(2).value := 0;
    apex_web_service.g_request_headers(3).name := 'Authorization';
    apex_web_service.g_request_headers(3).value := 'Bearer '|| p_token;

    APEX_JSON.parse(

    apex_web_service.make_rest_request(
            p_url => global_vars.get_resource_url || '/api/services/HRPortalServices/EmployeeProfileService/getAbsenceCodeGroupList',
            p_http_method => 'POST',
            --p_body => l_body,
            p_transfer_timeout => 3600
            )
    );

    --DBMS_OUTPUT.put_line(l_response_clob);
    l_numrow := APEX_JSON.get_count (p_path =>'.'); --Đếm tổng số chuỗi trả về
    DBMS_OUTPUT.put_line(TO_CHAR(l_numrow));

    FOR i IN 1 .. l_numrow
    LOOP
        n_id := TO_NUMBER(apex_json.get_varchar2('[%d].$id', i));        
        n_group_id := apex_json.get_varchar2('[%d].absence_group_id', i);
        n_group_id := CASE WHEN LOWER(n_group_id) = 'leave' then 'APL' ELSE n_group_id END; 
        n_name := apex_json.get_varchar2('[%d].description', i);
        n_registration := apex_json.get_boolean('[%d].registration', i);
        -- DBMS_OUTPUT.put_line(n_id);
        -- DBMS_OUTPUT.put_line(n_group_id);
        -- DBMS_OUTPUT.put_line(n_name); 
        -- IF n_registration THEN
        --     DBMS_OUTPUT.put_line('TRUE');
        -- ELSE
        --     DBMS_OUTPUT.put_line('FALSE');
        -- END IF;
        
        IF n_registration THEN
            -- INSERT/UPDATE code_group where regist = TRUE
            SELECT COUNT(*) INTO l_count_idemp FROM ABSENCE_CODE_GROUP_LIST 
            WHERE ACGL_ABSENCE_GROUP_ID = n_group_id;
            If l_count_idemp > 0 Then
                UPDATE ABSENCE_CODE_GROUP_LIST SET ACGL_DESCRIPTION = n_name, ACGL_ABSENCE_GROUP_ID = n_group_id
                WHERE ACGL_ABSENCE_GROUP_ID = n_group_id ;            

            Else
                INSERT INTO ABSENCE_CODE_GROUP_LIST(ACGL_DESCRIPTION, ACGL_ABSENCE_GROUP_ID)
                VALUES(n_name, n_group_id);
            End If;
        ELSE
            -- DELETE code_group where regist = FALSE
            DELETE FROM ABSENCE_CODE_GROUP_LIST WHERE ACGL_ABSENCE_GROUP_ID = n_group_id;
        END IF;

        COMMIT; 

    END LOOP;
    END;
/