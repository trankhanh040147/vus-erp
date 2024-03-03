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
            DBMS_SCHEDULER.CREATE_JOB(
                job_name => 'JOB_GET_ABSENCE_GROUP_' || v_from_num || '_' || v_to_num,
                job_type => 'PLSQL_BLOCK',
                job_action => 'BEGIN SP_GET_MANY_ABSENCE_GROUP_EMPLOYEE(' || v_from_num || ',' || v_to_num || '); END;',
                start_date => SYSTIMESTAMP,
                enabled => TRUE
            );
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