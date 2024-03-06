select er.ID,
       er.REQUESTOR_ID,
       er.REQUEST_ID,
       er.EMPLOYEE_CODE,
       er.EMPLOYEE_NAME,
       er.ALL_DAY,
       er.FROM_DATE,
       er.END_DATE,
       er.NOTE,
       rt.NAME as TYPE,
       er.TOTAL_DAYS,
       s.status as STATUS,
       er.man_res_status as RESPONSE,
       'Approve'as Approve,
       'Reject' as Reject
  from EMPLOYEE_REQUESTS er
  left join REQUEST_TYPE rt on er.emp_req_status = rt.id
  join STATUS s on er.emp_req_status = s.id
  where er.IS_DEL = 0 and er.man_res_status is null and er.REQUESTOR_ID <> :APP_USER_ID
  union
  select er.ID,
       er.REQUESTOR_ID,
       er.REQUEST_ID,
       er.EMPLOYEE_CODE,
       er.EMPLOYEE_NAME,
       er.ALL_DAY,
       er.FROM_DATE,
       er.END_DATE,
       er.NOTE,
       rt.NAME as TYPE,
       er.TOTAL_DAYS,
       s.status as STATUS,
       er.man_res_status as RESPONSE,
       null as Approve,
       null as Reject
  from EMPLOYEE_REQUESTS er
  left join REQUEST_TYPE rt on er.emp_req_status = rt.id
  join STATUS s on er.emp_req_status = s.id
  where er.IS_DEL = 0 and er.man_res_status is not null and er.REQUESTOR_ID <> :APP_USER_ID