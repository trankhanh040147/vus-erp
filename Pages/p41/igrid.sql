with temp as (
    select
        wa.WA_GROUP
    from
        EMP_REQUESTS er
        join WORKFLOW_APPROVAL wa on wa.WF_PROCESS_ID = er.WF_PROCESS_ID
        join employees emp on emp.APPROVAL_GROUP = wa.WA_GROUP
   where
        lower(wa.WA_GROUP) not like 'line_manager' --and emp.employee_code = :APP_EMP_CODE
        group by
        wa.WA_GROUP

),
temp_2 as (
    select sum(TOTAL_HOUR_WK) as TOTAL_HOUR_WK,
        sum(TOTAL_HOUR_REST_WK) as TOTAL_HOUR_REST_WK,
        sum(TOTAL_HOUR_PUBLIC) as TOTAL_HOUR_PUBLIC,
        DETAIL_ID
        from EMP_OVERTIME_REQUESTS
        --where employee_code = :APP_EMP_CODE
        group by DETAIL_ID
)
select
    --eor.ID,
    emp.FULL_NAME,
    er.SUBMIT_DATE,
    eor.EMPLOYEE_CODE,
    -- eor.CREATED_DATE,
    er.CREATE_DATE,
    er.STATUS,
    -- eor.STATUS,
    er.NOTE,
    --(select FULL_NAME from employees where eor.MODIFIED_BY_CODE = emp.employee_code) as MODIFIED_BY,
    eor.MODIFIED_DATE,
    t2.TOTAL_HOUR_WK,
    t2.TOTAL_HOUR_REST_WK,
    t2.TOTAL_HOUR_PUBLIC,
    --eor.MANAGER_CODE,
    eor.DETAIL_ID,
    er.ID as REQUEST_ID
from
    EMP_OVERTIME_REQUESTS eor
    join EMP_REQUESTS er on eor.DETAIL_ID = er.REQUEST_DETAIL_ID
    and er.STATUS <> 1
    join temp_2 t2 on t2.DETAIL_ID = er.REQUEST_DETAIL_ID
    join employees emp on emp.employee_code = er.EMPLOYEE_CODE
-- where er.next_step = 1 and :APP_EMP_CODE = er.LINE_MANAGER 
where er.next_step = 1 and :APP_EMP_CODE = (SELECT MANAGER_ID FROM EMPLOYEES Where EMPLOYEE_CODE = ER.EMPLOYEE_CODE) 
and lower(emp.FULL_NAME) like '%' || TRIM(lower(:P41_EMPLOYEE)) ||'%' 
and to_date(er.CREATE_DATE,'MM/DD/YYYY') between to_date(:P41_FROM_DATE,'MM/DD/YYYY') and to_date(:P41_TO_DATE,'MM/DD/YYYY')
and lower(er.STATUS) like '%' || :P41_STATUS || '%'
-- and lower(er.STATUS) like '%' || lower(case when :P41_STATUS = 'na' then '' else :P41_STATUS end) || '%'
union
select
    --eor.ID,
    emp.FULL_NAME,
    er.SUBMIT_DATE,
    eor.EMPLOYEE_CODE,
    -- eor.CREATED_DATE,
    er.CREATE_DATE,
    er.STATUS,
    -- eor.STATUS,
    er.NOTE,
    eor.MODIFIED_DATE,
    t2.TOTAL_HOUR_WK,
    t2.TOTAL_HOUR_REST_WK,
    t2.TOTAL_HOUR_PUBLIC,
    eor.DETAIL_ID,
    er.ID as REQUEST_ID
from
    EMP_OVERTIME_REQUESTS eor
    join EMP_REQUESTS er on eor.DETAIL_ID = er.REQUEST_DETAIL_ID
    and er.STATUS <> 1
    join temp_2 t2 on t2.DETAIL_ID = er.REQUEST_DETAIL_ID
    join WORKFLOW_APPROVAL wa on wa.WF_PROCESS_ID = er.WF_PROCESS_ID
    join employees emp on emp.employee_code = er.EMPLOYEE_CODE
where er.next_step > 1 and (wa.WA_GROUP in (select WA_GROUP from temp) or wf_is_in_next_sequence(:APP_EMP_CODE,er.ID) = 1) 
and lower(emp.FULL_NAME) like '%' || TRIM(lower(:P41_EMPLOYEE)) ||'%'
and to_date(er.CREATE_DATE,'MM/DD/YYYY') between to_date(:P41_FROM_DATE,'MM/DD/YYYY') and to_date(:P41_TO_DATE,'MM/DD/YYYY')
and lower(er.STATUS) like '%' || :P41_STATUS || '%'
