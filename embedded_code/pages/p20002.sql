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
-- Page: 20002 - new_scholarship_request > Region: WORKFLOW_DETAILS > Source > SQL Query

select wd.ID,
       wd.WD_MODIFIED_DATE,
       wd.WD_MODIFIED_CODE,
       e.FULL_NAME,
       wd.WD_COMMENT,
       wd.STATUS
  from WORKFLOW_DETAIL wd
  join EMPLOYEES e on wd.WD_MODIFIED_CODE = e.EMPLOYEE_CODE
  where REQUEST_ID = :P20002_REQUEST_ID;

-- ----------------------------------------
-- Page: 20002 - new_scholarship_request > Process: submit > Source > PL/SQL Code

declare
c_date date := to_char(sysdate,'MM/DD/YYYY');
-- SCHOLARSHIP_REQUEST_ID NUMBER;
-- line_manager_code nvarchar2(50);

begin
    -- SELECT MANAGER_ID INTO line_manager_code 
    -- FROM EMPLOYEES 
    -- WHERE EMPLOYEE_CODE = :APP_EMP_CODE;

    --if :P20002_REQUEST_ID is null then
--         for rec in (select WF_FEATURE_APPLY,WF_PROCESS_ID from WORKFLOW where lower(WF_FEATURE_APPLY) = 'scholarship' and WF_EXPIRATION_DATE >= sysdate)loop
--     insert into EMP_REQUESTS(REQUEST_TYPE,SUBMIT_DATE,EMPLOYEE_CODE,STATUS,NOTE,CREATE_DATE,REQUEST_DETAIL_ID,WF_PROCESS_ID,LINE_MANAGER)
--     values(rec.WF_FEATURE_APPLY,sysdate,:APP_EMP_CODE,2,:P20002_NOTE, sysdate,
--     :P20002_SCHOLARSHIP_DETAIL,
--     rec.WF_PROCESS_ID,:P20002_LINE_MANAGER);
-- end loop;
    UPDATE SCHOLARSHIP_REQUEST sr
    SET STATUS = 2,
        -- REQUESTER_CODE = 
        --     CASE 
        --         WHEN :P20002_SCHOLARSHIP_RECIPIENT = 'D' THEN :P20002_REQUEST_NAME
        --         ELSE :P20002_EMPLOYEE_CODE
        --     END,
        -- REQUESTER_DEPARTMENT = :P20002_DEPARTMENT,
        -- REQUESTER_DEPARTMENT_CODE = :P20002_DEPARTMENT_CODE,
        -- REQUESTER_LEVEL = :P20002_LEVEL,
        PARTNER_NAME = :P20002_PARTNER_NAME,
        PARTNER_PHONE = :P20002_PARTNER_PHONE,
        PARTNER_TITLE = :P20002_TITLE,
        PARTNER_DEPARTMENT = :P20002_PARTNER_DEPARTMENT,
        PARTNER_FIELD = :P20002_FIELD,
        PARTNER_WORKPLACE = :P20002_WORKPLACE,
        RECIPIENT_NAME = :P20002_RECIPIENT_NAME,
        RECIPIENT_DOB = :P20002_RECIPIENT_DOB,
        RECIPIENT_PHONE = :P20002_RECIPIENT_PHONE,
        RECIPIENT_RELATIONSHIP = :P20002_RELATIONSHIP,
        RECIPIENT_CAMPUS = :P20002_CAMPUS,
        ATTACH_NAME = :P20002_NAME_FILES,
        ATTACH_FILE = :P20002_URL_FILES,
        RECIPIENT_REPLACEMENT = :P20002_REPLACEMENT,
        RECIPIENT_VOUCHER_CODE_REPLACEMENT = :P20002_VOUCHER_CODE_REPLACEMENT,
        RECIPIENT_EXPIRATION_DATE_REPLACEMENT = :P20002_EXPIRATION_DATE_REPLACEMENT,
        RECIPIENT_NOTE = :P20002_NOTE,
        RECIPIENT_REASON_REQUEST = :P20002_REASON_REQUEST
        -- DISCOUNT_RATE = :P20002_DISCOUNT_RATE,
        -- VOUCHER_CODE = :P20002_VOUCHER_CODE,
        -- NUMBER_OF_COURSES = :P20002_NUMBER_OF_COURSES,
        -- EFFECTIVE_DATE = :P20002_EFFECTIVE_DATE,
        -- EXPIRATION_DATE = :P20002_EXPIRATION_DATE,
        -- APPROVED_DATE = :P20002_APPROVED_DATE,
        -- CREATED_DATE = c_date

    WHERE :P20002_REQUEST_ID = sr.ID;

    -- Insert into EMP_REQUEST
        
   UPDATE EMP_REQUESTS emp
   SET
        STATUS = 2,
        NOTE = 
            CASE 
                WHEN :P20002_SCHOLARSHIP_RECIPIENT = 'A' OR :P20002_SCHOLARSHIP_RECIPIENT = 'B' THEN :P20002_NOTE
                ELSE :P20002_REASON_REQUEST
            END
    WHERE :P20002_REQUEST_ID = emp.REQUEST_DETAIL_ID;
    
end;

-- ----------------------------------------
-- Page: 20002 - new_scholarship_request > Process: update > Source > PL/SQL Code

declare
c_date date := to_char(sysdate,'MM/DD/YYYY');
scholarship_request_id number;
begin
    UPDATE SCHOLARSHIP_REQUEST sr
    SET 
        -- STATUS = 1,
        -- RECIPIENT_TYPE = :P20002_SCHOLARSHIP_RECIPIENT,
        -- PROGRAM = :P20002_PROGRAM,
        -- REQUESTER_CODE = 
        --     CASE 
        --         WHEN :P20002_SCHOLARSHIP_RECIPIENT = 'D' THEN :P20002_REQUEST_NAME
        --         ELSE :P20002_EMPLOYEE_CODE
        --     END,
        -- REQUESTER_DEPARTMENT = :P20002_DEPARTMENT,
        -- REQUESTER_DEPARTMENT_CODE = :P20002_DEPARTMENT_CODE,
        -- REQUESTER_LEVEL = :P20002_LEVEL,
        PARTNER_NAME = :P20002_PARTNER_NAME,
        PARTNER_PHONE = :P20002_PARTNER_PHONE,
        PARTNER_TITLE = :P20002_TITLE,
        PARTNER_DEPARTMENT = :P20002_PARTNER_DEPARTMENT,
        PARTNER_FIELD = :P20002_FIELD,
        PARTNER_WORKPLACE = :P20002_WORKPLACE,
        RECIPIENT_NAME = :P20002_RECIPIENT_NAME,
        RECIPIENT_DOB = :P20002_RECIPIENT_DOB,
        RECIPIENT_PHONE = :P20002_RECIPIENT_PHONE,
        RECIPIENT_RELATIONSHIP = :P20002_RELATIONSHIP,
        RECIPIENT_CAMPUS = :P20002_CAMPUS,
        ATTACH_NAME = :P20002_NAME_FILES,
        ATTACH_FILE = :P20002_URL_FILES,
        RECIPIENT_REPLACEMENT = :P20002_REPLACEMENT,
        RECIPIENT_VOUCHER_CODE_REPLACEMENT = :P20002_VOUCHER_CODE_REPLACEMENT,
        RECIPIENT_EXPIRATION_DATE_REPLACEMENT = :P20002_EXPIRATION_DATE_REPLACEMENT,
        RECIPIENT_NOTE = :P20002_NOTE,
        RECIPIENT_REASON_REQUEST = :P20002_REASON_REQUEST,
        -- DISCOUNT_RATE = :P20002_DISCOUNT_RATE,
        -- VOUCHER_CODE = :P20002_VOUCHER_CODE,
        -- NUMBER_OF_COURSES = :P20002_NUMBER_OF_COURSES,
        -- EFFECTIVE_DATE = :P20002_EFFECTIVE_DATE,
        -- EXPIRATION_DATE = :P20002_EXPIRATION_DATE,
        -- APPROVED_DATE = :P20002_APPROVED_DATE,
        CREATED_DATE = c_date
    WHERE :P20002_REQUEST_ID = sr.ID;

    UPDATE EMP_REQUESTS emp
    SET
        NOTE = 
            CASE 
                WHEN :P20002_SCHOLARSHIP_RECIPIENT = 'A' OR :P20002_SCHOLARSHIP_RECIPIENT = 'B' THEN :P20002_NOTE
                ELSE :P20002_REASON_REQUEST
            END
    WHERE :P20002_REQUEST_ID = emp.REQUEST_DETAIL_ID;
end;

-- ----------------------------------------
-- Page: 20002 - new_scholarship_request > Process: save > Source > PL/SQL Code

declare
c_date date := to_char(sysdate,'MM/DD/YYYY');
scholarship_request_id number;
pro_code nvarchar2(50);
begin
    --if :P20002_REQUEST_ID is null then
    select PROMOTION_CODE into pro_code
    from COREEDU_PROMOTION
    where PROGRAM = :P20002_PROGRAM and DISCOUNT_RATE = :P20002_DISCOUNT_RATE;
    
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
        
end;

-- ----------------------------------------
-- Page: 20002 - new_scholarship_request > Process: save when submit > Source > PL/SQL Code

declare
c_date date := to_char(sysdate,'MM/DD/YYYY');
SCHOLARSHIP_REQUEST_ID NUMBER;
line_manager_code nvarchar2(50);
pro_code nvarchar2(50);

begin
    SELECT MANAGER_ID INTO line_manager_code 
    FROM EMPLOYEES 
    WHERE EMPLOYEE_CODE = :APP_EMP_CODE;

    select PROMOTION_CODE into pro_code
    from COREEDU_PROMOTION
    where PROGRAM = :P20002_PROGRAM and DISCOUNT_RATE = :P20002_DISCOUNT_RATE;
    
    -- if :P20002_REQUEST_ID is null then
--         for rec in (select WF_FEATURE_APPLY,WF_PROCESS_ID from WORKFLOW where lower(WF_FEATURE_APPLY) = 'scholarship' and WF_EXPIRATION_DATE >= sysdate)loop
--     insert into EMP_REQUESTS(REQUEST_TYPE,SUBMIT_DATE,EMPLOYEE_CODE,STATUS,NOTE,CREATE_DATE,REQUEST_DETAIL_ID,WF_PROCESS_ID,LINE_MANAGER)
--     values(rec.WF_FEATURE_APPLY,sysdate,:APP_EMP_CODE,2,:P20002_NOTE, sysdate,
--     :P20002_SCHOLARSHIP_DETAIL,
--     rec.WF_PROCESS_ID,:P20002_LINE_MANAGER);
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
                DETAIL_ID,
                PROMOTION_CODE
            )
        VALUES
        (
                2,
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
            )
            returning ID into SCHOLARSHIP_REQUEST_ID;
    -- else
    --     UPDATE SCHOLARSHIP_REQUEST sr
    --     SET STATUS = 2,
    --         RECIPIENT_TYPE = :P20002_SCHOLARSHIP_RECIPIENT,
    --         PROGRAM = :P20002_PROGRAM,
    --         REQUESTER_CODE = 
    --             CASE 
    --                 WHEN :P20002_SCHOLARSHIP_RECIPIENT = 'D' THEN :P20002_REQUEST_NAME
    --                 ELSE :P20002_EMPLOYEE_CODE
    --             END,
    --         REQUESTER_DEPARTMENT = :P20002_DEPARTMENT,
    --         REQUESTER_DEPARTMENT_CODE = :P20002_DEPARTMENT_CODE,
    --         REQUESTER_LEVEL = :P20002_LEVEL,
    --         PARTNER_NAME = :P20002_PARTNER_NAME,
    --         PARTNER_PHONE = :P20002_PARTNER_PHONE,
    --         PARTNER_TITLE = :P20002_TITLE,
    --         PARTNER_DEPARTMENT = :P20002_PARTNER_DEPARTMENT,
    --         PARTNER_FIELD = :P20002_FIELD,
    --         PARTNER_WORKPLACE = :P20002_WORKPLACE,
    --         RECIPIENT_NAME = :P20002_RECIPIENT_NAME,
    --         RECIPIENT_DOB = :P20002_RECIPIENT_DOB,
    --         RECIPIENT_PHONE = :P20002_RECIPIENT_PHONE,
    --         RECIPIENT_RELATIONSHIP = :P20002_RELATIONSHIP,
    --         RECIPIENT_CAMPUS = :P20002_CAMPUS,
    --         ATTACH_NAME = :P20002_NAME_FILES,
    --         ATTACH_FILE = :P20002_URL_FILES,
    --         RECIPIENT_REPLACEMENT = :P20002_REPLACEMENT,
    --         RECIPIENT_VOUCHER_CODE_REPLACEMENT = :P20002_VOUCHER_CODE_REPLACEMENT,
    --         RECIPIENT_EXPIRATION_DATE_REPLACEMENT = :P20002_EXPIRATION_DATE_REPLACEMENT,
    --         RECIPIENT_NOTE = :P20002_NOTE,
    --         RECIPIENT_REASON_REQUEST = :P20002_REASON_REQUEST,
    --         DISCOUNT_RATE = :P20002_DISCOUNT_RATE,
    --         VOUCHER_CODE = :P20002_VOUCHER_CODE,
    --         NUMBER_OF_COURSES = :P20002_NUMBER_OF_COURSES,
    --         EFFECTIVE_DATE = :P20002_EFFECTIVE_DATE,
    --         EXPIRATION_DATE = :P20002_EXPIRATION_DATE,
    --         APPROVED_DATE = :P20002_APPROVED_DATE,
    --         CREATED_DATE = c_date
    --     WHERE :P20002_REQUEST_ID = sr.ID;
    -- end if;

    -- Insert into EMP_REQUEST
    FOR REC IN (
        SELECT
            WF_FEATURE_APPLY,
            WF_PROCESS_ID
        FROM
            WORKFLOW
        WHERE
            -- WF_FEATURE_APPLY = :P20002_FEATURE
            lower(WF_FEATURE_APPLY) = lower(:P20002_FEATURE) 
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
            -- :P20002_NOTE,
            CASE 
                WHEN :P20002_SCHOLARSHIP_RECIPIENT = 'A' OR :P20002_SCHOLARSHIP_RECIPIENT = 'B' THEN :P20002_NOTE
                ELSE :P20002_REASON_REQUEST
            END,
            SYSDATE,
            SCHOLARSHIP_REQUEST_ID,
            REC.WF_PROCESS_ID,
            line_manager_code
        );
    END LOOP;
end;

-- ----------------------------------------
-- Page: 20002 - new_scholarship_request > Validation: btn_save_check_P20002_EXPIRATION_DATE > Validation > PL/SQL Function Body

BEGIN
  IF :P20002_SCHOLARSHIP_RECIPIENT = 'C' or :P20002_SCHOLARSHIP_RECIPIENT = 'D' THEN
    IF :P20002_EXPIRATION_DATE IS NULL THEN
      RETURN FALSE; -- Trả về FALSE nếu 'EXPIRATION_DATE' chưa được điền
    ELSE
      RETURN TRUE; -- Trả về TRUE nếu 'EXPIRATION_DATE' đã được điền
    END IF;
  ELSE
    RETURN TRUE; -- Bỏ qua kiểm tra nếu 'SCHOLARSHIP_RECIPIENT' không có giá trị 'D' và 'C'
  END IF;
END;

-- ----------------------------------------
-- Page: 20002 - new_scholarship_request > Validation: btn_save_check_P20002_DISCOUNT_RATE > Validation > PL/SQL Function Body

BEGIN
  IF :P20002_SCHOLARSHIP_RECIPIENT = 'C' or :P20002_SCHOLARSHIP_RECIPIENT = 'D' THEN
    IF :P20002_DISCOUNT_RATE IS NULL THEN
      RETURN FALSE; -- Trả về FALSE nếu 'DISCOUNT_RATE' chưa được điền
    ELSE
      RETURN TRUE; -- Trả về TRUE nếu 'DISCOUNT_RATE' đã được điền
    END IF;
  ELSE
    RETURN TRUE; -- Bỏ qua kiểm tra nếu 'SCHOLARSHIP_RECIPIENT' không có giá trị 'D' và 'C'
  END IF;
END;

-- ----------------------------------------
-- Page: 20002 - new_scholarship_request > Validation: btn_save_check_P20002_WORKPLACE > Validation > PL/SQL Function Body

BEGIN
  IF :P20002_SCHOLARSHIP_RECIPIENT = 'C' or :P20002_SCHOLARSHIP_RECIPIENT = 'D' THEN
    IF :P20002_WORKPLACE IS NULL THEN
      RETURN FALSE; -- Trả về FALSE nếu 'WORKPLACE' chưa được điền
    ELSE
      RETURN TRUE; -- Trả về TRUE nếu 'WORKPLACE' đã được điền
    END IF;
  ELSE
    RETURN TRUE; -- Bỏ qua kiểm tra nếu 'SCHOLARSHIP_RECIPIENT' không có giá trị 'D' và 'C'
  END IF;
END;

-- ----------------------------------------
-- Page: 20002 - new_scholarship_request > Validation: btn_save_check_P20002_PARTNER_PHONE > Validation > PL/SQL Function Body

BEGIN
  IF :P20002_SCHOLARSHIP_RECIPIENT = 'C' or :P20002_SCHOLARSHIP_RECIPIENT = 'D' THEN
    IF :P20002_PARTNER_PHONE IS NULL THEN
      RETURN FALSE; -- Trả về FALSE nếu 'PARTNER_PHONE' chưa được điền
    ELSE
      RETURN TRUE; -- Trả về TRUE nếu 'PARTNER_PHONE' đã được điền
    END IF;
  ELSE
    RETURN TRUE; -- Bỏ qua kiểm tra nếu 'SCHOLARSHIP_RECIPIENT' không có giá trị 'D' và 'C'
  END IF;
END;

-- ----------------------------------------
-- Page: 20002 - new_scholarship_request > Validation: btn_save_check_P20002_PARTNER_NAME > Validation > PL/SQL Function Body

BEGIN
  IF :P20002_SCHOLARSHIP_RECIPIENT = 'C' or :P20002_SCHOLARSHIP_RECIPIENT = 'D' THEN
    IF :P20002_PARTNER_NAME IS NULL THEN
      RETURN FALSE; -- Trả về FALSE nếu 'PARTNER_NAME' chưa được điền
    ELSE
      RETURN TRUE; -- Trả về TRUE nếu 'PARTNER_NAME' đã được điền
    END IF;
  ELSE
    RETURN TRUE; -- Bỏ qua kiểm tra nếu 'SCHOLARSHIP_RECIPIENT' không có giá trị 'D' và 'C'
  END IF;
END;

-- ----------------------------------------
-- Page: 20002 - new_scholarship_request > Validation: btn_save_submit_check_P20002_EXPIRATION_DATE > Validation > PL/SQL Function Body

BEGIN
  IF :P20002_SCHOLARSHIP_RECIPIENT = 'C' or :P20002_SCHOLARSHIP_RECIPIENT = 'D' THEN
    IF :P20002_EXPIRATION_DATE IS NULL THEN
      RETURN FALSE; -- Trả về FALSE nếu 'EXPIRATION_DATE' chưa được điền
    ELSE
      RETURN TRUE; -- Trả về TRUE nếu 'EXPIRATION_DATE' đã được điền
    END IF;
  ELSE
    RETURN TRUE; -- Bỏ qua kiểm tra nếu 'SCHOLARSHIP_RECIPIENT' không có giá trị 'D' và 'C'
  END IF;
END;

-- ----------------------------------------
-- Page: 20002 - new_scholarship_request > Validation: btn_save_submit_check_P20002_DISCOUNT_RATE > Validation > PL/SQL Function Body

BEGIN
  IF :P20002_SCHOLARSHIP_RECIPIENT = 'C' or :P20002_SCHOLARSHIP_RECIPIENT = 'D' THEN
    IF :P20002_DISCOUNT_RATE IS NULL THEN
      RETURN FALSE; -- Trả về FALSE nếu 'DISCOUNT_RATE' chưa được điền
    ELSE
      RETURN TRUE; -- Trả về TRUE nếu 'DISCOUNT_RATE' đã được điền
    END IF;
  ELSE
    RETURN TRUE; -- Bỏ qua kiểm tra nếu 'SCHOLARSHIP_RECIPIENT' không có giá trị 'D' và 'C'
  END IF;
END;

-- ----------------------------------------
-- Page: 20002 - new_scholarship_request > Validation: btn_save_submit_check_P20002_WORKPLACE > Validation > PL/SQL Function Body

BEGIN
  IF :P20002_SCHOLARSHIP_RECIPIENT = 'C' or :P20002_SCHOLARSHIP_RECIPIENT = 'D' THEN
    IF :P20002_WORKPLACE IS NULL THEN
      RETURN FALSE; -- Trả về FALSE nếu 'WORKPLACE' chưa được điền
    ELSE
      RETURN TRUE; -- Trả về TRUE nếu 'WORKPLACE' đã được điền
    END IF;
  ELSE
    RETURN TRUE; -- Bỏ qua kiểm tra nếu 'SCHOLARSHIP_RECIPIENT' không có giá trị 'D' và 'C'
  END IF;
END;

-- ----------------------------------------
-- Page: 20002 - new_scholarship_request > Validation: btn_save_submit_check_P20002_PARTNER_PHONE > Validation > PL/SQL Function Body

BEGIN
  IF :P20002_SCHOLARSHIP_RECIPIENT = 'C' or :P20002_SCHOLARSHIP_RECIPIENT = 'D' THEN
    IF :P20002_PARTNER_PHONE IS NULL THEN
      RETURN FALSE; -- Trả về FALSE nếu 'PARTNER_PHONE' chưa được điền
    ELSE
      RETURN TRUE; -- Trả về TRUE nếu 'PARTNER_PHONE' đã được điền
    END IF;
  ELSE
    RETURN TRUE; -- Bỏ qua kiểm tra nếu 'SCHOLARSHIP_RECIPIENT' không có giá trị 'D' và 'C'
  END IF;
END;

-- ----------------------------------------
-- Page: 20002 - new_scholarship_request > Validation: btn_save_submit_check_P20002_PARTNER_NAME > Validation > PL/SQL Function Body

BEGIN
  IF :P20002_SCHOLARSHIP_RECIPIENT = 'C' or :P20002_SCHOLARSHIP_RECIPIENT = 'D' THEN
    IF :P20002_PARTNER_NAME IS NULL THEN
      RETURN FALSE; -- Trả về FALSE nếu 'PARTNER_NAME' chưa được điền
    ELSE
      RETURN TRUE; -- Trả về TRUE nếu 'PARTNER_NAME' đã được điền
    END IF;
  ELSE
    RETURN TRUE; -- Bỏ qua kiểm tra nếu 'SCHOLARSHIP_RECIPIENT' không có giá trị 'D' và 'C'
  END IF;
END;

-- ----------------------------------------
-- Page: 20002 - new_scholarship_request > Dynamic Action: Hide/Show Button > Action: Execute JavaScript Code > Server-side Condition (Function Body) > PL/SQL Function Body

declare
temp number;
begin
    if :P20002_REQUEST_ID is null then
        return false;
    else
        select status into temp from SCHOLARSHIP_REQUEST where ID = :P20002_REQUEST_ID;
        if temp = 2 then 
            return true;
        else
            return false;
        end if; 
    end if;
end;

-- ----------------------------------------
-- Page: 20002 - new_scholarship_request > Dynamic Action: set_value_of_voucher_code > Action: Set Value > Settings > PL/SQL Function Body

declare
    x1 nvarchar2(100);
    x2 nvarchar2(100);
    x3 nvarchar2(100);
    x4 nvarchar2(100);
    x5 nvarchar2(100);
begin
    -- if :P20002_EFFECTIVE_DATE is null
    -- then
    --     x1 := null;
    -- else
    --     select to_char(to_date(:P20002_EFFECTIVE_DATE, 'MM/DD/YYYY'),'YY') || 
    --         case
    --             when :P20002_EFFECTIVE_DATE is null then '00'
    --             when :P20002_EFFECTIVE_DATE is not null then to_char(to_date(:P20002_EXPIRATION_DATE, 'MM/DD/YYYY'),'MM')
    --         end
    --     into x1 
    --     from dual;
    -- end if;
    -- if :P20002_EFFECTIVE_DATE is not null then
        select to_char(to_date(:P20002_EFFECTIVE_DATE, 'MM/DD/YYYY'), 'YY') ||
            coalesce(to_char(to_date(:P20002_EXPIRATION_DATE, 'MM/DD/YYYY'), 'MM'), '00')
        into x1
        from dual;
    -- end if;

    if :P20002_DISCOUNT_RATE < 100 then
        select to_char(:P20002_DISCOUNT_RATE, '000') 
        into x2 
        from dual;
    else
        select :P20002_DISCOUNT_RATE 
        into x2 
        from dual;
    end if;

    if :P20002_SCHOLARSHIP_RECIPIENT is not null then
        select replace(:P20002_SCHOLARSHIP_RECIPIENT || x2, ' ', '')
        into x2
        from dual;
    end if;

    if :P20002_PROGRAM is not null then
        select :P20002_PROGRAM
        into x3
        from dual;
    end if;

    if :P20002_SCHOLARSHIP_RECIPIENT like 'A' or :P20002_SCHOLARSHIP_RECIPIENT like 'B' then
        select :P20002_EMPLOYEE_CODE
        into x4
        from dual;
        select LTRIM(TO_CHAR(COUNT(REQUESTER_CODE) + 1, '000')) 
        into x5
        from SCHOLARSHIP_REQUEST 
        where REQUESTER_CODE = :P20002_EMPLOYEE_CODE;
    else
        if :P20002_SCHOLARSHIP_RECIPIENT like 'C' or :P20002_SCHOLARSHIP_RECIPIENT like 'D' then
            select :P20002_DEPARTMENT_CODE
            into x4
            from dual;
            select  LTRIM(TO_CHAR(COUNT(REQUESTER_DEPARTMENT_CODE) + 1,'000'))
            into x5 
            from SCHOLARSHIP_REQUEST 
            where REQUESTER_DEPARTMENT_CODE = :P20002_DEPARTMENT_CODE;
        end if;
    end if;

    -- if :P20002_SCHOLARSHIP_RECIPIENT like 'A' or :P20002_SCHOLARSHIP_RECIPIENT like 'B' then
    --     select LTRIM(TO_CHAR(COUNT(REQUESTER_CODE) + 1, '000')) 
    --     into x5
    --     from SCHOLARSHIP_REQUEST 
    --     where REQUESTER_CODE = :P20002_EMPLOYEE_CODE;
    -- else
    --     if :P20002_SCHOLARSHIP_RECIPIENT like 'C' or :P20002_SCHOLARSHIP_RECIPIENT like 'D' then
    --         select  LTRIM(TO_CHAR(COUNT(REQUESTER_DEPARTMENT_CODE) + 1,'000'))
    --         into x5 
    --         from SCHOLARSHIP_REQUEST 
    --         where REQUESTER_DEPARTMENT_CODE = :P20002_DEPARTMENT_CODE;
    --     end if;
    -- end if;

    return x1 || '-' || x2 || '-' || x3 || '-' || x4 || '-' || x5;
end;

-- ----------------------------------------
-- Page: 20002 - new_scholarship_request > Dynamic Action: change_value_of_replacement > Action: set_value_for_expiration_date_replacement > Settings > SQL Statement

select EXPIRATION_DATE
from SCHOLARSHIP_REQUEST
where VOUCHER_CODE = :P20002_REPLACEMENT;

-- ----------------------------------------
-- Page: 20002 - new_scholarship_request > Dynamic Action: change_value_of_replacement > Action: set_value_for_voucher_code_replacement > Settings > SQL Statement

select VOUCHER_CODE
from SCHOLARSHIP_REQUEST
where VOUCHER_CODE = :P20002_REPLACEMENT;

-- ----------------------------------------
-- Page: 20002 - new_scholarship_request > Dynamic Action: change_value_of_request_name > Action: set_value_department > Settings > SQL Statement

select emp.DEPARTMENT_NAME from EMPLOYEES emp where :P20002_REQUEST_NAME = emp.EMPLOYEE_CODE;

-- ----------------------------------------
-- Page: 20002 - new_scholarship_request > Dynamic Action: change_value_of_request_name > Action: set_value_department_code > Settings > SQL Statement

select emp.DEPARTMENT_ID from EMPLOYEES emp where :P20002_REQUEST_NAME = emp.EMPLOYEE_CODE;

-- ----------------------------------------
-- Page: 20002 - new_scholarship_request > Dynamic Action: Change P20002_EFFECTIVE_DATE > Action: Set Value > Settings > SQL Statement

select SYSDATE from DUAL;

-- ----------------------------------------
-- Page: 20002 - new_scholarship_request > Dynamic Action: Change P20002_RELATIONSHIP > Action: Set Value > Settings > PL/SQL Function Body

DECLARE
    temp nvarchar2(100);
BEGIN
    IF :P20002_SCHOLARSHIP_RECIPIENT = 'A' 
    THEN
        temp := 1;
        RETURN temp;
    ELSIF
        :P20002_SCHOLARSHIP_RECIPIENT = 'C' OR :P20002_SCHOLARSHIP_RECIPIENT = 'D'
    THEN
        temp := 8;
        RETURN temp;
    ELSE
        RETURN null;
    END IF;
END;


-- ----------------------------------------
-- Page: 20002 - new_scholarship_request > Dynamic Action: Change P20002_RECIPIENT_DOB > Action: Set Value > Settings > PL/SQL Function Body

DECLARE
    temp nvarchar2(100);
BEGIN
    IF :P20002_SCHOLARSHIP_RECIPIENT = 'A' 
    THEN
        select DOB into temp from EMPLOYEES where USER_NAME = :APP_USER_NAME; 
        RETURN temp;
    ELSE
        return null;
    END IF;
END;


-- ----------------------------------------
-- Page: 20002 - new_scholarship_request > Dynamic Action: Change P20002_RECIPIENT_NAME > Action: Set Value > Settings > PL/SQL Function Body

DECLARE
    temp nvarchar2(100);
BEGIN
    IF :P20002_SCHOLARSHIP_RECIPIENT = 'A' 
    THEN
        select FULL_NAME into temp from employees where USER_NAME = :APP_USER_NAME; 
        RETURN temp;
    ELSE
        return null;
    END IF;
END;


-- ----------------------------------------
-- Page: 20002 - new_scholarship_request > Dynamic Action: Change P20002_TERMINATION_DATE > Action: Set Value > Settings > PL/SQL Function Body

DECLARE
    temp nvarchar2(100);
BEGIN
    IF :P20002_SCHOLARSHIP_RECIPIENT = 'A' OR :P20002_SCHOLARSHIP_RECIPIENT = 'B' 
    THEN
        select TERMINATE_DATE into temp from EMPLOYEES where :APP_USER_NAME = USER_NAME;
        return temp;
    ELSE
        return null;
    END IF;
END;


-- ----------------------------------------
-- Page: 20002 - new_scholarship_request > Dynamic Action: Change P20002_START_DATE > Action: Set Value > Settings > PL/SQL Function Body

DECLARE
    temp nvarchar2(100);
BEGIN
    IF :P20002_SCHOLARSHIP_RECIPIENT = 'A' OR :P20002_SCHOLARSHIP_RECIPIENT = 'B' 
    THEN
        select START_DATE into temp from EMPLOYEES where :APP_USER_NAME = USER_NAME;
        return temp;
    ELSE
        return null;
    END IF;
END;


-- ----------------------------------------
-- Page: 20002 - new_scholarship_request > Dynamic Action: Change P20002_LEVEL > Action: Set Value > Settings > PL/SQL Function Body

DECLARE
    temp nvarchar2(100);
BEGIN
    IF :P20002_SCHOLARSHIP_RECIPIENT = 'A' OR :P20002_SCHOLARSHIP_RECIPIENT = 'B' 
    THEN
        select LEVEL_DESCRIPTION into temp from employees where :APP_USER_NAME = USER_NAME; 
        RETURN temp;
    ELSE
        return null;
    END IF;
END;


-- ----------------------------------------
-- Page: 20002 - new_scholarship_request > Dynamic Action: Change P20002_DEPARTMENT > Action: Set Value > Settings > PL/SQL Function Body

DECLARE
    temp nvarchar2(100);
BEGIN
    -- IF :P20002_SCHOLARSHIP_RECIPIENT = 'A' OR :P20002_SCHOLARSHIP_RECIPIENT = 'B' 
    -- THEN
        select DEPARTMENT_NAME into temp from employees where :APP_USER_NAME = USER_NAME;
        RETURN temp;
    -- ELSE
    --     RETURN null;
    -- END IF;
    
END;


-- ----------------------------------------
-- Page: 20002 - new_scholarship_request > Dynamic Action: Change P20002_DEPARTMENT_CODE > Action: Set Value > Settings > PL/SQL Function Body

DECLARE
    temp nvarchar2(100);
BEGIN
    IF :P20002_SCHOLARSHIP_RECIPIENT = 'C' OR :P20002_SCHOLARSHIP_RECIPIENT = 'D' 
    THEN
        select DEPARTMENT_ID into temp from employees where :APP_USER_NAME = USER_NAME;
        RETURN temp;
    ELSE
        RETURN null;
    END IF;
    
END;


-- ----------------------------------------
-- Page: 20002 - new_scholarship_request > Dynamic Action: Change P20002_EMPLOYEE_CODE > Action: Set Value > Settings > PL/SQL Function Body

DECLARE
    temp nvarchar2(100);
BEGIN
    IF :P20002_SCHOLARSHIP_RECIPIENT = 'A' OR :P20002_SCHOLARSHIP_RECIPIENT = 'B' or :P20002_SCHOLARSHIP_RECIPIENT = 'C'
    THEN
        select :APP_EMP_CODE into temp from DUAL;
        RETURN temp;
    ELSE
        RETURN null;
    END IF;
END;


-- ----------------------------------------
-- Page: 20002 - new_scholarship_request > Dynamic Action: Change P20002_REQUEST_NAME > Action: Set Value > Settings > PL/SQL Function Body

DECLARE
    temp nvarchar2(100);
BEGIN
    IF :P20002_SCHOLARSHIP_RECIPIENT = 'C' OR :P20002_SCHOLARSHIP_RECIPIENT = 'D' 
    THEN
        select EMPLOYEE_CODE into temp from EMPLOYEES where USER_NAME = :APP_USER_NAME;
        RETURN temp;
    ELSE
        RETURN null;
    END IF;
END;

-- ----------------------------------------
-- Page: 20002 - new_scholarship_request > Dynamic Action: Change P20002_REQUEST_NAME_AB > Action: Set Value > Settings > PL/SQL Function Body

DECLARE
    temp nvarchar2(100);
BEGIN
    IF :P20002_SCHOLARSHIP_RECIPIENT = 'A' OR :P20002_SCHOLARSHIP_RECIPIENT = 'B' 
    THEN
        SELECT FULL_NAME INTO temp FROM EMPLOYEES WHERE USER_NAME = :APP_USER_NAME;
        RETURN temp;
    ELSE
        RETURN null;
    END IF;
END;


-- ----------------------------------------
-- Page: 20002 - new_scholarship_request > Dynamic Action: Change P20002_DISCOUNT_RATE > Action: Set Value > Settings > SQL Statement

select DISCOUNT_RATE
from COREEDU_PROMOTION
where PROGRAM = :P20002_PROGRAM
and DISCOUNT_RATE >= 100;

-- ----------------------------------------
-- Page: 20002 - new_scholarship_request > Page Item: P20002_NOTE > Default > PL/SQL Function Body

DECLARE
    temp nvarchar2(1000);
BEGIN
    IF :P20002_REQUEST_ID IS NOT NULL THEN
       select RECIPIENT_NOTE into temp from SCHOLARSHIP_REQUEST where :P20002_REQUEST_ID = ID;
       RETURN temp;
    ELSE
      RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 20002 - new_scholarship_request > Page Item: P20002_REASON_REQUEST > Default > PL/SQL Function Body

DECLARE
    temp nvarchar2(1000);
BEGIN
    IF :P20002_REQUEST_ID IS NOT NULL THEN
       select RECIPIENT_REASON_REQUEST into temp from SCHOLARSHIP_REQUEST where :P20002_REQUEST_ID = ID;
       RETURN temp;
    ELSE
      RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 20002 - new_scholarship_request > Page Item: P20002_EXPIRATION_DATE_REPLACEMENT > Default > PL/SQL Function Body

DECLARE
    temp date;
BEGIN
    IF :P20002_REQUEST_ID IS NOT NULL THEN
       select RECIPIENT_EXPIRATION_DATE_REPLACEMENT into temp from SCHOLARSHIP_REQUEST where :P20002_REQUEST_ID = ID;
       RETURN temp;
    ELSE
      RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 20002 - new_scholarship_request > Page Item: P20002_EXPIRATION_DATE > Default > PL/SQL Function Body

DECLARE
    temp DATE;
BEGIN
    IF :P20002_REQUEST_ID IS NOT NULL THEN
       select EXPIRATION_DATE into temp from SCHOLARSHIP_REQUEST where :P20002_REQUEST_ID = ID;
       RETURN temp;
    ELSE
      RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 20002 - new_scholarship_request > Page Item: P20002_VOUCHER_CODE_REPLACEMENT > Default > PL/SQL Function Body


DECLARE
    temp nvarchar2(1000);
BEGIN
    IF :P20002_REQUEST_ID IS NOT NULL THEN
       select RECIPIENT_VOUCHER_CODE_REPLACEMENT into temp from SCHOLARSHIP_REQUEST where :P20002_REQUEST_ID = ID;
       RETURN temp;
    ELSE
      RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 20002 - new_scholarship_request > Page Item: P20002_NUMBER_OF_COURSES > Default > PL/SQL Function Body

DECLARE
    temp NVARCHAR2(1000);
BEGIN
    IF :P20002_REQUEST_ID IS NOT NULL THEN
       select NUMBER_OF_COURSES into temp from SCHOLARSHIP_REQUEST where :P20002_REQUEST_ID = ID;
       RETURN temp;
    ELSE
      RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 20002 - new_scholarship_request > Page Item: P20002_REPLACEMENT > Default > PL/SQL Function Body

-- SELECT sr.RECIPIENT_NAME || ' - ' || sr.RECIPIENT_DOB, sr.VOUCHER_CODE as ID
-- FROM SCHOLARSHIP_REQUEST sr
-- WHERE sr.REQUESTER_CODE = :P20002_EMPLOYEE_CODE AND sr.RECIPIENT_RELATIONSHIP != 1;

DECLARE
    temp nvarchar2(1000);
BEGIN
    IF :P20002_REQUEST_ID IS NOT NULL THEN
       select RECIPIENT_REPLACEMENT into temp from SCHOLARSHIP_REQUEST where :P20002_REQUEST_ID = ID;
       RETURN temp;
    ELSE
      RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 20002 - new_scholarship_request > Page Item: P20002_REPLACEMENT > List of Values > SQL Query

SELECT RECIPIENT_NAME || ' - ' || RECIPIENT_DOB as DISPLAY_VALUE, VOUCHER_CODE as RETURN_VALUE
FROM SCHOLARSHIP_REQUEST
WHERE REQUESTER_CODE = :APP_EMP_CODE 
AND RECIPIENT_TYPE = 'B'
AND RECIPIENT_RELATIONSHIP != 1
AND STATUS != 7
AND ID != :P20002_REQUEST_ID;

-- ----------------------------------------
-- Page: 20002 - new_scholarship_request > Page Item: P20002_APPROVED_DATE > Default > PL/SQL Function Body

DECLARE
    temp DATE;
BEGIN
    IF :P20002_REQUEST_ID IS NOT NULL THEN
       select APPROVED_DATE into temp from SCHOLARSHIP_REQUEST where :P20002_REQUEST_ID = ID;
       RETURN temp;
    ELSE
      RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 20002 - new_scholarship_request > Page Item: P20002_TERMINATION_DATE > Default > PL/SQL Function Body

--select TERMINATE_DATE from employees where USER_NAME = :APP_USER_NAME;

DECLARE
    temp nvarchar2(1000);
BEGIN
    IF :P20002_REQUEST_ID IS NOT NULL THEN
    --    select REQUESTER_LEVEL into temp from SCHOLARSHIP_REQUEST where :P20002_REQUEST_ID = ID;
       select emp.TERMINATE_DATE into temp 
       from EMPLOYEES emp 
       join SCHOLARSHIP_REQUEST sr 
       on emp.EMPLOYEE_CODE = sr.REQUESTER_CODE 
       where sr.ID = :P20002_REQUEST_ID;

       RETURN temp;
    ELSE
    --    SELECT TERMINATE_DATE INTO temp FROM EMPLOYEES WHERE :APP_USER_NAME = USER_NAME; 
       
    --    RETURN temp;
       RETURN NULL;
    END IF;
END;



-- ----------------------------------------
-- Page: 20002 - new_scholarship_request > Page Item: P20002_EFFECTIVE_DATE > Default > PL/SQL Function Body

DECLARE
    temp DATE;
BEGIN
    IF :P20002_REQUEST_ID IS NOT NULL THEN
       select EFFECTIVE_DATE into temp from SCHOLARSHIP_REQUEST where :P20002_REQUEST_ID = ID;
       RETURN temp;
    ELSE
      RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 20002 - new_scholarship_request > Page Item: P20002_START_DATE > Default > PL/SQL Function Body

--select START_DATE from EMPLOYEES where USER_NAME = :APP_USER_NAME;

DECLARE
    temp DATE;
BEGIN
    IF :P20002_REQUEST_ID IS NOT NULL THEN
    --    select REQUESTER_LEVEL into temp from SCHOLARSHIP_REQUEST where :P20002_REQUEST_ID = ID;
       select emp.START_DATE into temp 
       from EMPLOYEES emp 
       join SCHOLARSHIP_REQUEST sr 
       on emp.EMPLOYEE_CODE = sr.REQUESTER_CODE 
       where sr.ID = :P20002_REQUEST_ID;

       RETURN temp;
    ELSE
    --    SELECT START_DATE INTO temp FROM EMPLOYEES WHERE :APP_USER_NAME = USER_NAME; 
       
    --    RETURN temp;
       RETURN NULL;
    END IF;
END;



-- ----------------------------------------
-- Page: 20002 - new_scholarship_request > Page Item: P20002_LEVEL > Default > PL/SQL Function Body

--select LEVEL_DESCRIPTION from EMPLOYEES where USER_NAME = :APP_USER_NAME;

DECLARE
    temp nvarchar2(1000);
BEGIN
    IF :P20002_REQUEST_ID IS NOT NULL THEN
       select REQUESTER_LEVEL into temp from SCHOLARSHIP_REQUEST where :P20002_REQUEST_ID = ID;
       RETURN temp;
    ELSE
    --    SELECT LEVEL_DESCRIPTION INTO temp FROM EMPLOYEES WHERE :APP_USER_NAME = USER_NAME; 
    --    RETURN temp;
       RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 20002 - new_scholarship_request > Page Item: P20002_WORKPLACE > Default > PL/SQL Function Body

DECLARE
    temp nvarchar2(1000);
BEGIN
    IF :P20002_REQUEST_ID IS NOT NULL THEN
       select PARTNER_WORKPLACE into temp from SCHOLARSHIP_REQUEST where :P20002_REQUEST_ID = ID;
       RETURN temp;
    ELSE
      RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 20002 - new_scholarship_request > Page Item: P20002_DEPARTMENT > Default > PL/SQL Function Body

DECLARE
    temp nvarchar2(1000);
BEGIN
    IF :P20002_REQUEST_ID IS NOT NULL THEN
       select REQUESTER_DEPARTMENT into temp from SCHOLARSHIP_REQUEST where :P20002_REQUEST_ID = ID;
       RETURN temp;
    ELSE
    --    SELECT DEPARTMENT_NAME INTO temp FROM EMPLOYEES WHERE :APP_USER_NAME = USER_NAME; 
    --    RETURN temp;
       RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 20002 - new_scholarship_request > Page Item: P20002_DEPARTMENT > List of Values > SQL Query

select DISTINCT DEPARTMENT_NAME from EMPLOYEES;

-- ----------------------------------------
-- Page: 20002 - new_scholarship_request > Page Item: P20002_CAMPUS > Default > PL/SQL Function Body

--select RECIPIENT_CAMPUS from SCHOLARSHIP_REQUEST where :P20002_REQUEST_ID = id;

DECLARE
    temp nvarchar2(1000);
BEGIN
    IF :P20002_REQUEST_ID IS NOT NULL THEN
       select RECIPIENT_CAMPUS into temp from SCHOLARSHIP_REQUEST where :P20002_REQUEST_ID = ID;
       RETURN temp;
    ELSE
      RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 20002 - new_scholarship_request > Page Item: P20002_CAMPUS > List of Values > SQL Query

SELECT DISTINCT UNIT_NAME FROM DEPARTMENT_CAMPUS WHERE UNIT_TYPE LIKE 'Business unit' AND UNIT_NUMBER <> '00000401';

-- ----------------------------------------
-- Page: 20002 - new_scholarship_request > Page Item: P20002_DEPARTMENT_CODE > Default > PL/SQL Function Body

DECLARE
    temp nvarchar2(1000);
BEGIN
    IF :P20002_REQUEST_ID IS NOT NULL THEN
       select REQUESTER_DEPARTMENT_CODE into temp from SCHOLARSHIP_REQUEST where :P20002_REQUEST_ID = ID;
       RETURN temp;
    ELSE
    --    SELECT DEPARTMENT_ID INTO temp FROM EMPLOYEES WHERE :APP_USER_NAME = USER_NAME; 
    --    RETURN temp;
       RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 20002 - new_scholarship_request > Page Item: P20002_SCHOLARSHIP_DETAIL > Default > SQL Query

select SCHOLARSHIP_DETAIL_ID.nextval from dual;

-- ----------------------------------------
-- Page: 20002 - new_scholarship_request > Page Item: P20002_VOUCHER_CODE > Default > PL/SQL Function Body

DECLARE
    temp nvarchar2(1000);
BEGIN
    IF :P20002_REQUEST_ID IS NOT NULL THEN
       select VOUCHER_CODE into temp from SCHOLARSHIP_REQUEST where :P20002_REQUEST_ID = ID;
       RETURN temp;
    ELSE
      RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 20002 - new_scholarship_request > Page Item: P20002_TITLE > Default > PL/SQL Function Body

DECLARE
    temp nvarchar2(1000);
BEGIN
    IF :P20002_REQUEST_ID IS NOT NULL THEN
       select PARTNER_TITLE into temp from SCHOLARSHIP_REQUEST where :P20002_REQUEST_ID = ID;
       RETURN temp;
    ELSE
      RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 20002 - new_scholarship_request > Page Item: P20002_EMPLOYEE_CODE > Default > PL/SQL Function Body

DECLARE
    temp nvarchar2(1000);
BEGIN
    IF :P20002_REQUEST_ID IS NOT NULL THEN
       select REQUESTER_CODE into temp from SCHOLARSHIP_REQUEST where :P20002_REQUEST_ID = ID;
       RETURN temp;
    ELSE
    --    select :APP_EMP_CODE into temp from DUAL;
    --    RETURN temp;
       RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 20002 - new_scholarship_request > Page Item: P20002_LINE_MANAGER > Default > SQL Query

SELECT MANAGER_ID FROM EMPLOYEES WHERE EMPLOYEE_CODE = :APP_EMP_CODE;

-- ----------------------------------------
-- Page: 20002 - new_scholarship_request > Page Item: P20002_RECIPIENT_PHONE > Default > PL/SQL Function Body

DECLARE
    temp nvarchar2(1000);
BEGIN
    IF :P20002_REQUEST_ID IS NOT NULL THEN
       select RECIPIENT_PHONE into temp from SCHOLARSHIP_REQUEST where :P20002_REQUEST_ID = ID;
       RETURN temp;
    ELSE
      RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 20002 - new_scholarship_request > Page Item: P20002_DISCOUNT_RATE > List of Values > PL/SQL Function Body returning SQL Query

declare
    v_sql nvarchar2(1000);
begin
    v_sql := 'SELECT
                ''voucher '' || DISCOUNT_RATE || ''%'' as DISPLAY_VALUE, 
                DISCOUNT_RATE as RETURN_VALUE
              FROM 
                COREEDU_PROMOTION 
              WHERE 
                PROGRAM = :P20002_PROGRAM
              ORDER BY DISCOUNT_RATE DESC';
    RETURN v_sql;
end;

-- ----------------------------------------
-- Page: 20002 - new_scholarship_request > Page Item: P20002_DISCOUNT_RATE > Default > PL/SQL Function Body

DECLARE
    temp number;
BEGIN
    IF :P20002_REQUEST_ID IS NOT NULL THEN
       select DISCOUNT_RATE into temp from SCHOLARSHIP_REQUEST where :P20002_REQUEST_ID = ID;
       RETURN temp;
    ELSE
      RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 20002 - new_scholarship_request > Page Item: P20002_PARTNER_PHONE > Default > PL/SQL Function Body

DECLARE
    temp nvarchar2(1000);
BEGIN
    IF :P20002_REQUEST_ID IS NOT NULL THEN
       select PARTNER_PHONE into temp from SCHOLARSHIP_REQUEST where :P20002_REQUEST_ID = ID;
       RETURN temp;
    ELSE
      RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 20002 - new_scholarship_request > Page Item: P20002_REQUEST_NAME_AB > Default > PL/SQL Function Body

--select FULL_NAME from EMPLOYEES where USER_NAME = :APP_USER_NAME

DECLARE
    temp nvarchar2(1000);
BEGIN
    IF :P20002_REQUEST_ID IS NOT NULL THEN
    --    select REQUESTER_LEVEL into temp from SCHOLARSHIP_REQUEST where :P20002_REQUEST_ID = ID;
       select emp.FULL_NAME into temp 
       from EMPLOYEES emp 
       join SCHOLARSHIP_REQUEST sr 
       on emp.EMPLOYEE_CODE = sr.REQUESTER_CODE 
       where sr.ID = :P20002_REQUEST_ID;

       RETURN temp;
    ELSE
    --    SELECT FULL_NAME INTO temp FROM EMPLOYEES WHERE :APP_USER_NAME = USER_NAME; 
       
    --    RETURN temp;
       RETURN NULL;
    END IF;
END;



-- ----------------------------------------
-- Page: 20002 - new_scholarship_request > Page Item: P20002_RECIPIENT_DOB > Default > PL/SQL Function Body

DECLARE
    temp DATE;
BEGIN
    IF :P20002_REQUEST_ID IS NOT NULL THEN
       select RECIPIENT_DOB into temp from SCHOLARSHIP_REQUEST where :P20002_REQUEST_ID = ID;
       RETURN temp;
    ELSE
      RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 20002 - new_scholarship_request > Page Item: P20002_PARTNER_NAME > Default > PL/SQL Function Body

DECLARE
    temp nvarchar2(1000);
BEGIN
    IF :P20002_REQUEST_ID IS NOT NULL THEN
       select PARTNER_NAME into temp from SCHOLARSHIP_REQUEST where :P20002_REQUEST_ID = ID;
       RETURN temp;
    ELSE
      RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 20002 - new_scholarship_request > Page Item: P20002_REQUEST_NAME > Default > PL/SQL Function Body

DECLARE
    temp nvarchar2(1000);
BEGIN
    IF :P20002_REQUEST_ID IS NOT NULL THEN
       select emp.EMPLOYEE_CODE into temp 
       from EMPLOYEES emp 
       join SCHOLARSHIP_REQUEST sr 
       on emp.EMPLOYEE_CODE = sr.REQUESTER_CODE 
       where sr.ID = :P20002_REQUEST_ID;
       
       --select EMPLOYEE_CODE into temp from EMPLOYEES where USER_NAME = :APP_USER_NAME;
       RETURN temp;
    ELSE
       RETURN NULL;
    END IF;
END;



-- ----------------------------------------
-- Page: 20002 - new_scholarship_request > Page Item: P20002_REQUEST_NAME > List of Values > SQL Query

select FULL_NAME || ' - ' || EMPLOYEE_CODE, EMPLOYEE_CODE as ID from EMPLOYEES;

-- ----------------------------------------
-- Page: 20002 - new_scholarship_request > Page Item: P20002_RECIPIENT_NAME > Default > PL/SQL Function Body

--select RECIPIENT_NAME from SCHOLARSHIP_REQUEST where :P20002_REQUEST_ID = id;

DECLARE
    temp nvarchar2(1000);
BEGIN
    IF :P20002_REQUEST_ID IS NOT NULL THEN
       select RECIPIENT_NAME into temp from SCHOLARSHIP_REQUEST where :P20002_REQUEST_ID = ID;
       RETURN temp;
    ELSE
      RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 20002 - new_scholarship_request > Page Item: P20002_PARTNER_DEPARTMENT > Default > PL/SQL Function Body

DECLARE
    temp nvarchar2(1000);
BEGIN
    IF :P20002_REQUEST_ID IS NOT NULL THEN
       select PARTNER_DEPARTMENT into temp from SCHOLARSHIP_REQUEST where :P20002_REQUEST_ID = ID;
       RETURN temp;
    ELSE
      RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 20002 - new_scholarship_request > Page Item: P20002_RELATIONSHIP > Default > PL/SQL Function Body

DECLARE
    temp nvarchar2(1000);
BEGIN
    IF :P20002_REQUEST_ID IS NOT NULL THEN
       select RECIPIENT_RELATIONSHIP into temp from SCHOLARSHIP_REQUEST where :P20002_REQUEST_ID = ID;
       RETURN temp;
    ELSE
      RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 20002 - new_scholarship_request > Page Item: P20002_SCHOLARSHIP_RECIPIENT > Default > PL/SQL Function Body

declare
    temp nvarchar2(1000);
begin
    IF :P20002_REQUEST_ID IS NOT NULL THEN
       select RECIPIENT_TYPE into temp from SCHOLARSHIP_REQUEST where :P20002_REQUEST_ID = ID;
       return temp;
    ELSE
      RETURN null;
    END IF;
end;

-- ----------------------------------------
-- Page: 20002 - new_scholarship_request > Page Item: P20002_FIELD > Default > PL/SQL Function Body

DECLARE
    temp nvarchar2(1000);
BEGIN
    IF :P20002_REQUEST_ID IS NOT NULL THEN
       select PARTNER_FIELD into temp from SCHOLARSHIP_REQUEST where :P20002_REQUEST_ID = ID;
       RETURN temp;
    ELSE
      RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 20002 - new_scholarship_request > Page Item: P20002_PROGRAM > Default > PL/SQL Function Body

declare
    temp nvarchar2(1000);
begin
    IF :P20002_REQUEST_ID IS NOT NULL THEN
       select PROGRAM into temp from SCHOLARSHIP_REQUEST where :P20002_REQUEST_ID = ID;
       return temp;
    ELSE
       RETURN null;
    END IF;
end;

-- ----------------------------------------
-- Page: 20002 - new_scholarship_request > Region: ATTACHMENT_HISTORY > Source > SQL Query

select ah.ATTACHMENT_DATE,
       e.FULL_NAME,
       ah.URL
  from ATTACHMENT_HISTORY ah
  join EMPLOYEES e on e.EMPLOYEE_CODE = ah.EMPLOYEE_CODE;

