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
-- Page: 10050 - Feedback > Page Item: P10050_USER_AGENT > Source > SQL Query

select sys.owa_util.get_cgi_env('user-agent') x
from dual;

-- ----------------------------------------
-- Page: 10050 - Feedback > Validation: At least One Feedback Required > Validation > PL/SQL Function Body

if :P10050_FEEDBACK is null and :P10050_RATING is null then
    return false;
else
    return true;
end if;

