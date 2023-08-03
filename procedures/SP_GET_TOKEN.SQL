create or replace PROCEDURE "SP_GET_TOKEN" is
  l_blob BLOB;
  l_body CLOB;
  l_method_url varchar2(255);
  l_clob_response CLOB;
  l_access_token varchar2(5000); -- Adjust the length as per your requirement
begin
  l_method_url := 'https://login.microsoftonline.com/d1005fc5-bff9-42d5-81e5-1f3fcb089799/oauth2/token';
  apex_web_service.g_request_headers(1).name := 'Content-Type';  
  apex_web_service.g_request_headers(1).value := 'multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW'; 
  l_body := '------WebKitFormBoundary7MA4YWxkTrZu0gW
Content-Disposition: form-data; name="tenant_id"

 

d1005fc5-bff9-42d5-81e5-1f3fcb089799
------WebKitFormBoundary7MA4YWxkTrZu0gW
Content-Disposition: form-data; name="grant_type"

 

client_credentials
------WebKitFormBoundary7MA4YWxkTrZu0gW
Content-Disposition: form-data; name="client_id"

 

6f663eae-a6cc-4d0d-80ff-73251258d544
------WebKitFormBoundary7MA4YWxkTrZu0gW
Content-Disposition: form-data; name="client_secret"

 

Irl8Q~cT2m3opVHwo-iQWkCzaVD7~l1bTb8qfaoR
------WebKitFormBoundary7MA4YWxkTrZu0gW
Content-Disposition: form-data; name="resource"

 

https://hra.sandbox.operations.dynamics.com
------WebKitFormBoundary7MA4YWxkTrZu0gW';

  l_blob := apex_web_service.make_rest_request_b(
    p_url => l_method_url,
    p_http_method => 'POST',
    p_body => l_body,
    p_transfer_timeout => 3600
  );

  l_clob_response := utl_raw.cast_to_varchar2(l_blob); -- Convert BLOB to CLOB
  APEX_JSON.parse(l_clob_response);

  l_access_token := apex_json.get_varchar2('access_token');

  DBMS_OUTPUT.PUT_LINE(l_access_token);
end;
/