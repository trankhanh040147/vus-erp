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
-- Page: 10020 - Application Appearance > Page Item: P10020_DESKTOP_THEME_STYLE_ID > Source > SQL Query

select s.theme_style_id
from apex_application_theme_styles s,
    apex_application_themes t
where s.application_id = t.application_id
    and s.theme_number = t.theme_number
    and s.application_id = :app_id
    and s.is_current = 'Yes';

-- ----------------------------------------
-- Page: 10020 - Application Appearance > Process: Save End User Style Preference > Source > PL/SQL Code

declare
    l_enabled boolean := case when :P10020_END_USER_STYLE = 'Yes' then true else false end;
begin
    for l_theme in ( select theme_number
                       from apex_applications
                      where application_id  = :APP_ID )
    loop
        if l_enabled then
            apex_theme.enable_user_style (
                p_application_id => :APP_ID,
                p_theme_number   => l_theme.theme_number );
        else
            apex_theme.disable_user_style (
                p_application_id => :APP_ID,
                p_theme_number   => l_theme.theme_number );
            apex_theme.clear_all_users_style(:APP_ID);
        end if;
    end loop;
end;

-- ----------------------------------------
-- Page: 10020 - Application Appearance > Process: Save Theme Style > Source > PL/SQL Code

if :P10020_DESKTOP_THEME_STYLE_ID is not null then
    for l_theme in (select theme_number
                      from apex_application_themes
                     where application_id = :app_id
                       and is_current     = 'Yes')
    loop
        apex_util.set_current_theme_style (
            p_theme_number   => l_theme.theme_number,
            p_theme_style_id => :P10020_DESKTOP_THEME_STYLE_ID
            );
    end loop;
end if;

-- ----------------------------------------
-- Page: 10020 - Application Appearance > Page Item: P10020_END_USER_STYLE > Source > SQL Query

select a.theme_style_by_user_pref
  from apex_applications a
 where a.application_id  = :app_id;

-- ----------------------------------------
-- Page: 10020 - Application Appearance > Page Item: P10020_DESKTOP_THEME_STYLE_ID > Server-side Condition (Rows returned) > SQL Query

select null
  from apex_application_theme_styles s,
       apex_application_themes t
 where s.application_id = t.application_id
   and s.theme_number   = t.theme_number
   and s.application_id = :app_id;

