select er.ID,
       er.REQUESTOR_ID,
       er.REQUEST_ID,
       er.EMPLOYEE_CODE_REQ,
       er.EMPLOYEE_NAME,
       er.ALL_DAY,
       er.FROM_DATE,
       er.END_DATE,
       er.NOTE,
       rt.NAME as TYPE,
       er.TOTAL_DAYS,
       s.status as STATUS,
       er.man_res_status as RESPONSE,
       age.HRM_ABSENCE_CODE_ID,
       age.HRM_ABSENCE_CODE_GROUP_ID,
       case er.emp_req_status
       when 2 then
       'Aprrove' 
       when 3 then
       'Cancel'
       else
       null
       end as Action
  from EMPLOYEE_REQUESTS er
    join REQUEST_TYPE rt on er.LEAVE_TYPE = rt.REQUEST_TYPE_CODE
    join STATUS s on er.emp_req_status = s.id
    left join ABSENCE_GROUP_EMPLOYEE age on er.EMPLOYEE_CODE_REQ = age.EMPLOYEE_CODE
  where er.IS_DEL = 0 and er.REQUESTOR_ID <> :APP_USER_ID
    and to_date(SUBMIT_DATE,'MM/DD/YYYY') between to_date(:P9_FROM_DATE,'MM/DD/YYYY') and to_date(:P9_TO_DATE,'MM/DD/YYYY')
    and :P9_STATUS = 99
  union
  select er.ID,
       er.REQUESTOR_ID,
       er.REQUEST_ID,
       er.EMPLOYEE_CODE_REQ,
       er.EMPLOYEE_NAME,
       er.ALL_DAY,
       er.FROM_DATE,
       er.END_DATE,
       er.NOTE,
       rt.NAME as TYPE,
       er.TOTAL_DAYS,
       s.status as STATUS,
       er.man_res_status as RESPONSE,
       age.HRM_ABSENCE_CODE_ID,
       age.HRM_ABSENCE_CODE_GROUP_ID,
       case er.emp_req_status
       when 2 then
       'Aprrove' 
       when 3 then
       'Cancel'
       else
       null
       end as Action
  from EMPLOYEE_REQUESTS er
    join REQUEST_TYPE rt on er.LEAVE_TYPE = rt.REQUEST_TYPE_CODE
    join STATUS s on er.emp_req_status = s.id
    left join ABSENCE_GROUP_EMPLOYEE age on er.EMPLOYEE_CODE_REQ = age.EMPLOYEE_CODE
  where er.IS_DEL = 0 and er.REQUESTOR_ID <> :APP_USER_ID
    and to_date(SUBMIT_DATE,'MM/DD/YYYY') between to_date(:P9_FROM_DATE,'MM/DD/YYYY') and to_date(:P9_TO_DATE,'MM/DD/YYYY')
    and :P9_STATUS = er.emp_req_status
    and :P9_STATUS <> 99

  

