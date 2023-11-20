-- --------------------------------------------------------------------------------
-- 
-- Oracle APEX source export file
-- 
-- The contents of this file are intended for review and analysis purposes only.
-- Developers must use the Application Builder to make modifications to an
-- application. Changes to this file will not be reflected in the application.
-- 
-- --------------------------------------------------------------------------------

-- ----------------------------------------
-- Page: 35 - List Request overtime for Employee > Region: Report > Source > SQL Query

with temp as (
    select sum(TOTAL_HOUR_WK) as TOTAL_HOUR_WK,
        sum(TOTAL_HOUR_REST_WK) as TOTAL_HOUR_REST_WK,
        sum(TOTAL_HOUR_PUBLIC) as TOTAL_HOUR_PUBLIC,
        DETAIL_ID
        from EMP_OVERTIME_REQUESTS
        where employee_code = :APP_EMP_CODE
        group by DETAIL_ID
)

select
        ER.ID,
        emp.FULL_NAME,
        er.EMPLOYEE_CODE,
        er.SUBMIT_DATE,
        er.STATUS,
        er.NOTE,
        eor.TOTAL_HOUR_WK,
        eor.TOTAL_HOUR_REST_WK,
        eor.TOTAL_HOUR_PUBLIC,
        (select FULL_NAME from employees where employee_code = er.MODIFIED_BY_CODE) as MODIFIED_BY_CODE,
        er.MODIFIED_DATE,
        eor.DETAIL_ID
from EMP_REQUESTS er 
join temp eor on er.REQUEST_DETAIL_ID = eor.DETAIL_ID
join employees emp on emp.employee_code = er.EMPLOYEE_CODE
where emp.employee_code = :APP_EMP_CODE
and lower(emp.FULL_NAME) like '%' || TRIM(lower(:P35_EMPLOYEE)) ||'%' 
and to_date(er.CREATE_DATE,'MM/DD/YYYY') between to_date(:P35_FROM_DATE,'MM/DD/YYYY') and to_date(:P35_TO_DATE,'MM/DD/YYYY')
and lower(er.STATUS) like '%' || :P35_STATUS || '%';

-- ----------------------------------------
-- Page: 35 - List Request overtime for Employee > Region: Report > Column: STATUS > List of Values > SQL Query

SELECT STATUS, ID AS ID 
From STATUS;

-- ----------------------------------------
-- Page: 35 - List Request overtime for Employee > Process: Delete detail > Source > PL/SQL Code

declare
    n_check number;
begin
select count(id) into n_check from EMP_OVERTIME_REQUESTS where DETAIL_ID not in (select REQUEST_DETAIL_ID from EMP_REQUESTS where EMPLOYEE_CODE = :APP_EMP_CODE);
if n_check > 0 then
    delete from EMP_OVERTIME_REQUESTS where DETAIL_ID not in (select REQUEST_DETAIL_ID from EMP_REQUESTS where EMPLOYEE_CODE = :APP_EMP_CODE);
end if;

end;

-- ----------------------------------------
-- Page: 35 - List Request overtime for Employee > Dynamic Action: Onclick > Action: Reset page items > Settings > PL/SQL Code

begin
    :P35_EMPLOYEE := null;
    :P35_STATUS := null;
    SELECT TRUNC(SYSDATE, 'YEAR') INTO :P35_FROM_DATE FROM DUAL;
    SELECT TO_CHAR(SYSDATE, 'MM/DD/YYYY') INTO :P35_TO_DATE FROM DUAL;
end;

-- ----------------------------------------
-- Page: 35 - List Request overtime for Employee > Page Item: P35_TO_DATE > Default > SQL Query

SELECT TO_CHAR(SYSDATE, 'MM/DD/YYYY') FROM DUAL;

-- ----------------------------------------
-- Page: 35 - List Request overtime for Employee > Page Item: P35_FROM_DATE > Default > SQL Query

SELECT TRUNC(SYSDATE, 'YEAR') FROM DUAL;

-- ----------------------------------------
-- Page: 35 - List Request overtime for Employee > Page Item: P35_STATUS > List of Values > SQL Query

select status,id from STATUS;

-- ----------------------------------------
-- Page: 35 - List Request overtime for Employee > Page Item: P35_EMPLOYEE > Default > SQL Query

select full_name from employees where employee_code = :APP_EMP_CODE;

