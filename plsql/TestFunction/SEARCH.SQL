WHERE lower(E.FULL_NAME) like '%' || TRIM(lower(:P43_EMPLOYEE_NAME)) ||'%'
    and lower(ws.PROFILE_ID) like '%' || lower(case when :P43_PROFILE_TIME = 'na' then '' else :P43_PROFILE_TIME end) || '%'
    and ws.PROFILE_ID not like '%-x-%';