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
-- Page: 10032 - Application Error Log > Region: Application Error Log > Source > SQL Query

select step_id,
       userid,
       time_stamp err_time,
       sqlerrm,
       sqlerrm_component_type,
       sqlerrm_component_name
  from apex_activity_log
 where flow_id = :app_id
   and sqlerrm is not null;

