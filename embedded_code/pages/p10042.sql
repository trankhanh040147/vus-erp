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
-- Page: 10042 - Manage User Access > Validation: Cannot remove yourself from administrator > Validation > PL/SQL Function Body

if :P10042_USER_NAME = :APP_USER and
    apex_acl.is_role_removed_from_user (
        p_application_id => :APP_ID,
        p_user_name      => :APP_USER,
        p_role_static_id => 'ADMINISTRATOR',
        p_role_ids       => apex_string.split_numbers(
                                p_str => case when :REQUEST = 'DELETE' then
                                             null
                                         else
                                             :P10042_ROLE_IDS
                                         end,
                                p_sep => ':') ) then
    return false;
else
    return true;
end if;

