create or replace PROCEDURE "SP_GET_LIST_EDUCATION"
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
n_code NVARCHAR2(100 CHAR);
n_level_edu_description NVARCHAR2(2000);
n_level_of_edu NUMBER;
n_major NVARCHAR2(100 CHAR);
n_school_name VARCHAR2(2000);
n_end_date DATE;
p_token NVARCHAR2(10000);
BEGIN
    SP_GET_TOKEN(p_token);
    --apex_web_service.g_request_headers.delete();
    --apex_web_service.g_request_headers(1).name := 'tenant_id';
    --apex_web_service.g_request_headers(1).value := 'd1005fc5-bff9-42d5-81e5-1f3fcb089799';
    --apex_web_service.g_request_headers(2).name := 'client_id';
    --apex_web_service.g_request_headers(2).value := 'c74729ce-651b-41a6-9f44-d65d88c0f5e7';
    --apex_web_service.g_request_headers(3).name := 'client_secret';
    --apex_web_service.g_request_headers(3).value := 'Ddy8Q~2CS45IhZOGRAIINn3xew~Ivo9SecFeybYk';
    --apex_web_service.g_request_headers(4).name := 'resource';
    --apex_web_service.g_request_headers(4).value := 'https://hra.sandbox.operations.dynamics.com/';
    --apex_web_service.g_request_headers(5).name := 'grant_type';
    --apex_web_service.g_request_headers(5).value := 'client_credentials';

    --APEX_JSON.parse(
        --apex_web_service.make_rest_request(
            --p_url => 'https://login.microsoftonline.com/d1005fc5-bff9-42d5-81e5-1f3fcb089799/oauth2/token',
            --p_http_method => 'POST',
            --p_body => l_body,
            --p_transfer_timeout => 3600
            --)
    --);
    --l_numrow := APEX_JSON.get_count (p_path =>'.');
    --FOR i IN 1 .. l_numrow
    --LOOP
        --l_token_type := apex_json.get_varchar2('[%d].token_type', i);
        --l_access_token := apex_json.get_varchar2('[%d].access_token', i);
    --END LOOP;
    --l_authorization := l_token_type + ' ' + l_access_token;
    --DBMS_OUTPUT.put_line(l_authorization);
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
            p_url => 'https://hra.sandbox.operations.dynamics.com/api/services/HRPortalServices/EmployeeProfileService/getListEducation',
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
        n_employee_id := i;
        n_code := apex_json.get_varchar2('[%d].EmployeeCode', i);
        n_level_edu_description := apex_json.get_varchar2('[%d].LevelOfEduDescription', i);
       
        -- n_level_of_edu := TO_NUMBER(apex_json.get_varchar2('[%d].HcmEducationLevelId', i));
        n_level_of_edu := 1;

        n_major := apex_json.get_varchar2('[%d].VUSTC_Major', i);
        n_school_name := apex_json.get_varchar2('[%d].NameOfSchool', i);
        n_end_date := TO_DATE(apex_json.get_varchar2('[%d].EndDate', i), 'YYYY-MM-DD"T"HH24:MI:SS');

        
         
        SELECT COUNT(ID) INTO l_count_idemp FROM EMP_EDUCATION WHERE ID = i ;
        If l_count_idemp > 0 Then
            UPDATE EMP_EDUCATION SET EMPLOYEE_ID = n_employee_id, LEVEL_OF_EDU = n_level_of_edu,
                                MAJOR = n_major, PLACE = n_school_name,  GRADUATED_DATE = n_end_date, EMPLOYEE_CODE = n_code
            WHERE ID = i ;

        Else
            INSERT INTO EMP_EDUCATION(ID, EMPLOYEE_ID, LEVEL_OF_EDU, MAJOR, PLACE, GRADUATED_DATE, EMPLOYEE_CODE)
            VALUES(i, i, n_level_of_edu, n_major, n_school_name, n_end_date, n_code);
        End If;

        COMMIT; 
         
    END LOOP;
    --DBMS_OUTPUT.put_line(TO_CHAR(n_id)||n_name||TO_CHAR(n_managerPosition));
    
END;
/