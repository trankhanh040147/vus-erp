-- APEX ORACLE 23.1.5
create or replace PROCEDURE "SP_GET_LIST_CUSTOMER_GROUP_COREEDU"
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
l_keys APEX_T_VARCHAR2;
l_count NUMBER;

n_customer_group_id VARCHAR2(20);
n_customer_group_name NVARCHAR2(50);
n_scholarship_recipient_type VARCHAR2(5);

p_token NVARCHAR2(10000);
BEGIN
    SP_GET_TOKEN(p_token);

    apex_web_service.g_request_headers.delete();
    apex_web_service.g_request_headers(1).name := 'Content-Type';
    apex_web_service.g_request_headers(1).value := 'application/json';
    apex_web_service.g_request_headers(2).name := 'username';
    apex_web_service.g_request_headers(2).value := 'coreedu-webapi-test';
    apex_web_service.g_request_headers(3).name := 'password';
    apex_web_service.g_request_headers(3).value := 'p3$pus?e&lmls&tHaZ_d';

    l_body := '{"Action":"GetListCustomerGroup"}';

    l_response := apex_web_service.make_rest_request(
        p_url => 'https://coreeduwebapitest.azurewebsites.net/vusapi/v1/DoAction',
        p_http_method => 'POST',
        p_body => l_body,
        p_transfer_timeout => 3600
    );

    -- Print the response
    DBMS_OUTPUT.PUT_LINE('Response: ' || l_response);

    APEX_JSON.parse(l_response);

    -- response: 
--     "500000000": "Sponsor",
--     "500000001": "Partner",
--     "500000002": "Staff",
--     "500000003": "   "
-- each is a row in table COREEDU_CUSTOMER_GROUP with value as: customer_group_id : 500000000, customer_group_name : Sponsor

  -- Loop through the JSON object
    for i in 1 .. APEX_JSON.get_count(p_path => '.') loop
        -- get customer_group_id (500000000)
        n_customer_group_id := APEX_JSON.get_varchar2(p_path => 'keys[' || i || ']');
        DBMS_OUTPUT.PUT_LINE('customer_group_id: ' || n_customer_group_id);
        -- get customer_group_name (Sponsor)
        n_customer_group_name := APEX_JSON.get_varchar2(p_path => 'values[' || i || ']');
        DBMS_OUTPUT.PUT_LINE('customer_group_name: ' || n_customer_group_name);
        -- n_customer_group_id := APEX_JSON.get_varchar2(p_path => 'keys[' || i || ']');
        -- n_customer_group_name := APEX_JSON.get_varchar2(p_path => 'values[' || i || ']');
        n_scholarship_recipient_type := 'N'; -- Default value

        -- Check if the record exists in COREEDU_CUSTOMER_GROUP
        SELECT COUNT(ID) INTO l_count_idemp FROM COREEDU_CUSTOMER_GROUP 
        WHERE CUSTOMER_GROUP_ID = n_customer_group_id;

        -- Insert or update the record
        If l_count_idemp > 0 Then
            -- Update existing record
            UPDATE COREEDU_CUSTOMER_GROUP
            SET CUSTOMER_GROUP_NAME = n_customer_group_name,
                SCHOLARSHIP_RECIPIENT_TYPE = n_scholarship_recipient_type
            WHERE CUSTOMER_GROUP_ID = n_customer_group_id;
        Else
            -- Insert new record
            INSERT INTO COREEDU_CUSTOMER_GROUP(
                CUSTOMER_GROUP_ID,
                CUSTOMER_GROUP_NAME,
                SCHOLARSHIP_RECIPIENT_TYPE
            )
            VALUES (
                n_customer_group_id,
                n_customer_group_name,
                n_scholarship_recipient_type
            );
        End If;

        COMMIT; 
    end loop;
    
END;


-- body:
-- {
--     "Action":"GetListCustomerGroup"
-- }

-- response: 
-- {
--     "500000000": "Sponsor",
--     "500000001": "Partner",
--     "500000002": "Staff",
--     "500000003": "Staffs_Relative"
-- }

-- TABLE: COREEDU_CUSTOMER_GROUP
-- ID	NUMBER(3,0)
-- CUSTOMER_GROUP_ID	VARCHAR2(20 CHAR)
-- CUSTOMER_GROUP_NAME	NVARCHAR2(50 CHAR)
-- SCHOLARSHIP_RECIPIENT_TYPE	VARCHAR2(5 CHAR)