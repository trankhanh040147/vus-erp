-- INSERT INTO SCHOLARSHIP_REQUEST(
-- STATUS, RECIPIENT_TYPE, PROGRAM, REQUESTER_CODE, REQUESTER_DEPARTMENT, REQUESTER_DEPARTMENT_CODE, REQUESTER_LEVEL, 
-- PARTNER_NAME, PARTNER_PHONE, PARTNER_TITLE, PARTNER_DEPARTMENT, PARTNER_FIELD, PARTNER_WORKPLACE, 
-- RECIPIENT_NAME, RECIPIENT_DOB, RECIPIENT_PHONE, RECIPIENT_RELATIONSHIP, RECIPIENT_CAMPUS, ATTACH_NAME, ATTACH_FILE, 
-- RECIPIENT_REPLACEMENT, RECIPIENT_VOUCHER_CODE_REPLACEMENT, RECIPIENT_EXPIRATION_DATE_REPLACEMENT, RECIPIENT_NOTE, RECIPIENT_REASON_REQUEST, 
-- DISCOUNT_RATE, VOUCHER_CODE, NUMBER_OF_COURSES, EFFECTIVE_DATE, EXPIRATION_DATE, APPROVED_DATE, CREATED_DATE)
-- VALUES(
-- STATUS, :P22_SCHOLARSHIP_RECIPIENT, :P22_PROGRAM, :P22_EMPLOYEE_CODE, :P22_DEPARTMENT, :P22_DEPARTMENT_CODE, :P22_LEVEL, 
-- :P22_PARTNER_NAME, :P22_PARTNER_PHONE, :P22_TITLE, :P22_PARTNER_DEPARTMENT, :P22_FIELD, :P22_WORKPLACE, 
-- :P22_RECIPIENT_NAME, :P22_RECIPIENT_DOB, :P22_RECIPIENT_PHONE, :P22_RELATIONSHIP, :P22_CAMPUS, :P22_NAME_FILES, :P22_URL_FILES, 
-- :P22_REPLACEMENT, :P22_VOUCHER_CODE_REPLACEMENT, :P22_EXPIRATION_DATE_REPLACEMENT, :P22_NOTE, :P22_REASON_REQUEST, 
-- :P22_DISCOUNT_RATE, :P22_VOUCHER_CODE, :P22_NUMBER_OF_COURSES, :P22_EFFECTIVE_DATE, :P22_EXPIRATION_DATE, :P22_APPROVED_DATE, c_date);


declare
c_date date := to_char(sysdate,'MM/DD/YYYY');

begin
    -- INSERT INTO
    --     SCHOLARSHIP_REQUEST(
    --         STATUS,
    --         RECIPIENT_TYPE,
    --         PROGRAM,
    --         REQUESTER_CODE,
    --         REQUESTER_DEPARTMENT,
    --         REQUESTER_DEPARTMENT_CODE,
    --         REQUESTER_LEVEL,
    --         PARTNER_NAME,
    --         PARTNER_PHONE,
    --         PARTNER_TITLE,
    --         PARTNER_DEPARTMENT,
    --         PARTNER_FIELD,
    --         PARTNER_WORKPLACE,
    --         RECIPIENT_NAME,
    --         RECIPIENT_DOB,
    --         RECIPIENT_PHONE,
    --         RECIPIENT_RELATIONSHIP,
    --         RECIPIENT_CAMPUS,
    --         ATTACH_NAME,
    --         ATTACH_FILE,
    --         RECIPIENT_REPLACEMENT,
    --         RECIPIENT_VOUCHER_CODE_REPLACEMENT,
    --         RECIPIENT_EXPIRATION_DATE_REPLACEMENT,
    --         RECIPIENT_NOTE,
    --         RECIPIENT_REASON_REQUEST,
    --         DISCOUNT_RATE,
    --         VOUCHER_CODE,
    --         NUMBER_OF_COURSES,
    --         EFFECTIVE_DATE,
    --         EXPIRATION_DATE,
    --         APPROVED_DATE,
    --         CREATED_DATE
    --     )
    -- VALUES
    -- (
    --         2,
    --         :P22_SCHOLARSHIP_RECIPIENT,
    --         :P22_PROGRAM,
    --         --'0013'
    --         --:P22_EMPLOYEE_CODE
    --         case
    --             when :P22_SCHOLARSHIP_RECIPIENT = 'D' then :P22_REQUEST_NAME
    --         else
    --             :P22_EMPLOYEE_CODE
    --         end,
    --         :P22_DEPARTMENT,
    --         :P22_DEPARTMENT_CODE,
    --         :P22_LEVEL,
    --         :P22_PARTNER_NAME,
    --         :P22_PARTNER_PHONE,
    --         :P22_TITLE,
    --         :P22_PARTNER_DEPARTMENT,
    --         :P22_FIELD,
    --         :P22_WORKPLACE,
    --         :P22_RECIPIENT_NAME,
    --         :P22_RECIPIENT_DOB,
    --         :P22_RECIPIENT_PHONE,
    --         :P22_RELATIONSHIP,
    --         :P22_CAMPUS,
    --         :P22_NAME_FILES,
    --         :P22_URL_FILES,
    --         :P22_REPLACEMENT,
    --         :P22_VOUCHER_CODE_REPLACEMENT,
    --         :P22_EXPIRATION_DATE_REPLACEMENT,
    --         :P22_NOTE,
    --         :P22_REASON_REQUEST,
    --         :P22_DISCOUNT_RATE,
    --         :P22_VOUCHER_CODE,
    --         :P22_NUMBER_OF_COURSES,
    --         :P22_EFFECTIVE_DATE,
    --         :P22_EXPIRATION_DATE,
    --         :P22_APPROVED_DATE,
    --         c_date
    --     );

    if :P22_REQUEST_ID is null then
        for rec in (select WF_FEATURE_APPLY,WF_PROCESS_ID from WORKFLOW where lower(WF_FEATURE_APPLY) = 'scholarship' and WF_EXPIRATION_DATE >= sysdate)loop
    insert into EMP_REQUESTS(REQUEST_TYPE,SUBMIT_DATE,EMPLOYEE_CODE,STATUS,NOTE,CREATE_DATE,REQUEST_DETAIL_ID,WF_PROCESS_ID,LINE_MANAGER)
    values(rec.WF_FEATURE_APPLY,sysdate,:APP_EMP_CODE,2,:P22_NOTE, sysdate,
    :P22_SCHOLARSHIP_DETAIL,
    rec.WF_PROCESS_ID,:P22_LINE_MANAGER);
end loop;

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
                DETAIL_ID
            )
        VALUES
        (
                2,
                :P22_SCHOLARSHIP_RECIPIENT,
                :P22_PROGRAM,
                --'0013'
                --:P22_EMPLOYEE_CODE
                case
                    when :P22_SCHOLARSHIP_RECIPIENT = 'D' then :P22_REQUEST_NAME
                else
                    :P22_EMPLOYEE_CODE
                end,
                :P22_DEPARTMENT,
                :P22_DEPARTMENT_CODE,
                :P22_LEVEL,
                :P22_PARTNER_NAME,
                :P22_PARTNER_PHONE,
                :P22_TITLE,
                :P22_PARTNER_DEPARTMENT,
                :P22_FIELD,
                :P22_WORKPLACE,
                :P22_RECIPIENT_NAME,
                :P22_RECIPIENT_DOB,
                :P22_RECIPIENT_PHONE,
                :P22_RELATIONSHIP,
                :P22_CAMPUS,
                :P22_NAME_FILES,
                :P22_URL_FILES,
                :P22_REPLACEMENT,
                :P22_VOUCHER_CODE_REPLACEMENT,
                :P22_EXPIRATION_DATE_REPLACEMENT,
                :P22_NOTE,
                :P22_REASON_REQUEST,
                :P22_DISCOUNT_RATE,
                :P22_VOUCHER_CODE,
                :P22_NUMBER_OF_COURSES,
                :P22_EFFECTIVE_DATE,
                :P22_EXPIRATION_DATE,
                :P22_APPROVED_DATE,
                c_date,
                :P22_SCHOLARSHIP_DETAIL
            );
    else
        UPDATE SCHOLARSHIP_REQUEST sr
        SET STATUS = 2,
            RECIPIENT_TYPE = :P22_SCHOLARSHIP_RECIPIENT,
            PROGRAM = :P22_PROGRAM,
            REQUESTER_CODE = 
                CASE 
                    WHEN :P22_SCHOLARSHIP_RECIPIENT = 'D' THEN :P22_REQUEST_NAME
                    ELSE :P22_EMPLOYEE_CODE
                END,
            REQUESTER_DEPARTMENT = :P22_DEPARTMENT,
            REQUESTER_DEPARTMENT_CODE = :P22_DEPARTMENT_CODE,
            REQUESTER_LEVEL = :P22_LEVEL,
            PARTNER_NAME = :P22_PARTNER_NAME,
            PARTNER_PHONE = :P22_PARTNER_PHONE,
            PARTNER_TITLE = :P22_TITLE,
            PARTNER_DEPARTMENT = :P22_PARTNER_DEPARTMENT,
            PARTNER_FIELD = :P22_FIELD,
            PARTNER_WORKPLACE = :P22_WORKPLACE,
            RECIPIENT_NAME = :P22_RECIPIENT_NAME,
            RECIPIENT_DOB = :P22_RECIPIENT_DOB,
            RECIPIENT_PHONE = :P22_RECIPIENT_PHONE,
            RECIPIENT_RELATIONSHIP = :P22_RELATIONSHIP,
            RECIPIENT_CAMPUS = :P22_CAMPUS,
            ATTACH_NAME = :P22_NAME_FILES,
            ATTACH_FILE = :P22_URL_FILES,
            RECIPIENT_REPLACEMENT = :P22_REPLACEMENT,
            RECIPIENT_VOUCHER_CODE_REPLACEMENT = :P22_VOUCHER_CODE_REPLACEMENT,
            RECIPIENT_EXPIRATION_DATE_REPLACEMENT = :P22_EXPIRATION_DATE_REPLACEMENT,
            RECIPIENT_NOTE = :P22_NOTE,
            RECIPIENT_REASON_REQUEST = :P22_REASON_REQUEST,
            DISCOUNT_RATE = :P22_DISCOUNT_RATE,
            VOUCHER_CODE = :P22_VOUCHER_CODE,
            NUMBER_OF_COURSES = :P22_NUMBER_OF_COURSES,
            EFFECTIVE_DATE = :P22_EFFECTIVE_DATE,
            EXPIRATION_DATE = :P22_EXPIRATION_DATE,
            APPROVED_DATE = :P22_APPROVED_DATE,
            CREATED_DATE = c_date
        WHERE :P22_REQUEST_ID = sr.ID;
    end if;

    -- Insert into EMP_REQUEST
    begin
    for rec in (select WF_FEATURE_APPLY,WF_PROCESS_ID from WORKFLOW where WF_FEATURE_APPLY = :P22_FEATURE and WF_EXPIRATION_DATE >= sysdate)loop
        insert into EMP_REQUESTS(REQUEST_TYPE,SUBMIT_DATE,EMPLOYEE_CODE,STATUS,NOTE,CREATE_DATE,REQUEST_DETAIL_ID,WF_PROCESS_ID,LINE_MANAGER,CONVERT_TYPE,CONVERT_VALUE)
        values(rec.WF_FEATURE_APPLY,sysdate,:APP_EMP_CODE,2,:P22_NOTE, sysdate,:P22_DETAIL_ID,rec.WF_PROCESS_ID,:P22_LINE_MANAGER,:P22_COVERTED,:P22_TOTAL_DAY_OFF) returning ID into :P22_REQUEST_ID;
    end loop;

    end;

end;