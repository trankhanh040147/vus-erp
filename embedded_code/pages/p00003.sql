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
-- Page: 3 - Leave Request for Employee > Page Item: P3_APPROVED_MANAGER > List of Values > SQL Query

SELECT FULL_NAME,EMPLOYEE_ID as ID FROM EMPLOYEES WHERE POSITION_ID = (
select MANAGER_POSITION_ID FROM EMPLOYEES WHERE EMPLOYEE_CODE = :APP_EMP_CODE );

-- ----------------------------------------
-- Page: 3 - Leave Request for Employee > Process: Calculate request > Source > PL/SQL Code

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

-- ----------------------------------------
-- Page: 3 - Leave Request for Employee > Process: Calculate request > Server-side Condition (Function Body) > PL/SQL Function Body

declare
    v_count number:=0;
begin
select count(id) into v_count from ABSENCE_GROUP_EMPLOYEE where EMPLOYEE_CODE = :APP_EMP_CODE and EXPIRATION_DATE >= to_char(sysdate,'MM/DD/YYYY');
if v_count > 0 then
    return true;
else
    return false;
end if;
end;

-- ----------------------------------------
-- Page: 3 - Leave Request for Employee > Process: Save when submit > Source > PL/SQL Code

declare
v_request_id_temp number:=1;
v_id NUMBER:=1;
v_name_type nvarchar2(100);
v_benefit_code nvarchar2(100):='';
v_annual_temp float:=0;
v_crf_temp float:=0;
manager_email nvarchar2(100);
manager_name nvarchar2(100);
requester_schedule NVARCHAR2(50);
v_body_emp clob := '';
v_body_man clob:= '';
begin

    requester_schedule := LOWER(TRIM(:P3_LEAVE_TYPE_DEPT));

    -- Waiting for the end to come
    -- dbms_session.sleep(1);

    -- INSERT INTO DEMO_ATTACHMENT(URL) VALUES(:P3_URL_FILES);


    if :P3_ANNUAL_LEAVE = 'APL' then
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
    else 
        v_annual_temp := :P3_TOTAL_DAYS;
        v_benefit_code := :P3_LEAVE_DETAIL;
    end if;

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
            START_TIME,END_TIME,SUBMIT_DATE,BENEFIT_CODE,CRF_DAY_TEMP,ANNUAL_DAY_TEMP,ATTACH_NAME,ATTATCH_FILE, LEAVE_BALANCE
        ) values (
            :APP_USER_ID,v_request_id_temp,:P3_EMPLOYEE_CODE,:P3_EMPLOYEE,to_date(:P3_FROM_DATE, 'DD/MM/YYYY'),
            CASE WHEN :P3_END_DATE IS NULL OR :P3_END_DATE = '' THEN to_date(:P3_FROM_DATE, 'DD/MM/YYYY') ELSE to_date(:P3_END_DATE, 'DD/MM/YYYY') END,to_char(:P3_ALL_DAY),:P3_NOTE,:P3_TOTAL_DAYS,2,:P3_ANNUAL_LEAVE,:P3_APPROVED_MANAGER,:P3_MANAGER_CODE,
            CASE WHEN requester_schedule = 'ho' THEN :P3_START_TIME_HO ELSE :P3_START_TIME END,:P3_END_TIME,sysdate,v_benefit_code,v_crf_temp,v_annual_temp,nvl(:P3_NAME_FILES,''),:P3_URL_FILES, :P3_ANNUAL_LEAVE_BALANCE
        ) returning ID into v_id;

    :P3_REQUEST_ID_IMPORTED := v_id;


    -- -- -- Log data into tables
    -- INSERT INTO OUTPUT_LOGS(DATE1, DATE2, STR1, STR2)
    -- VALUES (TO_DATE(:P3_FROM_DATE, 'DD/MM/YYYY'),TO_DATE(:P3_END_DATE, 'DD/MM/YYYY'), :P3_FROM_DATE, :P3_END_DATE);


    -- Send mail

    SELECT USER_NAME, FULL_NAME INTO manager_email, manager_name FROM EMPLOYEES WHERE (SELECT MANAGER_ID FROM EMPLOYEES WHERE EMPLOYEE_CODE = :P3_EMPLOYEE_CODE) = EMPLOYEE_CODE;
        
    --For employee

    -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'thviet615@gmail.com', 'Leave Request Submitted Successfully', '<p> Dear '|| :P3_EMPLOYEE ||', </p>' ||
    -- -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', :APP_USER_NAME, 'Leave Request Submitted Successfully', '<p> Dear '|| :P3_EMPLOYEE ||', </p>' ||
    -- '<p>Successfully submitted. Kindly return <b>My leave history page</b> to follow your leave request. Here are the details: </p>' ||
    -- '<p>Employee Code: '|| :P3_EMPLOYEE_CODE ||' </p>' ||
    -- -- '<p> Total Days: '|| CASE
    -- --            WHEN :P3_TOTAL_DAYS = 0.5 THEN to_char(:P3_TOTAL_DAYS, '0.0')
    -- --            ELSE :P3_TOTAL_DAYS
    -- --        END ||' </p>' ||
    -- '<p>Total Days: '|| to_char(:P3_TOTAL_DAYS, '0.0') ||' </p>' ||
    -- '<p>From Date: '|| :P3_FROM_DATE ||' </p>' ||
    -- '<p>To Date: '|| :P3_END_DATE ||' </p>' ||
    -- '<br>' || 
    -- '<p>If you have any questions or need further assistance, please feel free to reach out to the HR department. </p>' ||
    -- '<br>' || 
    -- '<p>Thank you, </p>' ||
    -- '<p>VUS </p>');

    -- v_body_emp := v_body_emp || '<img style=''width:100%'' src=''https://hcm01.vstorage.vngcloud.vn/v1/AUTH_77c1e15122904b63990a9da99711590d/LXP_Media/ERP/images/header.png''></img>';
    v_body_emp := v_body_emp || '<h3 style=''color:black;text-align:center''>[PHÒNG NHÂN SỰ HÀNH CHÍNH - VUS] – ĐƠN XIN NGHỈ PHÉP</h3>';
    v_body_emp := v_body_emp || '<h3 style=''color:black;text-align:center''>[HRA DEPARTMENT - VUS] – REQUEST FOR LEAVE LETTER</h3>';
    v_body_emp := v_body_emp || '<p style=''color:black;margin-top:20px''>Anh/Chị '|| :P3_EMPLOYEE ||' thân mến,</p>';
    v_body_emp := v_body_emp || '<p style=''color:black;margin-top:0''>Dear Mr/Ms. '|| :P3_EMPLOYEE ||',</p>';
    v_body_emp := v_body_emp || '<p style=''color:black''>Hệ thống nhận được đề nghị xin nghỉ phép của nhân viên như sau:</p>';
    v_body_emp := v_body_emp || '<p style=''color:black''>Employee Portal system has received a request for leave as below:</p>';
    v_body_emp := v_body_emp || '<ul>';
    v_body_emp := v_body_emp || '<p style=''color:black''><strong style=''color:black''>- Họ và tên/ Full name:</strong> '|| :P3_EMPLOYEE ||'</p>';
    v_body_emp := v_body_emp || '<p style=''color:black''><strong style=''color:black''>- Mã số nhân viên/ Employee Code:</strong> '|| :P3_EMPLOYEE_CODE ||'</p>';
    v_body_emp := v_body_emp || '<p style=''color:black''><strong style=''color:black''>- Loại phép/ Leave Type:</strong> '|| :P3_ANNUAL_LEAVE ||'</p>';
    if (:P3_TOTAL_DAYS <= 0.5) then
        v_body_emp := v_body_emp || '<p style=''color:black''><strong style=''color:black''>- Tổng Số Ngày/ Total Days:</strong> '|| to_char(:P3_TOTAL_DAYS, '0.0') ||'</p>';
        v_body_emp := v_body_emp || '<p style=''color:black''><strong style=''color:black''>- Từ Ngày/ From Date:</strong> '|| :P3_FROM_DATE ||'</p>';
        v_body_emp := v_body_emp || '<p style=''color:black''><strong style=''color:black''>- Đến Ngày/ To Date:</strong> '|| :P3_END_DATE ||'</p>';
        v_body_emp := v_body_emp || '<p style=''color:black''><strong style=''color:black''>- Từ/ Start Time:</strong> '|| :P3_START_TIME ||'</p>';
        v_body_emp := v_body_emp || '<p style=''color:black''><strong style=''color:black''>- Đến/ To Time:</strong> '|| :P3_END_TIME ||'</p>';
    else
        v_body_emp := v_body_emp || '<p style=''color:black''><strong style=''color:black''>- Tổng Số Ngày/ Total Days:</strong> '|| :P3_TOTAL_DAYS ||'</p>';
        v_body_emp := v_body_emp || '<p style=''color:black''><strong style=''color:black''>- Từ Ngày/ From Date:</strong> '|| :P3_FROM_DATE ||'</p>';
        v_body_emp := v_body_emp || '<p style=''color:black''><strong style=''color:black''>- Đến Ngày/ To Date:</strong> '|| :P3_END_DATE ||'</p>';
    end if;
    v_body_emp := v_body_emp || '<p style=''color:black''><strong style=''color:black''>- Ghi Chú/ Note:</strong> '|| :P3_NOTE ||'</p>';
    v_body_emp := v_body_emp || '</ul><br>';
    v_body_emp := v_body_emp || '<p style=''color:black''>Đơn xin nghỉ phép của bạn đã được gửi đi thành công!</p>';
    v_body_emp := v_body_emp || '<p style=''color:black''>Your leave request has been successfully submitted!</p>';
    v_body_emp := v_body_emp || '<p style=''color:black''>Phòng Nhân sự Hành chính sẽ xem xét và phản hồi đơn xin nghỉ phép của bạn trong 3 đến 5 ngày làm việc.</p>';
    v_body_emp := v_body_emp || '<p style=''color:black''>HRA department will review and respond your leave request within 3-5 working days.</p>';
    v_body_emp := v_body_emp || '<p style=''color:black''>Vui lòng quay lại ''Lịch sử xin nghỉ phép của tôi'' để theo dõi đơn nghỉ phép của bạn.</p>';
    v_body_emp := v_body_emp || '<p style=''color:black''>Please return to ''My Leave History'' to follow your leave request.</p><br>';

    v_body_emp := v_body_emp || '<p style=''color:black''>Nếu bạn có bất kỳ câu hỏi nào hoặc cần thêm sự hỗ trợ, xin đừng ngần ngại liên hệ với phòng Nhân sự Hành chính.</p>';
    v_body_emp := v_body_emp || '<p style=''color:black''>If you have any questions or need further assistance, please feel free to reach out to the HRA department.</p>';
    v_body_emp := v_body_emp || '<p style=''color:black''>Trân trọng,</p>';
    v_body_emp := v_body_emp || '<p style=''color:black''>Phòng Nhân sự Hành chính</p>';
    v_body_emp := v_body_emp || '<p style=''color:black''>Best regards,</p>';
    v_body_emp := v_body_emp || '<p style=''color:black''>HR & Admin Department </p>';
    -- v_body_emp := v_body_emp || '<img style=''width:100%'' src=''https://hcm01.vstorage.vngcloud.vn/v1/AUTH_77c1e15122904b63990a9da99711590d/LXP_Media/ERP/images/footer.jpg''></img>';

    SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', :APP_USER_NAME, 'Gửi đơn xin nghỉ phép thành công', v_body_emp);
    SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'thviet615@gmail.com', 'Gửi đơn xin nghỉ phép thành công', v_body_emp);

    --For manager

    -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'thviet615@gmail.com', 'Leave Request Approval Required', '<p>Dear '|| manager_name ||',</p>' ||
    -- -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', manager_email, 'Leave Request Approval Required', '<p>Dear '|| manager_name ||',</p>' ||
    --     '<p>A leave request from '|| :P3_EMPLOYEE ||' requires your approval. Here are the details:</p>' ||
    --     '<p>Employee Code: '|| :P3_EMPLOYEE_CODE ||'</p>' ||
    --     -- '<p>Total Days: '|| CASE
    --     --        WHEN :P3_TOTAL_DAYS = 0.5 THEN to_char(:P3_TOTAL_DAYS, '0.0')
    --     --        ELSE :P3_TOTAL_DAYS
    --     --    END ||'</p>' ||
    --     '<p>Total Days: '|| to_char(:P3_TOTAL_DAYS, '0.0') ||' </p>' ||
    --     '<p>From Date: '|| :P3_FROM_DATE ||'</p>' ||
    --     '<p>To Date: '|| :P3_END_DATE ||'</p>' ||
    --     '<br>' || 
    --     '<p>Please log in to the leave management system to review and approve the request. You can approve the leave by clicking on the following link: <a href=\"https://erp-uat.vus.edu.vn/ords/r/erp/erp/approve-leave?request_id=' || to_char(v_id) || '\"> link to approve the leave ↗.</a></p>' ||
    --     '<br>' || 
    --     '<p>If you have any questions or need further information, please contact the HR department.</p>' ||
    --     '<br>' || 
    --     '<p>Thank you,</p>' ||'<p>VUS</p>');

    -- v_body_man := v_body_man || '<img style=''width:100%'' src=''https://hcm01.vstorage.vngcloud.vn/v1/AUTH_77c1e15122904b63990a9da99711590d/LXP_Media/ERP/images/header.png''></img>';
    v_body_man := v_body_man || '<h3 style=''color:black;text-align:center''>[PHÒNG NHÂN SỰ HÀNH CHÍNH - VUS] – ĐƠN XIN NGHỈ PHÉP</h3>';
    v_body_man := v_body_man || '<h3 style=''color:black;text-align:center''>[HRA DEPARTMENT - VUS] – REQUEST FOR LEAVE LETTER</h3>';
    v_body_man := v_body_man || '<p style=''color:black;margin-top:20px''>Anh/Chị '|| manager_name ||' thân mến,</p>';
    v_body_man := v_body_man || '<p style=''color:black;margin-top:0''>Dear Mr/Ms. '|| manager_name ||',</p>';
    v_body_man := v_body_man || '<p style=''color:black''>Hệ thống nhận được đề nghị xin nghỉ phép của nhân viên như sau:</p>';
    v_body_man := v_body_man || '<p style=''color:black''>Employee Portal system has received a request for leave as below:</p>';
    v_body_man := v_body_man || '<ul>';
    v_body_man := v_body_man || '<p style=''color:black''><strong style=''color:black''>- Họ và tên/ Full name:</strong> '|| :P3_EMPLOYEE ||'</p>';
    v_body_man := v_body_man || '<p style=''color:black''><strong style=''color:black''>- Mã số nhân viên/ Employee Code:</strong> '|| :P3_EMPLOYEE_CODE ||'</p>';
    v_body_man := v_body_man || '<p style=''color:black''><strong style=''color:black''>- Loại phép/ Leave Type:</strong> '|| :P3_ANNUAL_LEAVE ||'</p>';
    if (:P3_TOTAL_DAYS <= 0.5) then
        v_body_man := v_body_man || '<p style=''color:black''><strong style=''color:black''>- Tổng Số Ngày/ Total Days:</strong> '|| to_char(:P3_TOTAL_DAYS, '0.0') ||'</p>';
        v_body_man := v_body_man || '<p style=''color:black''><strong style=''color:black''>- Từ Ngày/ From Date:</strong> '|| :P3_FROM_DATE ||'</p>';
        v_body_man := v_body_man || '<p style=''color:black''><strong style=''color:black''>- Đến Ngày/ To Date:</strong> '|| :P3_END_DATE ||'</p>';
        v_body_man := v_body_man || '<p style=''color:black''><strong style=''color:black''>- Từ/ Start Time:</strong> '|| :P3_START_TIME ||'</p>';
        v_body_man := v_body_man || '<p style=''color:black''><strong style=''color:black''>- Đến/ To Time:</strong> '|| :P3_END_TIME ||'</p>';
    else
        v_body_man := v_body_man || '<p style=''color:black''><strong style=''color:black''>- Tổng Số Ngày/ Total Days:</strong> '|| :P3_TOTAL_DAYS ||'</p>';
        v_body_man := v_body_man || '<p style=''color:black''><strong style=''color:black''>- Từ Ngày/ From Date:</strong> '|| :P3_FROM_DATE ||'</p>';
        v_body_man := v_body_man || '<p style=''color:black''><strong style=''color:black''>- Đến Ngày/ To Date:</strong> '|| :P3_END_DATE ||'</p>';
    end if;
    v_body_man := v_body_man || '<p style=''color:black''><strong style=''color:black''>- Ghi Chú/ Note:</strong> '|| :P3_NOTE ||'</p>';
    v_body_man := v_body_man || '</ul><br>';
    v_body_man := v_body_man || '<p style=''color:black''>Vui lòng đăng nhập vào Hệ thống Quản lý nghỉ phép để xem xét và phản hồi yêu cầu. Bạn có thể phản hồi yêu cầu nghỉ phép bằng cách nhấp vào liên kết sau:</p>';
    v_body_man := v_body_man || '<p style=''color:black''>Please log in to The leave management system to review and respond the leave request. You can respond the leave request by clicking on the following link: <a href=\"https://erp-uat.vus.edu.vn/ords/r/erp/erp/approve-leave?request_id=' || to_char(v_id) || '\"> link to respond the leave request ↗.</a></p><br>';

    v_body_man := v_body_man || '<p style=''color:black''>Nếu bạn có bất kỳ câu hỏi nào hoặc cần thêm sự hỗ trợ, xin đừng ngần ngại liên hệ với phòng Nhân sự Hành chính.</p>';
    v_body_man := v_body_man || '<p style=''color:black''>If you have any questions or need further assistance, please feel free to reach out to the HRA department.</p>';
    v_body_man := v_body_man || '<p style=''color:black''>Trân trọng,</p>';
    v_body_man := v_body_man || '<p style=''color:black''>Phòng Nhân sự Hành chính</p>';
    v_body_man := v_body_man || '<p style=''color:black''>Best regards,</p>';
    v_body_man := v_body_man || '<p style=''color:black''>HR & Admin Department </p>';
    -- v_body_man := v_body_man || '<img style=''width:100%'' src=''https://hcm01.vstorage.vngcloud.vn/v1/AUTH_77c1e15122904b63990a9da99711590d/LXP_Media/ERP/images/footer.jpg''></img>';

    SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', manager_email, 'Yêu cầu duyệt đơn nghỉ phép', v_body_man);
    SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'thviet615@gmail.com', 'Yêu cầu duyệt đơn nghỉ phép', v_body_man);

end;

-- ----------------------------------------
-- Page: 3 - Leave Request for Employee > Validation: Check unvalid benefit acrual plan > Validation > PL/SQL Function Body

DECLARE
    l_count_is_exist_benefit NUMBER;
    flag BOOLEAN := true;
BEGIN

    select count(*) into l_count_is_exist_benefit from ABSENCE_GROUP_EMPLOYEE
    where EMPLOYEE_CODE = :APP_EMP_CODE and :P3_LEAVE_DETAIL = HRM_ABSENCE_CODE_ID;
    -- where EMPLOYEE_CODE = :APP_EMP_CODE and :P3_LEAVE_DETAIL = HRM_ABSENCE_CODE_ID and EXPIRATION_DATE > sysdate;
    
    if l_count_is_exist_benefit > 0 then return true;
        else return false;
    end if;
    
END;

-- ----------------------------------------
-- Page: 3 - Leave Request for Employee > Validation: Check 23rd day > Validation > PL/SQL Function Body

declare 
date_23_last_month DATE;
BEGIN
    select to_date('23/'||to_char(add_months(sysdate, -1), 'MM')||'/'||to_char(add_months(sysdate, -1), 'YYYY'), 'DD/MM/YYYY') into date_23_last_month from dual;
    IF(to_date(:P3_FROM_DATE,'DD/MM/YYYY') >= date_23_last_month) THEN
        RETURN TRUE;
    ELSE RETURN FALSE;
    END IF;
END;

-- ----------------------------------------
-- Page: 3 - Leave Request for Employee > Validation: Check overlapping time > Validation > PL/SQL Function Body

DECLARE 
    IS_NOT_OVERLAPPED BOOLEAN := TRUE;
    INP_START_TIME NVARCHAR2(10);
    INP_END_TIME NVARCHAR2(10);
    rec_start NVARCHAR2(10);
    rec_end NVARCHAR2(10);
BEGIN
    INP_START_TIME := TRIM(:P3_START_TIME);
    INP_END_TIME := TRIM(:P3_END_TIME);
    
    FOR rec IN (SELECT start_time, end_time 
                FROM EMPLOYEE_REQUESTS 
                WHERE EMPLOYEE_CODE_REQ = :P3_EMPLOYEE_CODE 
                AND EMP_REQ_STATUS in (2,3)
                AND :P3_ALL_DAY = 'N' 
                AND TO_DATE(:P3_FROM_DATE, 'DD/MM/YYYY') = FROM_DATE)
    LOOP
        rec_start := rec.start_time;
        rec_end := rec.end_time;
        DBMS_OUTPUT.put_line(rec_start || '-' || rec_end);
        
        -- Check if overlap with INP_START_TIME, INP_END_TIME
        IF (INP_START_TIME < rec_end) AND (INP_END_TIME > rec_start) THEN
            -- IS_NOT_OVERLAPPED := TRUE;
            IS_NOT_OVERLAPPED := FALSE;
            EXIT;  -- No need to check further if we found an overlap
        END IF;
    END LOOP;
    

    -- Print IS_NOT_OVERLAPPED 
    -- IF IS_NOT_OVERLAPPED THEN
    --     DBMS_OUTPUT.put_line('The time intervals overlap.');
    -- ELSE
    --     DBMS_OUTPUT.put_line('The time intervals do not overlap.');
    -- END IF;

    RETURN IS_NOT_OVERLAPPED;

END;

-- ----------------------------------------
-- Page: 3 - Leave Request for Employee > Validation: Check overlapping leaves > Validation > PL/SQL Function Body

DECLARE
    TOTAL_OVERLAP_DAYS NUMBER := 0;
    V_TOTAL_DAYS       NUMBER;
    V_EMP_REQ_STATUS   NUMBER;
    flag BOOLEAN := true;
    p3_total_days NUMBER;
BEGIN
    -- There will be case :P3_TOTAL_DAYS = '0.5'
    p3_total_days := case when :P3_TOTAL_DAYS = '0.5' then 0.5 else TO_NUMBER(:P3_TOTAL_DAYS) end;
    -- p3_total_days := TO_NUMBER(:P3_TOTAL_DAYS);

    IF(:P3_ALL_DAY = 'N') THEN
        :P3_END_DATE := :P3_FROM_DATE;
        p3_total_days := 0.5;
    END IF;

    FOR REC IN (
        SELECT
            ER.TOTAL_DAYS,
            ER.EMP_REQ_STATUS,
            ER.FROM_DATE,
            ER.END_DATE
        FROM
            EMPLOYEE_REQUESTS ER
        WHERE
            ER.EMPLOYEE_CODE_REQ = :APP_EMP_CODE 
            AND (TO_DATE(:P3_END_DATE, 'DD/MM/YYYY') >= TO_DATE(ER.FROM_DATE, 'MM/DD/YYYY') 
            AND TO_DATE(:P3_FROM_DATE, 'DD/MM/YYYY') <= TO_DATE(ER.END_DATE, 'MM/DD/YYYY'))
    ) LOOP
        -- INSERT INTO OUTPUT_LOGS(STR1) VALUES (rec.FROM_DATE || '->' || rec.END_DATE || ':' || rec.EMP_REQ_STATUS);
        DBMS_OUTPUT.put_line(rec.FROM_DATE || ' -> ' || rec.END_DATE || ' : ' || rec.EMP_REQ_STATUS);

        IF REC.EMP_REQ_STATUS = 5 THEN
            -- V_TOTAL_DAYS := -REC.TOTAL_DAYS;
            V_TOTAL_DAYS := 0;
        ELSIF REC.EMP_REQ_STATUS = 2 OR REC.EMP_REQ_STATUS = 3 THEN
            V_TOTAL_DAYS := TO_NUMBER(REC.TOTAL_DAYS);
        ELSE
            V_TOTAL_DAYS := 0;
        END IF;
        TOTAL_OVERLAP_DAYS := TOTAL_OVERLAP_DAYS + V_TOTAL_DAYS;
    END LOOP;
        
    DBMS_OUTPUT.put_line('TOTAL_OVERLAP_DAYS = ' || TOTAL_OVERLAP_DAYS);

    IF TOTAL_OVERLAP_DAYS >= 1 
        OR (TO_NUMBER(p3_total_days) = 0.5 AND TOTAL_OVERLAP_DAYS > 0.5)
        OR (TOTAL_OVERLAP_DAYS = 0.5 AND TO_NUMBER(p3_total_days) >= 1 ) THEN
        flag := FALSE;
    ELSE
        flag := TRUE;
    END IF;
    
    -- IF flag THEN DBMS_OUTPUT.put_line('TRUE'); ELSE DBMS_OUTPUT.put_line('FALSE'); END IF;

    return flag;
    
END;

-- ----------------------------------------
-- Page: 3 - Leave Request for Employee > Validation: Check total > Validation > PL/SQL Function Body

DECLARE
    v_maximum_days NUMBER;
    v_total_of_year NUMBER;
    v_max_per_year NUMBER;
    v_total_month NUMBER;
    flag boolean;

    n_total_days NUMBER;
BEGIN
    flag := TRUE; 
    v_total_of_year := 0;

    -- Calculate maximum total month for other leave types
    IF trim(:P3_ANNUAL_LEAVE) != 'APL' THEN
        SELECT MAXIMUM_MONTHS_LIMIT_PER_TIME into v_total_month FROM ABSENCE_CODE_LIST 
        WHERE lower(ACL_ABSENCECODE_ID) = lower(:P3_LEAVE_DETAIL) AND ROWNUM=1;
    END IF;

    IF trim(:P3_ANNUAL_LEAVE) = 'APL' THEN
        SELECT TO_NUMBER(:P3_ANNUAL_LEAVE_BALANCE)
        INTO v_maximum_days
        FROM DUAL;
    ELSIF v_total_month != 99999 THEN
        v_maximum_days := TO_DATE(:P3_FROM_DATE, 'DD/MM/YYYY') + interval '1' month * v_total_month - TO_DATE(:P3_FROM_DATE, 'DD/MM/YYYY');
    ELSE
        -- Check MAXIMUM_LIMIT_PER_TIME of other types
        SELECT MAXIMUM_LIMIT_PER_TIME
        INTO v_maximum_days
        FROM ABSENCE_CODE_LIST
        WHERE TRIM(LOWER(ACL_ABSENCECODE_ID)) = TRIM(LOWER(:P3_LEAVE_DETAIL));

        -- Check MAXIMUM_LIMIT_PER_YEAR of other types
        SELECT NVL(SUM(er.TOTAL_DAYS),0) INTO v_total_of_year FROM EMPLOYEE_REQUESTS er
        WHERE EMPLOYEE_CODE_REQ = :P3_EMPLOYEE_CODE 
        AND EMP_REQ_STATUS in (2,3) 
        AND LOWER(er.BENEFIT_CODE) = TRIM(LOWER(:P3_LEAVE_DETAIL))
        AND EXTRACT(YEAR FROM er.FROM_DATE) = EXTRACT(YEAR FROM TO_DATE(:P3_FROM_DATE, 'DD/MM/YYYY'));

        SELECT MAXIMUM_LIMIT_PER_YEAR INTO v_max_per_year FROM ABSENCE_CODE_LIST  
        WHERE TRIM(LOWER(ACL_ABSENCECODE_ID)) = TRIM(LOWER(:P3_LEAVE_DETAIL));

    END IF;

    -- There will be a case :P3_TOTAL_DAYS = '0.5', so we need to convert it to number

    IF :P3_TOTAL_DAYS = '0.5' THEN
        n_total_days := 0.5;
    ELSE
        n_total_days := to_number(:P3_TOTAL_DAYS);
    END IF;

    -- Validate total days APL & total days per time
    IF (n_total_days <= v_maximum_days) THEN
        flag := TRUE;
    ELSE
        flag := FALSE;
    END IF;

    -- Validate total days per year of other types
    IF (trim(:P3_ANNUAL_LEAVE) != 'APL') AND (n_total_days + v_total_of_year > v_max_per_year) THEN 
        flag := FALSE;
    END IF;


    return flag;
END;

-- ----------------------------------------
-- Page: 3 - Leave Request for Employee > Dynamic Action: On change > Action: Set End_time_ho > Settings > PL/SQL Code

BEGIN
    :P3_END_TIME := CASE
        WHEN TRIM(:P3_START_TIME_HO) = '08:00' THEN '12:00'
        WHEN TRIM(:P3_START_TIME_HO) = '13:30' THEN '18:00'
    END;
END;

-- ----------------------------------------
-- Page: 3 - Leave Request for Employee > Dynamic Action: New_1 > Action: Set End Time > Settings > PL/SQL Code

BEGIN
    :P3_END_TIME:= :P3_START_TIME;
END;


-- ----------------------------------------
-- Page: 3 - Leave Request for Employee > Dynamic Action: Change end date > Action: Execute Server-side Code > Settings > PL/SQL Code

begin
if :P3_ALL_DAY = 'Y' then
select ROUND(TO_DATE(:P3_END_DATE,'DD/MM/YYYY')-TO_DATE(:P3_FROM_DATE,'DD/MM/YYYY'))+1 into :P3_TOTAL_DAYS FROM DUAL;
end if;
if :P3_ALL_DAY = 'N' then
select (TO_DATE(:P3_END_DATE,'DD/MM/YYYY')-TO_DATE(:P3_FROM_DATE,'DD/MM/YYYY'))+0.5 into :P3_TOTAL_DAYS FROM DUAL;
end if;
end;

-- ----------------------------------------
-- Page: 3 - Leave Request for Employee > Dynamic Action: Change Type_1 > Action: Calc Balance > Settings > PL/SQL Code

begin
for rec in (select * from ABSENCE_GROUP_EMPLOYEE 
emp_al
right JOIN EMPLOYEES e ON emp_al.EMPLOYEE_CODE = e.EMPLOYEE_CODE
where USER_NAME = :APP_USER_NAME and EXPIRATION_DATE >= to_char(sysdate,'MM/DD/YYYY') 
 and HRM_ABSENCE_CODE_GROUP_ID = :P3_ANNUAL_LEAVE)loop
    if rec.CARRY_FORWORD_EXP_DATE >= to_char(sysdate,'MM/DD/YYYY')  then
        :P3_ANNUAL_LEAVE_BALANCE := rec.AVAILABLE + rec.CARRY_FORWARD_AVALABLE;
    else
        :P3_ANNUAL_LEAVE_BALANCE := rec.AVAILABLE;
    end if;
end loop;
/*
select nvl(AVAILABLE+CARRY_FORWARD_AVALABLE,0) into :P3_ANNUAL_LEAVE_BALANCE
from ABSENCE_GROUP_EMPLOYEE emp_al
right JOIN EMPLOYEES e ON emp_al.EMPLOYEE_CODE = e.EMPLOYEE_CODE
where e.USER_NAME = :APP_USER_NAME and HRM_ABSENCE_CODE_GROUP_ID = :P3_ANNUAL_LEAVE and EXPIRATION_DATE >= to_char(sysdate,'MM/DD/YYYY');
*/
end;

-- ----------------------------------------
-- Page: 3 - Leave Request for Employee > Dynamic Action: Change Type_1 > Action: Update Leave Detail list > Settings > SQL Statement

select ACL_DESCRIPTION, ACL_ABSENCECODE_ID as ID 
FROM ABSENCE_CODE_LIST
WHERE ABSENCE_GROUP = :P3_ANNUAL_LEAVE
ORDER BY ACL_DESCRIPTION;

-- ----------------------------------------
-- Page: 3 - Leave Request for Employee > Dynamic Action: Change from date > Action: Execute Server-side Code > Settings > PL/SQL Code

begin
if :P3_ALL_DAY = 'Y' then
select ROUND(TO_DATE(:P3_END_DATE, 'DD/MM/YYYY')-TO_DATE(:P3_FROM_DATE, 'DD/MM/YYYY'))+1 into :P3_TOTAL_DAYS FROM DUAL;
end if;
if :P3_ALL_DAY = 'N' then
select (TO_DATE(:P3_END_DATE, 'DD/MM/YYYY')-TO_DATE(:P3_FROM_DATE, 'DD/MM/YYYY'))+0.5 into :P3_TOTAL_DAYS FROM DUAL;
end if;
end;

-- ----------------------------------------
-- Page: 3 - Leave Request for Employee > Dynamic Action: Change from date > Action: Change End_Date when it disabled > Settings > PL/SQL Code

BEGIN
    :P3_END_DATE := :P3_START_DATE;
END;


-- ----------------------------------------
-- Page: 3 - Leave Request for Employee > Dynamic Action: Set display time > Action: Calculate Total Days > Settings > PL/SQL Code

-- begin
-- if :P3_ALL_DAY = 'Y' then
-- select ROUND(TO_DATE(:P3_END_DATE)-TO_DATE(:P3_FROM_DATE))+1 into :P3_TOTAL_DAYS FROM DUAL;
-- end if;
-- if :P3_ALL_DAY = 'N' then
-- select (TO_DATE(:P3_END_DATE)-TO_DATE(:P3_FROM_DATE))+0.5 into :P3_TOTAL_DAYS FROM DUAL;
-- end if;
-- end;

begin
if :P3_ALL_DAY = 'Y' then
select ROUND(TO_DATE(:P3_END_DATE,'DD/MM/YYYY')-TO_DATE(:P3_FROM_DATE,'DD/MM/YYYY'))+1 into :P3_TOTAL_DAYS FROM DUAL;
end if;
if :P3_ALL_DAY = 'N' then
select (TO_DATE(:P3_END_DATE,'DD/MM/YYYY')-TO_DATE(:P3_FROM_DATE,'DD/MM/YYYY'))+0.5 into :P3_TOTAL_DAYS FROM DUAL;
end if;
end;

-- ----------------------------------------
-- Page: 3 - Leave Request for Employee > Dynamic Action: ON_CHANGE_FROM_DATE_AND_LEAVE_DETAIL > Action: Change End_Date when in specified absence_code > Settings > PL/SQL Function Body

declare
    v_start_time NUMBER;
    v_end_time NUMBER;
    o_end_date DATE;
    total_month number;
begin
    -- v_start_time := DBMS_UTILITY.GET_TIME;  -- Current time in 1/100ths of a second
    -- LOOP
    --     v_end_time := DBMS_UTILITY.GET_TIME;
    --     EXIT WHEN (v_end_time - v_start_time) > (1 * 100);  -- 5 seconds
    -- END LOOP;
    
    -- SELECT MAXIMUM_LIMIT_PER_TIME INTO v_total_maxium_date FROM ABSENCE_CODE_LIST WHERE lower(ACL_ABSENCECODE_ID) = lower(:P3_LEAVE_DETAIL) AND ROWNUM=1;
    -- return TO_CHAR((to_date(:P3_FROM_DATE,'DD/MM/YYYY') + INTERVAL '1' DAY * (FLOOR(abs(v_total_maxium_date)) - 1)),'DD/MM/YYYY');

    SELECT MAXIMUM_MONTHS_LIMIT_PER_TIME into total_month FROM ABSENCE_CODE_LIST WHERE lower(ACL_ABSENCECODE_ID) = lower(:P3_LEAVE_DETAIL) AND ROWNUM=1;
    -- DBMS_OUTPUT.PUT_LINE(total_month);
    o_end_date := to_date(:P3_FROM_DATE, 'DD/MM/YYYY') + interval '1' month * total_month - interval '1' day;
    -- DBMS_OUTPUT.PUT_LINE(TO_CHAR(o_end_date,'DD/MM/YYYY'));

    return TO_CHAR(o_end_date,'DD/MM/YYYY');    

end;

-- ----------------------------------------
-- Page: 3 - Leave Request for Employee > Page Item: P3_TOTAL_DAYS > Default > SQL Query

SELECT 
--case :P3_ALL_DAY
--when 'Y' then
--TO_DATE(:P3_END_DATE) - TO_DATE(:P3_FROM_DATE)
--else
--TO_DATE(:P3_END_DATE,'MM/DD/YYY')-TO_DATE(:P3_FROM_DATE,'MM/DD/YYY')+0.5
--null
--end 
--as total_days
0
FROM DUAL;

-- ----------------------------------------
-- Page: 3 - Leave Request for Employee > Page Item: P3_END_DATE > Default > SQL Query

select TO_DATE(sysdate, 'MM/DD/YYYY') from dual;

-- ----------------------------------------
-- Page: 3 - Leave Request for Employee > Page Item: P3_FROM_DATE > Default > SQL Query

select TO_DATE(sysdate, 'MM/DD/YYYY') from dual;

-- ----------------------------------------
-- Page: 3 - Leave Request for Employee > Page Item: P3_MANAGER_CODE > Default > SQL Query

select MANAGER_POSITION_ID FROM EMPLOYEES e WHERE e.USER_NAME = :APP_USER_NAME;

-- ----------------------------------------
-- Page: 3 - Leave Request for Employee > Page Item: P3_LEAVE_TYPE_DEPT > Default > SQL Query

SELECT SCHEDULE FROM EMPLOYEES WHERE EMPLOYEE_CODE = :APP_EMP_CODE;

-- ----------------------------------------
-- Page: 3 - Leave Request for Employee > Page Item: P3_CURRENT_TIME_PROFILE > Default > SQL Query

SELECT PROFILE_ID FROM EMPLOYEES WHERE EMPLOYEE_CODE = :APP_EMP_CODE;

-- ----------------------------------------
-- Page: 3 - Leave Request for Employee > Page Item: P3_ANNUAL_LEAVE > List of Values > SQL Query

select ACGL_DESCRIPTION,ACGL_ABSENCE_GROUP_ID as ID 
FROM ABSENCE_CODE_GROUP_LIST 
order by ACGL_DESCRIPTION;

-- ----------------------------------------
-- Page: 3 - Leave Request for Employee > Page Item: P3_LEAVE_DETAIL > List of Values > SQL Query

select ACL_DESCRIPTION, ACL_ABSENCECODE_ID as ID 
FROM ABSENCE_CODE_LIST
WHERE ABSENCE_GROUP = :P3_ANNUAL_LEAVE
ORDER BY ACL_DESCRIPTION;

-- ----------------------------------------
-- Page: 3 - Leave Request for Employee > Page Item: P3_EMPLOYEE > Default > SQL Query

select full_name from employees where EMPLOYEE_CODE = :APP_EMP_CODE;

-- ----------------------------------------
-- Page: 3 - Leave Request for Employee > Page Item: P3_APPROVED_MANAGER > Default > SQL Query

SELECT EMPLOYEE_ID as ID FROM EMPLOYEES WHERE POSITION_ID = (
select MANAGER_POSITION_ID FROM EMPLOYEES WHERE EMPLOYEE_CODE = :APP_EMP_CODE );

