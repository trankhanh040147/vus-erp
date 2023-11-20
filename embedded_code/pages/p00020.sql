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
-- Page: 20 - Reload Employee Info > Dynamic Action: New > Action: Sync Employee Info > Settings > PL/SQL Code

begin
    SP_GET_ONE_EMPLOYEE(:APP_EMP_CODE);
    SP_GET_ONE_ABSENCE_GROUP_EMPLOYEE(:APP_EMP_CODE);
    delete from EMP_EDUCATION where EMPLOYEE_CODE = :APP_EMP_CODE;
    delete from EMP_CERTIFICATE where EMPLOYEE_CODE = :APP_EMP_CODE;

    -- Remove all attachments 
    UPDATE EMP_ID_NUMBER 
    SET ATTACH_NAME = null,
        ATTACH_FILE = null
    where

    EMPLOYEE_CODE = :APP_EMP_CODE;
    SP_GET_ONE_EDUCATION(:APP_EMP_CODE);
    -- SP_GET_LIST_EDUCATION();
    -- SP_GET_LIST_CERTIFICATE();
    SP_GET_ONE_CERTIFICATE(:APP_EMP_CODE);
end;

