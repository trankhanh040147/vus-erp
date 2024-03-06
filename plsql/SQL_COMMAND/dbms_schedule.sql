
DELETE
FROM all_scheduler_jobs
WHERE job_name = 'MY_AUTOMATION_JOB';

SELECT * FROM USER_SCHEDULER_JOBS

BEGIN
  DBMS_SCHEDULER.DROP_JOB(job_name => 'LEAVE_CALCULATION_SCHEDULE');
END;
/

BEGIN
  DBMS_SCHEDULER.CREATE_JOB (
    job_name        => 'LEAVE_CALCULATION_SCHEDULE',
    job_type        => 'PLSQL_BLOCK',
    job_action      => 'BEGIN SCHEDULE_LEAVE_CALCULATE(); END;',
    start_date      => TO_TIMESTAMP_TZ('2023-11-23 00:00:00.000000 Asia/Bangkok', 'YYYY-MM-DD HH24:MI:SS.FF TZR'),
    repeat_interval => 'FREQ=MONTHLY; BYMONTHDAY=23; BYHOUR=00; BYMINUTE=0; BYSECOND=0',
    enabled         => TRUE,
    comments        => 'Job to run at the beginning of the 23rd day of each month at 12 PM GMT+7.'
  );
END;
/

-- BEGIN
--   DBMS_SCHEDULER.CREATE_JOB (
--     job_name        => 'JOB_SYNC_ALL_EMPLOYEES',
--     job_type        => 'PLSQL_BLOCK',
--     job_action      => 'BEGIN SP_GET_ALL_EMPLOYEES(0, 1800); END;',
--     -- start_date      => TO_TIMESTAMP_TZ('2023-11-23 00:00:00.000000 Asia/Bangkok', 'YYYY-MM-DD HH24:MI:SS.FF TZR'),
--     -- start_date = now
--     start_date      => TO_TIMESTAMP_TZ('2024-01-02 15:40:00.000000 Asia/Bangkok', 'YYYY-MM-DD HH24:MI:SS.FF TZR'),
--     -- repeat_interval => 'FREQ=MONTHLY; BYMONTHDAY=01; BYHOUR=00; BYMINUTE=0; BYSECOND=0',
--     -- repeat per day
--     repeat_interval => 'FREQ=DAILY; BYHOUR=15; BYMINUTE=40; BYSECOND=0',
--     enabled         => TRUE,
--     comments        => 'Job to run at the beginning of the 23rd day of each month at 12 PM GMT+7.'
--   );
-- END;
-- /


-- Calculate total job time
SELECT 
    JOB_NAME, 
    NEXT_RUN_DATE, 
    (EXTRACT(DAY FROM (NEXT_RUN_DATE - SYSTIMESTAMP)) * 24 * 60) +
    (EXTRACT(HOUR FROM (NEXT_RUN_DATE - SYSTIMESTAMP)) * 60) +
    EXTRACT(MINUTE FROM (NEXT_RUN_DATE - SYSTIMESTAMP)) AS MINUTES_REMAINING
FROM 
    USER_SCHEDULER_JOBS
WHERE 
    -- JOB_NAME = 'test_schedule_job';
    JOB_NAME = 'LEAVE_CALCULATION_SCHEDULE';

-- run the job instantly
begin
    dbms_scheduler.run_job('JOB_SYNC_ALL_EMPLOYEES');
end;