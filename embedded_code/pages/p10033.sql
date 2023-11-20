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
-- Page: 10033 - Page Performance > Region: Page Performance > Source > SQL Query

select step_id page,
    (   select page_name
        from apex_application_pages p
        where p.page_id = l.step_id
            and p.application_id = :app_id ) page_name,
    median(elap)                   median_elapsed,
    count(*) * median(elap)        weighted_performance,
    sum(decode(sqlerrm,null,0,1))  errors,
    count(distinct userid)         distinct_users,
    count(distinct session_id)     application_sessions,
    count(*)                       page_views,
    max(elap)                      max_elapsed,
    sum(nvl(num_rows,0))           total_rows,
    sum(decode(page_mode,'P',1,0)) partial_page_views,
    sum(decode(page_mode,'D',1,0)) full_page_views,
    min(elap)                      min_elapsed,
    avg(elap)                      avg_elapsed
from apex_activity_log l
where flow_id = :app_id
    and time_stamp >= sysdate - ( 1/24/60/60 * :P10033_TIMEFRAME )
    and userid is not null
group by step_id;

