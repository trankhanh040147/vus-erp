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
-- Page: 19 - Setup Workflow > Region: Content > Source > SQL Query

select ID,
       WF_PROCESS_ID,
       WF_NAME,
       WF_DESCRIPTION,
       WF_FEATURE_APPLY,
       WF_CONDITIONAL_ID,
       WF_EFFECTIVE_DATE,
       WF_EXPIRATION_DATE,
       WF_MODIFIER_NAME,
       WF_MODIFIER_CODE,
       WF_MODIFIED_DATE
from "WORKFLOW" WF;

