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
-- Page: 9 - Approve Leave > Region: Content filter by ID > Source > SQL Query

select er.ID,
       er.REQUESTOR_ID,
       er.REQUEST_ID,
       er.EMPLOYEE_CODE_REQ,
       er.EMPLOYEE_NAME,
       er.ALL_DAY,
    --    case 
    --    when er.ALL_DAY = 'N' then to_char(to_char(er.FROM_DATE, 'DD/MM/YYYY') ||' | '||er.START_TIME)
    --    else to_char(er.FROM_DATE, 'DD/MM/YYYY') end as FROM_DATE,
    --     case 
    --    when er.ALL_DAY = 'N' then to_char(to_char(er.END_DATE, 'DD/MM/YYYY') ||' | '||er.END_TIME)
    --    else to_char(er.END_DATE, 'DD/MM/YYYY') end as END_DATE,
       er.FROM_DATE,
       er.END_DATE,
       er.NOTE,
       CASE
           WHEN er.LEAVE_TYPE = 'APL' THEN 'Leave'
           ELSE to_char(er.LEAVE_TYPE)
       END AS TYPE,
       CASE
           WHEN er.TOTAL_DAYS = 0.5 THEN 0.5
           ELSE er.TOTAL_DAYS
       END as TOTAL_DAYS,
       s.status as STATUS,
       er.man_res_status as RESPONSE,
       age.HRM_ABSENCE_CODE_ID,
       age.HRM_ABSENCE_CODE_GROUP_ID,
       case er.emp_req_status
       when 2 then
       'Approve' 
       when 3 then
       'Cancel'
       else
       null
       end as Action,
       case er.is_d365
           when 1 then '<span class="fa fa-check"></span>'
           else
           null
       end as hr_update
  from EMPLOYEE_REQUESTS er
    join STATUS s on er.emp_req_status = s.id
    join ABSENCE_GROUP_EMPLOYEE age on er.EMPLOYEE_CODE_REQ = age.EMPLOYEE_CODE and age.EXPIRATION_DATE >= to_char(sysdate,'MM/DD/YYYY')
    -- join EMPLOYEES emp on er.EMPLOYEE_CODE_REQ = emp.EMPLOYEE_CODE
  where er.IS_DEL = 0 and er.ID = :REQUEST_ID;

-- ----------------------------------------
-- Page: 9 - Approve Leave > Dynamic Action: onload > Action: Update Message SQL > Settings > PL/SQL Code

declare
    r_inserted_status number; 
begin
    SELECT INSERTED_STATUS INTO r_inserted_status FROM EMPLOYEE_REQUESTS where ID = :APPROVED_REQUEST_ID;
    IF r_inserted_status = 1 THEN
        -- Trigger success message
        -- apex_application.g_print_success_message := 'Request approved successfully.';
        :P9_MESSAGE := 'SUCCESS';
        -- apex_error.add_error (
        --     p_message          => 'Approved the request. Please check the benefit accruals for the employee.',
        --         p_display_location => apex_error.c_inline_in_notification);

    ELSE
    -- Trigger error message
        :P9_MESSAGE := 'FAILED';

        -- apex_error.add_error (
        --     p_message          => 'Cannot approve the request. Please check the benefit accruals for the employee.',
        --         p_display_location => apex_error.c_inline_in_notification);

    END IF;
end;


-- ----------------------------------------
-- Page: 9 - Approve Leave > Page Item: P9_TO_DATE > Default > SQL Query

SELECT TO_CHAR(SYSDATE, 'DD/MM/YYYY') AS formatted_date FROM DUAL;

-- ----------------------------------------
-- Page: 9 - Approve Leave > Page Item: P9_FROM_DATE > Default > SQL Query

SELECT TRUNC(SYSDATE, 'YEAR') AS first_day_of_current_year FROM DUAL;

-- ----------------------------------------
-- Page: 9 - Approve Leave > Page Item: P9_SEARCH > Default > SQL Query

SELECT FULL_NAME From EMPLOYEES Where EMPLOYEE_CODE = (SELECT EMPLOYEE_CODE_REQ FROM EMPLOYEE_REQUESTS WHERE ID = :REQUEST_ID);

-- ----------------------------------------
-- Page: 9 - Approve Leave > Region: Content > Source > SQL Query

select er.ID,
       er.REQUESTOR_ID,
       er.REQUEST_ID,
       er.EMPLOYEE_CODE_REQ,
       er.EMPLOYEE_NAME,
       er.ALL_DAY,
    --    case 
    -- --    when er.ALL_DAY = 'N' then to_char(er.FROM_DATE||' | '||er.START_TIME)
    --    when (er.ALL_DAY = 'N' and er.TOTAL_DAYS = 0.5) then to_char(to_char(er.FROM_DATE, 'DD/MM/YYYY') || ' | ' || er.START_TIME)
    --    else to_char(er.FROM_DATE, 'DD/MM/YYYY') end as FROM_DATE,
       er.FROM_DATE,
    --     case 
    -- --    when er.ALL_DAY = 'N' then to_char(er.END_DATE || ' | ' || er.END_TIME)
    --    when (er.ALL_DAY = 'N' and er.TOTAL_DAYS = 0.5) then to_char(to_char(er.END_DATE, 'DD/MM/YYYY') || ' | ' || er.END_TIME)
    --    else to_char(er.END_DATE, 'DD/MM/YYYY') end as END_DATE,
       er.END_DATE,
       er.NOTE,
       CASE
           WHEN er.LEAVE_TYPE = 'APL' THEN 'Leave'
           ELSE to_char(er.LEAVE_TYPE)
       END AS TYPE,
       CASE
           WHEN er.TOTAL_DAYS = 0.5 THEN 0.5
           ELSE er.TOTAL_DAYS
       END as TOTAL_DAYS,
       s.status as STATUS,
       er.man_res_status as RESPONSE,
    --    age.HRM_ABSENCE_CODE_ID,
    --    age.HRM_ABSENCE_CODE_GROUP_ID,
       case er.emp_req_status
       when 2 then 'Approve'
       when 3 then
        case ER.IS_D365 when 0 then'Cancel' end
       else
       null
       end as Action,
       case er.is_d365
           when 1 then '<span class="fa fa-check"></span>'
           else
           null
       end as hr_update
  from EMPLOYEE_REQUESTS er
    join STATUS s on er.emp_req_status = s.id
    -- join ABSENCE_GROUP_EMPLOYEE age on er.EMPLOYEE_CODE_REQ = age.EMPLOYEE_CODE 
    --     and er.LEAVE_TYPE = age.HRM_ABSENCE_CODE_GROUP_ID and er.BENEFIT_CODE = age.BENEFIT_ACCRUAL_PLAN
  where er.IS_DEL = 0 and er.EMPLOYEE_CODE_REQ <> :APP_EMP_CODE
    and :APP_EMP_CODE = (SELECT MANAGER_ID FROM EMPLOYEES WHERE EMPLOYEE_CODE = er.EMPLOYEE_CODE_REQ)
    and er.id_root is null
    and to_date(er.FROM_DATE,'MM/DD/YYYY') between to_date(:P9_FROM_DATE,'DD/MM/YYYY') and to_date(:P9_TO_DATE,'DD/MM/YYYY')
    and (:P9_STATUS = 99 or :P9_STATUS = er.emp_req_status)  
    and (lower(er.EMPLOYEE_NAME) LIKE '%' || lower(:P9_SEARCH) || '%' or
        lower(er.NOTE) LIKE '%' || lower(:P9_SEARCH) || '%' or
        lower(er.EMPLOYEE_CODE_REQ) LIKE '%' || lower(:P9_SEARCH) || '%' or
        lower(TYPE) LIKE '%' || lower(:P9_SEARCH) || '%')
    and er.REQUEST_ID like '%' || :REQUEST_ID || '%';

