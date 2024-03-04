create or replace procedure "SB_JOB_SYNC_EMPLOYEES_CREATION"
is
    v_from_num NUMBER := 1;
    v_to_num NUMBER := 100;
    v_total_employees NUMBER;
begin
    -- This procedure will create a lot of jobs that will be executed in parallel
    -- to call API to get data of all employees and store it in the database

    -- 1. Get total employees
    SP_GET_TOTAL_EMPLOYEES(v_total_employees);
    DBMS_OUTPUT.PUT_LINE('Total employees: ' || v_total_employees);

    -- 2. Create jobs to get employees data
    WHILE v_from_num <= v_total_employees LOOP
            DBMS_SCHEDULER.CREATE_JOB(
                job_name => 'JOB_GET_EMPLOYEES_' || v_from_num || '_' || v_to_num,
                job_type => 'PLSQL_BLOCK',
                job_action => 'BEGIN SP_GET_ALL_EMPLOYEES(' || v_from_num || ',' || v_to_num || '); END;',
                start_date => SYSTIMESTAMP,
                enabled => TRUE
            );
            v_from_num := v_to_num + 1;
            v_to_num := v_to_num + 100;
            DBMS_OUTPUT.PUT_LINE('Created job: JOB_GET_EMPLOYEES_' || v_from_num || '_' || v_to_num);
    END LOOP;

    COMMIT;
end;
/
-- Utils functions to check jobs status

-- *List down all "SP_GET_ALL_EMPLOYEES" jobs
SELECT * FROM USER_SCHEDULER_JOBS WHERE JOB_NAME LIKE 'JOB_GET_EMPLOYEES_%';

-- Check log of all "SP_GET_ALL_EMPLOYEES" jobs
SELECT * FROM USER_SCHEDULER_JOB_LOG WHERE JOB_NAME LIKE 'JOB_GET_EMPLOYEES_%' ORDER BY LOG_DATE DESC;

-- Stop and Delete all current JOB_GET_EMPLOYEES_ jobs
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
