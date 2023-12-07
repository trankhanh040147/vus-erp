-- table: EMP_REQUESTS
-- ID	NUMBER(10,0)
-- REQUEST_TYPE	NVARCHAR2(100 CHAR)
-- SUBMIT_DATE	DATE
-- EMPLOYEE_CODE	NVARCHAR2(200 CHAR)
-- STATUS	NUMBER(2,0)
-- NOTE	NVARCHAR2(2000 CHAR)
-- MODIFIED_BY_CODE	NVARCHAR2(500 CHAR)
-- MODIFIED_DATE	DATE
-- REQUEST_DETAIL_ID	NUMBER(10,0)
-- WF_PROCESS_ID	NVARCHAR2(500 CHAR)
-- LINE_MANAGER	NVARCHAR2(100 CHAR)
-- CURRENT_STEP	NUMBER(5,0)
-- CREATE_DATE	DATE
-- NEXT_STEP	NUMBER(5,0)

-- table: WORKFLOW
-- ID	NUMBER(10,0)
-- WF_PROCESS_ID	NVARCHAR2(100 CHAR)
-- WF_NAME	NVARCHAR2(100 CHAR)
-- WF_DESCRIPTION	NVARCHAR2(200 CHAR)
-- WF_FEATURE_APPLY	NVARCHAR2(100 CHAR)
-- WF_CONDITIONAL_ID	NUMBER
-- WF_EFFECTIVE_DATE	DATE
-- WF_EXPIRATION_DATE	DATE
-- WF_MODIFIER_CODE	NVARCHAR2(50 CHAR)
-- WF_PAGE_APPLY	NUMBER(5,0)

-- table: WORKFLOW_APPROVAL
-- WF_PROCESS_ID	NVARCHAR2(100 CHAR)
-- WA_ID	NUMBER(5,0)
-- WA_SEQUENCE_NUMBER	NUMBER(5,0) -- step
-- WA_GROUP	NVARCHAR2(200 CHAR)

-- table: EMPLOYEES
-- ID	NUMBER(10,0)
-- EMPLOYEE_CODE	NVARCHAR2(100 CHAR)
-- APPROVAL_GROUP	NVARCHAR2(50 CHAR)


create or replace FUNCTION get_manager_next_sequence (
    p_emp_request_id IN NUMBER
) RETURN NVARCHAR2
IS
    v_next_step NVARCHAR2(100);
    v_current_step NUMBER;
    v_process_id NVARCHAR2(100);
    v_request_type NVARCHAR2(100);
    v_wa_sequence_number NUMBER;
    
    v_wa_group NVARCHAR2(200);
    v_wa_group_next_step NVARCHAR2(200);
    v_line_manager NVARCHAR2(100);
    v_approver_group NVARCHAR2(50);
    v_approver_group_list NVARCHAR2(200);
    v_approver_group_list_arr SYS.ODCIVARCHAR2LIST;
    v_approver_group_list_arr_size NUMBER;

    v_result NVARCHAR2(200);
begin
    -- get process id, request type, current step...begin
    select WF_PROCESS_ID, REQUEST_TYPE, CURRENT_STEP
    into v_process_id, v_request_type, v_current_step
    from EMP_REQUESTS
    where ID = p_emp_request_id;

    -- get row in WORKFLOW_APPROVAL base on current step
    select WA_SEQUENCE_NUMBER, WA_GROUP
    into v_wa_sequence_number, v_wa_group
    from WORKFLOW_APPROVAL
    where WF_PROCESS_ID = v_process_id
    and WA_SEQUENCE_NUMBER = v_current_step;

    -- get next step in WORKFLOW_APPROVAL (return -1 when no data found: select coallesce)
    select coalesce(min(WA_SEQUENCE_NUMBER), -1)      
    into v_next_step
    from WORKFLOW_APPROVAL
    where WF_PROCESS_ID = v_process_id
    and WA_SEQUENCE_NUMBER > v_current_step;

    if v_next_step != -1 then
        -- get row in WORKFLOW_APPROVAL base on next step
        select WA_GROUP
        into v_wa_group_next_step
        from WORKFLOW_APPROVAL
        where WF_PROCESS_ID = v_process_id
        and WA_SEQUENCE_NUMBER = v_next_step;
    else 
        return NULL;
    end if;

    -- find all employee codes where APPROVAL_GROUP = v_wa_group_next_step
    -- join which ',' to string
    -- result belike: 'EMP001' or 'EMP001,EMP002,EMP003'
    v_result := '';
    select listagg(EMPLOYEE_CODE, ',') within group (order by EMPLOYEE_CODE)
    into v_result
    from EMPLOYEES
    where APPROVAL_GROUP = v_wa_group_next_step;

    
    -- print log
    -- dbms_output.put_line('v_wa_sequence_number: ' || v_wa_sequence_number);

    dbms_output.put_line('v_next_step: ' || v_next_step || ' - v_wa_group_next_step: ' || v_wa_group_next_step);

    -- return v_wa_group || ' - ' || v_wa_sequence_number;
    return v_result;
end;



declare 
    v_emp_request_id NUMBER;
    result NVARCHAR2(100);
BEGIN
    v_emp_request_id := 479;
    -- v_emp_request_id := 413;
    result := get_manager_next_sequence(v_emp_request_id);
    -- dbms_output.put_line('result: ' || result);
    if result is null then
        dbms_output.put_line('null');
    else
        dbms_output.put_line('result' || result);
    end if;
END;