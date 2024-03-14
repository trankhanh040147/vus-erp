create or replace procedure "SP_JOB_SYNC_AUTOMATION_EMPLOYEES"
IS
BEGIN

    -- create job
    begin
        DBMS_SCHEDULER.CREATE_JOB (
            job_name        => 'JOB_SYNC_AUTOMATION_EMPLOYEES',
            job_type        => 'PLSQL_BLOCK',
            job_action      => 'BEGIN SB_JOB_SYNC_EMPLOYEES_CREATION(); END;',
            -- start_date      => TO_TIMESTAMP_TZ('2023-11-23 00:00:00.000000 Asia/Bangkok', 'YYYY-MM-DD HH24:MI:SS.FF TZR'),
            start_date      => TO_TIMESTAMP_TZ('2024-03-07 00:00:00.000000 Asia/Bangkok', 'YYYY-MM-DD HH24:MI:SS.FF TZR'),
            -- repeat_interval => 'FREQ=MONTHLY; BYMONTHDAY=23; BYHOUR=00; BYMINUTE=0; BYSECOND=0',
            -- repeat_interval everyday at 00.00 am
            repeat_interval => 'FREQ=DAILY; BYHOUR=00; BYMINUTE=0; BYSECOND=0',
            enabled         => TRUE,
            comments        => 'Job to sync employees everyday at 12.00 AM'
        );
    exception
      when OTHERS then
        -- if sqlcode = -27475 then
        --   DBMS_OUTPUT.PUT_LINE('Job already exists');
        -- else
        --   raise;
        -- end if;
        DBMS_OUTPUT.PUT_LINE('Job already exists');
    end;

    ---------------------------------------------------------------------------------------------------
    ---------------------------------------------------------------------------------------------------
    ---------------------------------------------------------------------------------------------------

    -- util functions 
    -- -- *Delete job
    -- DELETE
    -- FROM all_scheduler_jobs
    -- WHERE job_name = 'JOB_SYNC_AUTOMATION_EMPLOYEES';

    -- -- *Check all job
    -- SELECT * FROM USER_SCHEDULER_JOBS

    -- -- *Drop Job
    -- BEGIN
    -- DBMS_SCHEDULER.DROP_JOB(job_name => 'JOB_SYNC_AUTOMATION_EMPLOYEES');
    -- END;
    -- /

    -- -- *Calculate next run date
    -- SELECT 
    --     JOB_NAME, 
    --     NEXT_RUN_DATE, 
    --     (EXTRACT(DAY FROM (NEXT_RUN_DATE - SYSTIMESTAMP)) * 24 * 60) +
    --     (EXTRACT(HOUR FROM (NEXT_RUN_DATE - SYSTIMESTAMP)) * 60) +
    --     EXTRACT(MINUTE FROM (NEXT_RUN_DATE - SYSTIMESTAMP)) AS MINUTES_REMAINING
    -- FROM 
    --     USER_SCHEDULER_JOBS
    -- WHERE 
    --     -- JOB_NAME = 'test_schedule_job';
    --     JOB_NAME = 'LEAVE_CALCULATION_SCHEDULE';

    -- -- *run the job instantly
    -- -- !This will run the job instantly, regardless of the repeat_interval
    -- begin
    --     dbms_scheduler.run_job('JOB_SYNC_AUTOMATION_EMPLOYEES');
    -- end;

        
END;



---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

-- *job_name here is JOB_SYNC_AUTOMATION_EMPLOYEES

-- *Check all job
SELECT * FROM USER_SCHEDULER_JOBS

-- *Drop Job
BEGIN
  DBMS_SCHEDULER.DROP_JOB(job_name => 'JOB_SYNC_AUTOMATION_EMPLOYEES');
END;
/

-- *Stop the job
BEGIN
  DBMS_SCHEDULER.STOP_JOB(job_name => 'JOB_SYNC_AUTOMATION_EMPLOYEES');
END;

-- *Calculate next run date
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
    JOB_NAME = 'JOB_SYNC_AUTOMATION_EMPLOYEES';

-- *run the job instantly
-- !This will run the job instantly, regardless of the repeat_interval
begin
    dbms_scheduler.run_job('JOB_SYNC_AUTOMATION_EMPLOYEES');
end;

-- *Delete job
-- !Do not have privilege to delete job, so this will not work
DELETE
FROM all_scheduler_jobs
WHERE job_name = 'JOB_SYNC_AUTOMATION_EMPLOYEES';

---------------------------------------------------------------------------------------------------

--* Check JOB_GET_EMPLOYEES_ jobs


-- *List down all "SP_GET_ALL_EMPLOYEES" jobs
SELECT * FROM USER_SCHEDULER_JOBS WHERE JOB_NAME LIKE 'JOB_GET_EMPLOYEES_%';

-- *Check log of all "SP_GET_ALL_EMPLOYEES" jobs
SELECT * FROM USER_SCHEDULER_JOB_LOG WHERE JOB_NAME LIKE 'JOB_GET_EMPLOYEES_%' ORDER BY LOG_DATE DESC;

-- *Stop and Delete all current JOB_GET_EMPLOYEES_ jobs
BEGIN
    FOR cur_rec IN (SELECT JOB_NAME FROM USER_SCHEDULER_JOBS WHERE JOB_NAME LIKE 'JOB_GET_EMPLOYEES_%') LOOP
        BEGIN
            BEGIN
                DBMS_SCHEDULER.STOP_JOB(job_name => cur_rec.JOB_NAME, force => TRUE);
                DBMS_SCHEDULER.DROP_JOB(job_name => cur_rec.JOB_NAME);
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    -- Handle the case when the job does not exist
                    DBMS_OUTPUT.PUT_LINE('Job ' || cur_rec.JOB_NAME || ' does not exist.');
                WHEN OTHERS THEN
                    -- Handle other exceptions if necessary
                    DBMS_OUTPUT.PUT_LINE('Error occurred while stopping/dropping job ' || cur_rec.JOB_NAME || ': ' || SQLERRM);
            END;
        END;
    END LOOP;
END;
