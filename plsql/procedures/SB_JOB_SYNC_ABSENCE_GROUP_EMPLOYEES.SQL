create or replace procedure "SB_JOB_SYNC_ABSENCE_GROUP_EMPLOYEES"(
    p_limit in number default -1
)
is
    v_total_per_batch NUMBER := 50;
    v_from_num NUMBER := 1;
    v_to_num NUMBER := v_total_per_batch;
    v_total_employees NUMBER;
begin
    -- This procedure will create a lot of jobs that will be executed in parallel
    -- to call API to get absence group of all employees and store it in the database

    -- 1. Get total employees
    SELECT COUNT(ID) INTO v_total_employees FROM EMPLOYEES;

    -- 1.1 If p_limit is set, then use it as the total employees
    IF p_limit > 0 THEN
        v_total_employees := p_limit;
    END IF;

    -- 2. Create jobs to get employees data
    WHILE v_from_num <= v_total_employees LOOP
            -- BEGIN
                DBMS_SCHEDULER.CREATE_JOB(
                    job_name => 'JOB_GET_ABSENCE_GROUP_' || v_from_num || '_' || v_to_num,
                    job_type => 'PLSQL_BLOCK',
                    job_action => 'BEGIN SP_GET_MANY_ABSENCE_GROUP_EMPLOYEE(' || v_from_num || ',' || v_to_num || '); END;',
                    start_date => SYSTIMESTAMP,
                    enabled => TRUE
                );
            --     EXCEPTION
            --         WHEN OTHERS THEN
            --             DBMS_OUTPUT.PUT_LINE('Error creating job: JOB_GET_ABSENCE_GROUP' || v_from_num || '_' || v_to_num);
            --             CONTINUE;
            -- END;
            DBMS_OUTPUT.PUT_LINE('Created job: JOB_GET_ABSENCE_GROUP' || v_from_num || '_' || v_to_num);
            v_from_num := v_to_num + 1;
            v_to_num := v_to_num + v_total_per_batch;
    END LOOP;

    COMMIT;
end;    
/
-- Utils functions to check jobs status

-- *List down all "SP_GET_MANY_ABSENCE_GROUP_EMPLOYEE" jobs
SELECT * FROM USER_SCHEDULER_JOBS WHERE JOB_NAME LIKE 'JOB_GET_ABSENCE_GROUP%';

-- Check log of all "SP_GET_MANY_ABSENCE_GROUP_EMPLOYEE" jobs
SELECT * FROM USER_SCHEDULER_JOB_LOG WHERE JOB_NAME LIKE 'JOB_GET_ABSENCE_GROUP%' ORDER BY LOG_DATE DESC;

-- Stop and Delete all current JOB_GET_ABSENCE_GROUP jobs
BEGIN
    FOR cur_rec IN (SELECT JOB_NAME FROM USER_SCHEDULER_JOBS WHERE JOB_NAME LIKE 'JOB_GET_ABSENCE_GROUP%') LOOP
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



