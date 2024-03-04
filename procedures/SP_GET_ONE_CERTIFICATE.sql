create or replace PROCEDURE "SP_GET_ONE_CERTIFICATE"
(
    p_employee_code nvarchar2
)
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
n_certificate_description NVARCHAR2(100 CHAR);
n_start_date DATE;
n_end_date DATE;
n_short_note NVARCHAR2(100 CHAR);
n_certificate_type NVARCHAR2(100 CHAR);
p_token nvarchar2(10000);
n_rec_id NVARCHAR2(50 CHAR);

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
    --apex_web_service.g_request_headers(4).value := global_vars.get_resource_url || '/';
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
            p_url => global_vars.get_resource_url || '/api/services/HRPortalServices/EmployeeProfileService/getListCertificateEmployee',
            p_http_method => 'POST',
            --p_body => l_body,
            p_transfer_timeout => 3600
            ) --;
    );

    -- delete from EMP_CERTIFICATE;
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
        n_certificate_description := apex_json.get_varchar2('[%d].CertificateDescription', i);
        n_start_date := CASE WHEN apex_json.get_varchar2('[%d].StartDate', i) LIKE '%1900-01-01%' THEN NULL ELSE TO_CHAR(TO_DATE(apex_json.get_varchar2('[%d].StartDate', i), 'YYYY-MM-DD"T"HH24:MI:SS'), 'MM/DD/YYYY') END;
        n_end_date := CASE WHEN apex_json.get_varchar2('[%d].EndDate', i) LIKE '%1900-01-01%' THEN NULL ELSE TO_CHAR(TO_DATE(apex_json.get_varchar2('[%d].EndDate', i), 'YYYY-MM-DD"T"HH24:MI:SS'), 'MM/DD/YYYY') END;
        n_short_note := apex_json.get_varchar2('[%d].HrmShortNote', i);
        n_certificate_type := apex_json.get_varchar2('[%d].HcmCertificateTypeId', i);
        n_rec_id := apex_json.get_varchar2('[%d].CertificateRecId', i); 

        if n_code != p_employee_code then
            -- Skip this row, go to next row
            CONTINUE;
        end if;
         
        SELECT COUNT(ID) INTO l_count_idemp FROM EMP_CERTIFICATE WHERE REC_ID = n_rec_id ;

        If l_count_idemp > 0 Then
            UPDATE EMP_CERTIFICATE SET EMPLOYEE_ID = n_employee_id, CERTIFICATE_DESCRIPTION = n_certificate_description,
                                END_DATE = n_end_date, START_DATE = n_start_date,  SHORT_NOTE = n_short_note, CERTIFICATE_TYPE = n_certificate_type,  EMPLOYEE_CODE = n_code
            WHERE   REC_ID = n_rec_id;

        Else
            INSERT INTO EMP_CERTIFICATE(ID, EMPLOYEE_ID, CERTIFICATE_DESCRIPTION, END_DATE, START_DATE, SHORT_NOTE, CERTIFICATE_TYPE, EMPLOYEE_CODE, REC_ID)
            VALUES(i, i, n_certificate_description, n_end_date, n_start_date, n_short_note, n_certificate_type, n_code, n_rec_id);
        End If;

        COMMIT; 
         
    END LOOP;
    --DBMS_OUTPUT.put_line(TO_CHAR(n_id)||n_name||TO_CHAR(n_managerPosition));
    
END;
/