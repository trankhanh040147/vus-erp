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
-- Page: 10041 - Manage User Access > Region: Manage User Access > Source > SQL Query

select id,
   user_name_lc USERNAME,
   role_names ACCESS_ROLE
from APEX_APPL_ACL_USERS
where APPLICATION_ID = :APP_ID;

