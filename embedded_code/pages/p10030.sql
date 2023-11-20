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
-- Page: 10030 - Activity Dashboard > Region: Recent Errors > Source > SQL Query

select sqlerrm    label,
       time_stamp value
  from apex_activity_log
 where flow_id    = :app_id
   and time_stamp >= sysdate - ( 1/24/60/60 * :P10030_TIMEFRAME )
   and sqlerrm    is not null
 order by 2 desc, 1;

-- ----------------------------------------
-- Page: 10030 - Activity Dashboard > Region: Top Users > Attributes:  > Series: Series 1 > Source > SQL Query

select nvl( userid_lc, apex_lang.message('APEX.FEATURE.TOP_USERS.USERNAME.NOT_IDENTIFIED') ) as label,
       count(*) as value
from apex_activity_log
where flow_id = :app_id
and time_stamp >= sysdate - ( 1/24/60/60 * :P10030_TIMEFRAME )
group by nvl( userid_lc, apex_lang.message('APEX.FEATURE.TOP_USERS.USERNAME.NOT_IDENTIFIED') )
order by 2 desc;

-- ----------------------------------------
-- Page: 10030 - Activity Dashboard > Region: Most Active Pages > Attributes:  > Series: Series 1 > Source > SQL Query

select x.step_id||'. '||(select page_name from apex_application_pages p where p.application_id = :app_id and page_id = x.step_id) label, 
        value
from ( select step_id,
              count(*) as value
         from apex_activity_log
        where flow_id = :app_id
          and time_stamp >= sysdate - ( 1/24/60/60 * :P10030_TIMEFRAME )
          and step_id is not null
        group by step_id
        order by 2 desc
     ) x;

-- ----------------------------------------
-- Page: 10030 - Activity Dashboard > Region: Hourly Page Events > Attributes:  > Series: Series 1 > Source > SQL Query

with nw as (
    -- APEX_ACTIVITY_LOG uses dates; convert system time to local time zone.
    select from_tz( cast( sysdate as timestamp ), to_char( systimestamp, 'TZR' ) ) at local as tm from dual
),
window as (
    select
         trunc(nw.tm - ((level-1)/24),'HH') start_tm,
         trunc(nw.tm - ((level-2)/24),'HH') end_tm,
         trunc(sysdate-((level-1)/24),'HH') log_start_tm,
         trunc(sysdate-((level-2)/24),'HH') log_end_tm
    from nw
    connect by level <= round( 24 * ( 1/24/60/60 * nvl(:P10030_TIMEFRAME,1) ) )
)
select w.start_tm log_time,
       ( select count(*)
           from apex_activity_log l
          where l.flow_id = :app_id
            and l.time_stamp between w.log_start_tm and w.log_end_tm ) as value
from window w
order by 1;

-- ----------------------------------------
-- Page: 10030 - Activity Dashboard > Region: Latest Activity > Source > SQL Query

select userid_lc       as username,
       max(time_stamp) as last_activity
  from apex_activity_log
 where flow_id     = :app_id
   and time_stamp >= sysdate - ( 1/24/60/60 * :P10030_TIMEFRAME )
   and userid_lc  is not null
 group by userid_lc
 order by 2 desc;

