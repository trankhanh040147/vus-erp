create or replace function wf_is_in_next_sequence(p_employee_code in varchar2, p_emp_request_id in number) return number is
-- function to check if p_employee_code is in the current sequence of approval of the workflow
  l_current_step number;
  l_next_step number;
  l_req_status number;
  l_is_in_next_sequence number;
  l_process_id varchar2(100);
  l_wa_group varchar2(200);
  l_wa_user varchar2(100);
  l_requester_code varchar2(100);
begin   
    l_is_in_next_sequence := 0;

    IF p_employee_code is null or p_emp_request_id is null then
        return 0;
    end if;

    -- if request status is not Waiting/In review, return 0
    select status into l_req_status
    from emp_requests
    where id = p_emp_request_id;

    if l_req_status != 2 and l_req_status != 6 then
        return 0;
    end if;

    -- get the current step and next step of the workflow
    select current_step, next_step, WF_PROCESS_ID, EMPLOYEE_CODE into l_current_step, l_next_step, l_process_id, l_requester_code
    from emp_requests
    where id = p_emp_request_id;

    -- get the group and user of the next step
    -- [TODO] deal with multiple wa_sequence_number = l_next_step
    select lower(wa_group), lower(wa_user) into l_wa_group, l_wa_user
    from workflow_approval
    where wa_sequence_number = l_next_step
    and wf_process_id = l_process_id;

    -- check if p_employee_code is in the next sequence of approval of the workflow 
    -- case wa_group = 'line_manager', 'ceo', 'hr_manager', 'hr_admin'
    if l_wa_group = 'line_manager' then
        select count(*) into l_is_in_next_sequence
        from EMPLOYEES
        where EMPLOYEE_CODE = l_requester_code 
        and MANAGER_ID = p_employee_code;
    elsif l_wa_group = 'ceo' then
        select count(*) into l_is_in_next_sequence
        from EMPLOYEES
        where EMPLOYEE_CODE = p_employee_code 
        and lower(LEVEL_ID) = 'c';
    elsif l_wa_group = 'hr_admin' then
        select count(*) into l_is_in_next_sequence
        from EMPLOYEES
        where  EMPLOYEE_CODE = p_employee_code
        and IS_HR_ADMIN = 1;
    elsif l_wa_group = 'user' then
        select count(*) into l_is_in_next_sequence
        from EMPLOYEES
        where  EMPLOYEE_CODE = p_employee_code
        and trim(lower(USER_NAME)) = trim(lower(l_wa_user));    
    else
        select count(*) into l_is_in_next_sequence
        from EMPLOYEES e
        where  EMPLOYEE_CODE = p_employee_code
        -- and is_approval_group_present(lower(APPROVAL_GROUPS), lower(l_wa_group)) = 1;
        and (is_approval_group_present(lower(APPROVAL_GROUPS), lower(l_wa_group)) = 1
            or e.APPROVAL_GROUP = lower(l_wa_group));
    end if;

    -- print info of the next step
    dbms_output.put_line('current step: ' || l_current_step);
    dbms_output.put_line('next step: ' || l_next_step);
    dbms_output.put_line('group: ' || l_wa_group);
    dbms_output.put_line('user: ' || l_wa_user);

    return l_is_in_next_sequence;
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
