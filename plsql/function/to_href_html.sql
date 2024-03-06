-- Oracle APEX 23.1.5
-- attachment_url := 'https://hcm01.vstorage.vngcloud.vn/v1/AUTH_77c1e15122904b63990a9da99711590d/ERP_PORTAL/07-11-2023_626_1699310580956.jpg;https://hcm01.vstorage.vngcloud.vn/v1/AUTH_77c1e15122904b63990a9da99711590d/ERP_PORTAL/07-11-2023_626_1699310581282.jpg';
-- attachment_name := '07-11-2023_626_1699310580956.jpg;07-11-2023_626_1699310581282.jpg';

-- href_html = to_href_html(attachment_url, attachment_name);

-- --href_html should be: '<a href=\"https://hcm01.vstorage.vngcloud.vn/v1/AUTH_77c1e15122904b63990a9da99711590d/ERP_PORTAL/07-11-2023_626_1699310580956.jpg'\">07-11-2023_626_1699310580956.jpg</a> <a href=\"https://hcm01.vstorage.vngcloud.vn/v1/AUTH_77c1e15122904b63990a9da99711590d/ERP_PORTAL/07-11-2023_626_1699310581282.jpg'\">07-11-2023_626_1699310581282.jpg</a>'


CREATE OR REPLACE FUNCTION to_href_html(
    attachment_url IN VARCHAR2,
    attachment_name IN VARCHAR2
) RETURN VARCHAR2
IS
    href_html VARCHAR2(4000);
    attachment_url_arr APEX_APPLICATION_GLOBAL.VC_ARR2;
    attachment_name_arr APEX_APPLICATION_GLOBAL.VC_ARR2;
BEGIN
    attachment_url_arr := APEX_UTIL.STRING_TO_TABLE(attachment_url, ';');
    attachment_name_arr := APEX_UTIL.STRING_TO_TABLE(attachment_name, ';');
    FOR i IN 1..attachment_url_arr.COUNT LOOP
        href_html := href_html || '<a href="' || attachment_url_arr(i) || '">' || attachment_name_arr(i) || '</a> ';
    END LOOP;
    RETURN href_html;
END;

-- create a script to test
DECLARE
    attachment_url VARCHAR2(4000);
    attachment_name VARCHAR2(4000);
    href_html VARCHAR2(4000);
BEGIN
    attachment_url := 'https://hcm01.vstorage.vngcloud.vn/v1/AUTH_77c1e15122904b63990a9da99711590d/ERP_PORTAL/07-11-2023_626_1699310580956.jpg;https://hcm01.vstorage.vngcloud.vn/v1/AUTH_77c1e15122904b63990a9da99711590d/ERP_PORTAL/07-11-2023_626_1699310581282.jpg';
    attachment_name := '07-11-2023_626_1699310580956.jpg;07-11-2023_626_1699310581282.jpg';
    href_html := to_href_html(attachment_url, attachment_name);
    dbms_output.put_line(href_html);
END;
```