with temp as (
    select
        wa.WA_GROUP
    from
        EMP_REQUESTS er
        join WORKFLOW_APPROVAL wa on wa.WF_PROCESS_ID = er.WF_PROCESS_ID
        join employees emp on emp.APPROVAL_GROUP = wa.WA_GROUP
    -- where
    --     emp.EMPLOYEE_CODE = :APP_EMP_CODE
    group by
        wa.WA_GROUP
)
select
    eor.ID,
    emp.FULL_NAME,
    er.SUBMIT_DATE,
    eor.EMPLOYEE_CODE,
    eor.CREATED_DATE,
    eor.STATUS,
    er.NOTE,
    --(select FULL_NAME from employees where eor.MODIFIED_BY_CODE = emp.employee_code) as MODIFIED_BY,
    eor.MODIFIED_DATE,
    eor.TOTAL_HOUR_WK,
    eor.TOTAL_HOUR_REST_WK,
    eor.TOTAL_HOUR_PUBLIC,
    eor.MANAGER_CODE,
    eor.DETAIL_ID,
    er.ID as REQUEST_ID
from
    EMP_OVERTIME_REQUESTS eor
    join EMP_REQUESTS er on eor.DETAIL_ID = er.REQUEST_DETAIL_ID
    and er.STATUS <> 8
    join WORKFLOW_APPROVAL wa on wa.WF_PROCESS_ID = er.WF_PROCESS_ID
    join employees emp on emp.employee_code = er.EMPLOYEE_CODE
    join temp tmp on tmp.WA_GROUP = wa.WA_GROUP --join employees emp on emp.APPROVAL_GROUP = wa.WA_GROUP --and emp.employee_code = :APP_EMP_CODE
    --where er.LINE_MANAGER = :APP_EMP_CODE
    --join temp emp on emp.employee_code = er.LINE_MANAGER
    --where emp.employee_code = :APP_EMP_CODE