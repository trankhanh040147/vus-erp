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
-- Page: 10053 - Manage Feedback > Region: Manage Feedback > Source > SQL Query

select feedback_id id,
    page_id||'. '||page_name page_name,
    created_on created,
    lower(created_by) created_by,
    feedback,
    feedback_rating rating,
    case feedback_rating
      when 1 then 'fa-frown-o feedback-negative' 
      when 2 then 'fa-emoji-neutral feedback-neutral'  
      when 3 then 'fa-smile-o feedback-positive'
    end rating_icon,
    feedback_status status,
    public_response response,
    http_user_agent user_agent,
    updated_on updated,
    lower(updated_by) updated_by,
    page_id
from apex_team_feedback f
where application_id = :APP_ID;

