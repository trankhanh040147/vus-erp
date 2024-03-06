declare
v_request_id number;
v_action nvarchar2(100);
v_day_temp number:=0;

begin
for rec in (select * from ABSENCE_GROUP_EMPLOYEE eal 
where eal.EMPLOYEE_CODE = :APP_EMP_CODE and EXPIRATION_DATE >= to_char(sysdate,'MM/DD/YYYY')
and eal.HRM_ABSENCE_CODE_GROUP_ID = :P10_ANNUAL_LEAVE 
)loop
if rec.HRM_ABSENCE_CODE_ID like 'ALPL%' then
    if rec.CARRY_FORWARD_AVALABLE > 0 and :P10_TOTAL_DAYS <= rec.AVAILABLE then
    --update EMPLOYEE_REQUESTS set emp_req_status = 3,man_res_status = 3 where id = rec.id;
        if rec.CARRY_FORWARD > 0 and :P10_TOTAL_DAYS <= rec.CARRY_FORWARD_AVALABLE then
                update ABSENCE_GROUP_EMPLOYEE 
                set CARRY_FORWARD_USED = rec.CARRY_FORWARD_USED + :P10_TOTAL_DAYS,
                DAY_APPROVE = sysdate,
                CARRY_FORWARD_AVALABLE = rec.CARRY_FORWARD_AVALABLE - :P10_TOTAL_DAYS
                where EMPLOYEE_CODE = rec.EMPLOYEE_CODE and EXPIRATION_DATE >= to_char(sysdate,'MM/DD/YYYY') 
                and rec.HRM_ABSENCE_CODE_GROUP_ID = HRM_ABSENCE_CODE_GROUP_ID;
        else
            if rec.CARRY_FORWARD_AVALABLE > 0 and :P10_TOTAL_DAYS > rec.CARRY_FORWARD_AVALABLE then
                v_day_temp := :P10_TOTAL_DAYS - rec.CARRY_FORWARD;
                update ABSENCE_GROUP_EMPLOYEE 
                set PLAN_YEAR_USED = rec.PLAN_YEAR_USED + v_day_temp,
                AVAILABLE = rec.AVAILABLE - v_day_temp,
                DAY_APPROVE = sysdate,
                CARRY_FORWARD_USED = rec.CARRY_FORWARD,
                CARRY_FORWARD_AVALABLE = 0
                where EMPLOYEE_CODE = rec.EMPLOYEE_CODE and EXPIRATION_DATE >= to_char(sysdate,'MM/DD/YYYY') 
                and rec.HRM_ABSENCE_CODE_GROUP_ID = HRM_ABSENCE_CODE_GROUP_ID;
            else
                update ABSENCE_GROUP_EMPLOYEE 
                set PLAN_YEAR_USED = rec.PLAN_YEAR_USED + :P10_TOTAL_DAYS,
                AVAILABLE = rec.AVAILABLE - :P10_TOTAL_DAYS,
                DAY_APPROVE = sysdate
                where EMPLOYEE_CODE = rec.EMPLOYEE_CODE and EXPIRATION_DATE >= to_char(sysdate,'MM/DD/YYYY') 
                and rec.HRM_ABSENCE_CODE_GROUP_ID = HRM_ABSENCE_CODE_GROUP_ID;
            end if;
        end if;
    end if;
end if;
end loop;
end;