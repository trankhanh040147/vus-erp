declare
v_request_id_temp number:=1;
v_id NUMBER:=1;
v_name_type nvarchar2(100);
v_benefit_code nvarchar2(100):='';
v_annual_temp float:=0;
v_crf_temp float:=0;
manager_email nvarchar2(100);
manager_name nvarchar2(100);
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
        elsif rec.CARRY_FORWARD_AVALABLE <= 0 THEN
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

-- Insert leave request
-- insert into EMPLOYEE_REQUESTS (
--     REQUESTOR_ID,REQUEST_ID,EMPLOYEE_CODE_REQ,EMPLOYEE_NAME,FROM_DATE,
--     END_DATE,ALL_DAY,NOTE,TOTAL_DAYS,EMP_REQ_STATUS,LEAVE_TYPE,RESPONSER_ID,TARGET_CODE,
--     START_TIME,END_TIME,SUBMIT_DATE,BENEFIT_CODE,CRF_DAY_TEMP,ANNUAL_DAY_TEMP,ATTACH_NAME,ATTATCH_FILE
--     ) values (
--         :APP_USER_ID,v_request_id_temp,:P3_EMPLOYEE_CODE,:P3_EMPLOYEE,:P3_FROM_DATE,
--         :P3_END_DATE,to_char(:P3_ALL_DAY),:P3_NOTE,:P3_TOTAL_DAYS,2,:P3_ANNUAL_LEAVE,:P3_APPROVED_MANAGER,:P3_MANAGER_CODE,
--         :P3_START_TIME,:P3_END_TIME,sysdate,v_benefit_code,v_crf_temp,v_annual_temp,nvl(:P3_NAME_FILES,''),nvl(:P3_URL_FILES,'#')
--         ); 
--     returning ID into v_id;

    -- Insert a leave request and retrieve the ID into v_id
    insert into EMPLOYEE_REQUESTS (
        REQUESTOR_ID,REQUEST_ID,EMPLOYEE_CODE_REQ,EMPLOYEE_NAME,FROM_DATE,
        END_DATE,ALL_DAY,NOTE,TOTAL_DAYS,EMP_REQ_STATUS,LEAVE_TYPE,RESPONSER_ID,TARGET_CODE,
        START_TIME,END_TIME,SUBMIT_DATE,BENEFIT_CODE,CRF_DAY_TEMP,ANNUAL_DAY_TEMP,ATTACH_NAME,ATTATCH_FILE
    ) values (
        :APP_USER_ID,v_request_id_temp,:P3_EMPLOYEE_CODE,:P3_EMPLOYEE,:P3_FROM_DATE,
        :P3_END_DATE,to_char(:P3_ALL_DAY),:P3_NOTE,:P3_TOTAL_DAYS,2,:P3_ANNUAL_LEAVE,:P3_APPROVED_MANAGER,:P3_MANAGER_CODE,
        :P3_START_TIME,:P3_END_TIME,sysdate,v_benefit_code,v_crf_temp,v_annual_temp,nvl(:P3_NAME_FILES,''),nvl(:P3_URL_FILES,'#')
    ) returning ID into v_id;

-- Send mail

SELECT USER_NAME, FULL_NAME INTO manager_email, manager_name FROM EMPLOYEES WHERE (SELECT MANAGER_ID FROM EMPLOYEES WHERE EMPLOYEE_CODE = :P3_EMPLOYEE_CODE) = EMPLOYEE_CODE;
    
    --For employee
SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', :APP_USER_NAME, 'Leave Request Submitted Successfully', '<p> Dear '|| :P3_EMPLOYEE ||', </p>' ||
'<p> Your leave request has been submitted successfully. Here are the details: </p>' ||
'<p> Employee Code: '|| :P3_EMPLOYEE_CODE ||' </p>' ||
'<p> Total Days: '|| :P3_TOTAL_DAYS ||' </p>' ||
'<p> From Date: '|| :P3_FROM_DATE ||' </p>' ||
'<p> To Date: '|| :P3_END_DATE ||' </p>' ||
'<br>' || 
'<p> If you have any questions or need further assistance, please feel free to reach out to the HR department. </p>' ||
'<br>' || 
'<p> Thank you, </p>' ||
'<p> VUS </p>');


    --For manager
SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', manager_email, 'Leave Request Approval Required', '<p>Dear '|| manager_name ||',</p>' ||
    '<p>A leave request from '|| :P3_EMPLOYEE ||' requires your approval. Here are the details:</p>' ||
    '<p>Employee Code: '|| :P3_EMPLOYEE_CODE ||'</p>' ||
    '<p>Total Days: '|| :P3_TOTAL_DAYS ||'</p>' ||
    '<p>From Date: '|| :P3_FROM_DATE ||'</p>' ||
    '<p>To Date: '|| :P3_END_DATE ||'</p>' ||
    '<br>' || 
    '<p>Please log in to the leave management system to review and approve the request. You can approve the leave by clicking on the following link: <a href=\"https://erp-uat.vus.edu.vn/ords/r/erp/erp/approve-leave?request_id=' || to_char(v_id) || '\"> link to approve the leave ↗.</a></p>' ||
    '<br>' || 
    '<p>If you have any questions or need further information, please contact the HR department.</p>' ||
    '<br>' || 
    '<p>Thank you,</p>' ||'<p>VUS</p>');

end;