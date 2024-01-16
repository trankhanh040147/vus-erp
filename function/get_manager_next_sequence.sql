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
    -- select WA_SEQUENCE_NUMBER, WA_GROUP
    -- into v_wa_sequence_number, v_wa_group
    -- from WORKFLOW_APPROVAL
    -- where WF_PROCESS_ID = v_process_id
    -- and WA_SEQUENCE_NUMBER = v_current_step;

    -- get next step in WORKFLOW_APPROVAL (return -1 when no data found: select coallesce)
    select coalesce(min(WA_SEQUENCE_NUMBER), -1)      
    into v_next_step
    from WORKFLOW_APPROVAL
    where WF_PROCESS_ID = v_process_id
    and WA_SEQUENCE_NUMBER > v_current_step;

    if v_next_step != -1 then
        -- v_next_step = 1: trường hợp này đang là line manager => cần cộng thêm 1 để chạy trường hợp tiếp theo
        if v_next_step = 1 then
            v_next_step := v_next_step + 1;
            -- get row in WORKFLOW_APPROVAL base on next step
            select WA_GROUP
            into v_wa_group_next_step
            from WORKFLOW_APPROVAL
            where WF_PROCESS_ID = v_process_id
            and WA_SEQUENCE_NUMBER = v_next_step;
        else
            select WA_GROUP
            into v_wa_group_next_step
            from WORKFLOW_APPROVAL
            where WF_PROCESS_ID = v_process_id
            and WA_SEQUENCE_NUMBER = v_next_step;
        end if;
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
    -- where instr(APPROVAL_GROUPS,v_wa_group_next_step) > 0;
    where APPROVAL_GROUP = v_wa_group_next_step;

    
    -- print log
    -- dbms_output.put_line('v_wa_sequence_number: ' || v_wa_sequence_number);

    -- dbms_output.put_line('v_next_step: ' || v_next_step || ' - v_wa_group_next_step: ' || v_wa_group_next_step);

    -- return v_wa_group || ' - ' || v_wa_sequence_number;
    return v_result;
end;
/