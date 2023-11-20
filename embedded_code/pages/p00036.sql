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
-- Page: 36 - Overtime Request for Manager > Region: Report > Source > SQL Query

select 
    eor.ID,
    eor.EMPLOYEE_CODE,
    eor.CREATED_DATE,
    eor.profile_time,
    eor.start_time,
    eor.end_time,
    eor.TOTAL_HOUR_WK,
    eor.TOTAL_HOUR_REST_WK,
    eor.TOTAL_HOUR_PUBLIC,
    eor.REASON,
    eor.NOTE,
    eor.WORKING_PLACE,
    eor.status
from EMP_OVERTIME_REQUESTS eor
where eor.EMPLOYEE_CODE = :P36_EMPLOYEE_CODE;

-- ----------------------------------------
-- Page: 36 - Overtime Request for Manager > Dynamic Action: Set value > Action: Execute Server-side Code > Settings > PL/SQL Code

begin
for rec in (select * from employees where employee_code = :P36_EMPLOYEE_CODE)loop
    :P36_EMPLOYEE_NAME := rec.FULL_NAME;
    :P36_TITLE := rec.TITLE;
    :P36_DEPARTMENT := rec.DEPARTMENT_ID;
    :P36_LEVEL := 'SE';
end loop;
    
end;

