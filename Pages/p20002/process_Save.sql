declare
c_date date := to_char(sysdate,'MM/DD/YYYY');
scholarship_request_id number;
pro_code nvarchar2(50);
begin

    --if :P20002_REQUEST_ID is null then
    -- select PROMOTION_CODE into pro_code
    -- from COREEDU_PROMOTION
    -- where PROGRAM = :P20002_PROGRAM and DISCOUNT_RATE = :P20002_DISCOUNT_RATE;
    
        INSERT INTO
            SCHOLARSHIP_REQUEST(
                STATUS,
                RECIPIENT_TYPE,
                PROGRAM,
                REQUESTER_CODE,
                REQUESTER_DEPARTMENT,
                REQUESTER_DEPARTMENT_CODE,
                REQUESTER_LEVEL,
                PARTNER_NAME,
                PARTNER_PHONE,
                PARTNER_TITLE,
                PARTNER_DEPARTMENT,
                PARTNER_FIELD,
                PARTNER_WORKPLACE,
                RECIPIENT_NAME,
                RECIPIENT_DOB,
                RECIPIENT_PHONE,
                RECIPIENT_RELATIONSHIP,
                RECIPIENT_CAMPUS,
                ATTACH_NAME,
                ATTACH_FILE,
                RECIPIENT_REPLACEMENT,
                RECIPIENT_VOUCHER_CODE_REPLACEMENT,
                RECIPIENT_EXPIRATION_DATE_REPLACEMENT,
                RECIPIENT_NOTE,
                RECIPIENT_REASON_REQUEST,
                DISCOUNT_RATE,
                VOUCHER_CODE,
                NUMBER_OF_COURSES,
                EFFECTIVE_DATE,
                EXPIRATION_DATE,
                APPROVED_DATE,
                CREATED_DATE,
                DETAIL_ID,
                PROMOTION_CODE
            )
        VALUES
        (
                1,
                :P20002_SCHOLARSHIP_RECIPIENT,
                :P20002_PROGRAM,
                case
                    when :P20002_SCHOLARSHIP_RECIPIENT = 'D' then :P20002_REQUEST_NAME
                else
                    :P20002_EMPLOYEE_CODE
                end,
                :P20002_DEPARTMENT,
                :P20002_DEPARTMENT_CODE,
                :P20002_LEVEL,
                :P20002_PARTNER_NAME,
                :P20002_PARTNER_PHONE,
                :P20002_TITLE,
                :P20002_PARTNER_DEPARTMENT,
                :P20002_FIELD,
                :P20002_WORKPLACE,
                :P20002_RECIPIENT_NAME,
                :P20002_RECIPIENT_DOB,
                :P20002_RECIPIENT_PHONE,
                :P20002_RELATIONSHIP,
                :P20002_CAMPUS,
                :P20002_NAME_FILES,
                :P20002_URL_FILES,
                :P20002_REPLACEMENT,
                :P20002_VOUCHER_CODE_REPLACEMENT,
                :P20002_EXPIRATION_DATE_REPLACEMENT,
                :P20002_NOTE,
                :P20002_REASON_REQUEST,
                :P20002_DISCOUNT_RATE,
                :P20002_VOUCHER_CODE,
                :P20002_NUMBER_OF_COURSES,
                :P20002_EFFECTIVE_DATE,
                :P20002_EXPIRATION_DATE,
                :P20002_APPROVED_DATE,
                c_date,
                :P20002_SCHOLARSHIP_DETAIL,
                pro_code
            ) returning ID into scholarship_request_id;

        for rec in (
            select 
                WF_FEATURE_APPLY,
                WF_PROCESS_ID 
            from 
                WORKFLOW 
            where 
                -- lower(WF_FEATURE_APPLY) = 'scholarship' 
                lower(WF_FEATURE_APPLY) = lower(:P20002_FEATURE) 
                and WF_EXPIRATION_DATE >= sysdate)
        loop
            insert into EMP_REQUESTS(
                REQUEST_TYPE,
                SUBMIT_DATE,
                EMPLOYEE_CODE,
                STATUS,
                NOTE,
                CREATE_DATE,
                REQUEST_DETAIL_ID,
                WF_PROCESS_ID,
                LINE_MANAGER
                )
            values(
                rec.WF_FEATURE_APPLY,
                sysdate,
                :APP_EMP_CODE,
                1,
                -- :P20002_NOTE,
                CASE 
                    WHEN :P20002_SCHOLARSHIP_RECIPIENT = 'A' OR :P20002_SCHOLARSHIP_RECIPIENT = 'B' THEN :P20002_NOTE
                    ELSE :P20002_REASON_REQUEST
                END,
                sysdate,
                scholarship_request_id,
                rec.WF_PROCESS_ID,
                :P20002_LINE_MANAGER
                );
        end loop;

    
    -- Insert ATTACHMENT_HISTORY
    IF(:P20002_DEFAULT_IMAGES_URL != :P20002_URL_FILES or
       ( :P20002_REQUEST_ID is null and :P20002_URL_FILES is not null )) 
    THEN
        INSERT INTO ATTACHMENT_HISTORY (ATTACHMENT_DATE, EMPLOYEE_CODE, ATTACHMENT_URL, ATTACHMENT_NAME, REQUEST_ID)
        VALUES(sysdate, :APP_EMP_CODE, :P20002_URL_FILES, :P20002_NAME_FILES, (select ID from EMP_REQUESTS er where scholarship_request_id = er.REQUEST_DETAIL_ID));
    END IF;

    -- Write log attachments
    -- INSERT INTO OUTPUT_LOGS(NUMBER1, STR1, STR2, STR3)
    -- VALUES ((select ID from EMP_REQUESTS er where scholarship_request_id = er.REQUEST_DETAIL_ID), 'savedraft_scho', :P20002_DEFAULT_IMAGES_URL, :P20002_URL_FILES);
    

end;