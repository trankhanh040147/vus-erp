declare
v_request_id_temp number:=1;
v_name_type nvarchar2(100);
v_benefit_code nvarchar2(100):='';
v_annual_temp float:=0;
v_crf_temp float:=0;
begin

for rec in ( select * from ABSENCE_GROUP_EMPLOYEE where employee_code = :APP_EMP_CODE and EXPIRATION_DATE >= to_char(sysdate,'MM/DD/YYYY'))loop
    if rec.CARRY_FORWORD_EXP_DATE >= to_char(sysdate,'MM/DD/YYYY')  then
        if  :P10_TOTAL_DAYS <= rec.CARRY_FORWARD_AVALABLE and rec.CARRY_FORWARD_AVALABLE > 0 then
            v_benefit_code := rec.CARRY_FORWARD_CODE;
            v_crf_temp := :P10_TOTAL_DAYS;
            else
            v_benefit_code := rec.BENEFIT_ACCRUAL_PLAN||','||rec.CARRY_FORWARD_CODE;
            v_crf_temp := rec.CARRY_FORWARD_AVALABLE;
            v_annual_temp := :P10_TOTAL_DAYS - rec.CARRY_FORWARD_AVALABLE;
            end if;
        else
        v_benefit_code := rec.BENEFIT_ACCRUAL_PLAN;
        v_annual_temp := :P10_TOTAL_DAYS;
    end if;
end loop;

select "REQUEST_ID".nextval into v_request_id_temp from sys.dual; 
insert into EMPLOYEE_REQUESTS (
    REQUESTOR_ID,REQUEST_ID,EMPLOYEE_CODE_REQ,EMPLOYEE_NAME,FROM_DATE,
    END_DATE,ALL_DAY,NOTE,TOTAL_DAYS,EMP_REQ_STATUS,LEAVE_TYPE,RESPONSER_ID,TARGET_CODE,
    START_TIME,END_TIME,SUBMIT_DATE,BENEFIT_CODE,CRF_DAY_TEMP,ANNUAL_DAY_TEMP,ATTACH_NAME,ATTATCH_FILE
    ) values (
        :APP_USER_ID,v_request_id_temp,:P10_EMPLOYEE_CODE,:P10_EMPLOYEE,:P10_FROM_DATE,
        :P10_END_DATE,to_char(:P10_ALL_DAY),:P10_NOTE,:P10_TOTAL_DAYS,2,:P10_ANNUAL_LEAVE,:P10_APPROVED_MANAGER,:P10_MANAGER_CODE,
        :P10_START_TIME,:P10_END_TIME,sysdate,v_benefit_code,v_crf_temp,v_annual_temp,:P10_NAME_FILES,:P10_URL_FILES
        );
        /*
for rec in (select NAME FROM REQUEST_TYPE where id = :P10_ANNUAL_LEAVE)loop
    v_name_type := rec.NAME;
end loop;
SP_CREATE_LEAVER_REQUEST(:P10_TOTAL_DAYS,v_name_type,:P10_FROM_DATE,:P10_NOTE,:P10_EMPLOYEE_CODE,:P10_ANNUAL_LEAVE);
*/
end;