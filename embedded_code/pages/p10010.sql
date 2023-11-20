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
-- Page: 10010 - Configuration Options > Region: Configuration Options > Source > SQL Query

select 
    build_option_id     ID, 
    build_option_name   application_option,
    apex_item.hidden(1, build_option_id) ||
    apex_item.hidden(2, build_option_status) ||
    apex_item.switch ( 
         p_idx        => 3,
         p_value      => build_option_status,
         p_on_value   => 'Include',
         p_on_label   => m.enabled,
         p_off_value  => 'Exclude',
         p_off_label  => m.disabled,
         p_item_id    => 'BO_OPT_' || rownum,
         p_item_label => ( case when build_option_status = 'Include' then
                               apex_lang.message( 'APEX.FEATURE.CONFIG.IS_ENABLED', apex_escape.html(build_option_name) )
                           when build_option_status = 'Exclude' then
                               apex_lang.message( 'APEX.FEATURE.CONFIG.IS_DISABLED', apex_escape.html(build_option_name) )
                           end ),
         p_attributes => 'style="white-space:pre;"') "STATUS",
    component_comment   description,
    last_updated_on        updated,
    lower(last_updated_by) updated_by,
    build_option_status current_status
  from apex_application_build_options,
  (select apex_lang.message('APEX.FEATURE.CONFIG.ENABLED') enabled, apex_lang.message('APEX.FEATURE.CONFIG.DISABLED') disabled from dual) m
 where application_id = :APP_ID 
 and feature_identifier not in ( 'APPLICATION_ACCESS_CONTROL', 'APPLICATION_CONFIGURATION');

-- ----------------------------------------
-- Page: 10010 - Configuration Options > Process: Update > Source > PL/SQL Code

for i in 1..apex_application.g_f01.count loop
    for c1 in ( select application_id, build_option_name, build_option_status
                from apex_application_build_options
                where apex_application.g_f01(i) = build_option_id
                   and application_Id = :APP_ID) loop
        if c1.build_option_status != apex_application.g_f03(i) then
            apex_util.set_build_option_status(  p_application_id => :APP_ID,
                                                p_id => apex_application.g_f01(i),
                                                p_build_status => upper(apex_application.g_f03(i)) );
        end if;
    end loop;
end loop;

