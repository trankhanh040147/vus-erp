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
-- Page: 10040 - Configure Access Control > Page Item: P10040_ALLOW_OTHER_USERS > Source > PL/SQL Function Body

if apex_app_setting.get_value( p_name => 'ACCESS_CONTROL_SCOPE' ) = 'ACL_ONLY' then
    return 'N';
else
    return 'Y';
end if;

-- ----------------------------------------
-- Page: 10040 - Configure Access Control > Process: Set Access Control > Source > PL/SQL Code

begin
    if :P10040_ALLOW_OTHER_USERS = 'Y' then
        apex_app_setting.set_value (
            p_name  => 'ACCESS_CONTROL_SCOPE',
            p_value => 'ALL_USERS');
    else
        apex_app_setting.set_value (
            p_name  => 'ACCESS_CONTROL_SCOPE',
            p_value => 'ACL_ONLY');
    end if;
end;

