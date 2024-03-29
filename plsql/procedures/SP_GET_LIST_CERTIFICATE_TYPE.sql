-- API RESPONSE:
-- [
--     {
        -- "$id": "1",
        -- "HcmCertificateTypeId": "CCNA",
        -- "CertificateDescription": "Quản trị mạng"
--     },
-- ]
-- TABLE: LIST_CERTIFICATE_TYPE
-- LCT_ID	NUMBER(4,0)
-- LCT_HCM_CERTIFICATE_TYPE_ID	NVARCHAR2(30 CHAR)
-- LCT_CERTIFICATE_DESCRIPTION	NVARCHAR2(100 CHAR)

create or replace PROCEDURE "SP_GET_LIST_CERTIFICATE_TYPE"
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

n_HcmCertificateTypeId NVARCHAR2(30);
n_CertificateDescription NVARCHAR2(100);

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
            p_url => global_vars.get_resource_url || '/api/services/HRPortalServices/EmployeeProfileService/getCertificateType',
            p_http_method => 'POST',
            p_transfer_timeout => 3600
            ) --;
    );

    l_numrow := APEX_JSON.get_count (p_path =>'.'); --Đếm tổng số chuỗi trả về

    
    FOR i IN 1 .. l_numrow
    LOOP

        n_HcmCertificateTypeId := apex_json.get_varchar2('[%d].HcmCertificateTypeId', i);
        n_CertificateDescription := apex_json.get_varchar2('[%d].CertificateDescription', i);

        SELECT COUNT(*) INTO l_count_idemp FROM LIST_CERTIFICATE_TYPE WHERE LCT_HCM_CERTIFICATE_TYPE_ID = n_HcmCertificateTypeId;
        
        If l_count_idemp > 0 Then
            UPDATE LIST_CERTIFICATE_TYPE 
            SET LCT_CERTIFICATE_DESCRIPTION = n_CertificateDescription
            WHERE LCT_HCM_CERTIFICATE_TYPE_ID = n_HcmCertificateTypeId;
        Else
            INSERT INTO LIST_CERTIFICATE_TYPE (LCT_HCM_CERTIFICATE_TYPE_ID, LCT_CERTIFICATE_DESCRIPTION)
            VALUES (n_HcmCertificateTypeId, n_CertificateDescription);
        End If;

        COMMIT; 
         
    END LOOP;
    --DBMS_OUTPUT.put_line(TO_CHAR(n_id)||n_name||TO_CHAR(n_managerPosition));
    
END;
/