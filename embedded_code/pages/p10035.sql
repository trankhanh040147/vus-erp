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
-- Page: 10035 - Automations Log > Region: Automations Log > Source > SQL Query

select l.id,
       l.start_timestamp,
       a.name automation_name,
       l.status,
       l.successful_row_count,
       l.error_row_count,
       (select count(1) from apex_automation_msg_log m where m.automation_log_id = l.id) msg_count,
       l.is_job,
       l.end_timestamp
  from apex_appl_automations a, apex_automation_log l
 where a.automation_id = l.automation_id
 and l.application_id = :APP_ID;

