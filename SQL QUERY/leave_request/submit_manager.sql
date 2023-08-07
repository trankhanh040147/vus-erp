declare
v_request_id_temp number:=1;
v_name_type nvarchar2(100);
begin
select "REQUEST_ID".nextval into v_request_id_temp from sys.dual; 
insert into EMPLOYEE_REQUESTS (
    REQUESTOR_ID,REQUEST_ID,EMPLOYEE_CODE_REQ,EMPLOYEE_NAME,FROM_DATE,
    END_DATE,ALL_DAY,NOTE,TOTAL_DAYS,EMP_REQ_STATUS,LEAVE_TYPE,RESPONSER_ID,TARGET_CODE
    ) values (
        :APP_USER_ID,v_request_id_temp,:P10_EMPLOYEE_CODE,:P10_EMPLOYEE,:P10_FROM_DATE,
        :P10_END_DATE,:P10_ALL_DAY,:P10_NOTE,:P10_TOTAL_DAYS,2,:P10_ANNUAL_LEAVE,:P10_APPROVED_MANAGER,:P10_MANAGER_CODE
        );
        /*
for rec in (select NAME FROM REQUEST_TYPE where id = :P10_ANNUAL_LEAVE)loop
    v_name_type := rec.NAME;
end loop;
SP_CREATE_LEAVER_REQUEST(:P10_TOTAL_DAYS,v_name_type,:P10_FROM_DATE,:P10_NOTE,:P10_EMPLOYEE_CODE,:P10_ANNUAL_LEAVE);
*/
end;