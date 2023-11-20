-- --------------------------------------------------------------------------------
-- 
-- Oracle APEX source export file
-- 
-- The contents of this file are intended for review and analysis purposes only.
-- Developers must use the Application Builder to make modifications to an
-- application. Changes to this file will not be reflected in the application.
-- 
-- --------------------------------------------------------------------------------

-- ----------------------------------------
-- Page: 22 - New Scholarship Request PK > Region: WORKFLOW_DETAILS > Source > SQL Query

select wd.ID,
       wd.WD_MODIFIED_DATE,
       wd.WD_MODIFIED_CODE,
       e.FULL_NAME,
       wd.WD_COMMENT,
       wd.WD_INFORMATION
  from WORKFLOW_DETAIL wd
  join EMPLOYEES e on wd.WD_MODIFIED_CODE = e.EMPLOYEE_CODE;

-- ----------------------------------------
-- Page: 22 - New Scholarship Request PK > Process: save > Source > PL/SQL Code

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
scholarship_request_id number;
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
    --         8,
    --         :P22_SCHOLARSHIP_RECIPIENT,
    --         :P22_PROGRAM,
    --         --:P22_EMPLOYEE_CODE,
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

    IF :P22_REQUEST_ID IS NULL THEN
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
                8,
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
            ) returning ID into scholarship_request_id;
    else
        UPDATE SCHOLARSHIP_REQUEST sr
        SET STATUS = 8,
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

    -- Insert EMP_REQUESTS
    FOR REC IN (SELECT WF_FEATURE_APPLY, WF_PROCESS_ID FROM WORKFLOW WHERE LOWER(WF_FEATURE_APPLY) = 'scholarship' AND WF_EXPIRATION_DATE >= SYSDATE)LOOP

    INSERT INTO EMP_REQUESTS(
        REQUEST_TYPE,
        SUBMIT_DATE,
        EMPLOYEE_CODE,
        STATUS,
        NOTE,
        CREATE_DATE,
        REQUEST_DETAIL_ID,
        WF_PROCESS_ID,
        LINE_MANAGER
    ) VALUES(
        REC.WF_FEATURE_APPLY,
        SYSDATE,
        :APP_EMP_CODE,
        1,
        :P22_NOTE,
        SYSDATE,
        scholarship_request_id,
        REC.WF_PROCESS_ID,
        :P22_LINE_MANAGER
    );

    END LOOP;

end;

-- ----------------------------------------
-- Page: 22 - New Scholarship Request PK > Process: save when submit > Source > PL/SQL Code

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
SCHOLARSHIP_REQUEST_ID NUMBER;
line_manager_code nvarchar2(50);
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

    SELECT MANAGER_ID INTO line_manager_code 
    FROM EMPLOYEES 
    WHERE EMPLOYEE_CODE = :APP_EMP_CODE;

    if :P22_REQUEST_ID is null then
--         for rec in (select WF_FEATURE_APPLY,WF_PROCESS_ID from WORKFLOW where lower(WF_FEATURE_APPLY) = 'scholarship' and WF_EXPIRATION_DATE >= sysdate)loop
--     insert into EMP_REQUESTS(REQUEST_TYPE,SUBMIT_DATE,EMPLOYEE_CODE,STATUS,NOTE,CREATE_DATE,REQUEST_DETAIL_ID,WF_PROCESS_ID,LINE_MANAGER)
--     values(rec.WF_FEATURE_APPLY,sysdate,:APP_EMP_CODE,2,:P22_NOTE, sysdate,
--     :P22_SCHOLARSHIP_DETAIL,
--     rec.WF_PROCESS_ID,:P22_LINE_MANAGER);
-- end loop;

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
            )
            returning ID into SCHOLARSHIP_REQUEST_ID;
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
    FOR REC IN (
        SELECT
            WF_FEATURE_APPLY,
            WF_PROCESS_ID
        FROM
            WORKFLOW
        WHERE
            WF_FEATURE_APPLY = :P22_FEATURE
            AND WF_EXPIRATION_DATE >= SYSDATE
    )LOOP
        INSERT INTO EMP_REQUESTS(
            REQUEST_TYPE,
            SUBMIT_DATE,
            EMPLOYEE_CODE,
            STATUS,
            NOTE,
            CREATE_DATE,
            REQUEST_DETAIL_ID,
            WF_PROCESS_ID,
            LINE_MANAGER
        ) VALUES(
            REC.WF_FEATURE_APPLY,
            SYSDATE,
            :APP_EMP_CODE,
            2,
            :P22_NOTE,
            SYSDATE,
            SCHOLARSHIP_REQUEST_ID,
            REC.WF_PROCESS_ID,
            line_manager_code
        );
    END LOOP;

end;

-- ----------------------------------------
-- Page: 22 - New Scholarship Request PK > Validation: btn_save_check_null_expiration_date > Validation > PL/SQL Function Body

BEGIN
  IF :P22_SCHOLARSHIP_RECIPIENT = 'D' or :P22_SCHOLARSHIP_RECIPIENT = 'C' THEN
    IF :P22_EXPIRATION_DATE IS NULL THEN
      RETURN FALSE; -- Trả về FALSE nếu 'EXPIRATION_DATE' chưa được điền
    ELSE
      RETURN TRUE; -- Trả về TRUE nếu 'EXPIRATION_DATE' đã được điền
    END IF;
  ELSE
    RETURN TRUE; -- Bỏ qua kiểm tra nếu 'SCHOLARSHIP_RECIPIENT' không có giá trị 'D'
  END IF;
END;

-- ----------------------------------------
-- Page: 22 - New Scholarship Request PK > Validation: btn_save_submit_check_null_expiration_date > Validation > PL/SQL Function Body

BEGIN
  IF :P22_SCHOLARSHIP_RECIPIENT = 'D' or :P22_SCHOLARSHIP_RECIPIENT = 'C' THEN
    IF :P22_EXPIRATION_DATE IS NULL THEN
      RETURN FALSE; -- Trả về FALSE nếu 'EXPIRATION_DATE' chưa được điền
    ELSE
      RETURN TRUE; -- Trả về TRUE nếu 'EXPIRATION_DATE' đã được điền
    END IF;
  ELSE
    RETURN TRUE; -- Bỏ qua kiểm tra nếu 'SCHOLARSHIP_RECIPIENT' không có giá trị 'D'
  END IF;
END;

-- ----------------------------------------
-- Page: 22 - New Scholarship Request PK > Dynamic Action: change_value_of_replacement > Action: set_value_for_expiration_date_replacement > Settings > SQL Statement

select sr.EXPIRATION_DATE
from SCHOLARSHIP_REQUEST sr
where sr.VOUCHER_CODE = :P22_REPLACEMENT;

-- ----------------------------------------
-- Page: 22 - New Scholarship Request PK > Dynamic Action: change_value_of_replacement > Action: set_value_for_voucher_code_replacement > Settings > SQL Statement

select sr.VOUCHER_CODE
from SCHOLARSHIP_REQUEST sr
where sr.VOUCHER_CODE = :P22_REPLACEMENT;

-- ----------------------------------------
-- Page: 22 - New Scholarship Request PK > Dynamic Action: set_value_for_voucher_code_3 > Action: Set Value > Settings > SQL Statement

-- select TO_CHAR(SYSDATE, 'mmYY') || '-' || :P22_VOUCHER_CODE_1 || '-' ||
--     case
--         when :P22_SCHOLARSHIP_RECIPIENT like 'A' or :P22_SCHOLARSHIP_RECIPIENT || '-ccc'
--         when :P22_SCHOLARSHIP_RECIPIENT like 'B' then :P22_EMPLOYEE_CODE || '-ccc'
--         when :P22_SCHOLARSHIP_RECIPIENT like 'C' then :P22_DEPARTMENT_CODE || '-ccc'
--         when :P22_SCHOLARSHIP_RECIPIENT like 'D' then :P22_DEPARTMENT_CODE || '-ccc'
--     end as result
-- from dual; 

select TO_CHAR(SYSDATE, 'mmYY') || '-' || :P22_VOUCHER_CODE_1 || '-' ||
    case
        when :P22_SCHOLARSHIP_RECIPIENT like 'A' or :P22_SCHOLARSHIP_RECIPIENT like 'B' then :P22_EMPLOYEE_CODE || '-' || :P22_VOUCHER_CODE_3
        else
            :P22_DEPARTMENT_CODE || '-' || :P22_VOUCHER_CODE_2
    end as result
from dual;

-- ----------------------------------------
-- Page: 22 - New Scholarship Request PK > Dynamic Action: set_value_for_voucher_code_2 > Action: Set Value > Settings > SQL Statement

-- select TO_CHAR(SYSDATE, 'mmYY') || '-' || :P22_VOUCHER_CODE_1 || '-' ||
--     case
--         when :P22_SCHOLARSHIP_RECIPIENT like 'A' or :P22_SCHOLARSHIP_RECIPIENT || '-ccc'
--         when :P22_SCHOLARSHIP_RECIPIENT like 'B' then :P22_EMPLOYEE_CODE || '-ccc'
--         when :P22_SCHOLARSHIP_RECIPIENT like 'C' then :P22_DEPARTMENT_CODE || '-ccc'
--         when :P22_SCHOLARSHIP_RECIPIENT like 'D' then :P22_DEPARTMENT_CODE || '-ccc'
--     end as result
-- from dual; 

select TO_CHAR(SYSDATE, 'mmYY') || '-' || :P22_VOUCHER_CODE_1 || '-' ||
    case
        when :P22_SCHOLARSHIP_RECIPIENT like 'A' or :P22_SCHOLARSHIP_RECIPIENT like 'B' then :P22_EMPLOYEE_CODE || '-' || :P22_VOUCHER_CODE_3
        else
            :P22_DEPARTMENT_CODE || '-' || :P22_VOUCHER_CODE_2
    end as result
from dual;

-- ----------------------------------------
-- Page: 22 - New Scholarship Request PK > Dynamic Action: set_value_for_voucher_code_ccc_department > Action: Set Value > Settings > SQL Statement

-- SELECT 
--   CASE 
--     WHEN :P22_SCHOLARSHIP_RECIPIENT IN ('A', 'B') THEN LTRIM(to_char(COUNT(REQUESTER_DEPARTMENT_CODE) + 1,'000'))
--     WHEN :P22_SCHOLARSHIP_RECIPIENT IN ('C', 'D') THEN LTRIM(to_char(COUNT(REQUESTER_CODE) + 1,'000'))
--   END AS result
-- FROM SCHOLARSHIP_REQUEST 
-- WHERE 
--   (:P22_SCHOLARSHIP_RECIPIENT IN ('A', 'B') AND REQUESTER_DEPARTMENT_CODE = :P22_DEPARTMENT_CODE) OR
--   (:P22_SCHOLARSHIP_RECIPIENT IN ('C', 'D') AND REQUESTER_CODE = :P22_EMPLOYEE_CODE);

SELECT  LTRIM(TO_CHAR(COUNT(REQUESTER_DEPARTMENT_CODE) + 1,'000')) 
FROM SCHOLARSHIP_REQUEST 
WHERE REQUESTER_DEPARTMENT_CODE = :P22_DEPARTMENT_CODE;

-- ----------------------------------------
-- Page: 22 - New Scholarship Request PK > Dynamic Action: change_value_of_request_name > Action: set_value_termination_date > Settings > SQL Statement

select emp.TERMINATE_DATE from EMPLOYEES emp where :P22_REQUEST_NAME = emp.EMPLOYEE_CODE;

-- ----------------------------------------
-- Page: 22 - New Scholarship Request PK > Dynamic Action: change_value_of_request_name > Action: set_value_start_date > Settings > SQL Statement

select emp.START_DATE from EMPLOYEES emp where :P22_REQUEST_NAME = emp.EMPLOYEE_CODE;

-- ----------------------------------------
-- Page: 22 - New Scholarship Request PK > Dynamic Action: change_value_of_request_name > Action: set_value_level > Settings > SQL Statement

select emp.LEVEL_DESCRIPTION from EMPLOYEES emp where :P22_REQUEST_NAME = emp.EMPLOYEE_CODE;

-- ----------------------------------------
-- Page: 22 - New Scholarship Request PK > Dynamic Action: change_value_of_request_name > Action: set_value_department > Settings > SQL Statement

select emp.DEPARTMENT_NAME from EMPLOYEES emp where :P22_REQUEST_NAME = emp.EMPLOYEE_CODE;

-- ----------------------------------------
-- Page: 22 - New Scholarship Request PK > Dynamic Action: change_value_of_request_name > Action: set_value_department_code > Settings > SQL Statement

select emp.DEPARTMENT_ID from EMPLOYEES emp where :P22_REQUEST_NAME = emp.EMPLOYEE_CODE;

-- ----------------------------------------
-- Page: 22 - New Scholarship Request PK > Dynamic Action: set_value_for_voucher_code_aaa > Action: Set Value > Settings > SQL Statement

select :P22_SCHOLARSHIP_RECIPIENT || :P22_DISCOUNT_RATE || '-' || :P22_PROGRAM from dual;

-- ----------------------------------------
-- Page: 22 - New Scholarship Request PK > Dynamic Action: set_value_for_voucher_code > Action: Set Value > Settings > SQL Statement

-- select TO_CHAR(SYSDATE, 'mmYY') || '-' || :P22_VOUCHER_CODE_1 || '-' ||
--     case
--         when :P22_SCHOLARSHIP_RECIPIENT like 'A' or :P22_SCHOLARSHIP_RECIPIENT || '-ccc'
--         when :P22_SCHOLARSHIP_RECIPIENT like 'B' then :P22_EMPLOYEE_CODE || '-ccc'
--         when :P22_SCHOLARSHIP_RECIPIENT like 'C' then :P22_DEPARTMENT_CODE || '-ccc'
--         when :P22_SCHOLARSHIP_RECIPIENT like 'D' then :P22_DEPARTMENT_CODE || '-ccc'
--     end as result
-- from dual; 

select TO_CHAR(SYSDATE, 'mmYY') || '-' || :P22_VOUCHER_CODE_1 || '-' ||
    case
        when :P22_SCHOLARSHIP_RECIPIENT like 'A' or :P22_SCHOLARSHIP_RECIPIENT like 'B' then :P22_EMPLOYEE_CODE || '-' || :P22_VOUCHER_CODE_3
        else
            :P22_DEPARTMENT_CODE || '-' || :P22_VOUCHER_CODE_2
    end as result
from dual;

-- ----------------------------------------
-- Page: 22 - New Scholarship Request PK > Dynamic Action: set_value_for_voucher_code_X > Action: set_value_for_voucher_code_ccc_employee > Settings > SQL Statement

SELECT LTRIM(TO_CHAR(COUNT(REQUESTER_CODE) + 1, '000')) FROM SCHOLARSHIP_REQUEST WHERE REQUESTER_CODE = :P22_EMPLOYEE_CODE;

-- ----------------------------------------
-- Page: 22 - New Scholarship Request PK > Dynamic Action: set_value_for_voucher_code_X > Action: set_value_for_voucher_code_X > Settings > SQL Statement

select :P22_SCHOLARSHIP_RECIPIENT || :P22_DISCOUNT_RATE || '-' || :P22_PROGRAM from dual;

-- ----------------------------------------
-- Page: 22 - New Scholarship Request PK > Dynamic Action: Change_B > Action: set_value_effective_day > Settings > SQL Statement

select SYSDATE from DUAL;

-- ----------------------------------------
-- Page: 22 - New Scholarship Request PK > Dynamic Action: Change_B > Action: set_value_termination_date > Settings > SQL Statement

select emp.TERMINATE_DATE from EMPLOYEES emp where :APP_USER_NAME = USER_NAME;

-- ----------------------------------------
-- Page: 22 - New Scholarship Request PK > Dynamic Action: Change_B > Action: set_value_start_date > Settings > SQL Statement

select emp.START_DATE from EMPLOYEES emp where :APP_USER_NAME = USER_NAME;

-- ----------------------------------------
-- Page: 22 - New Scholarship Request PK > Dynamic Action: Change_B > Action: set_value_level > Settings > SQL Statement

select LEVEL_DESCRIPTION from employees where :APP_USER_NAME = USER_NAME;

-- ----------------------------------------
-- Page: 22 - New Scholarship Request PK > Dynamic Action: Change_B > Action: set_value_department > Settings > SQL Statement

select DEPARTMENT_NAME from employees where :APP_USER_NAME = USER_NAME;

-- ----------------------------------------
-- Page: 22 - New Scholarship Request PK > Dynamic Action: Change_B > Action: set_value_requester_code > Settings > SQL Statement

select :APP_EMP_CODE from DUAL;

-- ----------------------------------------
-- Page: 22 - New Scholarship Request PK > Dynamic Action: Change_B > Action: set_value_requester_name_ab > Settings > SQL Statement

SELECT FULL_NAME FROM EMPLOYEES WHERE :APP_USER_NAME = USER_NAME;

-- ----------------------------------------
-- Page: 22 - New Scholarship Request PK > Dynamic Action: set_value_for_voucher_code_EP/ELT > Action: Set Value > Settings > SQL Statement

select :P22_SCHOLARSHIP_RECIPIENT || :P22_DISCOUNT_RATE || '-' || :P22_PROGRAM from dual;

-- ----------------------------------------
-- Page: 22 - New Scholarship Request PK > Dynamic Action: Change_D > Action: set_value_requester_name > Settings > SQL Statement

select EMPLOYEE_CODE from EMPLOYEES where USER_NAME = :APP_USER_NAME;

-- ----------------------------------------
-- Page: 22 - New Scholarship Request PK > Dynamic Action: Change_D > Action: set_value_ effective_day > Settings > SQL Statement

select SYSDATE from DUAL;

-- ----------------------------------------
-- Page: 22 - New Scholarship Request PK > Dynamic Action: Change_C > Action: set_value_requester_name > Settings > SQL Statement

select EMPLOYEE_CODE from EMPLOYEES where USER_NAME = :APP_USER_NAME;

-- ----------------------------------------
-- Page: 22 - New Scholarship Request PK > Dynamic Action: Change_C > Action: set_value_ effective_day > Settings > SQL Statement

select SYSDATE from DUAL;

-- ----------------------------------------
-- Page: 22 - New Scholarship Request PK > Dynamic Action: Change_A > Action: set_value_effective_day > Settings > SQL Statement

select SYSDATE from DUAL;

-- ----------------------------------------
-- Page: 22 - New Scholarship Request PK > Dynamic Action: Change_A > Action: set_value_recipient_dob > Settings > SQL Statement

select DOB from EMPLOYEES where USER_NAME = :APP_USER_NAME;

-- ----------------------------------------
-- Page: 22 - New Scholarship Request PK > Dynamic Action: Change_A > Action: set_value_recipient_name > Settings > SQL Statement

select FULL_NAME from employees where USER_NAME = :APP_USER_NAME;

-- ----------------------------------------
-- Page: 22 - New Scholarship Request PK > Dynamic Action: Change_A > Action: set_value_termination_date > Settings > SQL Statement

select emp.TERMINATE_DATE from EMPLOYEES emp where :APP_USER_NAME = USER_NAME;

-- ----------------------------------------
-- Page: 22 - New Scholarship Request PK > Dynamic Action: Change_A > Action: set_value_start_date > Settings > SQL Statement

select emp.START_DATE from EMPLOYEES emp where :APP_USER_NAME = USER_NAME;

-- ----------------------------------------
-- Page: 22 - New Scholarship Request PK > Dynamic Action: Change_A > Action: set_value_level > Settings > SQL Statement

select LEVEL_DESCRIPTION from employees where :APP_USER_NAME = USER_NAME;

-- ----------------------------------------
-- Page: 22 - New Scholarship Request PK > Dynamic Action: Change_A > Action: set_value_department > Settings > SQL Statement

select DEPARTMENT_NAME from employees where :APP_USER_NAME = USER_NAME;

-- ----------------------------------------
-- Page: 22 - New Scholarship Request PK > Dynamic Action: Change_A > Action: set_value_requester_code > Settings > SQL Statement

select :APP_EMP_CODE from DUAL;

-- ----------------------------------------
-- Page: 22 - New Scholarship Request PK > Dynamic Action: Change_A > Action: set_value_requester_name_ab > Settings > SQL Statement

SELECT FULL_NAME FROM EMPLOYEES WHERE :APP_USER_NAME = USER_NAME;

-- ----------------------------------------
-- Page: 22 - New Scholarship Request PK > Page Item: P22_NOTE > Default > PL/SQL Function Body

DECLARE
    temp nvarchar2(1000);
BEGIN
    IF :P22_REQUEST_ID IS NOT NULL THEN
       select RECIPIENT_NOTE into temp from SCHOLARSHIP_REQUEST where :P22_REQUEST_ID = ID;
       RETURN temp;
    ELSE
      RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 22 - New Scholarship Request PK > Page Item: P22_REASON_REQUEST > Default > PL/SQL Function Body

DECLARE
    temp nvarchar2(1000);
BEGIN
    IF :P22_REQUEST_ID IS NOT NULL THEN
       select RECIPIENT_REASON_REQUEST into temp from SCHOLARSHIP_REQUEST where :P22_REQUEST_ID = ID;
       RETURN temp;
    ELSE
      RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 22 - New Scholarship Request PK > Page Item: P22_EXPIRATION_DATE_REPLACEMENT > Default > PL/SQL Function Body

DECLARE
    temp date;
BEGIN
    IF :P22_REQUEST_ID IS NOT NULL THEN
       select RECIPIENT_EXPIRATION_DATE_REPLACEMENT into temp from SCHOLARSHIP_REQUEST where :P22_REQUEST_ID = ID;
       RETURN temp;
    ELSE
      RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 22 - New Scholarship Request PK > Page Item: P22_EXPIRATION_DATE > Default > PL/SQL Function Body

DECLARE
    temp DATE;
BEGIN
    IF :P22_REQUEST_ID IS NOT NULL THEN
       select EXPIRATION_DATE into temp from SCHOLARSHIP_REQUEST where :P22_REQUEST_ID = ID;
       RETURN temp;
    ELSE
      RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 22 - New Scholarship Request PK > Page Item: P22_VOUCHER_CODE_REPLACEMENT > Default > PL/SQL Function Body


DECLARE
    temp nvarchar2(1000);
BEGIN
    IF :P22_REQUEST_ID IS NOT NULL THEN
       select RECIPIENT_VOUCHER_CODE_REPLACEMENT into temp from SCHOLARSHIP_REQUEST where :P22_REQUEST_ID = ID;
       RETURN temp;
    ELSE
      RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 22 - New Scholarship Request PK > Page Item: P22_NUMBER_OF_COURSES > Default > PL/SQL Function Body

DECLARE
    temp NVARCHAR2(1000);
BEGIN
    IF :P22_REQUEST_ID IS NOT NULL THEN
       select EXPIRATION_DATE into temp from SCHOLARSHIP_REQUEST where :P22_REQUEST_ID = ID;
       RETURN temp;
    ELSE
      RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 22 - New Scholarship Request PK > Page Item: P22_REPLACEMENT > Default > PL/SQL Function Body

-- SELECT sr.RECIPIENT_NAME || ' - ' || sr.RECIPIENT_DOB, sr.VOUCHER_CODE as ID
-- FROM SCHOLARSHIP_REQUEST sr
-- WHERE sr.REQUESTER_CODE = :P22_EMPLOYEE_CODE AND sr.RECIPIENT_RELATIONSHIP != 1;

-- DECLARE
--     temp nvarchar2(1000);
-- BEGIN
--     IF :P22_REQUEST_ID IS NOT NULL THEN
--        select RECIPIENT_REPLACEMENT into temp from SCHOLARSHIP_REQUEST where :P22_REQUEST_ID = ID;
--        RETURN temp;
--     ELSE
--       RETURN NULL;
--     END IF;
-- END;

-- ----------------------------------------
-- Page: 22 - New Scholarship Request PK > Page Item: P22_REPLACEMENT > List of Values > SQL Query

SELECT sr.RECIPIENT_NAME || ' - ' || sr.RECIPIENT_DOB, sr.VOUCHER_CODE as ID
FROM SCHOLARSHIP_REQUEST sr
WHERE sr.REQUESTER_CODE = :P22_EMPLOYEE_CODE AND sr.RECIPIENT_RELATIONSHIP != 1;

-- ----------------------------------------
-- Page: 22 - New Scholarship Request PK > Page Item: P22_APPROVED_DATE > Default > PL/SQL Function Body

DECLARE
    temp DATE;
BEGIN
    IF :P22_REQUEST_ID IS NOT NULL THEN
       select APPROVED_DATE into temp from SCHOLARSHIP_REQUEST where :P22_REQUEST_ID = ID;
       RETURN temp;
    ELSE
      RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 22 - New Scholarship Request PK > Page Item: P22_EFFECTIVE_DATE > Default > PL/SQL Function Body

DECLARE
    temp DATE;
BEGIN
    IF :P22_REQUEST_ID IS NOT NULL THEN
       select EFFECTIVE_DATE into temp from SCHOLARSHIP_REQUEST where :P22_REQUEST_ID = ID;
       RETURN temp;
    ELSE
      RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 22 - New Scholarship Request PK > Page Item: P22_TERMINATION_DATE > Default > PL/SQL Function Body

--select TERMINATE_DATE from employees where USER_NAME = :APP_USER_NAME;

DECLARE
    temp nvarchar2(1000);
BEGIN
    IF :P22_REQUEST_ID IS NOT NULL THEN
    --    select REQUESTER_LEVEL into temp from SCHOLARSHIP_REQUEST where :P22_REQUEST_ID = ID;
       select emp.TERMINATE_DATE into temp 
       from EMPLOYEES emp 
       join SCHOLARSHIP_REQUEST sr 
       on emp.EMPLOYEE_CODE = sr.REQUESTER_CODE 
       where sr.ID = :P22_REQUEST_ID;

       RETURN temp;
    ELSE
    --    SELECT TERMINATE_DATE INTO temp FROM EMPLOYEES WHERE :APP_USER_NAME = USER_NAME; 
       
    --    RETURN temp;
       RETURN NULL;
    END IF;
END;



-- ----------------------------------------
-- Page: 22 - New Scholarship Request PK > Page Item: P22_START_DATE > Default > PL/SQL Function Body

--select START_DATE from EMPLOYEES where USER_NAME = :APP_USER_NAME;

DECLARE
    temp DATE;
BEGIN
    IF :P22_REQUEST_ID IS NOT NULL THEN
    --    select REQUESTER_LEVEL into temp from SCHOLARSHIP_REQUEST where :P22_REQUEST_ID = ID;
       select emp.START_DATE into temp 
       from EMPLOYEES emp 
       join SCHOLARSHIP_REQUEST sr 
       on emp.EMPLOYEE_CODE = sr.REQUESTER_CODE 
       where sr.ID = :P22_REQUEST_ID;

       RETURN temp;
    ELSE
    --    SELECT START_DATE INTO temp FROM EMPLOYEES WHERE :APP_USER_NAME = USER_NAME; 
       
    --    RETURN temp;
       RETURN NULL;
    END IF;
END;



-- ----------------------------------------
-- Page: 22 - New Scholarship Request PK > Page Item: P22_WORKPLACE > Default > PL/SQL Function Body

DECLARE
    temp nvarchar2(1000);
BEGIN
    IF :P22_REQUEST_ID IS NOT NULL THEN
       select PARTNER_WORKPLACE into temp from SCHOLARSHIP_REQUEST where :P22_REQUEST_ID = ID;
       RETURN temp;
    ELSE
      RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 22 - New Scholarship Request PK > Page Item: P22_LEVEL > Default > PL/SQL Function Body

--select LEVEL_DESCRIPTION from EMPLOYEES where USER_NAME = :APP_USER_NAME;

DECLARE
    temp nvarchar2(1000);
BEGIN
    IF :P22_REQUEST_ID IS NOT NULL THEN
       select REQUESTER_LEVEL into temp from SCHOLARSHIP_REQUEST where :P22_REQUEST_ID = ID;
       RETURN temp;
    ELSE
    --    SELECT LEVEL_DESCRIPTION INTO temp FROM EMPLOYEES WHERE :APP_USER_NAME = USER_NAME; 
    --    RETURN temp;
       RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 22 - New Scholarship Request PK > Page Item: P22_DEPARTMENT > Default > PL/SQL Function Body

--select DEPARTMENT_NAME from EMPLOYEES where USER_NAME = :APP_USER_NAME;

DECLARE
    temp nvarchar2(1000);
BEGIN
    IF :P22_REQUEST_ID IS NOT NULL THEN
       select REQUESTER_DEPARTMENT into temp from SCHOLARSHIP_REQUEST where :P22_REQUEST_ID = ID;
       RETURN temp;
    ELSE
    --    SELECT DEPARTMENT_NAME INTO temp FROM EMPLOYEES WHERE :APP_USER_NAME = USER_NAME; 
    --    RETURN temp;
       RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 22 - New Scholarship Request PK > Page Item: P22_DEPARTMENT > List of Values > SQL Query

select DISTINCT DEPARTMENT_NAME from EMPLOYEES;

-- ----------------------------------------
-- Page: 22 - New Scholarship Request PK > Page Item: P22_CAMPUS > Default > PL/SQL Function Body

--select RECIPIENT_CAMPUS from SCHOLARSHIP_REQUEST where :P22_REQUEST_ID = id;

DECLARE
    temp nvarchar2(1000);
BEGIN
    IF :P22_REQUEST_ID IS NOT NULL THEN
       select RECIPIENT_CAMPUS into temp from SCHOLARSHIP_REQUEST where :P22_REQUEST_ID = ID;
       RETURN temp;
    ELSE
      RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 22 - New Scholarship Request PK > Page Item: P22_CAMPUS > List of Values > SQL Query

SELECT DISTINCT UNIT_NAME FROM DEPARTMENT_CAMPUS WHERE UNIT_TYPE LIKE 'Business unit' AND UNIT_NUMBER <> '00000401';

-- ----------------------------------------
-- Page: 22 - New Scholarship Request PK > Page Item: P22_DEPARTMENT_CODE > Default > PL/SQL Function Body

DECLARE
    temp nvarchar2(1000);
BEGIN
    IF :P22_REQUEST_ID IS NOT NULL THEN
       select REQUESTER_DEPARTMENT_CODE into temp from SCHOLARSHIP_REQUEST where :P22_REQUEST_ID = ID;
       RETURN temp;
    ELSE
    --    SELECT DEPARTMENT_ID INTO temp FROM EMPLOYEES WHERE :APP_USER_NAME = USER_NAME; 
    --    RETURN temp;
       RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 22 - New Scholarship Request PK > Page Item: P22_SCHOLARSHIP_DETAIL > Default > SQL Query

select SCHOLARSHIP_DETAIL_ID.nextval from dual;

-- ----------------------------------------
-- Page: 22 - New Scholarship Request PK > Page Item: P22_VOUCHER_CODE > Default > SQL Query

select S_CODE,SCHOLARSHIP_ID as ID from SCHOLARSHIP where S_RECIPIENT_TYPE = :P22_SCHOLARSHIP_RECIPIENT;

-- ----------------------------------------
-- Page: 22 - New Scholarship Request PK > Page Item: P22_VOUCHER_CODE > List of Values > SQL Query

select S_CODE,SCHOLARSHIP_ID as ID from SCHOLARSHIP where S_RECIPIENT_TYPE = :P22_SCHOLARSHIP_RECIPIENT;

-- ----------------------------------------
-- Page: 22 - New Scholarship Request PK > Page Item: P22_LINE_MANAGER > Default > SQL Query

SELECT MANAGER_ID FROM EMPLOYEES WHERE EMPLOYEE_CODE = :APP_EMP_CODE;

-- ----------------------------------------
-- Page: 22 - New Scholarship Request PK > Page Item: P22_RECIPIENT_PHONE > Default > PL/SQL Function Body

DECLARE
    temp nvarchar2(1000);
BEGIN
    IF :P22_REQUEST_ID IS NOT NULL THEN
       select RECIPIENT_PHONE into temp from SCHOLARSHIP_REQUEST where :P22_REQUEST_ID = ID;
       RETURN temp;
    ELSE
      RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 22 - New Scholarship Request PK > Page Item: P22_TITLE > Default > PL/SQL Function Body

DECLARE
    temp nvarchar2(1000);
BEGIN
    IF :P22_REQUEST_ID IS NOT NULL THEN
       select PARTNER_TITLE into temp from SCHOLARSHIP_REQUEST where :P22_REQUEST_ID = ID;
       RETURN temp;
    ELSE
      RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 22 - New Scholarship Request PK > Page Item: P22_EMPLOYEE_CODE > Default > PL/SQL Function Body

DECLARE
    temp nvarchar2(1000);
BEGIN
    IF :P22_REQUEST_ID IS NOT NULL THEN
       select REQUESTER_CODE into temp from SCHOLARSHIP_REQUEST where :P22_REQUEST_ID = ID;
       RETURN temp;
    ELSE
    --    select :APP_EMP_CODE into temp from DUAL;
    --    RETURN temp;
       RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 22 - New Scholarship Request PK > Page Item: P22_REQUEST_NAME_AB > Default > PL/SQL Function Body

--select FULL_NAME from EMPLOYEES where USER_NAME = :APP_USER_NAME

DECLARE
    temp nvarchar2(1000);
BEGIN
    IF :P22_REQUEST_ID IS NOT NULL THEN
    --    select REQUESTER_LEVEL into temp from SCHOLARSHIP_REQUEST where :P22_REQUEST_ID = ID;
       select emp.FULL_NAME into temp 
       from EMPLOYEES emp 
       join SCHOLARSHIP_REQUEST sr 
       on emp.EMPLOYEE_CODE = sr.REQUESTER_CODE 
       where sr.ID = :P22_REQUEST_ID;

       RETURN temp;
    ELSE
    --    SELECT FULL_NAME INTO temp FROM EMPLOYEES WHERE :APP_USER_NAME = USER_NAME; 
       
    --    RETURN temp;
       RETURN NULL;
    END IF;
END;



-- ----------------------------------------
-- Page: 22 - New Scholarship Request PK > Page Item: P22_RECIPIENT_DOB > Default > PL/SQL Function Body


DECLARE
    temp DATE;
BEGIN
    IF :P22_REQUEST_ID IS NOT NULL THEN
       select RECIPIENT_DOB into temp from SCHOLARSHIP_REQUEST where :P22_REQUEST_ID = ID;
       RETURN temp;
    ELSE
      RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 22 - New Scholarship Request PK > Page Item: P22_DISCOUNT_RATE > List of Values > PL/SQL Function Body returning SQL Query

DECLARE
    v_sql VARCHAR2(4000);
BEGIN
    -- if :P22_PROGRAM is null then
    --     v_sql := 'SELECT ''- - - - - - - - - -'' AS DISPLAY_VALUE, NULL AS RETURN_VALUE FROM dual';
    -- else
    --     v_sql := 'SELECT DISCOUNT_RATE FROM COREEDU_PROMOTION WHERE PROGRAM = :P22_PROGRAM';
    -- end if;
    -- RETURN v_sql;


    -- if :P22_PROGRAM is null then
    --     v_sql := '-------------';
    --     --return null;
    -- else
    -- Giả sử có một điều kiện cụ thể ở đây
        v_sql := 'SELECT DISCOUNT_RATE FROM COREEDU_PROMOTION WHERE PROGRAM = :P22_PROGRAM';
    -- end if;
    RETURN v_sql;
END;


-- ----------------------------------------
-- Page: 22 - New Scholarship Request PK > Page Item: P22_DISCOUNT_RATE > Default > PL/SQL Function Body

DECLARE
    temp nvarchar2(1000);
BEGIN
    IF :P22_REQUEST_ID IS NOT NULL THEN
       select DISCOUNT_RATE into temp from SCHOLARSHIP_REQUEST where :P22_REQUEST_ID = ID;
       RETURN temp;
    ELSE
      RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 22 - New Scholarship Request PK > Page Item: P22_PARTNER_PHONE > Default > PL/SQL Function Body

DECLARE
    temp nvarchar2(1000);
BEGIN
    IF :P22_REQUEST_ID IS NOT NULL THEN
       select PARTNER_PHONE into temp from SCHOLARSHIP_REQUEST where :P22_REQUEST_ID = ID;
       RETURN temp;
    ELSE
      RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 22 - New Scholarship Request PK > Page Item: P22_RECIPIENT_NAME > Default > PL/SQL Function Body

--select RECIPIENT_NAME from SCHOLARSHIP_REQUEST where :P22_REQUEST_ID = id;

DECLARE
    temp nvarchar2(1000);
BEGIN
    IF :P22_REQUEST_ID IS NOT NULL THEN
       select RECIPIENT_NAME into temp from SCHOLARSHIP_REQUEST where :P22_REQUEST_ID = ID;
       RETURN temp;
    ELSE
      RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 22 - New Scholarship Request PK > Page Item: P22_PARTNER_NAME > Default > PL/SQL Function Body

DECLARE
    temp nvarchar2(1000);
BEGIN
    IF :P22_REQUEST_ID IS NOT NULL THEN
       select PARTNER_NAME into temp from SCHOLARSHIP_REQUEST where :P22_REQUEST_ID = ID;
       RETURN temp;
    ELSE
      RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 22 - New Scholarship Request PK > Page Item: P22_REQUEST_NAME > List of Values > SQL Query

select FULL_NAME || ' - ' || EMPLOYEE_CODE, EMPLOYEE_CODE as ID  from EMPLOYEES;

-- ----------------------------------------
-- Page: 22 - New Scholarship Request PK > Page Item: P22_PARTNER_DEPARTMENT > Default > PL/SQL Function Body

DECLARE
    temp nvarchar2(1000);
BEGIN
    IF :P22_REQUEST_ID IS NOT NULL THEN
       select PARTNER_DEPARTMENT into temp from SCHOLARSHIP_REQUEST where :P22_REQUEST_ID = ID;
       RETURN temp;
    ELSE
      RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 22 - New Scholarship Request PK > Page Item: P22_RELATIONSHIP > Default > PL/SQL Function Body

DECLARE
    temp nvarchar2(1000);
BEGIN
    IF :P22_REQUEST_ID IS NOT NULL THEN
       select RECIPIENT_RELATIONSHIP into temp from SCHOLARSHIP_REQUEST where :P22_REQUEST_ID = ID;
       RETURN temp;
    ELSE
      RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 22 - New Scholarship Request PK > Page Item: P22_SCHOLARSHIP_RECIPIENT > Default > PL/SQL Function Body

declare
    temp nvarchar2(1000);
begin
    IF :P22_REQUEST_ID IS NOT NULL THEN
       select RECIPIENT_TYPE into temp from SCHOLARSHIP_REQUEST where :P22_REQUEST_ID = ID;
       return temp;
    ELSE
      RETURN null;
    END IF;
end;

-- ----------------------------------------
-- Page: 22 - New Scholarship Request PK > Page Item: P22_FIELD > Default > PL/SQL Function Body

DECLARE
    temp nvarchar2(1000);
BEGIN
    IF :P22_REQUEST_ID IS NOT NULL THEN
       select PARTNER_FIELD into temp from SCHOLARSHIP_REQUEST where :P22_REQUEST_ID = ID;
       RETURN temp;
    ELSE
      RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 22 - New Scholarship Request PK > Page Item: P22_PROGRAM > Default > PL/SQL Function Body

declare
    temp nvarchar2(1000);
begin
    IF :P22_REQUEST_ID IS NOT NULL THEN
       select PROGRAM into temp from SCHOLARSHIP_REQUEST where :P22_REQUEST_ID = ID;
       return temp;
    ELSE
        -- IF :P22_SCHOLARSHIP_RECIPIENT = 'A' OR :P22_SCHOLARSHIP_RECIPIENT = 'C' OR :P22_SCHOLARSHIP_RECIPIENT = 'D' THEN
        --     RETURN 'ELT';
        -- ELSE
            RETURN null;
        -- END IF;
    END IF;
end;

-- ----------------------------------------
-- Page: 22 - New Scholarship Request PK > Region: ATTACHMENT_HISTORY > Source > SQL Query

select ah.ATTACHMENT_DATE,
       e.FULL_NAME,
       ah.URL
  from ATTACHMENT_HISTORY ah
  join EMPLOYEES e on e.EMPLOYEE_CODE = ah.EMPLOYEE_CODE;

