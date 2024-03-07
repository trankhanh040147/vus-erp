create or replace procedure "SP_JOB_NEXT_RUN" 
(
    p_job_name in varchar2
)
is 
    n_job_name varchar2(100);
    n_next_run_date date;
    n_minutes_remaining number;
begin
    SELECT 
        JOB_NAME, 
        NEXT_RUN_DATE, 
        (EXTRACT(DAY FROM (NEXT_RUN_DATE - SYSTIMESTAMP)) * 24 * 60) +
        (EXTRACT(HOUR FROM (NEXT_RUN_DATE - SYSTIMESTAMP)) * 60) +
        EXTRACT(MINUTE FROM (NEXT_RUN_DATE - SYSTIMESTAMP)) AS MINUTES_REMAINING
    INTO
        n_job_name,
        n_next_run_date,
        n_minutes_remaining
    FROM 
        USER_SCHEDULER_JOBS
    WHERE 
        -- JOB_NAME = 'test_schedule_job';
        JOB_NAME = p_job_name;
    
    DBMS_OUTPUT.PUT_LINE('Job Name: ' || n_job_name);
    DBMS_OUTPUT.PUT_LINE('Next Run Date: ' || n_next_run_date);
    DBMS_OUTPUT.PUT_LINE('Minutes Remaining: ' || n_minutes_remaining);

end;