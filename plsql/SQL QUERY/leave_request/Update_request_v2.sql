declare
v_request_id number;
v_action nvarchar2(100);
v_day_temp number:=0;

r_name_type nvarchar2(100);
r_AdjustedHours FLOAT(10);
r_AdjustmentType number;
r_TransactionDate date;
r_Description nvarchar2(100);
r_EmployeeCode nvarchar2(100);
r_HRMAbsenceCodeGroupId nvarchar2(100);
r_HRMAbsenceCodeId nvarchar2(100);
r_IDPortal NUMBER;



begin
v_request_id := apex_application.g_x01;

--v_action := apex_application.g_x02;
--update EMPLOYEE_REQUESTS set IS_DEL = 1 where request_id = v_request_id;
/*
for rec in (select * from EMP_ANNUAL_LEAVE eal join EMPLOYEE_REQUESTS er on er.REQUESTOR_ID =  eal.EMPLOYEE_ID where er.id = v_request_id)loop
    if (rec.LEAVE_BALANCE + rec.LEVEA_OLD_YEAR) > 0 and rec.total_days <= (rec.LEAVE_BALANCE + rec.LEVEA_OLD_YEAR) then
    update EMPLOYEE_REQUESTS set emp_req_status = 3,man_res_status = 3 where id = v_request_id;
        if rec.total_days <= rec.LEVEA_OLD_YEAR then
            update EMP_ANNUAL_LEAVE 
            set LEAVE_USED_OLD = rec.LEAVE_USED_OLD + rec.total_days,
            DATE_APPLY=sysdate,
            LEVEA_OLD_YEAR=rec.LEVEA_OLD_YEAR-rec.total_days
        where employee_id = rec.employee_id;
        else
            v_day_temp := rec.total_days - rec.LEVEA_OLD_YEAR;
            update EMP_ANNUAL_LEAVE 
            set USED = rec.USED + v_day_temp,
            LEAVE_BALANCE=rec.LEAVE_ENTITLEMENT-rec.USED-v_day_temp,
            DATE_APPLY=sysdate,
            LEVEA_OLD_YEAR=0,
            LEAVE_USED_OLD=rec.LEAVE_USED_OLD + rec.LEVEA_OLD_YEAR
        where employee_id = rec.employee_id;
        end if;
    end if;
end loop;
*/

/*for rec in (select * from ABSENCE_GROUP_EMPLOYEE eal join EMPLOYEE_REQUESTS er on er.EMPLOYEE_CODE_REQ =  eal.EMPLOYEE_CODE 
where er.id = v_request_id and EXPIRATION_DATE >= to_char(sysdate,'MM/DD/YYYY'))loop
    if rec.AVAILABLE > 0 and rec.total_days <= rec.AVAILABLE then*/
    
    /*
        if rec.total_days <= rec.CARRY_FORWARD then
            begin
                update ABSENCE_GROUP_EMPLOYEE 
                set CARRY_FORWARD_USED = rec.CARRY_FORWARD_USED + rec.total_days,
                DAY_APPROVE = sysdate,
                CARRY_FORWARD = rec.CARRY_FORWARD - rec.total_days
                where EMPLOYEE_CODE = rec.EMPLOYEE_CODE and EXPIRATION_DATE >= to_char(sysdate,'MM/DD/YYYY');
*/
                for rec in (select * FROM EMPLOYEE_REQUESTS where id = v_request_id) loop
                    r_AdjustedHours := rec.TOTAL_DAYS;
                    r_AdjustmentType := 10;
                    r_TransactionDate := rec.FROM_DATE;
                    r_Description := rec.NOTE;
                    r_EmployeeCode := rec.EMPLOYEE_CODE_REQ;
                    r_HRMAbsenceCodeGroupId := rec.LEAVE_TYPE;
                    r_IDPortal := rec.ID;
                end loop;
                update EMPLOYEE_REQUESTS set emp_req_status = 3,man_res_status = 3 where id = v_request_id;
                SP_CREATE_LEAVE_REQUEST_V2(
                    TO_CHAR(r_AdjustedHours), 
                    TO_CHAR(r_AdjustmentType), 
                    TO_CHAR(r_TransactionDate, 'MM-DD-YYYY'), 
                    r_Description, r_EmployeeCode, r_HRMAbsenceCodeGroupId, 
                    TO_CHAR(r_IDPortal)
                );
                /*
            end;
        else
            v_day_temp := rec.total_days - rec.CARRY_FORWARD;
            update ABSENCE_GROUP_EMPLOYEE 
            set PLAN_YEAR_USED = rec.PLAN_YEAR_USED + v_day_temp,
            AVAILABLE = rec.PLAN_YEAR_ACCRUED - rec.PLAN_YEAR_USED - v_day_temp,
            DAY_APPROVE = sysdate,
            CARRY_FORWARD = 0,
            CARRY_FORWARD_USED = rec.CARRY_FORWARD_USED + rec.CARRY_FORWARD
        where EMPLOYEE_CODE = rec.EMPLOYEE_CODE and EXPIRATION_DATE >= to_char(sysdate,'MM/DD/YYYY');
        end if;*/
    --end if;
--end loop;
end;