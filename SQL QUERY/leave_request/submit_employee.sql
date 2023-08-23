declare
v_request_id_temp number:=1;
v_name_type nvarchar2(100);
v_benefit_code nvarchar2(100):='';
v_annual_temp float:=0;
v_crf_temp float:=0;
begin

for rec in ( select * from ABSENCE_GROUP_EMPLOYEE where employee_code = :APP_EMP_CODE and EXPIRATION_DATE >= to_char(sysdate,'MM/DD/YYYY'))loop
    if rec.CARRY_FORWORD_EXP_DATE >= to_char(sysdate,'MM/DD/YYYY') then
        -- CF not expired
        if  :P3_TOTAL_DAYS <= rec.CARRY_FORWARD_AVALABLE and rec.CARRY_FORWARD_AVALABLE > 0 then
            -- CF enough
            v_benefit_code := rec.CARRY_FORWARD_CODE;
            v_crf_temp := :P3_TOTAL_DAYS;
        elsif rec.CARRY_FORWARD_AVALABLE > 0 and :P3_TOTAL_DAYS > rec.CARRY_FORWARD_AVALABLE then
            -- CF not enough
            v_benefit_code := rec.BENEFIT_ACCRUAL_PLAN||','||rec.CARRY_FORWARD_CODE;
            v_crf_temp := rec.CARRY_FORWARD_AVALABLE;
            v_annual_temp := :P3_TOTAL_DAYS - rec.CARRY_FORWARD_AVALABLE;
        else 
            -- CF not expired, CF = 0
            v_benefit_code := rec.BENEFIT_ACCRUAL_PLAN;
            v_annual_temp := :P3_TOTAL_DAYS;
        end if;
    else
        v_benefit_code := rec.BENEFIT_ACCRUAL_PLAN;
        v_annual_temp := :P3_TOTAL_DAYS;
    end if;
end loop;

select "REQUEST_ID".nextval into v_request_id_temp from sys.dual; 
insert into EMPLOYEE_REQUESTS (
    REQUESTOR_ID,REQUEST_ID,EMPLOYEE_CODE_REQ,EMPLOYEE_NAME,FROM_DATE,
    END_DATE,ALL_DAY,NOTE,TOTAL_DAYS,EMP_REQ_STATUS,LEAVE_TYPE,RESPONSER_ID,TARGET_CODE,
    START_TIME,END_TIME,SUBMIT_DATE,BENEFIT_CODE,CRF_DAY_TEMP,ANNUAL_DAY_TEMP
    ) values (
        :APP_USER_ID,v_request_id_temp,:P3_EMPLOYEE_CODE,:P3_EMPLOYEE,:P3_FROM_DATE,
        :P3_END_DATE,to_char(:P3_ALL_DAY),:P3_NOTE,:P3_TOTAL_DAYS,2,:P3_ANNUAL_LEAVE,:P3_APPROVED_MANAGER,:P3_MANAGER_CODE,
        :P3_START_TIME,:P3_END_TIME,sysdate,v_benefit_code,v_crf_temp,v_annual_temp
        );

end;