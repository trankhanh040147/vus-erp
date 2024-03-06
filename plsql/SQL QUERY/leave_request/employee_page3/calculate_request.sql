-- declare
-- v_request_id number;
-- v_action nvarchar2(100);
-- v_day_temp number:=0;

-- begin

-- for rec in (select * from ABSENCE_GROUP_EMPLOYEE eal 
-- join (
--     select * from EMPLOYEE_REQUESTS where EMPLOYEE_CODE_REQ = :APP_EMP_CODE 
--     order by submit_date desc
--     FETCH FIRST 1 ROWS ONLY
-- ) er on er.EMPLOYEE_CODE_REQ = eal.employee_code 
-- where eal.EMPLOYEE_CODE = :APP_EMP_CODE and EXPIRATION_DATE >= to_char(sysdate,'MM/DD/YYYY')
-- and eal.HRM_ABSENCE_CODE_GROUP_ID = :P3_ANNUAL_LEAVE 
-- )loop
-- if rec.HRM_ABSENCE_CODE_GROUP_ID = 'APL' then
-- update ABSENCE_GROUP_EMPLOYEE 
--                 set CARRY_FORWARD_USED = rec.CARRY_FORWARD_USED + rec.CRF_DAY_TEMP,
--                 DAY_APPROVE = sysdate,
--                 CARRY_FORWARD_AVALABLE = rec.CARRY_FORWARD_AVALABLE - rec.CRF_DAY_TEMP,
--                 AVAILABLE = rec.AVAILABLE - rec.ANNUAL_DAY_TEMP,
--                 PLAN_YEAR_USED = rec.PLAN_YEAR_USED + rec.ANNUAL_DAY_TEMP
--                 where EMPLOYEE_CODE = rec.EMPLOYEE_CODE and EXPIRATION_DATE >= to_char(sysdate,'MM/DD/YYYY') ;

-- end if;
-- end loop;
-- end;


declare
v_request_id number;
v_action nvarchar2(100);
v_day_temp number:=0;

v_balance number:=0;

begin


-- Update used day and available balance ABSENCE_GROUP_EMPLOYEE

for rec in (select * from ABSENCE_GROUP_EMPLOYEE eal 
    join (
        select * from EMPLOYEE_REQUESTS where EMPLOYEE_CODE_REQ = :APP_EMP_CODE
        AND ID = to_number(:P3_REQUEST_ID_IMPORTED)
    ) er on er.EMPLOYEE_CODE_REQ = eal.employee_code 
    where eal.EMPLOYEE_CODE = :APP_EMP_CODE and EXPIRATION_DATE >= to_char(sysdate,'MM/DD/YYYY')
    and eal.HRM_ABSENCE_CODE_GROUP_ID = :P3_ANNUAL_LEAVE 
)loop
    if rec.HRM_ABSENCE_CODE_GROUP_ID = 'APL' then
    update ABSENCE_GROUP_EMPLOYEE 
                    set CARRY_FORWARD_USED = rec.CARRY_FORWARD_USED + rec.CRF_DAY_TEMP,
                    DAY_APPROVE = sysdate,
                    CARRY_FORWARD_AVALABLE = rec.CARRY_FORWARD_AVALABLE - rec.CRF_DAY_TEMP,
                    AVAILABLE = rec.AVAILABLE - rec.ANNUAL_DAY_TEMP,
                    PLAN_YEAR_USED = rec.PLAN_YEAR_USED + rec.ANNUAL_DAY_TEMP
                    where EMPLOYEE_CODE = rec.EMPLOYEE_CODE and EXPIRATION_DATE >= to_char(sysdate,'MM/DD/YYYY') ;

    end if;
end loop;

-- Update balance day in EMPLOYEE_REQUESTS

for rec in (select * from ABSENCE_GROUP_EMPLOYEE 
emp_al
right JOIN EMPLOYEES e ON emp_al.EMPLOYEE_CODE = e.EMPLOYEE_CODE
where e.EMPLOYEE_CODE = :APP_EMP_CODE and EXPIRATION_DATE >= to_char(sysdate,'MM/DD/YYYY') 
 and HRM_ABSENCE_CODE_GROUP_ID = :P3_ANNUAL_LEAVE and HRM_ABSENCE_CODE_GROUP_ID = 'APL'
)loop
    if rec.CARRY_FORWORD_EXP_DATE >= to_char(sysdate,'MM/DD/YYYY')  then
        v_balance := rec.AVAILABLE + rec.CARRY_FORWARD_AVALABLE;
    else
        v_balance := rec.AVAILABLE;
    end if;
end loop;

update EMPLOYEE_REQUESTS set LEAVE_BALANCE = v_balance where ID = to_number(:P3_REQUEST_ID_IMPORTED);

end;