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
-- Page: 10054 - Feedback > Process: Load Data > Source > PL/SQL Code

for l_feedback in (
   select page_id,
          page_name,
          case feedback_rating
                when 1 then '<span class="fa fa-frown-o feedback-negative" aria-hidden="true" title="Negative"></span>' 
                when 2 then '<span class="fa fa-emoji-neutral feedback-neutral" aria-hidden="true" title="Neutral"></span>'  
                when 3 then '<span class="fa fa-smile-o feedback-positive" aria-hidden="true" title="Positive"></span>' 
                end rating_icon,
          lower(created_by) || ' - ' || apex_util.get_since(created_on) filed,
          feedback,
          public_response,
          feedback_status,
          http_user_agent
     from apex_team_feedback
    where feedback_id = :P10054_ID )
loop
   :P10054_PAGE_ID         := l_feedback.page_id||'. '||l_feedback.page_name;
   :P10054_FILED           := l_feedback.filed;
   :P10054_RATING_ICON     := l_feedback.rating_icon;
   :P10054_FEEDBACK        := l_feedback.feedback;
   :P10054_RESPONSE        := l_feedback.public_response;
   :P10054_FEEDBACK_STATUS := l_feedback.feedback_status;
   :P10054_USER_AGENT      := l_feedback.http_user_agent;
end loop;

