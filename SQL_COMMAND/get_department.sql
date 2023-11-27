select unique(DEPARTMENT_ID) from EMPLOYEES

-- DEPARTMENT_ID values: 
-- get all values behind the first '_' of the DEPARTMENT_ID
-- and remove '441', null from result
select unique(substr(DEPARTMENT_ID, instr(DEPARTMENT_ID, '_')+1)) as dpm from EMPLOYEES where dpm not in ('441', null)
select unique(substr(DEPARTMENT_ID, instr(DEPARTMENT_ID, '_')+1)) from EMPLOYEES



-- select unique(substr(DEPARTMENT_ID, instr(DEPARTMENT_ID, '_')+1)) as dpm from EMPLOYEES where dpm not in ('441', null) 
sselect unique(substr(DEPARTMENT_ID, instr(DEPARTMENT_ID, '_')+1)) as dpm from EMPLOYEES where dpm not in ('441', null)