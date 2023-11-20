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
-- Page: 10036 - Log Messages > Region: Messages > Source > SQL Query

select message_timestamp,
       message,
       message_type,
       pk_value
  from apex_automation_msg_log
 where automation_log_id = :P10036_LOG_ID;

-- ----------------------------------------
-- Page: 10036 - Log Messages > Process: Get Log Detail > Source > PL/SQL Code

select automation_name,
       start_timestamp,
       status
  into :P10036_AUTOMATION_NAME,
       :P10036_START_TIMESTAMP,
       :P10036_STATUS
  from apex_automation_log
 where id = :P10036_LOG_ID;

