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
-- Page: 6 - My Payslips History > Page Item: P6_MONTH > List of Values > SQL Query

select level as month,
level as id
from dual
connect by level <= 12;

-- ----------------------------------------
-- Page: 6 - My Payslips History > Process: Get info payslip > Source > PL/SQL Code

declare 
    resp CLOB;
    n_worker_id NVARCHAR2(50);
begin
SELECT WORKER_ID into n_worker_id FROM EMPLOYEES where EMPLOYEE_CODE = :APP_EMP_CODE;
for rec in (select * from EMPLOYEES where EMPLOYEE_CODE = :APP_EMP_CODE)loop
SP_GET_ONE_PAYSLIP(
        --'V01',
        rec.DATAAREA,
        n_worker_id,
        :P6_YEAR,
        :P6_MONTH,
        resp
);
:P6_RESPONSE := resp;
end loop;
--return resp;
end;

-- ----------------------------------------
-- Page: 6 - My Payslips History > Validation: Check ID > Validation > PL/SQL Function Body

declare
n_check number:=0;
begin
select count(ID_NUMBER) into n_check from EMP_ID_NUMBER where employee_code = :APP_EMP_CODE and ID_NUMBER = :P6_ID_NUMBER;
if n_check > 0 then
    return true;
else
    return false;
end if;
end;

-- ----------------------------------------
-- Page: 6 - My Payslips History > Page Item: P6_YEAR > Default > SQL Query

select to_number(to_char(sysdate,'YYYY')) from dual;

-- ----------------------------------------
-- Page: 6 - My Payslips History > Page Item: P6_YEAR > List of Values > SQL Query

with temp as (
select to_char(sysdate,'YYYY')-level+1 as year,
to_char(sysdate,'YYYY')-level+1 as id
from dual
connect by level <= 10
)

select * from temp order by year desc;

-- ----------------------------------------
-- Page: 6 - My Payslips History > Page Item: P6_MONTH > Default > SQL Query

select to_number(to_char(sysdate,'MM')) from dual;

