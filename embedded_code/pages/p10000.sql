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
-- Page: 10000 - Administration > Region: User Counts Report > Source > SQL Query

select r.role_name, (select count(*) from apex_appl_acl_user_roles ur where r.role_id = ur.role_id) user_count, r.role_id
from apex_appl_acl_roles r
where r.application_id = :APP_ID
group by r.role_name, r.role_id
order by 2 desc, 1;

-- ----------------------------------------
-- Page: 10000 - Administration > Region: Report > Source > SQL Query

select l.display_value feedback_status, 
(select count(*) from apex_team_feedback f where f.application_id = :APP_ID and f.feedback_status = l.return_value) feedback_count 
from apex_application_lov_entries l
where l.application_id = :APP_ID
and l.list_of_values_name = 'FEEDBACK_STATUS'
order by 2 desc, 1;

