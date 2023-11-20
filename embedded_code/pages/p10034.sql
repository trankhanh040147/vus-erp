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
-- Page: 10034 - Page Views > Region: Page Views > Source > SQL Query

select 
    step_id||'. '||(select page_name
                    from apex_application_pages p
                    where p.page_id = l.step_id
                        and p.application_id = :APP_ID) page_name,
    userid_lc     user_id,
    time_stamp    timestamp,
    elap          elapsed,
    step_id       page,
    decode(page_mode,'P','Partial','D','Full',page_mode) page_mode,
    component_name,
    num_rows,
    ir_search,
    sqlerrm  error
from apex_activity_log l
where flow_id = :app_id
    and time_stamp >= sysdate - ( 1/24/60/60 * :P10034_TIMEFRAME )
    and userid is not null
    and step_id is not null
order by time_stamp desc;

