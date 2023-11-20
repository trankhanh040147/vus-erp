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
-- Page: 42 - Confirm Scholarship Request PK > Region: WORKFLOW_DETAILS > Source > SQL Query

select wd.ID,
       wd.WD_MODIFIED_DATE,
       wd.WD_MODIFIED_CODE,
       e.FULL_NAME,
       wd.WD_COMMENT,
       wd.WD_INFORMATION
  from WORKFLOW_DETAIL wd
  join EMPLOYEES e on wd.WD_MODIFIED_CODE = e.EMPLOYEE_CODE;

-- ----------------------------------------
-- Page: 42 - Confirm Scholarship Request PK > Process: Reject > Source > PL/SQL Code

declare
    n_check number;
    n_step number;
begin
for rec in (
    with temp as (
    select wa.WA_GROUP from EMP_REQUESTS er
        join WORKFLOW_APPROVAL wa on wa.WF_PROCESS_ID = er.WF_PROCESS_ID
        join employees emp on emp.APPROVAL_GROUP = wa.WA_GROUP
        where emp.EMPLOYEE_CODE = :APP_EMP_CODE
        group by wa.WA_GROUP
)
    select er.CURRENT_STEP,er.NEXT_STEP,count(wa.WA_SEQUENCE_NUMBER) as SEQ from EMP_REQUESTS er
        join WORKFLOW_APPROVAL wa on wa.WF_PROCESS_ID = er.WF_PROCESS_ID
        join WORKFLOW_APPROVAL tmp on tmp.WA_GROUP = wa.WA_GROUP
        where er.REQUEST_DETAIL_ID = :P42_REQUEST_ID and er.STATUS <> 3 group by er.CURRENT_STEP,er.NEXT_STEP)loop
            if rec.NEXT_STEP < rec.SEQ then
                --select wa.WA_SEQUENCE_NUMBER into n_step from EMPLOYEES emp join WORKFLOW_APPROVAL wa on wa.WA_GROUP = emp.APPROVAL_GROUP and employee_code = :APP_EMP_CODE;
                update EMP_REQUESTS set MODIFIED_DATE = sysdate,CURRENT_STEP=rec.NEXT_STEP,MODIFIED_BY_CODE = :APP_EMP_CODE,STATUS=4 where REQUEST_DETAIL_ID = :P42_REQUEST_ID;
                            insert into WORKFLOW_DETAIL(WD_MODIFIED_DATE,WD_MODIFIED_CODE,STATUS,REQUEST_ID,SEQUENCE) 
            values(sysdate,:APP_EMP_CODE,4,:P42_REQUEST_ID,rec.NEXT_STEP);
            update SCHOLARSHIP_REQUEST set STATUS = 4 where id = :P42_REQUEST_ID;
                --else
                --update EMP_REQUESTS set MODIFIED_DATE = sysdate,CURRENT_STEP=rec.NEXT_STEP,MODIFIED_BY_CODE = :APP_EMP_CODE,STATUS=3 where id = :P42_REQUEST_ID;
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
-- Page: 42 - Confirm Scholarship Request PK > Process: Approve > Source > PL/SQL Code

declare
    n_check number;
    n_step number;
begin
for rec in (
    with temp as (
    select wa.WA_GROUP from EMP_REQUESTS er
        join WORKFLOW_APPROVAL wa on wa.WF_PROCESS_ID = er.WF_PROCESS_ID
        join employees emp on emp.APPROVAL_GROUP = wa.WA_GROUP
        where emp.EMPLOYEE_CODE = :APP_EMP_CODE
        group by wa.WA_GROUP
)
    select er.CURRENT_STEP,er.NEXT_STEP,count(wa.WA_SEQUENCE_NUMBER) as SEQ from EMP_REQUESTS er
        join WORKFLOW_APPROVAL wa on wa.WF_PROCESS_ID = er.WF_PROCESS_ID
        join WORKFLOW_APPROVAL tmp on tmp.WA_GROUP = wa.WA_GROUP
        where er.REQUEST_DETAIL_ID = :P42_REQUEST_ID and er.STATUS <> 3 group by er.CURRENT_STEP,er.NEXT_STEP)loop
            if rec.NEXT_STEP < rec.SEQ then
                --select wa.WA_SEQUENCE_NUMBER into n_step from EMPLOYEES emp join WORKFLOW_APPROVAL wa on wa.WA_GROUP = emp.APPROVAL_GROUP and employee_code = :APP_EMP_CODE;
                update EMP_REQUESTS set MODIFIED_DATE = sysdate,CURRENT_STEP=rec.NEXT_STEP,MODIFIED_BY_CODE = :APP_EMP_CODE,NEXT_STEP = rec.NEXT_STEP+1,STATUS=6 where REQUEST_DETAIL_ID = :P42_REQUEST_ID;
                update SCHOLARSHIP_REQUEST set STATUS = 6 where id = :P42_REQUEST_ID;
                else
                update EMP_REQUESTS set MODIFIED_DATE = sysdate,CURRENT_STEP=rec.NEXT_STEP,MODIFIED_BY_CODE = :APP_EMP_CODE,STATUS=3 where REQUEST_DETAIL_ID = :P42_REQUEST_ID;
                update SCHOLARSHIP_REQUEST set STATUS = 3 where id = :P42_REQUEST_ID;
            end if;
            insert into WORKFLOW_DETAIL(WD_MODIFIED_DATE,WD_MODIFIED_CODE,STATUS,REQUEST_ID,SEQUENCE,WD_COMMENT) 
            values(sysdate,:APP_EMP_CODE,3,:P42_REQUEST_ID,rec.NEXT_STEP,:P42_NOTE);
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
-- Page: 42 - Confirm Scholarship Request PK > Validation: btn_save_check_null_expiration_date > Validation > PL/SQL Function Body

BEGIN
  IF :P42_SCHOLARSHIP_RECIPIENT = 'D' or :P42_SCHOLARSHIP_RECIPIENT = 'C' THEN
    IF :P42_EXPIRATION_DATE IS NULL THEN
      RETURN FALSE; -- Trả về FALSE nếu 'EXPIRATION_DATE' chưa được điền
    ELSE
      RETURN TRUE; -- Trả về TRUE nếu 'EXPIRATION_DATE' đã được điền
    END IF;
  ELSE
    RETURN TRUE; -- Bỏ qua kiểm tra nếu 'SCHOLARSHIP_RECIPIENT' không có giá trị 'D'
  END IF;
END;

-- ----------------------------------------
-- Page: 42 - Confirm Scholarship Request PK > Validation: btn_save_submit_check_null_expiration_date > Validation > PL/SQL Function Body

BEGIN
  IF :P42_SCHOLARSHIP_RECIPIENT = 'D' or :P42_SCHOLARSHIP_RECIPIENT = 'C' THEN
    IF :P42_EXPIRATION_DATE IS NULL THEN
      RETURN FALSE; -- Trả về FALSE nếu 'EXPIRATION_DATE' chưa được điền
    ELSE
      RETURN TRUE; -- Trả về TRUE nếu 'EXPIRATION_DATE' đã được điền
    END IF;
  ELSE
    RETURN TRUE; -- Bỏ qua kiểm tra nếu 'SCHOLARSHIP_RECIPIENT' không có giá trị 'D'
  END IF;
END;

-- ----------------------------------------
-- Page: 42 - Confirm Scholarship Request PK > Dynamic Action: change_value_of_replacement > Action: set_value_for_expiration_date_replacement > Settings > SQL Statement

select sr.EXPIRATION_DATE
from SCHOLARSHIP_REQUEST sr
where sr.VOUCHER_CODE = :P42_REPLACEMENT;

-- ----------------------------------------
-- Page: 42 - Confirm Scholarship Request PK > Dynamic Action: change_value_of_replacement > Action: set_value_for_voucher_code_replacement > Settings > SQL Statement

select sr.VOUCHER_CODE
from SCHOLARSHIP_REQUEST sr
where sr.VOUCHER_CODE = :P42_REPLACEMENT;

-- ----------------------------------------
-- Page: 42 - Confirm Scholarship Request PK > Dynamic Action: set_value_for_voucher_code_3 > Action: Set Value > Settings > SQL Statement

-- select TO_CHAR(SYSDATE, 'mmYY') || '-' || :P42_VOUCHER_CODE_1 || '-' ||
--     case
--         when :P42_SCHOLARSHIP_RECIPIENT like 'A' or :P42_SCHOLARSHIP_RECIPIENT || '-ccc'
--         when :P42_SCHOLARSHIP_RECIPIENT like 'B' then :P42_EMPLOYEE_CODE || '-ccc'
--         when :P42_SCHOLARSHIP_RECIPIENT like 'C' then :P42_DEPARTMENT_CODE || '-ccc'
--         when :P42_SCHOLARSHIP_RECIPIENT like 'D' then :P42_DEPARTMENT_CODE || '-ccc'
--     end as result
-- from dual; 

select TO_CHAR(SYSDATE, 'mmYY') || '-' || :P42_VOUCHER_CODE_1 || '-' ||
    case
        when :P42_SCHOLARSHIP_RECIPIENT like 'A' or :P42_SCHOLARSHIP_RECIPIENT like 'B' then :P42_EMPLOYEE_CODE || '-' || :P42_VOUCHER_CODE_3
        else
            :P42_DEPARTMENT_CODE || '-' || :P42_VOUCHER_CODE_2
    end as result
from dual;

-- ----------------------------------------
-- Page: 42 - Confirm Scholarship Request PK > Dynamic Action: set_value_for_voucher_code_2 > Action: Set Value > Settings > SQL Statement

-- select TO_CHAR(SYSDATE, 'mmYY') || '-' || :P42_VOUCHER_CODE_1 || '-' ||
--     case
--         when :P42_SCHOLARSHIP_RECIPIENT like 'A' or :P42_SCHOLARSHIP_RECIPIENT || '-ccc'
--         when :P42_SCHOLARSHIP_RECIPIENT like 'B' then :P42_EMPLOYEE_CODE || '-ccc'
--         when :P42_SCHOLARSHIP_RECIPIENT like 'C' then :P42_DEPARTMENT_CODE || '-ccc'
--         when :P42_SCHOLARSHIP_RECIPIENT like 'D' then :P42_DEPARTMENT_CODE || '-ccc'
--     end as result
-- from dual; 

select TO_CHAR(SYSDATE, 'mmYY') || '-' || :P42_VOUCHER_CODE_1 || '-' ||
    case
        when :P42_SCHOLARSHIP_RECIPIENT like 'A' or :P42_SCHOLARSHIP_RECIPIENT like 'B' then :P42_EMPLOYEE_CODE || '-' || :P42_VOUCHER_CODE_3
        else
            :P42_DEPARTMENT_CODE || '-' || :P42_VOUCHER_CODE_2
    end as result
from dual;

-- ----------------------------------------
-- Page: 42 - Confirm Scholarship Request PK > Dynamic Action: set_value_for_voucher_code_ccc_department > Action: Set Value > Settings > SQL Statement

-- SELECT 
--   CASE 
--     WHEN :P42_SCHOLARSHIP_RECIPIENT IN ('A', 'B') THEN LTRIM(to_char(COUNT(REQUESTER_DEPARTMENT_CODE) + 1,'000'))
--     WHEN :P42_SCHOLARSHIP_RECIPIENT IN ('C', 'D') THEN LTRIM(to_char(COUNT(REQUESTER_CODE) + 1,'000'))
--   END AS result
-- FROM SCHOLARSHIP_REQUEST 
-- WHERE 
--   (:P42_SCHOLARSHIP_RECIPIENT IN ('A', 'B') AND REQUESTER_DEPARTMENT_CODE = :P42_DEPARTMENT_CODE) OR
--   (:P42_SCHOLARSHIP_RECIPIENT IN ('C', 'D') AND REQUESTER_CODE = :P42_EMPLOYEE_CODE);

SELECT  LTRIM(TO_CHAR(COUNT(REQUESTER_DEPARTMENT_CODE) + 1,'000')) 
FROM SCHOLARSHIP_REQUEST 
WHERE REQUESTER_DEPARTMENT_CODE = :P42_DEPARTMENT_CODE;

-- ----------------------------------------
-- Page: 42 - Confirm Scholarship Request PK > Dynamic Action: change_value_of_request_name > Action: set_value_termination_date > Settings > SQL Statement

select emp.TERMINATE_DATE from EMPLOYEES emp where :P42_REQUEST_NAME = emp.EMPLOYEE_CODE;

-- ----------------------------------------
-- Page: 42 - Confirm Scholarship Request PK > Dynamic Action: change_value_of_request_name > Action: set_value_start_date > Settings > SQL Statement

select emp.START_DATE from EMPLOYEES emp where :P42_REQUEST_NAME = emp.EMPLOYEE_CODE;

-- ----------------------------------------
-- Page: 42 - Confirm Scholarship Request PK > Dynamic Action: change_value_of_request_name > Action: set_value_level > Settings > SQL Statement

select emp.LEVEL_DESCRIPTION from EMPLOYEES emp where :P42_REQUEST_NAME = emp.EMPLOYEE_CODE;

-- ----------------------------------------
-- Page: 42 - Confirm Scholarship Request PK > Dynamic Action: change_value_of_request_name > Action: set_value_department > Settings > SQL Statement

select emp.DEPARTMENT_NAME from EMPLOYEES emp where :P42_REQUEST_NAME = emp.EMPLOYEE_CODE;

-- ----------------------------------------
-- Page: 42 - Confirm Scholarship Request PK > Dynamic Action: change_value_of_request_name > Action: set_value_department_code > Settings > SQL Statement

select emp.DEPARTMENT_ID from EMPLOYEES emp where :P42_REQUEST_NAME = emp.EMPLOYEE_CODE;

-- ----------------------------------------
-- Page: 42 - Confirm Scholarship Request PK > Dynamic Action: set_value_for_voucher_code_EP/ELT > Action: Set Value > Settings > SQL Statement

select :P42_SCHOLARSHIP_RECIPIENT || :P42_DISCOUNT_RATE || '-' || :P42_PROGRAM from dual;

-- ----------------------------------------
-- Page: 42 - Confirm Scholarship Request PK > Dynamic Action: set_value_for_voucher_code_aaa > Action: Set Value > Settings > SQL Statement

select :P42_SCHOLARSHIP_RECIPIENT || :P42_DISCOUNT_RATE || '-' || :P42_PROGRAM from dual;

-- ----------------------------------------
-- Page: 42 - Confirm Scholarship Request PK > Dynamic Action: set_value_for_voucher_code > Action: Set Value > Settings > SQL Statement

-- select TO_CHAR(SYSDATE, 'mmYY') || '-' || :P42_VOUCHER_CODE_1 || '-' ||
--     case
--         when :P42_SCHOLARSHIP_RECIPIENT like 'A' or :P42_SCHOLARSHIP_RECIPIENT || '-ccc'
--         when :P42_SCHOLARSHIP_RECIPIENT like 'B' then :P42_EMPLOYEE_CODE || '-ccc'
--         when :P42_SCHOLARSHIP_RECIPIENT like 'C' then :P42_DEPARTMENT_CODE || '-ccc'
--         when :P42_SCHOLARSHIP_RECIPIENT like 'D' then :P42_DEPARTMENT_CODE || '-ccc'
--     end as result
-- from dual; 

select TO_CHAR(SYSDATE, 'mmYY') || '-' || :P42_VOUCHER_CODE_1 || '-' ||
    case
        when :P42_SCHOLARSHIP_RECIPIENT like 'A' or :P42_SCHOLARSHIP_RECIPIENT like 'B' then :P42_EMPLOYEE_CODE || '-' || :P42_VOUCHER_CODE_3
        else
            :P42_DEPARTMENT_CODE || '-' || :P42_VOUCHER_CODE_2
    end as result
from dual;

-- ----------------------------------------
-- Page: 42 - Confirm Scholarship Request PK > Dynamic Action: set_value_for_voucher_code_X > Action: set_value_for_voucher_code_ccc_employee > Settings > SQL Statement

SELECT LTRIM(TO_CHAR(COUNT(REQUESTER_CODE) + 1, '000')) FROM SCHOLARSHIP_REQUEST WHERE REQUESTER_CODE = :P42_EMPLOYEE_CODE;

-- ----------------------------------------
-- Page: 42 - Confirm Scholarship Request PK > Dynamic Action: set_value_for_voucher_code_X > Action: set_value_for_voucher_code_X > Settings > SQL Statement

select :P42_SCHOLARSHIP_RECIPIENT || :P42_DISCOUNT_RATE || '-' || :P42_PROGRAM from dual;

-- ----------------------------------------
-- Page: 42 - Confirm Scholarship Request PK > Dynamic Action: Change_B > Action: set_value_effective_day > Settings > SQL Statement

select SYSDATE from DUAL;

-- ----------------------------------------
-- Page: 42 - Confirm Scholarship Request PK > Dynamic Action: Change_B > Action: set_value_termination_date > Settings > SQL Statement

select emp.TERMINATE_DATE from EMPLOYEES emp where :APP_USER_NAME = USER_NAME;

-- ----------------------------------------
-- Page: 42 - Confirm Scholarship Request PK > Dynamic Action: Change_B > Action: set_value_start_date > Settings > SQL Statement

select emp.START_DATE from EMPLOYEES emp where :APP_USER_NAME = USER_NAME;

-- ----------------------------------------
-- Page: 42 - Confirm Scholarship Request PK > Dynamic Action: Change_B > Action: set_value_level > Settings > SQL Statement

select LEVEL_DESCRIPTION from employees where :APP_USER_NAME = USER_NAME;

-- ----------------------------------------
-- Page: 42 - Confirm Scholarship Request PK > Dynamic Action: Change_B > Action: set_value_department > Settings > SQL Statement

select DEPARTMENT_NAME from employees where :APP_USER_NAME = USER_NAME;

-- ----------------------------------------
-- Page: 42 - Confirm Scholarship Request PK > Dynamic Action: Change_B > Action: set_value_requester_code > Settings > SQL Statement

select :APP_EMP_CODE from DUAL;

-- ----------------------------------------
-- Page: 42 - Confirm Scholarship Request PK > Dynamic Action: Change_B > Action: set_value_requester_name_ab > Settings > SQL Statement

SELECT FULL_NAME FROM EMPLOYEES WHERE :APP_USER_NAME = USER_NAME;

-- ----------------------------------------
-- Page: 42 - Confirm Scholarship Request PK > Dynamic Action: Change_D > Action: set_value_requester_name > Settings > SQL Statement

select EMPLOYEE_CODE from EMPLOYEES where USER_NAME = :APP_USER_NAME;

-- ----------------------------------------
-- Page: 42 - Confirm Scholarship Request PK > Dynamic Action: Change_D > Action: set_value_ effective_day > Settings > SQL Statement

select SYSDATE from DUAL;

-- ----------------------------------------
-- Page: 42 - Confirm Scholarship Request PK > Dynamic Action: Change_C > Action: set_value_requester_name > Settings > SQL Statement

select EMPLOYEE_CODE from EMPLOYEES where USER_NAME = :APP_USER_NAME;

-- ----------------------------------------
-- Page: 42 - Confirm Scholarship Request PK > Dynamic Action: Change_C > Action: set_value_ effective_day > Settings > SQL Statement

select SYSDATE from DUAL;

-- ----------------------------------------
-- Page: 42 - Confirm Scholarship Request PK > Dynamic Action: Change_A > Action: set_value_effective_day > Settings > SQL Statement

select SYSDATE from DUAL;

-- ----------------------------------------
-- Page: 42 - Confirm Scholarship Request PK > Dynamic Action: Change_A > Action: set_value_recipient_dob > Settings > SQL Statement

select DOB from EMPLOYEES where USER_NAME = :APP_USER_NAME;

-- ----------------------------------------
-- Page: 42 - Confirm Scholarship Request PK > Dynamic Action: Change_A > Action: set_value_recipient_name > Settings > SQL Statement

select FULL_NAME from employees where USER_NAME = :APP_USER_NAME;

-- ----------------------------------------
-- Page: 42 - Confirm Scholarship Request PK > Dynamic Action: Change_A > Action: set_value_termination_date > Settings > SQL Statement

select emp.TERMINATE_DATE from EMPLOYEES emp where :APP_USER_NAME = USER_NAME;

-- ----------------------------------------
-- Page: 42 - Confirm Scholarship Request PK > Dynamic Action: Change_A > Action: set_value_start_date > Settings > SQL Statement

select emp.START_DATE from EMPLOYEES emp where :APP_USER_NAME = USER_NAME;

-- ----------------------------------------
-- Page: 42 - Confirm Scholarship Request PK > Dynamic Action: Change_A > Action: set_value_level > Settings > SQL Statement

select LEVEL_DESCRIPTION from employees where :APP_USER_NAME = USER_NAME;

-- ----------------------------------------
-- Page: 42 - Confirm Scholarship Request PK > Dynamic Action: Change_A > Action: set_value_department > Settings > SQL Statement

select DEPARTMENT_NAME from employees where :APP_USER_NAME = USER_NAME;

-- ----------------------------------------
-- Page: 42 - Confirm Scholarship Request PK > Dynamic Action: Change_A > Action: set_value_requester_code > Settings > SQL Statement

select :APP_EMP_CODE from DUAL;

-- ----------------------------------------
-- Page: 42 - Confirm Scholarship Request PK > Dynamic Action: Change_A > Action: set_value_requester_name_ab > Settings > SQL Statement

SELECT FULL_NAME FROM EMPLOYEES WHERE :APP_USER_NAME = USER_NAME;

-- ----------------------------------------
-- Page: 42 - Confirm Scholarship Request PK > Button: Reject > Server-side Condition (Function Body) > PL/SQL Function Body

declare
    n_check number;
    n_check_seq number;
    n_check_line_man number;
begin
select count(id) into n_check_seq from EMP_REQUESTS er where next_step = 1 and er.REQUEST_DETAIL_ID = :P42_REQUEST_ID;
if n_check_seq > 0 then
    select count(id) into n_check_line_man from EMP_REQUESTS er where next_step = 1 and er.REQUEST_DETAIL_ID = :P42_REQUEST_ID and er.line_manager = :APP_EMP_CODE ;
    if n_check_line_man > 0 then
        return true;
        else
        return false;
    end if;
else
    select count(er.id) into n_check from EMP_REQUESTS er
        join WORKFLOW_APPROVAL wa on wa.WF_PROCESS_ID = er.WF_PROCESS_ID
        join employees emp on emp.APPROVAL_GROUP = wa.WA_GROUP
        where er.REQUEST_DETAIL_ID = :P42_REQUEST_ID and er.NEXT_STEP = wa.WA_SEQUENCE_NUMBER
        and emp.EMPLOYEE_CODE = :APP_EMP_CODE and er.STATUS not in (3,4) and er.next_step > 1 and :APP_EMP_CODE <>(select line_manager from EMP_REQUESTS where REQUEST_DETAIL_ID = :P42_REQUEST_ID);

        if n_check > 0 then
            return true;
            else
            return false;
        end if;
end if;

end;

-- ----------------------------------------
-- Page: 42 - Confirm Scholarship Request PK > Button: Approve > Server-side Condition (Function Body) > PL/SQL Function Body

declare
    n_check number;
    n_check_seq number;
    n_check_line_man number;
begin
select count(id) into n_check_seq from EMP_REQUESTS er where next_step = 1 and er.REQUEST_DETAIL_ID = :P42_REQUEST_ID;
if n_check_seq > 0 then
    select count(id) into n_check_line_man from EMP_REQUESTS er where next_step = 1 and er.REQUEST_DETAIL_ID = :P42_REQUEST_ID and er.line_manager = :APP_EMP_CODE ;
    if n_check_line_man > 0 then
        return true;
        else
        return false;
    end if;
else
    select count(er.id) into n_check from EMP_REQUESTS er
        join WORKFLOW_APPROVAL wa on wa.WF_PROCESS_ID = er.WF_PROCESS_ID
        join employees emp on emp.APPROVAL_GROUP = wa.WA_GROUP
        where er.REQUEST_DETAIL_ID = :P42_REQUEST_ID and er.NEXT_STEP = wa.WA_SEQUENCE_NUMBER
        and emp.EMPLOYEE_CODE = :APP_EMP_CODE and er.STATUS not in (3,4) and er.next_step > 1 and :APP_EMP_CODE <>(select line_manager from EMP_REQUESTS where REQUEST_DETAIL_ID = :P42_REQUEST_ID);

        if n_check > 0 then
            return true;
            else
            return false;
        end if;
end if;

end;

-- ----------------------------------------
-- Page: 42 - Confirm Scholarship Request PK > Page Item: P42_NOTE > Default > PL/SQL Function Body

DECLARE
    temp nvarchar2(1000);
BEGIN
    IF :P42_REQUEST_ID IS NOT NULL THEN
       select RECIPIENT_NOTE into temp from SCHOLARSHIP_REQUEST where :P42_REQUEST_ID = ID;
       RETURN temp;
    ELSE
      RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 42 - Confirm Scholarship Request PK > Page Item: P42_REASON_REQUEST > Default > PL/SQL Function Body

DECLARE
    temp nvarchar2(1000);
BEGIN
    IF :P42_REQUEST_ID IS NOT NULL THEN
       select RECIPIENT_REASON_REQUEST into temp from SCHOLARSHIP_REQUEST where :P42_REQUEST_ID = ID;
       RETURN temp;
    ELSE
      RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 42 - Confirm Scholarship Request PK > Page Item: P42_EXPIRATION_DATE_REPLACEMENT > Default > PL/SQL Function Body

DECLARE
    temp date;
BEGIN
    IF :P42_REQUEST_ID IS NOT NULL THEN
       select RECIPIENT_EXPIRATION_DATE_REPLACEMENT into temp from SCHOLARSHIP_REQUEST where :P42_REQUEST_ID = ID;
       RETURN temp;
    ELSE
      RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 42 - Confirm Scholarship Request PK > Page Item: P42_EXPIRATION_DATE > Default > PL/SQL Function Body

DECLARE
    temp DATE;
BEGIN
    IF :P42_REQUEST_ID IS NOT NULL THEN
       select EXPIRATION_DATE into temp from SCHOLARSHIP_REQUEST where :P42_REQUEST_ID = ID;
       RETURN temp;
    ELSE
      RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 42 - Confirm Scholarship Request PK > Page Item: P42_VOUCHER_CODE_REPLACEMENT > Default > PL/SQL Function Body


DECLARE
    temp nvarchar2(1000);
BEGIN
    IF :P42_REQUEST_ID IS NOT NULL THEN
       select RECIPIENT_VOUCHER_CODE_REPLACEMENT into temp from SCHOLARSHIP_REQUEST where :P42_REQUEST_ID = ID;
       RETURN temp;
    ELSE
      RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 42 - Confirm Scholarship Request PK > Page Item: P42_NUMBER_OF_COURSES > Default > PL/SQL Function Body

DECLARE
    temp NVARCHAR2(1000);
BEGIN
    IF :P42_REQUEST_ID IS NOT NULL THEN
       select EXPIRATION_DATE into temp from SCHOLARSHIP_REQUEST where :P42_REQUEST_ID = ID;
       RETURN temp;
    ELSE
      RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 42 - Confirm Scholarship Request PK > Page Item: P42_REPLACEMENT > Default > PL/SQL Function Body

-- SELECT sr.RECIPIENT_NAME || ' - ' || sr.RECIPIENT_DOB, sr.VOUCHER_CODE as ID
-- FROM SCHOLARSHIP_REQUEST sr
-- WHERE sr.REQUESTER_CODE = :P42_EMPLOYEE_CODE AND sr.RECIPIENT_RELATIONSHIP != 1;

-- DECLARE
--     temp nvarchar2(1000);
-- BEGIN
--     IF :P42_REQUEST_ID IS NOT NULL THEN
--        select RECIPIENT_REPLACEMENT into temp from SCHOLARSHIP_REQUEST where :P42_REQUEST_ID = ID;
--        RETURN temp;
--     ELSE
--       RETURN NULL;
--     END IF;
-- END;

-- ----------------------------------------
-- Page: 42 - Confirm Scholarship Request PK > Page Item: P42_REPLACEMENT > List of Values > SQL Query

SELECT sr.RECIPIENT_NAME || ' - ' || sr.RECIPIENT_DOB, sr.VOUCHER_CODE as ID
FROM SCHOLARSHIP_REQUEST sr
WHERE sr.REQUESTER_CODE = :P42_EMPLOYEE_CODE AND sr.RECIPIENT_RELATIONSHIP != 1;

-- ----------------------------------------
-- Page: 42 - Confirm Scholarship Request PK > Page Item: P42_APPROVED_DATE > Default > PL/SQL Function Body

DECLARE
    temp DATE;
BEGIN
    IF :P42_REQUEST_ID IS NOT NULL THEN
       select APPROVED_DATE into temp from SCHOLARSHIP_REQUEST where :P42_REQUEST_ID = ID;
       RETURN temp;
    ELSE
      RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 42 - Confirm Scholarship Request PK > Page Item: P42_EFFECTIVE_DATE > Default > PL/SQL Function Body

DECLARE
    temp DATE;
BEGIN
    IF :P42_REQUEST_ID IS NOT NULL THEN
       select EFFECTIVE_DATE into temp from SCHOLARSHIP_REQUEST where :P42_REQUEST_ID = ID;
       RETURN temp;
    ELSE
      RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 42 - Confirm Scholarship Request PK > Page Item: P42_TERMINATION_DATE > Default > PL/SQL Function Body

--select TERMINATE_DATE from employees where USER_NAME = :APP_USER_NAME;

DECLARE
    temp nvarchar2(1000);
BEGIN
    IF :P42_REQUEST_ID IS NOT NULL THEN
    --    select REQUESTER_LEVEL into temp from SCHOLARSHIP_REQUEST where :P42_REQUEST_ID = ID;
       select emp.TERMINATE_DATE into temp 
       from EMPLOYEES emp 
       join SCHOLARSHIP_REQUEST sr 
       on emp.EMPLOYEE_CODE = sr.REQUESTER_CODE 
       where sr.ID = :P42_REQUEST_ID;

       RETURN temp;
    ELSE
    --    SELECT TERMINATE_DATE INTO temp FROM EMPLOYEES WHERE :APP_USER_NAME = USER_NAME; 
       
    --    RETURN temp;
       RETURN NULL;
    END IF;
END;



-- ----------------------------------------
-- Page: 42 - Confirm Scholarship Request PK > Page Item: P42_START_DATE > Default > PL/SQL Function Body

--select START_DATE from EMPLOYEES where USER_NAME = :APP_USER_NAME;

DECLARE
    temp DATE;
BEGIN
    IF :P42_REQUEST_ID IS NOT NULL THEN
    --    select REQUESTER_LEVEL into temp from SCHOLARSHIP_REQUEST where :P42_REQUEST_ID = ID;
       select emp.START_DATE into temp 
       from EMPLOYEES emp 
       join SCHOLARSHIP_REQUEST sr 
       on emp.EMPLOYEE_CODE = sr.REQUESTER_CODE 
       where sr.ID = :P42_REQUEST_ID;

       RETURN temp;
    ELSE
    --    SELECT START_DATE INTO temp FROM EMPLOYEES WHERE :APP_USER_NAME = USER_NAME; 
       
    --    RETURN temp;
       RETURN NULL;
    END IF;
END;



-- ----------------------------------------
-- Page: 42 - Confirm Scholarship Request PK > Page Item: P42_WORKPLACE > Default > PL/SQL Function Body

DECLARE
    temp nvarchar2(1000);
BEGIN
    IF :P42_REQUEST_ID IS NOT NULL THEN
       select PARTNER_WORKPLACE into temp from SCHOLARSHIP_REQUEST where :P42_REQUEST_ID = ID;
       RETURN temp;
    ELSE
      RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 42 - Confirm Scholarship Request PK > Page Item: P42_LEVEL > Default > PL/SQL Function Body

--select LEVEL_DESCRIPTION from EMPLOYEES where USER_NAME = :APP_USER_NAME;

DECLARE
    temp nvarchar2(1000);
BEGIN
    IF :P42_REQUEST_ID IS NOT NULL THEN
       select REQUESTER_LEVEL into temp from SCHOLARSHIP_REQUEST where :P42_REQUEST_ID = ID;
       RETURN temp;
    ELSE
    --    SELECT LEVEL_DESCRIPTION INTO temp FROM EMPLOYEES WHERE :APP_USER_NAME = USER_NAME; 
    --    RETURN temp;
       RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 42 - Confirm Scholarship Request PK > Page Item: P42_DEPARTMENT > Default > PL/SQL Function Body

--select DEPARTMENT_NAME from EMPLOYEES where USER_NAME = :APP_USER_NAME;

DECLARE
    temp nvarchar2(1000);
BEGIN
    IF :P42_REQUEST_ID IS NOT NULL THEN
       select REQUESTER_DEPARTMENT into temp from SCHOLARSHIP_REQUEST where :P42_REQUEST_ID = ID;
       RETURN temp;
    ELSE
    --    SELECT DEPARTMENT_NAME INTO temp FROM EMPLOYEES WHERE :APP_USER_NAME = USER_NAME; 
    --    RETURN temp;
       RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 42 - Confirm Scholarship Request PK > Page Item: P42_DEPARTMENT > List of Values > SQL Query

select DISTINCT DEPARTMENT_NAME from EMPLOYEES;

-- ----------------------------------------
-- Page: 42 - Confirm Scholarship Request PK > Page Item: P42_CAMPUS > Default > PL/SQL Function Body

--select RECIPIENT_CAMPUS from SCHOLARSHIP_REQUEST where :P42_REQUEST_ID = id;

DECLARE
    temp nvarchar2(1000);
BEGIN
    IF :P42_REQUEST_ID IS NOT NULL THEN
       select RECIPIENT_CAMPUS into temp from SCHOLARSHIP_REQUEST where :P42_REQUEST_ID = ID;
       RETURN temp;
    ELSE
      RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 42 - Confirm Scholarship Request PK > Page Item: P42_CAMPUS > List of Values > SQL Query

SELECT DISTINCT UNIT_NAME FROM DEPARTMENT_CAMPUS WHERE UNIT_TYPE LIKE 'Business unit' AND UNIT_NUMBER <> '00000401';

-- ----------------------------------------
-- Page: 42 - Confirm Scholarship Request PK > Page Item: P42_DEPARTMENT_CODE > Default > PL/SQL Function Body

DECLARE
    temp nvarchar2(1000);
BEGIN
    IF :P42_REQUEST_ID IS NOT NULL THEN
       select REQUESTER_DEPARTMENT_CODE into temp from SCHOLARSHIP_REQUEST where :P42_REQUEST_ID = ID;
       RETURN temp;
    ELSE
    --    SELECT DEPARTMENT_ID INTO temp FROM EMPLOYEES WHERE :APP_USER_NAME = USER_NAME; 
    --    RETURN temp;
       RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 42 - Confirm Scholarship Request PK > Page Item: P42_VOUCHER_CODE > Default > PL/SQL Function Body

DECLARE
    temp nvarchar2(1000);
BEGIN
    IF :P42_REQUEST_ID IS NOT NULL THEN
       select VOUCHER_CODE into temp from SCHOLARSHIP_REQUEST where :P42_REQUEST_ID = ID;
       RETURN temp;
    ELSE
      RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 42 - Confirm Scholarship Request PK > Page Item: P42_RECIPIENT_PHONE > Default > PL/SQL Function Body

DECLARE
    temp nvarchar2(1000);
BEGIN
    IF :P42_REQUEST_ID IS NOT NULL THEN
       select RECIPIENT_PHONE into temp from SCHOLARSHIP_REQUEST where :P42_REQUEST_ID = ID;
       RETURN temp;
    ELSE
      RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 42 - Confirm Scholarship Request PK > Page Item: P42_TITLE > Default > PL/SQL Function Body

DECLARE
    temp nvarchar2(1000);
BEGIN
    IF :P42_REQUEST_ID IS NOT NULL THEN
       select PARTNER_TITLE into temp from SCHOLARSHIP_REQUEST where :P42_REQUEST_ID = ID;
       RETURN temp;
    ELSE
      RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 42 - Confirm Scholarship Request PK > Page Item: P42_EMPLOYEE_CODE > Default > PL/SQL Function Body

DECLARE
    temp nvarchar2(1000);
BEGIN
    IF :P42_REQUEST_ID IS NOT NULL THEN
       select REQUESTER_CODE into temp from SCHOLARSHIP_REQUEST where :P42_REQUEST_ID = ID;
       RETURN temp;
    ELSE
    --    select :APP_EMP_CODE into temp from DUAL;
    --    RETURN temp;
       RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 42 - Confirm Scholarship Request PK > Page Item: P42_REQUEST_NAME_AB > Default > PL/SQL Function Body

--select FULL_NAME from EMPLOYEES where USER_NAME = :APP_USER_NAME

DECLARE
    temp nvarchar2(1000);
BEGIN
    IF :P42_REQUEST_ID IS NOT NULL THEN
    --    select REQUESTER_LEVEL into temp from SCHOLARSHIP_REQUEST where :P42_REQUEST_ID = ID;
       select emp.FULL_NAME into temp 
       from EMPLOYEES emp 
       join SCHOLARSHIP_REQUEST sr 
       on emp.EMPLOYEE_CODE = sr.REQUESTER_CODE 
       where sr.ID = :P42_REQUEST_ID;

       RETURN temp;
    ELSE
    --    SELECT FULL_NAME INTO temp FROM EMPLOYEES WHERE :APP_USER_NAME = USER_NAME; 
       
    --    RETURN temp;
       RETURN NULL;
    END IF;
END;



-- ----------------------------------------
-- Page: 42 - Confirm Scholarship Request PK > Page Item: P42_RECIPIENT_DOB > Default > PL/SQL Function Body


DECLARE
    temp DATE;
BEGIN
    IF :P42_REQUEST_ID IS NOT NULL THEN
       select RECIPIENT_DOB into temp from SCHOLARSHIP_REQUEST where :P42_REQUEST_ID = ID;
       RETURN temp;
    ELSE
      RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 42 - Confirm Scholarship Request PK > Page Item: P42_PARTNER_PHONE > Default > PL/SQL Function Body

DECLARE
    temp nvarchar2(1000);
BEGIN
    IF :P42_REQUEST_ID IS NOT NULL THEN
       select PARTNER_PHONE into temp from SCHOLARSHIP_REQUEST where :P42_REQUEST_ID = ID;
       RETURN temp;
    ELSE
      RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 42 - Confirm Scholarship Request PK > Page Item: P42_RECIPIENT_NAME > Default > PL/SQL Function Body

--select RECIPIENT_NAME from SCHOLARSHIP_REQUEST where :P42_REQUEST_ID = id;

DECLARE
    temp nvarchar2(1000);
BEGIN
    IF :P42_REQUEST_ID IS NOT NULL THEN
       select RECIPIENT_NAME into temp from SCHOLARSHIP_REQUEST where :P42_REQUEST_ID = ID;
       RETURN temp;
    ELSE
      RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 42 - Confirm Scholarship Request PK > Page Item: P42_PARTNER_NAME > Default > PL/SQL Function Body

DECLARE
    temp nvarchar2(1000);
BEGIN
    IF :P42_REQUEST_ID IS NOT NULL THEN
       select PARTNER_NAME into temp from SCHOLARSHIP_REQUEST where :P42_REQUEST_ID = ID;
       RETURN temp;
    ELSE
      RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 42 - Confirm Scholarship Request PK > Page Item: P42_REQUEST_NAME > List of Values > SQL Query

select FULL_NAME || ' - ' || EMPLOYEE_CODE, EMPLOYEE_CODE as ID  from EMPLOYEES;

-- ----------------------------------------
-- Page: 42 - Confirm Scholarship Request PK > Page Item: P42_PARTNER_DEPARTMENT > Default > PL/SQL Function Body

DECLARE
    temp nvarchar2(1000);
BEGIN
    IF :P42_REQUEST_ID IS NOT NULL THEN
       select PARTNER_DEPARTMENT into temp from SCHOLARSHIP_REQUEST where :P42_REQUEST_ID = ID;
       RETURN temp;
    ELSE
      RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 42 - Confirm Scholarship Request PK > Page Item: P42_RELATIONSHIP > Default > PL/SQL Function Body

DECLARE
    temp nvarchar2(1000);
BEGIN
    IF :P42_REQUEST_ID IS NOT NULL THEN
       select RECIPIENT_RELATIONSHIP into temp from SCHOLARSHIP_REQUEST where :P42_REQUEST_ID = ID;
       RETURN temp;
    ELSE
      RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 42 - Confirm Scholarship Request PK > Page Item: P42_SCHOLARSHIP_RECIPIENT > Default > PL/SQL Function Body

declare
    temp nvarchar2(1000);
begin
    IF :P42_REQUEST_ID IS NOT NULL THEN
       select RECIPIENT_TYPE into temp from SCHOLARSHIP_REQUEST where :P42_REQUEST_ID = ID;
       return temp;
    ELSE
      RETURN null;
    END IF;
end;

-- ----------------------------------------
-- Page: 42 - Confirm Scholarship Request PK > Page Item: P42_FIELD > Default > PL/SQL Function Body

DECLARE
    temp nvarchar2(1000);
BEGIN
    IF :P42_REQUEST_ID IS NOT NULL THEN
       select PARTNER_FIELD into temp from SCHOLARSHIP_REQUEST where :P42_REQUEST_ID = ID;
       RETURN temp;
    ELSE
      RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 42 - Confirm Scholarship Request PK > Page Item: P42_DISCOUNT_RATE > Default > PL/SQL Function Body

DECLARE
    temp nvarchar2(1000);
BEGIN
    IF :P42_REQUEST_ID IS NOT NULL THEN
       select DISCOUNT_RATE into temp from SCHOLARSHIP_REQUEST where :P42_REQUEST_ID = ID;
       RETURN temp;
    ELSE
      RETURN NULL;
    END IF;
END;

-- ----------------------------------------
-- Page: 42 - Confirm Scholarship Request PK > Page Item: P42_PROGRAM > Default > PL/SQL Function Body

declare
    temp nvarchar2(1000);
begin
    IF :P42_REQUEST_ID IS NOT NULL THEN
       select PROGRAM into temp from SCHOLARSHIP_REQUEST where :P42_REQUEST_ID = ID;
       return temp;
    ELSE
        -- IF :P42_SCHOLARSHIP_RECIPIENT = 'A' OR :P42_SCHOLARSHIP_RECIPIENT = 'C' OR :P42_SCHOLARSHIP_RECIPIENT = 'D' THEN
        --     RETURN 'ELT';
        -- ELSE
            RETURN null;
        -- END IF;
    END IF;
end;

-- ----------------------------------------
-- Page: 42 - Confirm Scholarship Request PK > Region: ATTACHMENT_HISTORY > Source > SQL Query

select ah.ATTACHMENT_DATE,
       e.FULL_NAME,
       ah.URL
  from ATTACHMENT_HISTORY ah
  join EMPLOYEES e on e.EMPLOYEE_CODE = ah.EMPLOYEE_CODE;

