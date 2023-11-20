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
-- Page: 100 - Admin Accounts > Page Item: P100_ACCOUNT_EMAIL > List of Values > SQL Query

SELECT USER_NAME From EMPLOYEES Where WORKER_TITLE_ID != 'ADMIN' or WORKER_TITLE_ID is null;

-- ----------------------------------------
-- Page: 100 - Admin Accounts > Process: Assign admin > Source > PL/SQL Code

DECLARE
BEGIN
    INSERT INTO ADMIN_USERS (USER_NAME, EMPLOYEE_CODE, ROLE)
    SELECT :P100_ACCOUNT_EMAIL, EMPLOYEE_CODE, :P100_ROLE 
    FROM EMPLOYEES e 
    WHERE e.USER_NAME = :P100_ACCOUNT_EMAIL;
END;


