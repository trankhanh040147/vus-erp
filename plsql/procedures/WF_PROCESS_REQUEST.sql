-- This procedure is to approve/reject a request that is applied for a workflow

-- Input parameters:
-- p_employee_code: employee code of the user who approves/rejects the request
-- p_emp_request_id: id of the request
-- p_action: 1: approve, 2: reject
-- p_comment: comment of the user who approves/rejects the request

-- Output parameters:
-- p_request_status_out: status of the request after approving/rejecting

create or replace procedure wf_process_request(
    p_employee_code in varchar2, -- employee code of the user who approves/rejects the request
    p_emp_request_id in number,
    p_action in number, -- 1: approve, 2: reject
    p_comment in varchar2,
    p_request_status_out out number 
) is
  l_current_step number;
  l_next_step number;
  l_last_step number;
  l_req_status number;
  l_is_in_next_sequence number;
  l_manager_code nvarchar2(100);
  l_process_id varchar2(100);
  l_wa_group nvarchar2(200);
  l_wa_user nvarchar2(100);
  l_requester_code nvarchar2(100);
begin   

    -- get request status, current step
    select status, current_step, next_step, wf_process_id, employee_code
    into l_req_status, l_current_step, l_next_step, l_process_id, l_requester_code
    from emp_requests
    where id = p_emp_request_id;

    -- get last step of the workflow
    select max(wa_sequence_number) into l_last_step
    from workflow_approval
    where wf_process_id = l_process_id;

    -- set next step equal to current step
    l_current_step := l_next_step;

    -- find next step
    if l_current_step = l_last_step then
        -- if the request is in the last step, then next step is null
        l_next_step := null;
    else
        -- if the request is not in the last step, then next step is WA_SEQUENCE_NUMBER of the first row that has WA_SEQUENCE_NUMBER > l_current_step
        --- (There will be case that sequence number is not continuous)
        select min(wa_sequence_number) into l_next_step
        from workflow_approval
        where wf_process_id = l_process_id 
            and wa_sequence_number > l_current_step;
        -- l_next_step := l_current_step + 1;
    end if;

    -- action: Reject
    if p_action = 2 then    
        -- update status of the request
        update emp_requests
        set status = 4, modified_by_code = p_employee_code, modified_date = sysdate, current_step = l_current_step, next_step = l_next_step
        where id = p_emp_request_id;
    end if;

    -- action: Approve
    if p_action = 1 then
        -- if the request is in the last step, then update status of the request to 3 (Approved)
        if l_current_step = l_last_step then
            update emp_requests
            set status = 3, modified_by_code = p_employee_code, modified_date = sysdate, current_step = l_current_step, next_step = l_next_step
            where id = p_emp_request_id;
        end if;

        -- if the request is not in the last step, then update status of the request to 6 (In review)
        if l_current_step < l_last_step then
            update emp_requests
            set status = 6, modified_by_code = p_employee_code, modified_date = sysdate, current_step = l_current_step, next_step = l_next_step
            where id = p_emp_request_id;
        end if;
    end if;

    -- set p_request_status_out equal to the status of the request after approving/rejecting
    select status into p_request_status_out
    from emp_requests
    where id = p_emp_request_id;

    -- insert workflow_detail
    insert into workflow_detail(wd_modified_date, wd_modified_code, wd_comment, wf_process_id, status, request_id, sequence)
    values (sysdate, p_employee_code, p_comment, l_process_id, p_request_status_out, p_emp_request_id, l_current_step);

    -- [TODO] check if there is a user approved this request that is in the next sequence, then approve the request automatically
    --- use WF_IS_IN_NEXT_SEQUENCE(:EMP_CODE, :EMP_REQUEST_ID); --> out 0 or 1
    --- loop through workflow_detail to find the user who approved the request that is in the next sequence
    --- if found, then call wf_process_request(:EMP_CODE, :EMP_REQUEST_ID, 1, 'Approved automatically');

    l_is_in_next_sequence := 0;
    l_manager_code := null;

    for r in (
        select *
        from workflow_detail
        where wf_process_id = l_process_id
            and request_id = p_emp_request_id
            and status = 6
    ) loop
        l_is_in_next_sequence := wf_is_in_next_sequence(r.wd_modified_code, p_emp_request_id);
        if l_is_in_next_sequence = 1 then
            l_manager_code := r.wd_modified_code;
            exit;
        end if;
    end loop;

    if l_is_in_next_sequence = 1 then
        dbms_output.put_line('Approve automatically');
        dbms_output.put_line('l_manager_code: ' || l_manager_code);
        wf_process_request(l_manager_code, p_emp_request_id, 1, 'Approved', p_request_status_out);
    end if;


    -- print data for debugging
    dbms_output.put_line('p_employee_code: ' || p_employee_code);
    dbms_output.put_line('p_emp_request_id: ' || p_emp_request_id);
    dbms_output.put_line('p_action: ' || p_action);
    dbms_output.put_line('l_current_step: ' || l_current_step);
    dbms_output.put_line('l_next_step: ' || l_next_step);
    dbms_output.put_line('l_last_step: ' || l_last_step);
    dbms_output.put_line('l_req_status (status before): ' || l_req_status);
    dbms_output.put_line('l_req_status (status after): ' || p_request_status_out);
    dbms_output.put_line('l_is_in_next_sequence: ' || l_is_in_next_sequence);
    dbms_output.put_line('l_process_id: ' || l_process_id);
    dbms_output.put_line('l_requester_code: ' || l_requester_code);

end;

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
-- CURRENT_STEP	NUMBER(5,0) -- sequence number of the current step in the workflow
-- CREATE_DATE	DATE
-- NEXT_STEP	NUMBER(5,0) -- next sequence number of the next step in the workflow
-- IS_DEL	NUMBER(2,0)

-- table: WORKFLOW
-- ID	NUMBER(10,0)
-- WF_PROCESS_ID	NVARCHAR2(100 CHAR)
-- WF_NAME	NVARCHAR2(100 CHAR)
-- WF_DESCRIPTION	NVARCHAR2(200 CHAR)
-- WF_FEATURE_APPLY	NVARCHAR2(100 CHAR)
-- WF_CONDITIONAL_ID	NUMBER
-- WF_EFFECTIVE_DATE	DATE
-- WF_EXPIRATION_DATE	DATE
-- WF_MODIFIER_NAME	NVARCHAR2(100 CHAR)
-- WF_MODIFIED_DATE	DATE
-- WF_MODIFIER_CODE	NVARCHAR2(50 CHAR)
-- NO	NUMBER(5,0)
-- WORKFLOW_NO	NUMBER(5,0)
-- WF_PAGE_APPLY	NUMBER(5,0)

-- table: WORKFLOW_APPROVAL
-- WF_PROCESS_ID	NVARCHAR2(100 CHAR)
-- WA_ID	NUMBER(5,0)
-- WA_SEQUENCE_NUMBER	NUMBER(5,0)
-- WA_GROUP	NVARCHAR2(200 CHAR)
-- WA_USER	NVARCHAR2(100 CHAR)
-- WA_TEMPLATE_EMAIL_ID	NUMBER(5,0)
-- WA_TEMPLATE_EMAIL	NVARCHAR2(100 CHAR)

-- table: WORKFLOW_DETAIL
-- ID	NUMBER(10,0)
-- WD_MODIFIED_DATE	DATE
-- WD_MODIFIED_CODE	NVARCHAR2(50 CHAR)
-- WD_COMMENT	NVARCHAR2(100 CHAR)
-- WD_INFORMATION	NVARCHAR2(50 CHAR)
-- WF_PROCESS_ID	NVARCHAR2(50 CHAR)
-- STATUS	NUMBER(5,0)
-- REQUEST_ID	NUMBER(10,0)
-- SEQUENCE	NUMBER(5,0)
