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
-- Page: 10099 - DTest > Page Item: P10099_NEW_1 > List of Values > SQL Query

select ATTATCH_FILE from employee_requests where id = 379;

-- ----------------------------------------
-- Page: 10099 - DTest > Process: New_1 > Source > PL/SQL Code

begin

   insert into resume_test(IMG) values(utl_raw.cast_to_raw(:P10099_UPLOAD));
end;

