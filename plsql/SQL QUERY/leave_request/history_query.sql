select er.ID,
       CASE
           WHEN rt.NAME = 'APL' THEN 'Leave'
           ELSE to_char(rt.NAME)
       END AS TYPE,
       er.REQUESTOR_ID,
       er.REQUEST_ID,
       er.EMPLOYEE_CODE_REQ,
       er.EMPLOYEE_NAME,
       er.ALL_DAY,
       er.FROM_DATE,
       er.END_DATE,
       er.NOTE,
       er.TOTAL_DAYS,
       s.status as STATUS,
        case er.emp_req_status
        when 2 then
        'Delete' 
        else
        null
        end as Action
  from EMPLOYEE_REQUESTS er
  join REQUEST_TYPE rt on er.LEAVE_TYPE = rt.REQUEST_TYPE_CODE
  join STATUS s on er.emp_req_status = s.id
  where er.IS_DEL = 0 and er.EMPLOYEE_CODE_REQ = :APP_EMP_CODE
  and to_date(SUBMIT_DATE,'MM/DD/YYYY') between to_date(:P7_FROM_DATE,'MM/DD/YYYY') and to_date(:P7_END_DATE,'MM/DD/YYYY')
  and :P7_STATUS = 99
  union
  select er.ID,
           CASE
           WHEN rt.NAME = 'APL' THEN 'Leave'
           ELSE to_char(rt.NAME)
       END AS TYPE,
       er.REQUESTOR_ID,
       er.REQUEST_ID,
       er.EMPLOYEE_CODE_REQ,
       er.EMPLOYEE_NAME,
       er.ALL_DAY,
       er.FROM_DATE,
       er.END_DATE,
       er.NOTE,
       er.TOTAL_DAYS,
       s.status as STATUS,
        case er.emp_req_status
        when 2 then
        'Delete' 
        else
        null
        end as Action
  from EMPLOYEE_REQUESTS er
  join REQUEST_TYPE rt on er.LEAVE_TYPE = rt.REQUEST_TYPE_CODE
  join STATUS s on er.emp_req_status = s.id
  where er.IS_DEL = 0 and er.EMPLOYEE_CODE_REQ = :APP_EMP_CODE
  and to_date(SUBMIT_DATE,'MM/DD/YYYY') between to_date(:P7_FROM_DATE,'MM/DD/YYYY') and to_date(:P7_END_DATE,'MM/DD/YYYY')
  and :P7_STATUS = er.emp_req_status
  and :P7_STATUS <> 99

  

