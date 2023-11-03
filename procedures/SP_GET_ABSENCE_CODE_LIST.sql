create or replace PROCEDURE "SP_GET_ABSENCE_CODE_LIST"
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
n_group NVARCHAR2(100);
n_name NVARCHAR2(2000);
n_code NVARCHAR2(200);
n_registration boolean;
p_token nvarchar2(2000);
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
            p_url => global_vars.get_resource_url || '/api/services/HRPortalServices/EmployeeProfileService/getAbsenceCodeList',
            p_http_method => 'POST',
            --p_body => l_body,
            p_transfer_timeout => 3600
            ) --;
    );
    --APEX_JSON.parse(l_response_clob);
    --APEX_JSON.parse(:body_text);
    --DBMS_OUTPUT.put_line(l_response_clob);
    l_numrow := APEX_JSON.get_count (p_path =>'.'); --Đếm tổng số chuỗi trả về
    --DBMS_OUTPUT.put_line(TO_CHAR(l_numrow));
    
    FOR i IN 1 .. l_numrow
    LOOP
        n_id := TO_NUMBER(apex_json.get_varchar2('[%d].$id', i));        
        n_code := apex_json.get_clob('[%d].absencecode_id', i);
        n_name := apex_json.get_varchar2('[%d].description', i);
        n_group := apex_json.get_varchar2('[%d].absence_group', i);
        n_registration := apex_json.get_boolean('[%d].registration', i);

        /*
        SELECT COUNT(ID) INTO l_count_idemp FROM REQUEST_TYPE WHERE ID = i ;
        If l_count_idemp > 0 Then
            UPDATE REQUEST_TYPE SET REQUEST_TYPE_CODE = n_code, NAME = n_name
            WHERE ID = i ;            

        Else
            INSERT INTO REQUEST_TYPE(ID, REQUEST_TYPE_CODE, NAME)
            VALUES(i, n_code, n_name);
        End If;
        */

        -- IF lower(n_group) = 'leave' then
        --     EXIT;
        -- end if;
           
        IF n_registration THEN

            -- INSERT/UPDATE absence_code where regist = TRUE
            SELECT COUNT(*) INTO l_count_idemp FROM ABSENCE_CODE_LIST WHERE ACL_ABSENCECODE_ID = n_code;
            If l_count_idemp > 0 Then
                UPDATE ABSENCE_CODE_LIST SET ACL_ABSENCECODE_ID = n_code, ACL_DESCRIPTION = n_name, ABSENCE_GROUP = n_group
                WHERE ACL_ABSENCECODE_ID = n_code ;            

            Else
                INSERT INTO ABSENCE_CODE_LIST(ACL_ABSENCECODE_ID, ACL_DESCRIPTION, ABSENCE_GROUP)
                VALUES(n_code, n_name, n_group);
            End If;

        ELSE
            -- DELETE absence_code where regist = FALSE
            DELETE FROM ABSENCE_CODE_LIST WHERE ACL_ABSENCECODE_ID = n_code;
        END IF;

        --n_checked_date := TO_CHAR(TO_DATE(n_checked_date, 'YYYY-MM-DD'), 'DD/MM/YYYY');
        COMMIT; 
         
    END LOOP;
    --DBMS_OUTPUT.put_line(TO_CHAR(n_id)||n_name||TO_CHAR(n_managerPosition));
    
END;
/