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

    -- get next step in WORKFLOW_APPROVAL (return -1 when no data found: select coallesce)
    -- This selection retrieves the minimum value of the WA_SEQUENCE_NUMBER column from the WORKFLOW_APPROVAL table, 
    -- where the WF_PROCESS_ID is equal to v_process_id and the WA_SEQUENCE_NUMBER is greater than v_current_step. The retrieved value is stored in the v_next_step variable. If no matching records are found, the v_next_step variable is set to -1.
    select coalesce(min(WA_SEQUENCE_NUMBER), -1)      
    into v_next_step
    from WORKFLOW_APPROVAL
    where WF_PROCESS_ID = v_process_id
    and WA_SEQUENCE_NUMBER > v_current_step;

    v_result := '';

    select listagg(EMPLOYEE_CODE, ',') within group (order by EMPLOYEE_CODE)
    into v_result
    from EMPLOYEES e
    -- where instr(APPROVAL_GROUPS,v_wa_group_next_step) > 0;
    where wf_is_in_next_sequence(e.EMPLOYEE_CODE, p_emp_request_id) = 1;
    
    -- print log
    -- dbms_output.put_line('v_wa_sequence_number: ' || v_wa_sequence_number);

    -- dbms_output.put_line('v_next_step: ' || v_next_step || ' - v_wa_group_next_step: ' || v_wa_group_next_step);

    -- return v_wa_group || ' - ' || v_wa_sequence_number;
    return v_result;
end;
/