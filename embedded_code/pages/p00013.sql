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
-- Page: 13 - Request Detail > Page Item: P13_EMPLOYEE_NAME > Default > SQL Query

select FULL_NAME from employees where EMPLOYEE_CODE = (select EMPLOYEE_CODE_REQ from EMPLOYEE_REQUESTS where ID = :P13_REQUEST_ID);

-- ----------------------------------------
-- Page: 13 - Request Detail > Branch: Redirect to page 9 > Server-side Condition (Function Body) > PL/SQL Function Body

declare
    r_inserted_status number; 
begin
    -- SELECT INSERTED_STATUS INTO r_inserted_status FROM EMPLOYEE_REQUESTS where ID = :P13_REQUEST_ID;
    -- IF r_inserted_status = 1 THEN
    --     RETURN TRUE;
    -- ELSE
    --     RETURN FALSE;
    -- END IF;

    return true;
end;

-- ----------------------------------------
-- Page: 13 - Request Detail > Process: Cancel_process > Source > PL/SQL Code

begin
for rec in (select TOTAL_DAYS,EMPLOYEE_CODE_REQ from EMPLOYEE_REQUESTS where id = :P13_REQUEST_ID)loop
    for rec_sub in (select * from ABSENCE_GROUP_EMPLOYEE where EMPLOYEE_CODE = rec.EMPLOYEE_CODE_REQ and EXPIRATION_DATE >= to_char(sysdate,'MM/DD/YYYY'))loop
        if rec_sub.HRM_ABSENCE_CODE_ID like 'ALP%' and rec_sub.CARRY_FORWARD_USED < rec_sub.CARRY_FORWARD then
            update ABSENCE_GROUP_EMPLOYEE set CARRY_FORWARD_USED = (rec_sub.CARRY_FORWARD_USED - rec.TOTAL_DAYS),CARRY_FORWARD_AVALABLE = (rec_sub.CARRY_FORWARD_AVALABLE + rec.TOTAL_DAYS) 
            where EMPLOYEE_CODE = rec.EMPLOYEE_CODE_REQ and EXPIRATION_DATE >= to_char(sysdate,'MM/DD/YYYY');
        else
            if rec_sub.HRM_ABSENCE_CODE_ID like 'ALP%' and rec_sub.CARRY_FORWARD_USED >= rec_sub.CARRY_FORWARD then
            update ABSENCE_GROUP_EMPLOYEE set PLAN_YEAR_USED = (rec_sub.PLAN_YEAR_USED - rec.TOTAL_DAYS),AVAILABLE = (rec_sub.AVAILABLE + rec.TOTAL_DAYS) 
            where EMPLOYEE_CODE = rec.EMPLOYEE_CODE_REQ and EXPIRATION_DATE >= to_char(sysdate,'MM/DD/YYYY');
            end if;
        end if;
    end loop;  
    SP_CANCEL_REQUEST_FIN(rec.EMPLOYEE_CODE_REQ,:P13_REQUEST_ID);
end loop;
end;


-- ----------------------------------------
-- Page: 13 - Request Detail > Process: Delay > Source > PL/SQL Code

DECLARE
    v_start_time NUMBER;
    v_end_time NUMBER;
    r_inserted_status number; 
BEGIN
    v_start_time := DBMS_UTILITY.GET_TIME;  -- Current time in 1/100ths of a second
    LOOP
        v_end_time := DBMS_UTILITY.GET_TIME;
        EXIT WHEN (v_end_time - v_start_time) > (3 * 100);  -- 5 seconds
    END LOOP;

        -- apex_util.set_session_state('REQUEST_APPROVED_ID', '999');
    :APPROVED_REQUEST_ID := :P13_REQUEST_ID;

    -- SELECT INSERTED_STATUS INTO r_inserted_status FROM EMPLOYEE_REQUESTS where ID = :P13_REQUEST_ID;
    -- IF r_inserted_status = 1 THEN
    --     -- Trigger success message
    --     apex_application.g_print_success_message := 'Approve request successfully.';
    -- ELSE
    --     -- Trigger error message
    --     apex_error.add_error (
    --         p_message          => 'Cannot approve the request. Please check the benefit accruals for the employee.',
    --         p_display_location => apex_error.c_inline_in_notification);
    -- END IF;

END;


-- ----------------------------------------
-- Page: 13 - Request Detail > Process: Cancel > Source > PL/SQL Code

begin
update EMPLOYEE_REQUESTS set emp_req_status = 5,man_res_status = 5 where id = :P13_REQUEST_ID;
for rec in (select TOTAL_DAYS,EMPLOYEE_CODE_REQ from EMPLOYEE_REQUESTS where id = :P13_REQUEST_ID)loop
    for rec_sub in (select * from ABSENCE_GROUP_EMPLOYEE where EMPLOYEE_CODE = rec.EMPLOYEE_CODE_REQ and EXPIRATION_DATE >= to_char(sysdate,'MM/DD/YYYY'))loop
        if rec_sub.HRM_ABSENCE_CODE_ID like 'ALP%' and rec_sub.CARRY_FORWARD_USED < rec_sub.CARRY_FORWARD then
            update ABSENCE_GROUP_EMPLOYEE set CARRY_FORWARD_USED = (rec_sub.CARRY_FORWARD_USED - rec.TOTAL_DAYS),CARRY_FORWARD_AVALABLE = (rec_sub.CARRY_FORWARD_AVALABLE + rec.TOTAL_DAYS) 
            where EMPLOYEE_CODE = rec.EMPLOYEE_CODE_REQ and EXPIRATION_DATE >= to_char(sysdate,'MM/DD/YYYY');
        else
            if rec_sub.HRM_ABSENCE_CODE_ID like 'ALP%' and rec_sub.CARRY_FORWARD_USED >= rec_sub.CARRY_FORWARD then
            update ABSENCE_GROUP_EMPLOYEE set PLAN_YEAR_USED = (rec_sub.PLAN_YEAR_USED - rec.TOTAL_DAYS),AVAILABLE = (rec_sub.AVAILABLE + rec.TOTAL_DAYS) 
            where EMPLOYEE_CODE = rec.EMPLOYEE_CODE_REQ and EXPIRATION_DATE >= to_char(sysdate,'MM/DD/YYYY');
            end if;
        end if;
    end loop;  
    SP_CANCEL_REQUEST_FIN(rec.EMPLOYEE_CODE_REQ,:P13_REQUEST_ID);
end loop;
end;


-- ----------------------------------------
-- Page: 13 - Request Detail > Dynamic Action: New > Action: Validate 0.5 days > Settings > SQL Statement

IF (select TOTAL_DAYS from EMPLOYEE_REQUESTS  where ID  = :P13_REQUEST_ID) = .5 
THEN '0.5'
ELSE (select TOTAL_DAYS from EMPLOYEE_REQUESTS  where ID  = :P13_REQUEST_ID)
END IF;

-- ----------------------------------------
-- Page: 13 - Request Detail > Dynamic Action: New > Action: Assign P13_REQUEST_ID_PORTAL > Settings > SQL Statement

SELECT ID FROM EMPLOYEE_REQUESTS WHERE REQUEST_ID = :P13_REQUEST_ID;

-- ----------------------------------------
-- Page: 13 - Request Detail > Page Item: P13_REQUEST_ID_PORTAL > Default > SQL Query

SELECT ID FROM EMPLOYEE_REQUESTS WHERE REQUEST_ID = :P13_REQUEST_ID;

-- ----------------------------------------
-- Page: 13 - Request Detail > Page Item: P13_TOTAL_DAYS > Default > SQL Query

SELECT CASE
    WHEN TOTAL_DAYS = 0.5 THEN '0.5'
    ELSE TO_CHAR(TOTAL_DAYS)
END AS DISPLAY_TOTAL_DAYS
FROM EMPLOYEE_REQUESTS
WHERE ID = :P13_REQUEST_ID;

-- ----------------------------------------
-- Page: 13 - Request Detail > Page Item: P13_ANNUAL_LEAVE_BALANCE > Default > SQL Query

select CASE WHEN LEAVE_BALANCE = 0.5 THEN '0.5' ELSE TO_CHAR(LEAVE_BALANCE) END 
from EMPLOYEE_REQUESTS  where ID = :P13_REQUEST_ID;

-- ----------------------------------------
-- Page: 13 - Request Detail > Page Item: P13_END_TIME > Default > SQL Query

select END_TIME from EMPLOYEE_REQUESTS  where ID = :P13_REQUEST_ID;

-- ----------------------------------------
-- Page: 13 - Request Detail > Page Item: P13_END_DATE > Default > SQL Query

select to_char(END_DATE, 'DD/MM/YYYY') from EMPLOYEE_REQUESTS  where ID = :P13_REQUEST_ID;

-- ----------------------------------------
-- Page: 13 - Request Detail > Page Item: P13_START_TIME > Default > SQL Query

select START_TIME from EMPLOYEE_REQUESTS  where ID = :P13_REQUEST_ID;

-- ----------------------------------------
-- Page: 13 - Request Detail > Page Item: P13_FROM_DATE > Default > SQL Query

select to_char(FROM_DATE, 'DD/MM/YYYY') from EMPLOYEE_REQUESTS  where ID = :P13_REQUEST_ID;

-- ----------------------------------------
-- Page: 13 - Request Detail > Page Item: P13_STANDARD_SCHEDULE > Default > SQL Query

select SCHEDULE from employees where EMPLOYEE_CODE = :P13_EMPLOYEE_CODE;

-- ----------------------------------------
-- Page: 13 - Request Detail > Page Item: P13_ALL_DAY > Default > SQL Query

select ALL_DAY from EMPLOYEE_REQUESTS  where ID = :P13_REQUEST_ID;

-- ----------------------------------------
-- Page: 13 - Request Detail > Page Item: P13_CURRENT_TIME_PROFILE > Default > SQL Query

select PROFILE_ID from employees where EMPLOYEE_CODE = :P13_EMPLOYEE_CODE;

-- ----------------------------------------
-- Page: 13 - Request Detail > Page Item: P13_LEAVE_DETAIL > Default > SQL Query

select 
case
    when LEAVE_TYPE != 'APL' then (SELECT ACL_DESCRIPTION from ABSENCE_CODE_LIST where  ACL_ABSENCECODE_ID = BENEFIT_CODE)
    else BENEFIT_CODE
end
from EMPLOYEE_REQUESTS where ID = :P13_REQUEST_ID;

-- ----------------------------------------
-- Page: 13 - Request Detail > Page Item: P13_NOTE > Default > SQL Query

select NOTE from EMPLOYEE_REQUESTS  where ID = :P13_REQUEST_ID;

-- ----------------------------------------
-- Page: 13 - Request Detail > Page Item: P13_LEAVE_TYPE > Default > SQL Query

select ACGL_DESCRIPTION from ABSENCE_CODE_GROUP_LIST where ACGL_ABSENCE_GROUP_ID = (select LEAVE_TYPE from EMPLOYEE_REQUESTS  where ID = :P13_REQUEST_ID)

-- select LEAVE_TYPE from EMPLOYEE_REQUESTS  where ID = :P13_REQUEST_ID;

-- ----------------------------------------
-- Page: 13 - Request Detail > Page Item: P13_APPROVED_MANAGER > Default > SQL Query

select FULL_NAME FROM EMPLOYEES e WHERE e.USER_NAME = :APP_USER_NAME;

-- ----------------------------------------
-- Page: 13 - Request Detail > Page Item: P13_EMPLOYEE_CODE > Default > SQL Query

select EMPLOYEE_CODE_REQ from EMPLOYEE_REQUESTS where ID = :P13_REQUEST_ID;

