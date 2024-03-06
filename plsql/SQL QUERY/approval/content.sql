    select er.ID,
       er.REQUESTOR_ID,
       er.REQUEST_ID,
       er.EMPLOYEE_CODE_REQ,
       er.EMPLOYEE_NAME,
       er.ALL_DAY,
       case 
    --    when er.ALL_DAY = 'N' then to_char(er.FROM_DATE||' | '||er.START_TIME)
       when er.ALL_DAY = 'N' then to_char(to_date(to_char(to_date(er.FROM_DATE, 'MM/DD/YYYY'), 'DD/MM/YYYY'), 'DD/MM/YYYY') || ' | ' || er.START_TIME)
       else to_char(to_date(to_char(to_date(er.FROM_DATE, 'MM/DD/YYYY'), 'DD/MM/YYYY'), 'DD/MM/YYYY')) end as FROM_DATE,
        case 
    --    when er.ALL_DAY = 'N' then to_char(er.END_DATE || ' | ' || er.END_TIME)
       when er.ALL_DAY = 'N' then to_char(to_date(to_char(to_date(er.END_DATE, 'MM/DD/YYYY'), 'DD/MM/YYYY'), 'DD/MM/YYYY') || ' | ' || er.END_TIME)
       else to_char(to_date(to_char(to_date(er.END_DATE, 'MM/DD/YYYY'), 'DD/MM/YYYY'), 'DD/MM/YYYY')) end as END_DATE,
       --er.FROM_DATE,
       --er.END_DATE,
       er.NOTE,
       er.LEAVE_TYPE as TYPE,
       CASE
           WHEN er.TOTAL_DAYS = 0.5 THEN 0.5
           ELSE er.TOTAL_DAYS
       END as TOTAL_DAYS,
       s.status as STATUS,
       er.man_res_status as RESPONSE,
       age.HRM_ABSENCE_CODE_ID,
       age.HRM_ABSENCE_CODE_GROUP_ID,
       case er.emp_req_status
       when 2 then
       'Approve' 
       when 3 then
       'Cancel'
       else
       null
       end as Action
  from EMPLOYEE_REQUESTS er
    join STATUS s on er.emp_req_status = s.id
    join ABSENCE_GROUP_EMPLOYEE age on er.EMPLOYEE_CODE_REQ = age.EMPLOYEE_CODE 
        and er.LEAVE_TYPE = age.HRM_ABSENCE_CODE_GROUP_ID and er.BENEFIT_CODE = age.BENEFIT_ACCRUAL_PLAN
    -- and age.EXPIRATION_DATE >= to_char(sysdate,'MM/DD/YYYY')
  where er.IS_DEL = 0 and er.REQUESTOR_ID <> :APP_USER_ID
    and :APP_EMP_CODE = (SELECT MANAGER_ID FROM EMPLOYEES WHERE EMPLOYEE_CODE = er.EMPLOYEE_CODE_REQ)
    and :P9_STATUS = 99 and er.id_root is null
    and to_date(er.FROM_DATE,'MM/DD/YYYY') between to_date(:P9_FROM_DATE,'DD/MM/YYYY') and to_date(:P9_TO_DATE,'DD/MM/YYYY')
    and (lower(er.EMPLOYEE_NAME) LIKE '%' || lower(:P9_SEARCH) || '%' or
        lower(er.NOTE) LIKE '%' || lower(:P9_SEARCH) || '%' or
        lower(er.EMPLOYEE_CODE_REQ) LIKE '%' || lower(:P9_SEARCH) || '%' or
        lower(TYPE) LIKE '%' || lower(:P9_SEARCH) || '%')
    and er.REQUEST_ID like '%' || :REQUEST_ID || '%'
  union
  select er.ID,
       er.REQUESTOR_ID,
       er.REQUEST_ID,
       er.EMPLOYEE_CODE_REQ,
       er.EMPLOYEE_NAME,
       er.ALL_DAY,
       case 
    --    when er.ALL_DAY = 'N' then to_char(er.FROM_DATE||' | '||er.START_TIME)
       when er.ALL_DAY = 'N' then to_char(to_date(to_char(to_date(er.FROM_DATE, 'MM/DD/YYYY'), 'DD/MM/YYYY'), 'DD/MM/YYYY') ||' | '|| er.START_TIME)
    --    else to_char(er.FROM_DATE) end as FROM_DATE,
       else to_char(to_date(to_char(to_date(er.FROM_DATE, 'MM/DD/YYYY'), 'DD/MM/YYYY'), 'DD/MM/YYYY')) end as FROM_DATE,
        case 
    --    when er.ALL_DAY = 'N' then to_char(er.END_DATE||' | '||er.END_TIME)
       when er.ALL_DAY = 'N' then to_char(to_date(to_char(to_date(er.END_DATE, 'MM/DD/YYYY'), 'DD/MM/YYYY'), 'DD/MM/YYYY') ||' | '||er.END_TIME)
    --    else to_char(er.END_DATE) end as END_DATE,
       else to_char(to_date(to_char(to_date(er.END_DATE, 'MM/DD/YYYY'), 'DD/MM/YYYY'), 'DD/MM/YYYY')) end as END_DATE,
       --er.FROM_DATE,
       --er.END_DATE,
       er.NOTE,
       er.LEAVE_TYPE as TYPE,
       er.TOTAL_DAYS,
       s.status as STATUS,
       er.man_res_status as RESPONSE,
       age.HRM_ABSENCE_CODE_ID,
       age.HRM_ABSENCE_CODE_GROUP_ID,
       case er.emp_req_status
       when 2 then
       'Approve' 
       when 3 then
       'Cancel'
       else
       null
       end as Action
  from EMPLOYEE_REQUESTS er
    join STATUS s on er.emp_req_status = s.id
    join ABSENCE_GROUP_EMPLOYEE age on er.EMPLOYEE_CODE_REQ = age.EMPLOYEE_CODE 
        and er.LEAVE_TYPE = age.HRM_ABSENCE_CODE_GROUP_ID and er.BENEFIT_CODE = age.BENEFIT_ACCRUAL_PLAN
    -- and age.EXPIRATION_DATE >= to_char(sysdate,'MM/DD/YYYY')
  where er.IS_DEL = 0 and er.REQUESTOR_ID <> :APP_USER_ID
    and :APP_EMP_CODE = (SELECT MANAGER_ID FROM EMPLOYEES WHERE EMPLOYEE_CODE = er.EMPLOYEE_CODE_REQ)
    and to_date(er.FROM_DATE,'MM/DD/YYYY') between to_date(:P9_FROM_DATE,'DD/MM/YYYY') and to_date(:P9_TO_DATE,'DD/MM/YYYY')
    and :P9_STATUS = er.emp_req_status
    and :P9_STATUS <> 99 and er.id_root is null
    and (lower(er.EMPLOYEE_NAME) LIKE '%' || lower(:P9_SEARCH) || '%' or
        lower(er.NOTE) LIKE '%' || lower(:P9_SEARCH) || '%' or
        lower(er.EMPLOYEE_CODE_REQ) LIKE '%' || lower(:P9_SEARCH) || '%' or
        lower(TYPE) LIKE '%' || lower(:P9_SEARCH) || '%')
    and er.REQUEST_ID like '%' || :REQUEST_ID || '%'
