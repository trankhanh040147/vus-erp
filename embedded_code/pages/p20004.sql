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
-- Page: 20004 - confirm_scholarship_request > Region: WORKFLOW_DETAILS > Source > SQL Query

select wd.ID,
       wd.WD_MODIFIED_DATE,
       wd.WD_MODIFIED_CODE,
       e.FULL_NAME,
       wd.WD_COMMENT,
       wd.STATUS
  from WORKFLOW_DETAIL wd
  join EMPLOYEES e on wd.WD_MODIFIED_CODE = e.EMPLOYEE_CODE
  where wd.REQUEST_ID = :P20004_REQUEST_ID;

-- ----------------------------------------
-- Page: 20004 - confirm_scholarship_request > Process: submit > Source > PL/SQL Code

declare
c_date date := to_char(sysdate,'MM/DD/YYYY');
-- SCHOLARSHIP_REQUEST_ID NUMBER;
-- line_manager_code nvarchar2(50);

begin
    -- SELECT MANAGER_ID INTO line_manager_code 
    -- FROM EMPLOYEES 
    -- WHERE EMPLOYEE_CODE = :APP_EMP_CODE;

    --if :P20004_REQUEST_ID is null then
--         for rec in (select WF_FEATURE_APPLY,WF_PROCESS_ID from WORKFLOW where lower(WF_FEATURE_APPLY) = 'scholarship' and WF_EXPIRATION_DATE >= sysdate)loop
--     insert into EMP_REQUESTS(REQUEST_TYPE,SUBMIT_DATE,EMPLOYEE_CODE,STATUS,NOTE,CREATE_DATE,REQUEST_DETAIL_ID,WF_PROCESS_ID,LINE_MANAGER)
--     values(rec.WF_FEATURE_APPLY,sysdate,:APP_EMP_CODE,2,:P20004_NOTE, sysdate,
--     :P20004_SCHOLARSHIP_DETAIL,
--     rec.WF_PROCESS_ID,:P20004_LINE_MANAGER);
-- end loop;
    UPDATE SCHOLARSHIP_REQUEST sr
    SET STATUS = 2,
        RECIPIENT_TYPE = :P20004_SCHOLARSHIP_RECIPIENT,
        PROGRAM = :P20004_PROGRAM,
        REQUESTER_CODE = 
            CASE 
                WHEN :P20004_SCHOLARSHIP_RECIPIENT = 'D' THEN :P20004_REQUEST_NAME
                ELSE :P20004_EMPLOYEE_CODE
            END,
        REQUESTER_DEPARTMENT = :P20004_DEPARTMENT,
        REQUESTER_DEPARTMENT_CODE = :P20004_DEPARTMENT_CODE,
        REQUESTER_LEVEL = :P20004_LEVEL,
        PARTNER_NAME = :P20004_PARTNER_NAME,
        PARTNER_PHONE = :P20004_PARTNER_PHONE,
        PARTNER_TITLE = :P20004_TITLE,
        PARTNER_DEPARTMENT = :P20004_PARTNER_DEPARTMENT,
        PARTNER_FIELD = :P20004_FIELD,
        PARTNER_WORKPLACE = :P20004_WORKPLACE,
        RECIPIENT_NAME = :P20004_RECIPIENT_NAME,
        RECIPIENT_DOB = :P20004_RECIPIENT_DOB,
        RECIPIENT_PHONE = :P20004_RECIPIENT_PHONE,
        RECIPIENT_RELATIONSHIP = :P20004_RELATIONSHIP,
        RECIPIENT_CAMPUS = :P20004_CAMPUS,
        ATTACH_NAME = :P20004_NAME_FILES,
        ATTACH_FILE = :P20004_URL_FILES,
        RECIPIENT_REPLACEMENT = :P20004_REPLACEMENT,
        RECIPIENT_VOUCHER_CODE_REPLACEMENT = :P20004_VOUCHER_CODE_REPLACEMENT,
        RECIPIENT_EXPIRATION_DATE_REPLACEMENT = :P20004_EXPIRATION_DATE_REPLACEMENT,
        RECIPIENT_NOTE = :P20004_NOTE,
        RECIPIENT_REASON_REQUEST = :P20004_REASON_REQUEST,
        DISCOUNT_RATE = :P20004_DISCOUNT_RATE,
        VOUCHER_CODE = :P20004_VOUCHER_CODE,
        NUMBER_OF_COURSES = :P20004_NUMBER_OF_COURSES,
        EFFECTIVE_DATE = :P20004_EFFECTIVE_DATE,
        EXPIRATION_DATE = :P20004_EXPIRATION_DATE,
        APPROVED_DATE = :P20004_APPROVED_DATE,
        CREATED_DATE = c_date
    WHERE :P20004_REQUEST_ID = sr.ID;

    -- Insert into EMP_REQUEST
        
       UPDATE EMP_REQUESTS emp
       SET
            STATUS = 2,
            NOTE = :P20004_NOTE
        WHERE :P20004_REQUEST_ID = emp.REQUEST_DETAIL_ID;
end;

-- ----------------------------------------
-- Page: 20004 - confirm_scholarship_request > Process: update > Source > PL/SQL Code

declare
c_date date := to_char(sysdate,'MM/DD/YYYY');
scholarship_request_id number;
begin
    --if :P20004_REQUEST_ID is null then
    -- else
        UPDATE SCHOLARSHIP_REQUEST sr
        SET STATUS = 1,
            -- RECIPIENT_TYPE = :P20004_SCHOLARSHIP_RECIPIENT,
            -- PROGRAM = :P20004_PROGRAM,
            -- REQUESTER_CODE = 
            --     CASE 
            --         WHEN :P20004_SCHOLARSHIP_RECIPIENT = 'D' THEN :P20004_REQUEST_NAME
            --         ELSE :P20004_EMPLOYEE_CODE
            --     END,
            -- REQUESTER_DEPARTMENT = :P20004_DEPARTMENT,
            -- REQUESTER_DEPARTMENT_CODE = :P20004_DEPARTMENT_CODE,
            -- REQUESTER_LEVEL = :P20004_LEVEL,
            PARTNER_NAME = :P20004_PARTNER_NAME,
            PARTNER_PHONE = :P20004_PARTNER_PHONE,
            PARTNER_TITLE = :P20004_TITLE,
            PARTNER_DEPARTMENT = :P20004_PARTNER_DEPARTMENT,
            PARTNER_FIELD = :P20004_FIELD,
            PARTNER_WORKPLACE = :P20004_WORKPLACE,
            RECIPIENT_NAME = :P20004_RECIPIENT_NAME,
            RECIPIENT_DOB = :P20004_RECIPIENT_DOB,
            RECIPIENT_PHONE = :P20004_RECIPIENT_PHONE,
            RECIPIENT_RELATIONSHIP = :P20004_RELATIONSHIP,
            RECIPIENT_CAMPUS = :P20004_CAMPUS,
            ATTACH_NAME = :P20004_NAME_FILES,
            ATTACH_FILE = :P20004_URL_FILES,
            RECIPIENT_REPLACEMENT = :P20004_REPLACEMENT,
            RECIPIENT_VOUCHER_CODE_REPLACEMENT = :P20004_VOUCHER_CODE_REPLACEMENT,
            RECIPIENT_EXPIRATION_DATE_REPLACEMENT = :P20004_EXPIRATION_DATE_REPLACEMENT,
            RECIPIENT_NOTE = :P20004_NOTE,
            RECIPIENT_REASON_REQUEST = :P20004_REASON_REQUEST,
            -- DISCOUNT_RATE = :P20004_DISCOUNT_RATE,
            -- VOUCHER_CODE = :P20004_VOUCHER_CODE,
            -- NUMBER_OF_COURSES = :P20004_NUMBER_OF_COURSES,
            -- EFFECTIVE_DATE = :P20004_EFFECTIVE_DATE,
            -- EXPIRATION_DATE = :P20004_EXPIRATION_DATE,
            -- APPROVED_DATE = :P20004_APPROVED_DATE,
            CREATED_DATE = c_date
        WHERE :P20004_REQUEST_ID = sr.ID;
    --end if;
end;

-- ----------------------------------------
-- Page: 20004 - confirm_scholarship_request > Process: save > Source > PL/SQL Code

declare
c_date date := to_char(sysdate,'MM/DD/YYYY');
scholarship_request_id number;
begin
    --if :P20004_REQUEST_ID is null then
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
                1,
                :P20004_SCHOLARSHIP_RECIPIENT,
                :P20004_PROGRAM,
                case
                    when :P20004_SCHOLARSHIP_RECIPIENT = 'D' then :P20004_REQUEST_NAME
                else
                    :P20004_EMPLOYEE_CODE
                end,
                :P20004_DEPARTMENT,
                :P20004_DEPARTMENT_CODE,
                :P20004_LEVEL,
                :P20004_PARTNER_NAME,
                :P20004_PARTNER_PHONE,
                :P20004_TITLE,
                :P20004_PARTNER_DEPARTMENT,
                :P20004_FIELD,
                :P20004_WORKPLACE,
                :P20004_RECIPIENT_NAME,
                :P20004_RECIPIENT_DOB,
                :P20004_RECIPIENT_PHONE,
                :P20004_RELATIONSHIP,
                :P20004_CAMPUS,
                :P20004_NAME_FILES,
                :P20004_URL_FILES,
                :P20004_REPLACEMENT,
                :P20004_VOUCHER_CODE_REPLACEMENT,
                :P20004_EXPIRATION_DATE_REPLACEMENT,
                :P20004_NOTE,
                :P20004_REASON_REQUEST,
                :P20004_DISCOUNT_RATE,
                :P20004_VOUCHER_CODE,
                :P20004_NUMBER_OF_COURSES,
                :P20004_EFFECTIVE_DATE,
                :P20004_EXPIRATION_DATE,
                :P20004_APPROVED_DATE,
                c_date,
                :P20004_SCHOLARSHIP_DETAIL
            ) returning ID into scholarship_request_id;

        for rec in (select WF_FEATURE_APPLY,WF_PROCESS_ID from WORKFLOW where lower(WF_FEATURE_APPLY) = 'scholarship' and WF_EXPIRATION_DATE >= sysdate)
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
                LINE_MANAGER)
            values(
                rec.WF_FEATURE_APPLY,
                sysdate,
                :APP_EMP_CODE,
                1,
                :P20004_NOTE,
                sysdate,
                scholarship_request_id,
                rec.WF_PROCESS_ID,
                :P20004_LINE_MANAGER);
        end loop;

    -- else
    --     UPDATE SCHOLARSHIP_REQUEST sr
    --     SET STATUS = 1,
    --         RECIPIENT_TYPE = :P20004_SCHOLARSHIP_RECIPIENT,
    --         PROGRAM = :P20004_PROGRAM,
    --         REQUESTER_CODE = 
    --             CASE 
    --                 WHEN :P20004_SCHOLARSHIP_RECIPIENT = 'D' THEN :P20004_REQUEST_NAME
    --                 ELSE :P20004_EMPLOYEE_CODE
    --             END,
    --         REQUESTER_DEPARTMENT = :P20004_DEPARTMENT,
    --         REQUESTER_DEPARTMENT_CODE = :P20004_DEPARTMENT_CODE,
    --         REQUESTER_LEVEL = :P20004_LEVEL,
    --         PARTNER_NAME = :P20004_PARTNER_NAME,
    --         PARTNER_PHONE = :P20004_PARTNER_PHONE,
    --         PARTNER_TITLE = :P20004_TITLE,
    --         PARTNER_DEPARTMENT = :P20004_PARTNER_DEPARTMENT,
    --         PARTNER_FIELD = :P20004_FIELD,
    --         PARTNER_WORKPLACE = :P20004_WORKPLACE,
    --         RECIPIENT_NAME = :P20004_RECIPIENT_NAME,
    --         RECIPIENT_DOB = :P20004_RECIPIENT_DOB,
    --         RECIPIENT_PHONE = :P20004_RECIPIENT_PHONE,
    --         RECIPIENT_RELATIONSHIP = :P20004_RELATIONSHIP,
    --         RECIPIENT_CAMPUS = :P20004_CAMPUS,
    --         ATTACH_NAME = :P20004_NAME_FILES,
    --         ATTACH_FILE = :P20004_URL_FILES,
    --         RECIPIENT_REPLACEMENT = :P20004_REPLACEMENT,
    --         RECIPIENT_VOUCHER_CODE_REPLACEMENT = :P20004_VOUCHER_CODE_REPLACEMENT,
    --         RECIPIENT_EXPIRATION_DATE_REPLACEMENT = :P20004_EXPIRATION_DATE_REPLACEMENT,
    --         RECIPIENT_NOTE = :P20004_NOTE,
    --         RECIPIENT_REASON_REQUEST = :P20004_REASON_REQUEST,
    --         DISCOUNT_RATE = :P20004_DISCOUNT_RATE,
    --         VOUCHER_CODE = :P20004_VOUCHER_CODE,
    --         NUMBER_OF_COURSES = :P20004_NUMBER_OF_COURSES,
    --         EFFECTIVE_DATE = :P20004_EFFECTIVE_DATE,
    --         EXPIRATION_DATE = :P20004_EXPIRATION_DATE,
    --         APPROVED_DATE = :P20004_APPROVED_DATE,
    --         CREATED_DATE = c_date
    --     WHERE :P20004_REQUEST_ID = sr.ID;
    --end if;
end;

-- ----------------------------------------
-- Page: 20004 - confirm_scholarship_request > Process: save when submit > Source > PL/SQL Code

declare
c_date date := to_char(sysdate,'MM/DD/YYYY');
SCHOLARSHIP_REQUEST_ID NUMBER;
line_manager_code nvarchar2(50);

begin
    SELECT MANAGER_ID INTO line_manager_code 
    FROM EMPLOYEES 
    WHERE EMPLOYEE_CODE = :APP_EMP_CODE;

    -- if :P20004_REQUEST_ID is null then
--         for rec in (select WF_FEATURE_APPLY,WF_PROCESS_ID from WORKFLOW where lower(WF_FEATURE_APPLY) = 'scholarship' and WF_EXPIRATION_DATE >= sysdate)loop
--     insert into EMP_REQUESTS(REQUEST_TYPE,SUBMIT_DATE,EMPLOYEE_CODE,STATUS,NOTE,CREATE_DATE,REQUEST_DETAIL_ID,WF_PROCESS_ID,LINE_MANAGER)
--     values(rec.WF_FEATURE_APPLY,sysdate,:APP_EMP_CODE,2,:P20004_NOTE, sysdate,
--     :P20004_SCHOLARSHIP_DETAIL,
--     rec.WF_PROCESS_ID,:P20004_LINE_MANAGER);
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
                :P20004_SCHOLARSHIP_RECIPIENT,
                :P20004_PROGRAM,
                case
                    when :P20004_SCHOLARSHIP_RECIPIENT = 'D' then :P20004_REQUEST_NAME
                else
                    :P20004_EMPLOYEE_CODE
                end,
                :P20004_DEPARTMENT,
                :P20004_DEPARTMENT_CODE,
                :P20004_LEVEL,
                :P20004_PARTNER_NAME,
                :P20004_PARTNER_PHONE,
                :P20004_TITLE,
                :P20004_PARTNER_DEPARTMENT,
                :P20004_FIELD,
                :P20004_WORKPLACE,
                :P20004_RECIPIENT_NAME,
                :P20004_RECIPIENT_DOB,
                :P20004_RECIPIENT_PHONE,
                :P20004_RELATIONSHIP,
                :P20004_CAMPUS,
                :P20004_NAME_FILES,
                :P20004_URL_FILES,
                :P20004_REPLACEMENT,
                :P20004_VOUCHER_CODE_REPLACEMENT,
                :P20004_EXPIRATION_DATE_REPLACEMENT,
                :P20004_NOTE,
                :P20004_REASON_REQUEST,
                :P20004_DISCOUNT_RATE,
                :P20004_VOUCHER_CODE,
                :P20004_NUMBER_OF_COURSES,
                :P20004_EFFECTIVE_DATE,
                :P20004_EXPIRATION_DATE,
                :P20004_APPROVED_DATE,
                c_date,
                :P20004_SCHOLARSHIP_DETAIL
            )
            returning ID into SCHOLARSHIP_REQUEST_ID;
    -- else
    --     UPDATE SCHOLARSHIP_REQUEST sr
    --     SET STATUS = 2,
    --         RECIPIENT_TYPE = :P20004_SCHOLARSHIP_RECIPIENT,
    --         PROGRAM = :P20004_PROGRAM,
    --         REQUESTER_CODE = 
    --             CASE 
    --                 WHEN :P20004_SCHOLARSHIP_RECIPIENT = 'D' THEN :P20004_REQUEST_NAME
    --                 ELSE :P20004_EMPLOYEE_CODE
    --             END,
    --         REQUESTER_DEPARTMENT = :P20004_DEPARTMENT,
    --         REQUESTER_DEPARTMENT_CODE = :P20004_DEPARTMENT_CODE,
    --         REQUESTER_LEVEL = :P20004_LEVEL,
    --         PARTNER_NAME = :P20004_PARTNER_NAME,
    --         PARTNER_PHONE = :P20004_PARTNER_PHONE,
    --         PARTNER_TITLE = :P20004_TITLE,
    --         PARTNER_DEPARTMENT = :P20004_PARTNER_DEPARTMENT,
    --         PARTNER_FIELD = :P20004_FIELD,
    --         PARTNER_WORKPLACE = :P20004_WORKPLACE,
    --         RECIPIENT_NAME = :P20004_RECIPIENT_NAME,
    --         RECIPIENT_DOB = :P20004_RECIPIENT_DOB,
    --         RECIPIENT_PHONE = :P20004_RECIPIENT_PHONE,
    --         RECIPIENT_RELATIONSHIP = :P20004_RELATIONSHIP,
    --         RECIPIENT_CAMPUS = :P20004_CAMPUS,
    --         ATTACH_NAME = :P20004_NAME_FILES,
    --         ATTACH_FILE = :P20004_URL_FILES,
    --         RECIPIENT_REPLACEMENT = :P20004_REPLACEMENT,
    --         RECIPIENT_VOUCHER_CODE_REPLACEMENT = :P20004_VOUCHER_CODE_REPLACEMENT,
    --         RECIPIENT_EXPIRATION_DATE_REPLACEMENT = :P20004_EXPIRATION_DATE_REPLACEMENT,
    --         RECIPIENT_NOTE = :P20004_NOTE,
    --         RECIPIENT_REASON_REQUEST = :P20004_REASON_REQUEST,
    --         DISCOUNT_RATE = :P20004_DISCOUNT_RATE,
    --         VOUCHER_CODE = :P20004_VOUCHER_CODE,
    --         NUMBER_OF_COURSES = :P20004_NUMBER_OF_COURSES,
    --         EFFECTIVE_DATE = :P20004_EFFECTIVE_DATE,
    --         EXPIRATION_DATE = :P20004_EXPIRATION_DATE,
    --         APPROVED_DATE = :P20004_APPROVED_DATE,
    --         CREATED_DATE = c_date
    --     WHERE :P20004_REQUEST_ID = sr.ID;
    -- end if;

    -- Insert into EMP_REQUEST
    FOR REC IN (
        SELECT
            WF_FEATURE_APPLY,
            WF_PROCESS_ID
        FROM
            WORKFLOW
        WHERE
            WF_FEATURE_APPLY = :P20004_FEATURE
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
            :P20004_NOTE,
            SYSDATE,
            SCHOLARSHIP_REQUEST_ID,
            REC.WF_PROCESS_ID,
            line_manager_code
        );
    END LOOP;
end;

-- ----------------------------------------
-- Page: 20004 - confirm_scholarship_request > Process: Reject > Source > PL/SQL Code

declare
    n_check number;
    n_step number;
begin
for rec in (
--     with temp as (
--     select wa.WA_GROUP from EMP_REQUESTS er
--         join WORKFLOW_APPROVAL wa on wa.WF_PROCESS_ID = er.WF_PROCESS_ID
--         join employees emp on emp.APPROVAL_GROUP = wa.WA_GROUP
--         where emp.EMPLOYEE_CODE = :APP_EMP_CODE
--         group by wa.WA_GROUP
-- )
    select er.CURRENT_STEP,er.NEXT_STEP,count(wa.WA_SEQUENCE_NUMBER) as SEQ from EMP_REQUESTS er
        join WORKFLOW_APPROVAL wa on wa.WF_PROCESS_ID = er.WF_PROCESS_ID
        -- join WORKFLOW_APPROVAL tmp on tmp.WA_GROUP = wa.WA_GROUP
        where er.REQUEST_DETAIL_ID = :P20004_REQUEST_ID and er.STATUS <> 3 group by er.CURRENT_STEP,er.NEXT_STEP) 
        loop
            if rec.NEXT_STEP < rec.SEQ then
                --select wa.WA_SEQUENCE_NUMBER into n_step from EMPLOYEES emp join WORKFLOW_APPROVAL wa on wa.WA_GROUP = emp.APPROVAL_GROUP and employee_code = :APP_EMP_CODE;
                update EMP_REQUESTS 
                set MODIFIED_DATE = sysdate,
                    CURRENT_STEP = rec.NEXT_STEP,
                    MODIFIED_BY_CODE = :APP_EMP_CODE,
                    STATUS = 4
                where REQUEST_DETAIL_ID = :P20004_REQUEST_ID;
                            
                insert into WORKFLOW_DETAIL(
                    WD_MODIFIED_DATE,
                    WD_MODIFIED_CODE,
                    STATUS,
                    REQUEST_ID,
                    SEQUENCE
                    ) 
                values(
                    sysdate,
                    :APP_EMP_CODE,
                    4,
                    :P20004_REQUEST_ID,
                    rec.NEXT_STEP
                    );
            
            update SCHOLARSHIP_REQUEST 
            set STATUS = 4 
            where id = :P20004_REQUEST_ID;
                --else
                --update EMP_REQUESTS set MODIFIED_DATE = sysdate,CURRENT_STEP=rec.NEXT_STEP,MODIFIED_BY_CODE = :APP_EMP_CODE,STATUS=3 where id = :P20004_REQUEST_ID;
            end if;
        end loop;

/*
SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'dieptran@vus-etsc.edu.vn', 'OT Request Submitted Successfully', '<p> Dear '|| :APP_USER_NAME ||', </p>' ||
'<p> Your OT request has been submitted successfully. Here are the details: </p>' ||

'<p> If you have any questions or need further assistance, please feel free to reach out to the HR department. </p>' ||
'<br>' || 
'<p> Thank you, </p>' ||
'<p> VUS </p>');
*/
end;

-- ----------------------------------------
-- Page: 20004 - confirm_scholarship_request > Process: Approve > Source > PL/SQL Code

declare
    pro_code nvarchar2(100);
    id_replace number;      -- id của voucher code bị replace
    emp_manager nvarchar2(200);
    emp_email nvarchar2(200);

begin

    -- lấy promotion_code mới
    select cp.PROMOTION_CODE
    into pro_code
    from COREEDU_PROMOTION cp
    where cp.PROGRAM = :P20004_PROGRAM and cp.DISCOUNT_RATE = :P20004_DISCOUNT_RATE;

    for rec in (
    --     with temp as (
    --     select wa.WA_GROUP from EMP_REQUESTS er
    --         join WORKFLOW_APPROVAL wa on wa.WF_PROCESS_ID = er.WF_PROCESS_ID
    --         join employees emp on emp.APPROVAL_GROUP = wa.WA_GROUP
    --         where emp.EMPLOYEE_CODE = :APP_EMP_CODE
    --         group by wa.WA_GROUP
    -- )
        select er.CURRENT_STEP,er.NEXT_STEP,
            count(wa.WA_SEQUENCE_NUMBER) as SEQ 
        from EMP_REQUESTS er
        join WORKFLOW_APPROVAL wa on wa.WF_PROCESS_ID = er.WF_PROCESS_ID
            -- join WORKFLOW_APPROVAL tmp on tmp.WA_GROUP = wa.WA_GROUP
        where er.REQUEST_DETAIL_ID = :P20004_REQUEST_ID 
            and er.STATUS <> 3 
        group by er.CURRENT_STEP,er.NEXT_STEP
    )
        loop
            if rec.NEXT_STEP < rec.SEQ then
                --select wa.WA_SEQUENCE_NUMBER into n_step from EMPLOYEES emp join WORKFLOW_APPROVAL wa on wa.WA_GROUP = emp.APPROVAL_GROUP and employee_code = :APP_EMP_CODE;
                
                -- cập nhật bảng EMP_REQUESTS về trạng thái 'in-review'
                update EMP_REQUESTS 
                set MODIFIED_DATE = sysdate,
                    CURRENT_STEP = rec.NEXT_STEP,
                    MODIFIED_BY_CODE = :APP_EMP_CODE,
                    NEXT_STEP = rec.NEXT_STEP + 1,
                    STATUS = 6 
                where REQUEST_DETAIL_ID = :P20004_REQUEST_ID;

                -- cập nhật bảng SCHOLARSHIP_REQUEST về trạng thái 'in-review'
                update SCHOLARSHIP_REQUEST 
                set STATUS = 6,
                    RECIPIENT_CAMPUS = :P20004_CAMPUS,
                    RECIPIENT_REPLACEMENT = :P20004_REPLACEMENT,
                    RECIPIENT_VOUCHER_CODE_REPLACEMENT = :P20004_VOUCHER_CODE_REPLACEMENT,
                    RECIPIENT_EXPIRATION_DATE_REPLACEMENT = :P20004_EXPIRATION_DATE_REPLACEMENT,
                    RECIPIENT_NOTE = :P20004_NOTE,
                    RECIPIENT_REASON_REQUEST = :P20004_REASON_REQUEST,
                    DISCOUNT_RATE = :P20004_DISCOUNT_RATE,
                    VOUCHER_CODE = :P20004_VOUCHER_CODE,
                    NUMBER_OF_COURSES = :P20004_NUMBER_OF_COURSES,
                    EFFECTIVE_DATE = :P20004_EFFECTIVE_DATE,
                    EXPIRATION_DATE = :P20004_EXPIRATION_DATE,
                    PROMOTION_CODE = pro_code
                where id = :P20004_REQUEST_ID;

                -- thêm dòng mới vào bảng 'WORKFLOW_DETAIL' khi có thao tác 'approve'
                insert into WORKFLOW_DETAIL(
                    WD_MODIFIED_DATE,
                    WD_MODIFIED_CODE,
                    STATUS,
                    REQUEST_ID,
                    SEQUENCE,
                    WD_COMMENT
                ) 
                values(
                    sysdate,
                    :APP_EMP_CODE,
                    6,
                    :P20004_REQUEST_ID,
                    rec.NEXT_STEP,
                    :P20004_NOTE
                    );
            else
                -- cập nhật bảng EMP_REQUESTS về trạng thái 'active'                
                update EMP_REQUESTS 
                set MODIFIED_DATE = sysdate,
                    CURRENT_STEP = rec.NEXT_STEP,
                    MODIFIED_BY_CODE = :APP_EMP_CODE,
                    STATUS = 3 
                where REQUEST_DETAIL_ID = :P20004_REQUEST_ID;

                -- cập nhật bảng SCHOLARSHIP_REQUEST về trạng thái 'active'
                update SCHOLARSHIP_REQUEST 
                set STATUS = 3,
                    RECIPIENT_CAMPUS = :P20004_CAMPUS,
                    RECIPIENT_REPLACEMENT = :P20004_REPLACEMENT,
                    RECIPIENT_VOUCHER_CODE_REPLACEMENT = :P20004_VOUCHER_CODE_REPLACEMENT,
                    RECIPIENT_EXPIRATION_DATE_REPLACEMENT = :P20004_EXPIRATION_DATE_REPLACEMENT,
                    RECIPIENT_NOTE = :P20004_NOTE,
                    RECIPIENT_REASON_REQUEST = :P20004_REASON_REQUEST,
                    DISCOUNT_RATE = :P20004_DISCOUNT_RATE,
                    VOUCHER_CODE = :P20004_VOUCHER_CODE,
                    NUMBER_OF_COURSES = :P20004_NUMBER_OF_COURSES,
                    EFFECTIVE_DATE = :P20004_EFFECTIVE_DATE,
                    EXPIRATION_DATE = :P20004_EXPIRATION_DATE,
                    PROMOTION_CODE = pro_code
                where id = :P20004_REQUEST_ID;

                -- thêm dòng mới vào bảng 'WORKFLOW_DETAIL' khi 'active'
                insert into WORKFLOW_DETAIL(
                    WD_MODIFIED_DATE,
                    WD_MODIFIED_CODE,
                    STATUS,
                    REQUEST_ID,
                    SEQUENCE,
                    WD_COMMENT
                ) 
                values(
                    sysdate,
                    :APP_EMP_CODE,
                    3,
                    :P20004_REQUEST_ID,
                    rec.NEXT_STEP,
                    :P20004_NOTE
                    );

                -- trường hợp replacement được chấp nhận, đổi status của voucher bị replace thành in-active (7)
                if :P20004_REPLACEMENT is not null then
                    select id into id_replace from SCHOLARSHIP_REQUEST where VOUCHER_CODE = :P20004_REPLACEMENT;
                    
                    update SCHOLARSHIP_REQUEST
                    set STATUS = 7
                    where id = id_replace;

                    update EMP_REQUESTS 
                    set STATUS = 7 
                    where REQUEST_DETAIL_ID = id_replace;
                    
                    -- thêm trạng thái in-active vào workflow_detail
                    insert into WORKFLOW_DETAIL(
                        WD_MODIFIED_DATE,
                        WD_MODIFIED_CODE,
                        STATUS,
                        REQUEST_ID,
                        WD_COMMENT
                    ) 
                    values(
                        sysdate,
                        :APP_EMP_CODE,
                        7,
                        id_replace,
                        :P20004_NOTE
                        );
                end if;
            end if;
            
            -- insert into WORKFLOW_DETAIL(
            --     WD_MODIFIED_DATE,
            --     WD_MODIFIED_CODE,
            --     STATUS,
            --     REQUEST_ID,
            --     SEQUENCE,
            --     WD_COMMENT
            --     ) 
            -- values(
            --     sysdate,
            --     :APP_EMP_CODE,
            --     3,
            --     :P20004_REQUEST_ID,
            --     rec.NEXT_STEP,
            --     :P20004_NOTE
            --     );
        end loop;


-- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'thviet613@gmail.com', 'Scholarship Request Submitted Successfully', '<p> Dear '|| :APP_USER_NAME ||', </p>' ||
-- '<p> Your Scholarship Request has been submitted successfully. Here are the details: </p>' ||

-- '<p> If you have any questions or need further assistance, please feel free to reach out to the HR department. </p>' ||
-- '<br>' || 
-- '<p> Thank you, </p>' ||
-- '<p> VUS </p>');

end;

-- ----------------------------------------
-- Page: 20004 - confirm_scholarship_request > Validation: btn_save_check_P20004_EXPIRATION_DATE > Validation > PL/SQL Function Body

BEGIN
  IF :P20004_SCHOLARSHIP_RECIPIENT = 'C' or :P20004_SCHOLARSHIP_RECIPIENT = 'D' THEN
    IF :P20004_EXPIRATION_DATE IS NULL THEN
      RETURN FALSE; -- Trả về FALSE nếu 'EXPIRATION_DATE' chưa được điền
    ELSE
      RETURN TRUE; -- Trả về TRUE nếu 'EXPIRATION_DATE' đã được điền
    END IF;
  ELSE
    RETURN TRUE; -- Bỏ qua kiểm tra nếu 'SCHOLARSHIP_RECIPIENT' không có giá trị 'D' và 'C'
  END IF;
END;

-- ----------------------------------------
-- Page: 20004 - confirm_scholarship_request > Validation: btn_save_check_P20004_DISCOUNT_RATE > Validation > PL/SQL Function Body

BEGIN
  IF :P20004_SCHOLARSHIP_RECIPIENT = 'C' or :P20004_SCHOLARSHIP_RECIPIENT = 'D' THEN
    IF :P20004_DISCOUNT_RATE IS NULL THEN
      RETURN FALSE; -- Trả về FALSE nếu 'DISCOUNT_RATE' chưa được điền
    ELSE
      RETURN TRUE; -- Trả về TRUE nếu 'DISCOUNT_RATE' đã được điền
    END IF;
  ELSE
    RETURN TRUE; -- Bỏ qua kiểm tra nếu 'SCHOLARSHIP_RECIPIENT' không có giá trị 'D' và 'C'
  END IF;
END;

-- ----------------------------------------
-- Page: 20004 - confirm_scholarship_request > Validation: btn_save_check_P20004_WORKPLACE > Validation > PL/SQL Function Body

BEGIN
  IF :P20004_SCHOLARSHIP_RECIPIENT = 'C' or :P20004_SCHOLARSHIP_RECIPIENT = 'D' THEN
    IF :P20004_WORKPLACE IS NULL THEN
      RETURN FALSE; -- Trả về FALSE nếu 'WORKPLACE' chưa được điền
    ELSE
      RETURN TRUE; -- Trả về TRUE nếu 'WORKPLACE' đã được điền
    END IF;
  ELSE
    RETURN TRUE; -- Bỏ qua kiểm tra nếu 'SCHOLARSHIP_RECIPIENT' không có giá trị 'D' và 'C'
  END IF;
END;

-- ----------------------------------------
-- Page: 20004 - confirm_scholarship_request > Validation: btn_save_check_P20004_PARTNER_PHONE > Validation > PL/SQL Function Body

BEGIN
  IF :P20004_SCHOLARSHIP_RECIPIENT = 'C' or :P20004_SCHOLARSHIP_RECIPIENT = 'D' THEN
    IF :P20004_PARTNER_PHONE IS NULL THEN
      RETURN FALSE; -- Trả về FALSE nếu 'PARTNER_PHONE' chưa được điền
    ELSE
      RETURN TRUE; -- Trả về TRUE nếu 'PARTNER_PHONE' đã được điền
    END IF;
  ELSE
    RETURN TRUE; -- Bỏ qua kiểm tra nếu 'SCHOLARSHIP_RECIPIENT' không có giá trị 'D' và 'C'
  END IF;
END;

-- ----------------------------------------
-- Page: 20004 - confirm_scholarship_request > Validation: btn_save_check_P20004_PARTNER_NAME > Validation > PL/SQL Function Body

BEGIN
  IF :P20004_SCHOLARSHIP_RECIPIENT = 'C' or :P20004_SCHOLARSHIP_RECIPIENT = 'D' THEN
    IF :P20004_PARTNER_NAME IS NULL THEN
      RETURN FALSE; -- Trả về FALSE nếu 'PARTNER_NAME' chưa được điền
    ELSE
      RETURN TRUE; -- Trả về TRUE nếu 'PARTNER_NAME' đã được điền
    END IF;
  ELSE
    RETURN TRUE; -- Bỏ qua kiểm tra nếu 'SCHOLARSHIP_RECIPIENT' không có giá trị 'D' và 'C'
  END IF;
END;

-- ----------------------------------------
-- Page: 20004 - confirm_scholarship_request > Validation: btn_save_submit_check_P20004_EXPIRATION_DATE > Validation > PL/SQL Function Body

BEGIN
  IF :P20004_SCHOLARSHIP_RECIPIENT = 'C' or :P20004_SCHOLARSHIP_RECIPIENT = 'D' THEN
    IF :P20004_EXPIRATION_DATE IS NULL THEN
      RETURN FALSE; -- Trả về FALSE nếu 'EXPIRATION_DATE' chưa được điền
    ELSE
      RETURN TRUE; -- Trả về TRUE nếu 'EXPIRATION_DATE' đã được điền
    END IF;
  ELSE
    RETURN TRUE; -- Bỏ qua kiểm tra nếu 'SCHOLARSHIP_RECIPIENT' không có giá trị 'D' và 'C'
  END IF;
END;

-- ----------------------------------------
-- Page: 20004 - confirm_scholarship_request > Validation: btn_save_submit_check_P20004_DISCOUNT_RATE > Validation > PL/SQL Function Body

BEGIN
  IF :P20004_SCHOLARSHIP_RECIPIENT = 'C' or :P20004_SCHOLARSHIP_RECIPIENT = 'D' THEN
    IF :P20004_DISCOUNT_RATE IS NULL THEN
      RETURN FALSE; -- Trả về FALSE nếu 'DISCOUNT_RATE' chưa được điền
    ELSE
      RETURN TRUE; -- Trả về TRUE nếu 'DISCOUNT_RATE' đã được điền
    END IF;
  ELSE
    RETURN TRUE; -- Bỏ qua kiểm tra nếu 'SCHOLARSHIP_RECIPIENT' không có giá trị 'D' và 'C'
  END IF;
END;

-- ----------------------------------------
-- Page: 20004 - confirm_scholarship_request > Validation: btn_save_submit_check_P20004_WORKPLACE > Validation > PL/SQL Function Body

BEGIN
  IF :P20004_SCHOLARSHIP_RECIPIENT = 'C' or :P20004_SCHOLARSHIP_RECIPIENT = 'D' THEN
    IF :P20004_WORKPLACE IS NULL THEN
      RETURN FALSE; -- Trả về FALSE nếu 'WORKPLACE' chưa được điền
    ELSE
      RETURN TRUE; -- Trả về TRUE nếu 'WORKPLACE' đã được điền
    END IF;
  ELSE
    RETURN TRUE; -- Bỏ qua kiểm tra nếu 'SCHOLARSHIP_RECIPIENT' không có giá trị 'D' và 'C'
  END IF;
END;

-- ----------------------------------------
-- Page: 20004 - confirm_scholarship_request > Validation: btn_save_submit_check_P20004_PARTNER_PHONE > Validation > PL/SQL Function Body

BEGIN
  IF :P20004_SCHOLARSHIP_RECIPIENT = 'C' or :P20004_SCHOLARSHIP_RECIPIENT = 'D' THEN
    IF :P20004_PARTNER_PHONE IS NULL THEN
      RETURN FALSE; -- Trả về FALSE nếu 'PARTNER_PHONE' chưa được điền
    ELSE
      RETURN TRUE; -- Trả về TRUE nếu 'PARTNER_PHONE' đã được điền
    END IF;
  ELSE
    RETURN TRUE; -- Bỏ qua kiểm tra nếu 'SCHOLARSHIP_RECIPIENT' không có giá trị 'D' và 'C'
  END IF;
END;

-- ----------------------------------------
-- Page: 20004 - confirm_scholarship_request > Validation: btn_save_submit_check_P20004_PARTNER_NAME > Validation > PL/SQL Function Body

BEGIN
  IF :P20004_SCHOLARSHIP_RECIPIENT = 'C' or :P20004_SCHOLARSHIP_RECIPIENT = 'D' THEN
    IF :P20004_PARTNER_NAME IS NULL THEN
      RETURN FALSE; -- Trả về FALSE nếu 'PARTNER_NAME' chưa được điền
    ELSE
      RETURN TRUE; -- Trả về TRUE nếu 'PARTNER_NAME' đã được điền
    END IF;
  ELSE
    RETURN TRUE; -- Bỏ qua kiểm tra nếu 'SCHOLARSHIP_RECIPIENT' không có giá trị 'D' và 'C'
  END IF;
END;

-- ----------------------------------------
-- Page: 20004 - confirm_scholarship_request > Dynamic Action: set_value_of_voucher_code > Action: Set Value > Settings > PL/SQL Function Body

declare
    x1 nvarchar2(100);
    x2 nvarchar2(100);
    x3 nvarchar2(100);
    x4 nvarchar2(100);
    x5 nvarchar2(100);
begin
    -- if :P20004_EFFECTIVE_DATE is null
    -- then
    --     x1 := null;
    -- else
    --     select to_char(to_date(:P20004_EFFECTIVE_DATE, 'MM/DD/YYYY'),'YY') || 
    --         case
    --             when :P20004_EFFECTIVE_DATE is null then '00'
    --             when :P20004_EFFECTIVE_DATE is not null then to_char(to_date(:P20004_EXPIRATION_DATE, 'MM/DD/YYYY'),'MM')
    --         end
    --     into x1 
    --     from dual;
    -- end if;
    if :P20004_EFFECTIVE_DATE is not null then
        select to_char(to_date(:P20004_EFFECTIVE_DATE, 'MM/DD/YYYY'), 'YY') ||
            coalesce(to_char(to_date(:P20004_EXPIRATION_DATE, 'MM/DD/YYYY'), 'MM'), '00')
        into x1
        from dual;
    end if;

    if :P20004_SCHOLARSHIP_RECIPIENT is not null then
        select :P20004_SCHOLARSHIP_RECIPIENT || :P20004_DISCOUNT_RATE
        into x2
        from dual;
    end if;

    if :P20004_PROGRAM is not null then
        select :P20004_PROGRAM
        into x3
        from dual;
    end if;

    if :P20004_SCHOLARSHIP_RECIPIENT like 'A' or :P20004_SCHOLARSHIP_RECIPIENT like 'B' then
        select :P20004_EMPLOYEE_CODE
        into x4
        from dual;
    else
        if :P20004_SCHOLARSHIP_RECIPIENT like 'C' or :P20004_SCHOLARSHIP_RECIPIENT like 'D' then
            select :P20004_DEPARTMENT_CODE
            into x4
            from dual;
        end if;
    end if;

    if :P20004_SCHOLARSHIP_RECIPIENT like 'A' or :P20004_SCHOLARSHIP_RECIPIENT like 'B' then
        select LTRIM(TO_CHAR(COUNT(REQUESTER_CODE) + 1, '000')) 
        into x5
        from SCHOLARSHIP_REQUEST 
        where REQUESTER_CODE = :P20004_EMPLOYEE_CODE;
    else
        if :P20004_SCHOLARSHIP_RECIPIENT like 'C' or :P20004_SCHOLARSHIP_RECIPIENT like 'D' then
            select  LTRIM(TO_CHAR(COUNT(REQUESTER_DEPARTMENT_CODE) + 1,'000'))
            into x5 
            from SCHOLARSHIP_REQUEST 
            where REQUESTER_DEPARTMENT_CODE = :P20004_DEPARTMENT_CODE;
        end if;
    end if;

    return x1 || '-' || x2 || '-' || x3 || '-' || x4 || '-' || x5;
end;

-- ----------------------------------------
-- Page: 20004 - confirm_scholarship_request > Dynamic Action: change_value_of_replacement > Action: set_value_for_expiration_date_replacement > Settings > SQL Statement

select EXPIRATION_DATE
from SCHOLARSHIP_REQUEST
where VOUCHER_CODE = :P20004_REPLACEMENT;

-- ----------------------------------------
-- Page: 20004 - confirm_scholarship_request > Dynamic Action: change_value_of_replacement > Action: set_value_for_voucher_code_replacement > Settings > SQL Statement

select VOUCHER_CODE
from SCHOLARSHIP_REQUEST
where VOUCHER_CODE = :P20004_REPLACEMENT;

-- ----------------------------------------
-- Page: 20004 - confirm_scholarship_request > Button: Reject > Server-side Condition (Function Body) > PL/SQL Function Body

declare
    n_check number;
    n_check_seq number;
    n_check_line_man number;
begin
    select count(id) 
    into n_check_seq 
    from EMP_REQUESTS er 
    where next_step = 1 
        and er.REQUEST_DETAIL_ID = :P20004_REQUEST_ID;

    if n_check_seq > 0 then
        select count(id) 
        into n_check_line_man 
        from EMP_REQUESTS er 
        where next_step = 1 
            and er.REQUEST_DETAIL_ID = :P20004_REQUEST_ID 
            and er.line_manager = :APP_EMP_CODE ;
    
        if n_check_line_man > 0 then
            return true;
        else
            return false;
        end if;
    else
        select count(er.id) 
        into n_check 
        from EMP_REQUESTS er
            join WORKFLOW_APPROVAL wa on wa.WF_PROCESS_ID = er.WF_PROCESS_ID
            join employees emp on emp.APPROVAL_GROUP = wa.WA_GROUP
        where er.REQUEST_DETAIL_ID = :P20004_REQUEST_ID 
            and er.NEXT_STEP = wa.WA_SEQUENCE_NUMBER
            and emp.EMPLOYEE_CODE = :APP_EMP_CODE 
            and er.STATUS not in (3,4) 
            and er.next_step > 1 
            and :APP_EMP_CODE <> (select line_manager from EMP_REQUESTS where REQUEST_DETAIL_ID = :P20004_REQUEST_ID);

        if n_check > 0 then
            return true;
        else
            return false;
        end if;
    end if;

end;

-- ----------------------------------------
-- Page: 20004 - confirm_scholarship_request > Button: Approve > Server-side Condition (Function Body) > PL/SQL Function Body

declare
    n_check number;     -- biến kiếm tra ẩn/hiện nút
    n_check_seq number; -- biến kiểm tra sequence trong emp_requests, đây là trường hợp mới tạo requests, chưa duyệt lần nào
    n_check_line_man number;
begin
    -- tìm xem dòng request_id có next_step bằng mấy? = 1 thì n_check_seq = count(id) = 1 tiếp tục vào if dưới
    --                                                > 1 thì  n_check_seq = count(id) = 0 tiếp tục vào else dưới
    select count(id) 
    into n_check_seq 
    from EMP_REQUESTS er 
    where next_step = 1 and er.REQUEST_DETAIL_ID = :P20004_REQUEST_ID;
    
    -- trường hợp = 1 thì kiểm tra user hiện tại có phải là line_manager của nv tạo request
    if n_check_seq > 0 then
        select count(id) 
        into n_check_line_man 
        from EMP_REQUESTS er 
        where next_step = 1 and er.REQUEST_DETAIL_ID = :P20004_REQUEST_ID and er.line_manager = :APP_EMP_CODE ; --so sánh line_manager trong request với emp_code của user
        
        if n_check_line_man > 0 then
            return true;    -- đúng thì hiện nút
            else
            return false;   -- sai thì không hiện
        end if;
    else
        select count(er.id) 
        into n_check 
        from EMP_REQUESTS er
            join WORKFLOW_APPROVAL wa on wa.WF_PROCESS_ID = er.WF_PROCESS_ID    -- join bằng cùng process_id
            join employees emp on emp.APPROVAL_GROUP = wa.WA_GROUP      -- join bằng cùng nhóm duyệt
        where er.REQUEST_DETAIL_ID = :P20004_REQUEST_ID -- đang xét request_id hiện tại
            and er.NEXT_STEP = wa.WA_SEQUENCE_NUMBER    -- kiểm tra xem next_step đang tới bước nào
            and emp.EMPLOYEE_CODE = :APP_EMP_CODE       -- kiểm tra nv hiện tại có phải thuộc vào approval group không
            and er.STATUS not in (3,4)          -- status không phải là approved và rejected
            and er.next_step > 1            -- để loại trường hợp mới tạo và next_step = 1
            and :APP_EMP_CODE <> (select line_manager from EMP_REQUESTS where REQUEST_DETAIL_ID = :P20004_REQUEST_ID); -- và user không phải là line manager

            if n_check > 0 then
                return true;
                else
                return false;
            end if;
    end if;

end;

-- ----------------------------------------
-- Page: 20004 - confirm_scholarship_request > Page Item: P20004_NOTE > Default > PL/SQL Function Body

DECLARE
    temp nvarchar2(1000);
BEGIN
    IF :P20004_REQUEST_ID IS NOT NULL THEN
       select RECIPIENT_NOTE into temp from SCHOLARSHIP_REQUEST where :P20004_REQUEST_ID = ID;
       RETURN temp;
    ELSE
      RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 20004 - confirm_scholarship_request > Page Item: P20004_REASON_REQUEST > Default > PL/SQL Function Body

DECLARE
    temp nvarchar2(1000);
BEGIN
    IF :P20004_REQUEST_ID IS NOT NULL THEN
       select RECIPIENT_REASON_REQUEST into temp from SCHOLARSHIP_REQUEST where :P20004_REQUEST_ID = ID;
       RETURN temp;
    ELSE
      RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 20004 - confirm_scholarship_request > Page Item: P20004_EXPIRATION_DATE > Default > PL/SQL Function Body

DECLARE
    temp DATE;
BEGIN
    IF :P20004_REQUEST_ID IS NOT NULL THEN
       select EXPIRATION_DATE into temp from SCHOLARSHIP_REQUEST where :P20004_REQUEST_ID = ID;
       RETURN temp;
    ELSE
      RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 20004 - confirm_scholarship_request > Page Item: P20004_EXPIRATION_DATE_REPLACEMENT > Default > PL/SQL Function Body

DECLARE
    temp date;
BEGIN
    IF :P20004_REQUEST_ID IS NOT NULL THEN
       select RECIPIENT_EXPIRATION_DATE_REPLACEMENT into temp from SCHOLARSHIP_REQUEST where :P20004_REQUEST_ID = ID;
       RETURN temp;
    ELSE
      RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 20004 - confirm_scholarship_request > Page Item: P20004_NUMBER_OF_COURSES > Default > PL/SQL Function Body

DECLARE
    temp NVARCHAR2(1000);
BEGIN
    IF :P20004_REQUEST_ID IS NOT NULL THEN
       select NUMBER_OF_COURSES into temp from SCHOLARSHIP_REQUEST where :P20004_REQUEST_ID = ID;
       RETURN temp;
    ELSE
      RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 20004 - confirm_scholarship_request > Page Item: P20004_VOUCHER_CODE_REPLACEMENT > Default > PL/SQL Function Body


DECLARE
    temp nvarchar2(1000);
BEGIN
    IF :P20004_REQUEST_ID IS NOT NULL THEN
       select RECIPIENT_VOUCHER_CODE_REPLACEMENT into temp from SCHOLARSHIP_REQUEST where :P20004_REQUEST_ID = ID;
       RETURN temp;
    ELSE
      RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 20004 - confirm_scholarship_request > Page Item: P20004_APPROVED_DATE > Default > PL/SQL Function Body

DECLARE
    temp DATE;
BEGIN
    IF :P20004_REQUEST_ID IS NOT NULL THEN
       select APPROVED_DATE into temp from SCHOLARSHIP_REQUEST where :P20004_REQUEST_ID = ID;
       RETURN temp;
    ELSE
      RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 20004 - confirm_scholarship_request > Page Item: P20004_REPLACEMENT > Default > PL/SQL Function Body

-- SELECT sr.RECIPIENT_NAME || ' - ' || sr.RECIPIENT_DOB, sr.VOUCHER_CODE as ID
-- FROM SCHOLARSHIP_REQUEST sr
-- WHERE sr.REQUESTER_CODE = :P20004_EMPLOYEE_CODE AND sr.RECIPIENT_RELATIONSHIP != 1;

DECLARE
    temp nvarchar2(1000);
BEGIN
    IF :P20004_REQUEST_ID IS NOT NULL THEN
       select RECIPIENT_REPLACEMENT into temp from SCHOLARSHIP_REQUEST where :P20004_REQUEST_ID = ID;
       RETURN temp;
    ELSE
      RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 20004 - confirm_scholarship_request > Page Item: P20004_REPLACEMENT > List of Values > SQL Query

SELECT RECIPIENT_NAME || ' - ' || RECIPIENT_DOB as DISPLAY_VALUE, VOUCHER_CODE as RETURN_VALUE
FROM SCHOLARSHIP_REQUEST
WHERE REQUESTER_CODE = :P20004_EMPLOYEE_CODE 
AND RECIPIENT_TYPE = 'B'
AND RECIPIENT_RELATIONSHIP != 1
AND STATUS != 7
AND ID != :P20004_REQUEST_ID;

-- ----------------------------------------
-- Page: 20004 - confirm_scholarship_request > Page Item: P20004_EFFECTIVE_DATE > Default > PL/SQL Function Body

DECLARE
    temp DATE;
BEGIN
    IF :P20004_REQUEST_ID IS NOT NULL THEN
       select EFFECTIVE_DATE into temp from SCHOLARSHIP_REQUEST where :P20004_REQUEST_ID = ID;
       RETURN temp;
    ELSE
      RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 20004 - confirm_scholarship_request > Page Item: P20004_TERMINATION_DATE > Default > PL/SQL Function Body

--select TERMINATE_DATE from employees where USER_NAME = :APP_USER_NAME;

DECLARE
    temp nvarchar2(1000);
BEGIN
    IF :P20004_REQUEST_ID IS NOT NULL THEN
    --    select REQUESTER_LEVEL into temp from SCHOLARSHIP_REQUEST where :P20004_REQUEST_ID = ID;
       select emp.TERMINATE_DATE into temp 
       from EMPLOYEES emp 
       join SCHOLARSHIP_REQUEST sr 
       on emp.EMPLOYEE_CODE = sr.REQUESTER_CODE 
       where sr.ID = :P20004_REQUEST_ID;

       RETURN temp;
    ELSE
    --    SELECT TERMINATE_DATE INTO temp FROM EMPLOYEES WHERE :APP_USER_NAME = USER_NAME; 
       
    --    RETURN temp;
       RETURN NULL;
    END IF;
END;



-- ----------------------------------------
-- Page: 20004 - confirm_scholarship_request > Page Item: P20004_START_DATE > Default > PL/SQL Function Body

--select START_DATE from EMPLOYEES where USER_NAME = :APP_USER_NAME;

DECLARE
    temp DATE;
BEGIN
    IF :P20004_REQUEST_ID IS NOT NULL THEN
    --    select REQUESTER_LEVEL into temp from SCHOLARSHIP_REQUEST where :P20004_REQUEST_ID = ID;
       select emp.START_DATE into temp 
       from EMPLOYEES emp 
       join SCHOLARSHIP_REQUEST sr 
       on emp.EMPLOYEE_CODE = sr.REQUESTER_CODE 
       where sr.ID = :P20004_REQUEST_ID;

       RETURN temp;
    ELSE
    --    SELECT START_DATE INTO temp FROM EMPLOYEES WHERE :APP_USER_NAME = USER_NAME; 
       
    --    RETURN temp;
       RETURN NULL;
    END IF;
END;



-- ----------------------------------------
-- Page: 20004 - confirm_scholarship_request > Page Item: P20004_WORKPLACE > Default > PL/SQL Function Body

DECLARE
    temp nvarchar2(1000);
BEGIN
    IF :P20004_REQUEST_ID IS NOT NULL THEN
       select PARTNER_WORKPLACE into temp from SCHOLARSHIP_REQUEST where :P20004_REQUEST_ID = ID;
       RETURN temp;
    ELSE
      RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 20004 - confirm_scholarship_request > Page Item: P20004_LEVEL > Default > PL/SQL Function Body

--select LEVEL_DESCRIPTION from EMPLOYEES where USER_NAME = :APP_USER_NAME;

DECLARE
    temp nvarchar2(1000);
BEGIN
    IF :P20004_REQUEST_ID IS NOT NULL THEN
       select REQUESTER_LEVEL into temp from SCHOLARSHIP_REQUEST where :P20004_REQUEST_ID = ID;
       RETURN temp;
    ELSE
    --    SELECT LEVEL_DESCRIPTION INTO temp FROM EMPLOYEES WHERE :APP_USER_NAME = USER_NAME; 
    --    RETURN temp;
       RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 20004 - confirm_scholarship_request > Page Item: P20004_DEPARTMENT > Default > PL/SQL Function Body

DECLARE
    temp nvarchar2(1000);
BEGIN
    IF :P20004_REQUEST_ID IS NOT NULL THEN
       select REQUESTER_DEPARTMENT into temp from SCHOLARSHIP_REQUEST where :P20004_REQUEST_ID = ID;
       RETURN temp;
    ELSE
    --    SELECT DEPARTMENT_NAME INTO temp FROM EMPLOYEES WHERE :APP_USER_NAME = USER_NAME; 
    --    RETURN temp;
       RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 20004 - confirm_scholarship_request > Page Item: P20004_DEPARTMENT > List of Values > SQL Query

select DISTINCT DEPARTMENT_NAME from EMPLOYEES;

-- ----------------------------------------
-- Page: 20004 - confirm_scholarship_request > Page Item: P20004_CAMPUS > Default > PL/SQL Function Body

--select RECIPIENT_CAMPUS from SCHOLARSHIP_REQUEST where :P20004_REQUEST_ID = id;

DECLARE
    temp nvarchar2(1000);
BEGIN
    IF :P20004_REQUEST_ID IS NOT NULL THEN
       select RECIPIENT_CAMPUS into temp from SCHOLARSHIP_REQUEST where :P20004_REQUEST_ID = ID;
       RETURN temp;
    ELSE
      RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 20004 - confirm_scholarship_request > Page Item: P20004_CAMPUS > List of Values > SQL Query

SELECT DISTINCT UNIT_NAME FROM DEPARTMENT_CAMPUS WHERE UNIT_TYPE LIKE 'Business unit' AND UNIT_NUMBER <> '00000401';

-- ----------------------------------------
-- Page: 20004 - confirm_scholarship_request > Page Item: P20004_DEPARTMENT_CODE > Default > PL/SQL Function Body

DECLARE
    temp nvarchar2(1000);
BEGIN
    IF :P20004_REQUEST_ID IS NOT NULL THEN
       select REQUESTER_DEPARTMENT_CODE into temp from SCHOLARSHIP_REQUEST where :P20004_REQUEST_ID = ID;
       RETURN temp;
    ELSE
    --    SELECT DEPARTMENT_ID INTO temp FROM EMPLOYEES WHERE :APP_USER_NAME = USER_NAME; 
    --    RETURN temp;
       RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 20004 - confirm_scholarship_request > Page Item: P20004_SCHOLARSHIP_DETAIL > Default > SQL Query

select SCHOLARSHIP_DETAIL_ID.nextval from dual;

-- ----------------------------------------
-- Page: 20004 - confirm_scholarship_request > Page Item: P20004_VOUCHER_CODE > Default > PL/SQL Function Body

DECLARE
    temp nvarchar2(1000);
BEGIN
    IF :P20004_REQUEST_ID IS NOT NULL THEN
       select VOUCHER_CODE into temp from SCHOLARSHIP_REQUEST where :P20004_REQUEST_ID = ID;
       RETURN temp;
    ELSE
      RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 20004 - confirm_scholarship_request > Page Item: P20004_RECIPIENT_PHONE > Default > PL/SQL Function Body

DECLARE
    temp nvarchar2(1000);
BEGIN
    IF :P20004_REQUEST_ID IS NOT NULL THEN
       select RECIPIENT_PHONE into temp from SCHOLARSHIP_REQUEST where :P20004_REQUEST_ID = ID;
       RETURN temp;
    ELSE
      RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 20004 - confirm_scholarship_request > Page Item: P20004_LINE_MANAGER > Default > SQL Query

SELECT MANAGER_ID FROM EMPLOYEES WHERE EMPLOYEE_CODE = :APP_EMP_CODE;

-- ----------------------------------------
-- Page: 20004 - confirm_scholarship_request > Page Item: P20004_TITLE > Default > PL/SQL Function Body

DECLARE
    temp nvarchar2(1000);
BEGIN
    IF :P20004_REQUEST_ID IS NOT NULL THEN
       select PARTNER_TITLE into temp from SCHOLARSHIP_REQUEST where :P20004_REQUEST_ID = ID;
       RETURN temp;
    ELSE
      RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 20004 - confirm_scholarship_request > Page Item: P20004_EMPLOYEE_CODE > Default > PL/SQL Function Body

DECLARE
    temp nvarchar2(1000);
BEGIN
    IF :P20004_REQUEST_ID IS NOT NULL THEN
       select REQUESTER_CODE into temp from SCHOLARSHIP_REQUEST where :P20004_REQUEST_ID = ID;
       RETURN temp;
    ELSE
    --    select :APP_EMP_CODE into temp from DUAL;
    --    RETURN temp;
       RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 20004 - confirm_scholarship_request > Page Item: P20004_RECIPIENT_DOB > Default > PL/SQL Function Body

DECLARE
    temp DATE;
BEGIN
    IF :P20004_REQUEST_ID IS NOT NULL THEN
       select RECIPIENT_DOB into temp from SCHOLARSHIP_REQUEST where :P20004_REQUEST_ID = ID;
       RETURN temp;
    ELSE
      RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 20004 - confirm_scholarship_request > Page Item: P20004_REQUEST_NAME_AB > Default > PL/SQL Function Body

--select FULL_NAME from EMPLOYEES where USER_NAME = :APP_USER_NAME

DECLARE
    temp nvarchar2(1000);
BEGIN
    IF :P20004_REQUEST_ID IS NOT NULL THEN
    --    select REQUESTER_LEVEL into temp from SCHOLARSHIP_REQUEST where :P20004_REQUEST_ID = ID;
       select emp.FULL_NAME into temp 
       from EMPLOYEES emp 
       join SCHOLARSHIP_REQUEST sr 
       on emp.EMPLOYEE_CODE = sr.REQUESTER_CODE 
       where sr.ID = :P20004_REQUEST_ID;

       RETURN temp;
    ELSE
    --    SELECT FULL_NAME INTO temp FROM EMPLOYEES WHERE :APP_USER_NAME = USER_NAME; 
       
    --    RETURN temp;
       RETURN NULL;
    END IF;
END;



-- ----------------------------------------
-- Page: 20004 - confirm_scholarship_request > Page Item: P20004_DISCOUNT_RATE > List of Values > PL/SQL Function Body returning SQL Query

declare
    t_sql nvarchar2(10000);
begin
    t_sql := 'SELECT
                ''voucher '' || DISCOUNT_RATE || ''%'' AS DISPLAY_VALUE,
                DISCOUNT_RATE AS RETURN_VALUE
              FROM
                COREEDU_PROMOTION
              WHERE
                PROGRAM = :P20004_PROGRAM
              ORDER BY
                DISCOUNT_RATE DESC';
    return t_sql;
end;

-- ----------------------------------------
-- Page: 20004 - confirm_scholarship_request > Page Item: P20004_DISCOUNT_RATE > Default > PL/SQL Function Body

DECLARE
    temp number;
BEGIN
    IF :P20004_REQUEST_ID IS NOT NULL THEN
       select DISCOUNT_RATE into temp from SCHOLARSHIP_REQUEST where :P20004_REQUEST_ID = ID;
       RETURN temp;
    ELSE
      RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 20004 - confirm_scholarship_request > Page Item: P20004_PARTNER_PHONE > Default > PL/SQL Function Body

DECLARE
    temp nvarchar2(1000);
BEGIN
    IF :P20004_REQUEST_ID IS NOT NULL THEN
       select PARTNER_PHONE into temp from SCHOLARSHIP_REQUEST where :P20004_REQUEST_ID = ID;
       RETURN temp;
    ELSE
      RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 20004 - confirm_scholarship_request > Page Item: P20004_RECIPIENT_NAME > Default > PL/SQL Function Body

--select RECIPIENT_NAME from SCHOLARSHIP_REQUEST where :P20004_REQUEST_ID = id;

DECLARE
    temp nvarchar2(1000);
BEGIN
    IF :P20004_REQUEST_ID IS NOT NULL THEN
       select RECIPIENT_NAME into temp from SCHOLARSHIP_REQUEST where :P20004_REQUEST_ID = ID;
       RETURN temp;
    ELSE
      RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 20004 - confirm_scholarship_request > Page Item: P20004_PARTNER_NAME > Default > PL/SQL Function Body

DECLARE
    temp nvarchar2(1000);
BEGIN
    IF :P20004_REQUEST_ID IS NOT NULL THEN
       select PARTNER_NAME into temp from SCHOLARSHIP_REQUEST where :P20004_REQUEST_ID = ID;
       RETURN temp;
    ELSE
      RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 20004 - confirm_scholarship_request > Page Item: P20004_REQUEST_NAME > Default > PL/SQL Function Body

DECLARE
    temp nvarchar2(1000);
BEGIN
    IF :P20004_REQUEST_ID IS NOT NULL THEN
       select emp.EMPLOYEE_CODE into temp 
       from EMPLOYEES emp 
       join SCHOLARSHIP_REQUEST sr 
       on emp.EMPLOYEE_CODE = sr.REQUESTER_CODE 
       where sr.ID = :P20004_REQUEST_ID;
       
       --select EMPLOYEE_CODE into temp from EMPLOYEES where USER_NAME = :APP_USER_NAME;
       RETURN temp;
    ELSE
       RETURN NULL;
    END IF;
END;



-- ----------------------------------------
-- Page: 20004 - confirm_scholarship_request > Page Item: P20004_REQUEST_NAME > List of Values > SQL Query

select FULL_NAME || ' - ' || EMPLOYEE_CODE, EMPLOYEE_CODE as ID from EMPLOYEES;

-- ----------------------------------------
-- Page: 20004 - confirm_scholarship_request > Page Item: P20004_PARTNER_DEPARTMENT > Default > PL/SQL Function Body

DECLARE
    temp nvarchar2(1000);
BEGIN
    IF :P20004_REQUEST_ID IS NOT NULL THEN
       select PARTNER_DEPARTMENT into temp from SCHOLARSHIP_REQUEST where :P20004_REQUEST_ID = ID;
       RETURN temp;
    ELSE
      RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 20004 - confirm_scholarship_request > Page Item: P20004_RELATIONSHIP > Default > PL/SQL Function Body

DECLARE
    temp nvarchar2(1000);
BEGIN
    IF :P20004_REQUEST_ID IS NOT NULL THEN
       select RECIPIENT_RELATIONSHIP into temp from SCHOLARSHIP_REQUEST where :P20004_REQUEST_ID = ID;
       RETURN temp;
    ELSE
      RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 20004 - confirm_scholarship_request > Page Item: P20004_SCHOLARSHIP_RECIPIENT > Default > PL/SQL Function Body

declare
    temp nvarchar2(1000);
begin
    IF :P20004_REQUEST_ID IS NOT NULL THEN
       select RECIPIENT_TYPE into temp from SCHOLARSHIP_REQUEST where :P20004_REQUEST_ID = ID;
       return temp;
    ELSE
      RETURN null;
    END IF;
end;

-- ----------------------------------------
-- Page: 20004 - confirm_scholarship_request > Page Item: P20004_FIELD > Default > PL/SQL Function Body

DECLARE
    temp nvarchar2(1000);
BEGIN
    IF :P20004_REQUEST_ID IS NOT NULL THEN
       select PARTNER_FIELD into temp from SCHOLARSHIP_REQUEST where :P20004_REQUEST_ID = ID;
       RETURN temp;
    ELSE
      RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 20004 - confirm_scholarship_request > Page Item: P20004_PROGRAM > Default > PL/SQL Function Body

declare
    temp nvarchar2(1000);
begin
    IF :P20004_REQUEST_ID IS NOT NULL THEN
       select PROGRAM into temp from SCHOLARSHIP_REQUEST where :P20004_REQUEST_ID = ID;
       return temp;
    ELSE
       RETURN null;
    END IF;
end;

-- ----------------------------------------
-- Page: 20004 - confirm_scholarship_request > Region: ATTACHMENT_HISTORY > Source > SQL Query

select ah.ATTACHMENT_DATE,
       e.FULL_NAME,
       ah.URL
  from ATTACHMENT_HISTORY ah
  join EMPLOYEES e on e.EMPLOYEE_CODE = ah.EMPLOYEE_CODE;

