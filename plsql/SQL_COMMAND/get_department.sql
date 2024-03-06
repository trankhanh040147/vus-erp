select unique(DEPARTMENT_ID) from EMPLOYEES

-- DEPARTMENT_ID values: 
-- get all values behind the first '_' of the DEPARTMENT_ID
-- and remove '441', null from result
select unique(substr(DEPARTMENT_ID, instr(DEPARTMENT_ID, '_')+1)) as dpm from EMPLOYEES where dpm not in ('441', null)
select unique(substr(DEPARTMENT_ID, instr(DEPARTMENT_ID, '_')+1)) from EMPLOYEES

-- union with: 'User':user, 'CEO':ceo, 'CTO':cto
SELECT 
    'Head of ' || substr(DEPARTMENT_ID, instr(DEPARTMENT_ID, '_')+1) as approval_group_desc,
    'head_of_' || lower(substr(DEPARTMENT_ID, instr(DEPARTMENT_ID, '_')+1)) as approval_group_id
FROM 
    EMPLOYEES 
WHERE 
    DEPARTMENT_ID NOT LIKE '%441%' 
    AND DEPARTMENT_ID IS NOT NULL
GROUP BY 
    substr(DEPARTMENT_ID, instr(DEPARTMENT_ID, '_')+1);
union all
select 'User' as approval_group_desc, 'user' as approval_group_id from dual
union all
select 'CEO' as approval_group_desc, 'ceo' as approval_group_id from dual
union all

--
-- use colesce for MAX(SUBSTR(sr.VOUCHER_CODE, INSTR(sr.VOUCHER_CODE, sr.REQUESTER_CODE) + LENGTH(sr.REQUESTER_CODE) + 1)) to replace null with 0
-- select MAX(SUBSTR(sr.VOUCHER_CODE, INSTR(sr.VOUCHER_CODE, sr.REQUESTER_CODE) + LENGTH(sr.REQUESTER_CODE) + 1)) + 1
select coalesce(MAX(SUBSTR(sr.VOUCHER_CODE, INSTR(sr.VOUCHER_CODE, sr.REQUESTER_CODE) + LENGTH(sr.REQUESTER_CODE) + 1)), 0) + 1
into x5
from SCHOLARSHIP_REQUEST sr 
where sr.REQUESTER_CODE = :P20002_EMPLOYEE_CODE 
    and (sr.RECIPIENT_TYPE like 'A' or sr.RECIPIENT_TYPE like 'B');