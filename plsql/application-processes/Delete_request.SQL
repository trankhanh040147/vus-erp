declare
v_request_id number;
begin
v_request_id := apex_application.g_x01;
-- update EMPLOYEE_REQUESTS set IS_DEL = 1 where ID = v_request_id;
for rec in (select CRF_DAY_TEMP,ANNUAL_DAY_TEMP,EMPLOYEE_CODE_REQ,BENEFIT_CODE from EMPLOYEE_REQUESTS er where id = v_request_id)loop
    update ABSENCE_GROUP_EMPLOYEE age
                set CARRY_FORWARD_USED = CARRY_FORWARD_USED - rec.CRF_DAY_TEMP,
                CARRY_FORWARD_AVALABLE = CARRY_FORWARD_AVALABLE + rec.CRF_DAY_TEMP,
                AVAILABLE = AVAILABLE + rec.ANNUAL_DAY_TEMP,
                PLAN_YEAR_USED = PLAN_YEAR_USED - rec.ANNUAL_DAY_TEMP
    where EMPLOYEE_CODE = rec.EMPLOYEE_CODE_REQ and trim(lower(rec.BENEFIT_CODE)) like '%' || trim(lower(age.BENEFIT_ACCRUAL_PLAN)) || '%';
end loop;

delete from EMPLOYEE_REQUESTS where ID = v_request_id;

end;