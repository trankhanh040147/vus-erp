create or replace PROCEDURE "SP_SAVE_SPEACIAL_CUSTOMER_COREEDU"
(
    p_scholarship_request_id number,
    p_feature_apply NVARCHAR2,
    -- OUT status logs
    p_response_log OUT NVARCHAR2,
    p_response_status OUT NVARCHAR2
)
is
l_token_type NVARCHAR2(2000);
l_body NVARCHAR2(2000);
l_response clob;
l_response_clob clob;
l_numrow number;    
l_rowsub number;
l_body_mail NVARCHAR2(2000);

n_emp_request_status number;
n_approve_date date;
n_full_name NVARCHAR2(2000);
n_dob NVARCHAR2(2000);
n_phone NVARCHAR2(2000);
n_customer_group NVARCHAR2(2000);
n_promotion_code NVARCHAR2(2000);
n_from_date NVARCHAR2(2000);
n_to_date NVARCHAR2(2000);
n_voucher_code NVARCHAR2(2000);
n_effective_date NVARCHAR2(2000);
n_expire_date NVARCHAR2(2000);


rsp_status nvarchar2(50);
v_body clob := ''; -- body of mail

BEGIN

    SELECT TO_CHAR(SYSDATE, 'MM/DD/YYYY') INTO n_approve_date FROM DUAL;

    apex_web_service.g_request_headers.delete();
    apex_web_service.g_request_headers(1).name := 'Content-Type';
    apex_web_service.g_request_headers(1).value := 'application/json';
    apex_web_service.g_request_headers(2).name := 'username';
    apex_web_service.g_request_headers(2).value := 'coreedu-webapi-test';
    apex_web_service.g_request_headers(3).name := 'password';   
    apex_web_service.g_request_headers(3).value := 'p3$pus?e&lmls&tHaZ_d';

        -- BODY:
    -- {
    --     "Action":"SaveSpecialCustomer",
    --     "Fullname":"NGUYỄN VĂN THIỆN",
    --     "DOB":"1988-08-23",
    --     "Phone":"0908112233",
    --     "CustomerGroup":"500000002",
    --     "PromotionCode":"N_082023.HNQ",
    --     "FromDate":"2023-09-01",
    --     "ToDate":"2024-09-01",
    --     "VoucherCode":"0908112233",
    --     "EffectiveDate":"2023-09-01",
    --     "ExpireDate":"2024-09-01"
    -- }

    -- Get request status from EMP_REQUESTS
    select STATUS into n_emp_request_status from EMP_REQUESTS er where p_scholarship_request_id = er.REQUEST_DETAIL_ID and lower(er.REQUEST_TYPE) = lower(p_feature_apply) ;

    -- Get data from SCHOLARSHIP_REQUEST
    for rec in (select * from SCHOLARSHIP_REQUEST where ID = p_scholarship_request_id) loop

        select CUSTOMER_GROUP_ID into n_customer_group from COREEDU_CUSTOMER_GROUP where SCHOLARSHIP_RECIPIENT_TYPE = rec.RECIPIENT_TYPE and ROWNUM = 1;
        
        -- Get customer full_name, dob, phone
        n_full_name := rec.RECIPIENT_NAME;
        n_dob := to_char(rec.RECIPIENT_DOB, 'YYYY-MM-DD');
        n_phone := rec.RECIPIENT_PHONE;

        n_promotion_code := rec.PROMOTION_CODE;
        n_from_date := to_char(rec.EFFECTIVE_DATE, 'YYYY-MM-DD');
        n_to_date := to_char(rec.EXPIRATION_DATE, 'YYYY-MM-DD');
        n_voucher_code := rec.VOUCHER_CODE;
        n_effective_date := to_char(rec.EFFECTIVE_DATE, 'YYYY-MM-DD');
        n_expire_date := to_char(rec.EXPIRATION_DATE, 'YYYY-MM-DD');

        -- Set default value
        if n_promotion_code is NULL then
            SELECT PROMOTION_CODE
            INTO n_promotion_code
            FROM COREEDU_PROMOTION
            WHERE DISCOUNT_RATE = rec.DISCOUNT_RATE and PROGRAM = rec.PROGRAM and ROWNUM = 1;
        end if;

        -- if n_to_date is NULL then n_to_date := 31/12/2154
        n_to_date := NVL(n_to_date, '2154-12-31');

        l_body := '{
            "Action":"SaveSpecialCustomer",
            "Fullname":"' || n_full_name || '",
            "DOB":"' || n_dob || '",
            "Phone":"' || n_phone || '",
            "CustomerGroup":"' || n_customer_group || '",
            "PromotionCode":"' || n_promotion_code || '",
            "FromDate":"' || n_from_date || '",
            "ToDate":"' || n_to_date || '",
            "VoucherCode":"' || n_voucher_code || '",
            "EffectiveDate":"' || n_effective_date || '",
            "ExpireDate":"' || n_expire_date || '"
        }';

        
        DBMS_OUTPUT.put_line('[BODY]: ');
        DBMS_OUTPUT.put_line(l_body);

        -- Call API
        --         --APEX_JSON.parse(

        l_response := apex_web_service.make_rest_request(
                p_url => 'https://coreeduwebapitest.azurewebsites.net/vusapi/v1/DoAction',
                p_http_method => 'POST',
                p_body => l_body,
                p_transfer_timeout => 3600
                ) ;

        DBMS_OUTPUT.put_line('');
        DBMS_OUTPUT.put_line('[RESPONSE]: ');
        DBMS_OUTPUT.put_line(l_response);
        
        APEX_JSON.parse(l_response);

        -- Write API Logs
        -- Insert the log entry after you receive the response
        INSERT INTO LOGS_API_RESPONSE (
            API_ENDPOINT,
            REQUEST_HEADERS,
            REQUEST_BODY,
            RESPONSE_CODE,
            RESPONSE_BODY,
            CALL_TIMESTAMP
            -- NOTE
        ) VALUES (
            'SaveSpecialCustomer', -- Endpoint you just called
            apex_web_service.g_request_headers(1).value, -- This is a simplification, you may need to concatenate all headers
            l_body, -- The request body you sent
            apex_web_service.g_status_code, -- Response status code
            l_response, -- The response body you received
            SYSDATE
        );

    end loop;

    -- Status = 1 inserted successfully on D365, otherwise Status = 0
    -- rsp_status := apex_json.get_varchar2('Status', 1);
    -- DBMS_OUTPUT.put_line('STATUS: ' || rsp_status);

    -- Update request status
    -- UPDATE EMPLOYEE_REQUESTS SET INSERTED_STATUS = TO_NUMBER(rsp_status) WHERE ID = p_request_id;
    -- UPDATE EMPLOYEE_REQUESTS SET EMP_REQ_STATUS = 3 WHERE ID = p_request_id and rsp_status = '1';

    COMMIT; -- Commit the transaction to save the log

END;


-- URL: https://coreeduwebapitest.azurewebsites.net/vusapi/v1/DoAction

-- HEADER:
-- username: coreedu-webapi-test
-- password: p3$pus?e&lmls&tHaZ_d
-- Content-Type: application/json

-- BODY:
-- {
--     "Action":"SaveSpecialCustomer",
--     "Fullname":"NGUYỄN VĂN THIỆN",
--     "DOB":"1988-08-23",
--     "Phone":"0908112233",
--     "CustomerGroup":"500000002",
--     "PromotionCode":"N_082023.HNQ",
--     "FromDate":"2023-09-01",
--     "ToDate":"2024-09-01",
--     "VoucherCode":"0908112233",
--     "EffectiveDate":"2023-09-01",
--     "ExpireDate":"2024-09-01"
-- }

-- TABLE: SCHOLARSHIP_REQUEST
-- ID	NUMBER(10,0)
-- RECIPIENT_TYPE	VARCHAR2(10 CHAR)
-- PROGRAM	NVARCHAR2(50 CHAR)
-- REQUESTER_CODE	NVARCHAR2(50 CHAR)
-- REQUESTER_DEPARTMENT	NVARCHAR2(50 CHAR)
-- REQUESTER_DEPARTMENT_CODE	NVARCHAR2(50 CHAR)
-- REQUESTER_LEVEL	NVARCHAR2(20 CHAR)
-- PARTNER_NAME	NVARCHAR2(50 CHAR)
-- PARTNER_PHONE	NVARCHAR2(20 CHAR)
-- PARTNER_TITLE	NVARCHAR2(50 CHAR)
-- PARTNER_DEPARTMENT	NVARCHAR2(50 CHAR)
-- PARTNER_FIELD	NVARCHAR2(50 CHAR)
-- PARTNER_WORKPLACE	NVARCHAR2(50 CHAR)
-- RECIPIENT_NAME	NVARCHAR2(50 CHAR)
-- RECIPIENT_DOB	DATE
-- RECIPIENT_PHONE	NVARCHAR2(20 CHAR)
-- RECIPIENT_RELATIONSHIP	NVARCHAR2(50 CHAR)
-- RECIPIENT_CAMPUS	NVARCHAR2(50 CHAR)
-- ATTACH_NAME	VARCHAR2(2000 CHAR)
-- ATTACH_FILE	VARCHAR2(2000 CHAR)
-- RECIPIENT_REPLACEMENT	NVARCHAR2(100 CHAR)
-- RECIPIENT_VOUCHER_CODE_REPLACEMENT	NVARCHAR2(50 CHAR)
-- RECIPIENT_EXPIRATION_DATE_REPLACEMENT	DATE
-- RECIPIENT_NOTE	NVARCHAR2(1000 CHAR)
-- RECIPIENT_REASON_REQUEST	NVARCHAR2(1000 CHAR)
-- DISCOUNT_RATE	NUMBER(3,0)
-- VOUCHER_CODE	NVARCHAR2(50 CHAR)
-- NUMBER_OF_COURSES	NUMBER(5,0)
-- EFFECTIVE_DATE	DATE
-- EXPIRATION_DATE	DATE
-- APPROVED_DATE	DATE
-- CREATED_DATE	DATE
-- STATUS	NUMBER(2,0)
-- DETAIL_ID	NUMBER(10,0)
-- PROMOTION_CODE	NVARCHAR2(50 CHAR)


-- declare
--     response_log NVARCHAR2(2000);
--     response_status NVARCHAR2(2000);
-- begin
--     SP_SAVE_SPEACIAL_CUSTOMER_COREEDU('530', 'scholarship', response_log, response_status);
--     DBMS_OUTPUT.put_line('response_log: ' || response_log);
--     DBMS_OUTPUT.put_line('response_status: ' || response_status);
-- end;