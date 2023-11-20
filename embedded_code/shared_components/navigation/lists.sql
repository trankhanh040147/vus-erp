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
-- List: Activity Reports > Entry: Automations Log > Server-side Condition (Rows returned) > SQL Query

select 1
from apex_appl_automations a, apex_automation_log l
where a.automation_id = l.automation_id
and l.application_id = :APP_ID;

