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
-- Application Process: Assign USER ID > Source > PL/SQL Code

-- Tracking User Access LOG
--- ASSGIN PERSON ID to USER ID
    for rec in (select ID,EMPLOYEE_ID,AVATAR_ID,USER_NAME, PERSON_TYPE,ROLE,POSITION_ID,WORKER_TITLE_ID,EMPLOYEE_CODE,APPROVAL_GROUP,DEPARTMENT_ID, LEVEL_ID from EMPLOYEES where lower(USER_NAME) = lower(:APP_USER) and ROWNUM = 1) loop
        :APP_USER_ID := rec.EMPLOYEE_ID;
        :APP_USER_NAME := rec.USER_NAME;
        :APP_USER_ACCESS_ID := rec.ID;
        :APP_PERSON_TYPE := rec.PERSON_TYPE;
        :APP_AVATAR_ID := rec.AVATAR_ID;
        :APP_EMP_CODE := rec.EMPLOYEE_CODE;
        :TITLE_NAME := rec.APPROVAL_GROUP;
        :IS_HR_ADMIN := CASE WHEN lower(rec.DEPARTMENT_ID) LIKE '%hr%' THEN 1 ELSE 2 END;
        -- :IS_HR_ADMIN := CASE WHEN (lower(rec.DEPARTMENT_ID) LIKE '%hr%') and (rec.LEVEL_ID = 'D' OR rec.LEVEL_ID = 'TL') THEN 1 ELSE 2 END;
        if upper(rec.WORKER_TITLE_ID) like '%ADMIN%' then
            :APP_USER_ROLE_ID := 0;
        elsif (upper(rec.WORKER_TITLE_ID) like '%MANAGER%' or upper(rec.WORKER_TITLE_ID) like '%DIRECTOR%') then
            :APP_USER_ROLE_ID := 2;
        else
            :APP_USER_ROLE_ID := 3;
        end if;
        --:APP_USER_ROLE_ID := rec.ROLE;
        :APP_POSITION_ID := rec.POSITION_ID;
        insert into USER_ACCESS_LOG (USER_ID,ACCESS_DATE) VALUES(rec.EMPLOYEE_ID,sysdate);
        
        --:APP_AVATAR_ICON :='fa-user';
        --for rec_avatar in (select ICON from AVATARS where ID = rec.AVATAR_ID) loop
            --:APP_AVATAR_ICON := rec_avatar.ICON; 
        --end loop;

        return;
                
    end loop;

   
    --for rec_ad in (select Display_Name,LAST_NAME from STAFFS where ID = :APP_USER_ID) loop
            --:APP_USER_FULL_NAME := rec_ad.Display_Name;
            --:APP_USER_LAST_NAME := rec_ad.LAST_NAME;
           -- end loop;

-- ----------------------------------------
-- Application Process: Cancel_request > Source > PL/SQL Code

declare
v_request_id number;
v_hrm_code nvarchar2(100);
begin
v_request_id := apex_application.g_x01;
v_hrm_code := apex_application.g_x02;
update EMPLOYEE_REQUESTS set emp_req_status = 5,man_res_status = 5 where id = v_request_id;

for rec in (select CRF_DAY_TEMP,ANNUAL_DAY_TEMP,EMPLOYEE_CODE_REQ from EMPLOYEE_REQUESTS where id = v_request_id)loop
    update ABSENCE_GROUP_EMPLOYEE 
                set CARRY_FORWARD_USED = CARRY_FORWARD_USED - rec.CRF_DAY_TEMP,
                CARRY_FORWARD_AVALABLE = CARRY_FORWARD_AVALABLE + rec.CRF_DAY_TEMP,
                AVAILABLE = AVAILABLE + rec.ANNUAL_DAY_TEMP,
                PLAN_YEAR_USED = PLAN_YEAR_USED - rec.ANNUAL_DAY_TEMP
                where EMPLOYEE_CODE = rec.EMPLOYEE_CODE_REQ and EXPIRATION_DATE >= to_char(sysdate,'MM/DD/YYYY') and HRM_ABSENCE_CODE_GROUP_ID = 'APL';

    SP_CANCEL_REQUEST_FIN(rec.EMPLOYEE_CODE_REQ,v_request_id);

end loop; 
end;

-- ----------------------------------------
-- Application Process: Create_request > Source > PL/SQL Code

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
r_HRMAbsenceCodeId nvarchar2(100);
r_IDPortal NUMBER;



begin
v_request_id := apex_application.g_x01;

for rec in (select * from ABSENCE_GROUP_EMPLOYEE eal join EMPLOYEE_REQUESTS er on er.EMPLOYEE_CODE_REQ =  eal.EMPLOYEE_CODE 
where er.id = v_request_id and EXPIRATION_DATE >= to_char(sysdate,'MM/DD/YYYY'))loop
    if rec.AVAILABLE > 0 and rec.total_days <= rec.AVAILABLE then
    /*
                for rec in (select * FROM EMPLOYEE_REQUESTS where id = v_request_id) loop
                    r_AdjustedHours := rec.TOTAL_DAYS;
                    r_AdjustmentType := 10;
                    r_TransactionDate := rec.FROM_DATE;
                    r_Description := rec.NOTE;
                    r_EmployeeCode := rec.EMPLOYEE_CODE_REQ;
                    r_HRMAbsenceCodeId := rec.LEAVE_TYPE;
                    r_IDPortal := rec.ID;
                end loop;*/
SP_CREATE_REQUEST_FIN(rec.EMPLOYEE_CODE_REQ,v_request_id);
    --SP_CREATE_LEAVER_REQUEST(
                    --TO_CHAR(r_AdjustedHours), TO_CHAR(r_AdjustmentType), TO_CHAR(r_TransactionDate, 'MM-DD-YYYY'), r_Description, r_EmployeeCode, r_HRMAbsenceCodeId, TO_CHAR(r_IDPortal)
                --);
    end if;
end loop;
end;

-- ----------------------------------------
-- Application Process: Delete_education > Source > PL/SQL Code

declare
v_id number;
v_type nvarchar2(100);
begin
v_id := apex_application.g_x01;
v_type := apex_application.g_x02;
if v_type = 'edu' then
update EMP_EDUCATION set is_del = 1 where id = v_id;
end if;
if v_type = 'other' then
update EMP_CERTIFICATE set is_del = 1 where id = v_id;
end if;
end;

-- ----------------------------------------
-- Application Process: Delete_request > Source > PL/SQL Code

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
    where EMPLOYEE_CODE = rec.EMPLOYEE_CODE_REQ and age.BENEFIT_ACCRUAL_PLAN = rec.BENEFIT_CODE;
end loop;

delete from EMPLOYEE_REQUESTS where ID = v_request_id;

end;

-- ----------------------------------------
-- Application Process: Reject_request > Source > PL/SQL Code

declare
v_request_id number;
v_hrm_code nvarchar2(100);
v_body clob := '';
begin
v_request_id := apex_application.g_x01;
v_hrm_code := apex_application.g_x02;
update EMPLOYEE_REQUESTS set emp_req_status = 4,man_res_status = 4 where id = v_request_id;

for rec in (select CRF_DAY_TEMP,ANNUAL_DAY_TEMP,EMPLOYEE_CODE_REQ from EMPLOYEE_REQUESTS where id = v_request_id and LEAVE_TYPE = 'APL')loop
    update ABSENCE_GROUP_EMPLOYEE 
                set CARRY_FORWARD_USED = CARRY_FORWARD_USED - rec.CRF_DAY_TEMP,
                CARRY_FORWARD_AVALABLE = CARRY_FORWARD_AVALABLE + rec.CRF_DAY_TEMP,
                AVAILABLE = AVAILABLE + rec.ANNUAL_DAY_TEMP,
                PLAN_YEAR_USED = PLAN_YEAR_USED - rec.ANNUAL_DAY_TEMP
                where EMPLOYEE_CODE = rec.EMPLOYEE_CODE_REQ and EXPIRATION_DATE >= to_char(sysdate,'MM/DD/YYYY') and HRM_ABSENCE_CODE_GROUP_ID = 'APL';
end loop;

-- send mail
for rec in (select er.*, emp.USER_NAME, emp.FULL_NAME, emp.EMPLOYEE_CODE,
        case 
            when er.ALL_DAY like 'N' then er.FROM_DATE -- Set END_DATE to FROM_DATE if ALLDAY is 'N'
            else er.END_DATE
        end as MODIFIED_END_DATE
        from EMPLOYEE_REQUESTS er
        join EMPLOYEES emp on emp.EMPLOYEE_CODE = er.EMPLOYEE_CODE_REQ
        where er.ID = v_request_id
    )loop

    -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', rec.USER_NAME, 'Leave Request Approved', '<p> Dear '|| rec.FULL_NAME ||', </p>' ||
    -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'thviet615@gmail.com', 'Leave Request Rejected', '<p> Dear '|| rec.FULL_NAME ||', </p>' ||
    --     '<p>Your leave request has been rejected. Here are the details:</p>' ||
    --     '<p>Employee Code: '|| rec.EMPLOYEE_CODE ||' </p>' ||
    --     '<p>Total Days: '|| to_char(rec.TOTAL_DAYS,'0.0') ||' </p>' ||
    --     '<p>From Date: '|| to_char(rec.FROM_DATE, 'DD/MM/YYYY') ||' </p>' ||
    --     '<p>To Date: '|| to_char(rec.MODIFIED_END_DATE, 'DD/MM/YYYY') ||' </p>' ||
    --     '<br>' || 
    --     -- '<p>Feel free to proceed with your leave plans accordingly.</p>' ||
    --     -- '<br>' || 
    --     '<p> If you have any questions or need further assistance, please feel free to reach out to the HR department. </p>' ||
    --     '<br>' || 
    --     '<p> Thank you, </p>' ||
    --     '<p> VUS </p>');

    v_body := v_body || '<img style=''width:100%'' src=''https://hcm01.vstorage.vngcloud.vn/v1/AUTH_77c1e15122904b63990a9da99711590d/LXP_Media/ERP/images/header.png''></img>';
    v_body := v_body || '<h3 style=''color:black;text-align:center''>[PHÒNG NHÂN SỰ HÀNH CHÍNH - VUS] – ĐƠN XIN NGHỈ PHÉP</h3>';
    v_body := v_body || '<h3 style=''color:black;text-align:center''>[HRA DEPARTMENT - VUS] – REQUEST FOR LEAVE LETTER</h3>';
    v_body := v_body || '<p style=''color:black;margin-top:20px''>Anh/Chị '|| rec.FULL_NAME ||' thân mến,</p>';
    v_body := v_body || '<p style=''color:black;margin-top:0''>Dear Mr/Ms. '|| rec.FULL_NAME ||',</p>';
    v_body := v_body || '<p style=''color:black''>Hệ thống nhận được đề nghị xin nghỉ phép của nhân viên như sau:</p>';
    v_body := v_body || '<p style=''color:black''>Employee Portal system has received a request for leave as below:</p>';
    v_body := v_body || '<ul>';
    v_body := v_body || '<p style=''color:black''><strong style=''color:black''>- Họ và tên/ Full name:</strong> '|| rec.FULL_NAME ||'</p>';
    v_body := v_body || '<p style=''color:black''><strong style=''color:black''>- Mã số nhân viên/ Employee Code:</strong> '|| rec.EMPLOYEE_CODE ||'</p>';
    v_body := v_body || '<p style=''color:black''><strong style=''color:black''>- Loại phép/ Leave Type:</strong> '|| rec.LEAVE_TYPE ||'</p>';
    if (rec.TOTAL_DAYS <= 0.5) then
        v_body := v_body || '<p style=''color:black''><strong style=''color:black''>- Tổng Số Ngày/ Total Days:</strong> '|| to_char(rec.TOTAL_DAYS,'0.0') ||'</p>';
        v_body := v_body || '<p style=''color:black''><strong style=''color:black''>- Từ Ngày/ From Date:</strong> '|| to_char(rec.FROM_DATE, 'DD/MM/YYYY') ||'</p>';
        v_body := v_body || '<p style=''color:black''><strong style=''color:black''>- Đến Ngày/ To Date:</strong> '|| to_char(rec.MODIFIED_END_DATE, 'DD/MM/YYYY') ||'</p>';
        v_body := v_body || '<p style=''color:black''><strong style=''color:black''>- Từ/ Start Time:</strong> '|| rec.START_TIME ||'</p>';
        v_body := v_body || '<p style=''color:black''><strong style=''color:black''>- Đến/ To Time:</strong> '|| rec.END_TIME ||'</p>';
    else
        v_body := v_body || '<p style=''color:black''><strong style=''color:black''>- Tổng Số Ngày/ Total Days:</strong> '|| rec.TOTAL_DAYS ||'</p>';
        v_body := v_body || '<p style=''color:black''><strong style=''color:black''>- Từ Ngày/ From Date:</strong> '|| to_char(rec.FROM_DATE, 'DD/MM/YYYY') ||'</p>';
        v_body := v_body || '<p style=''color:black''><strong style=''color:black''>- Đến Ngày/ To Date:</strong> '|| to_char(rec.MODIFIED_END_DATE, 'DD/MM/YYYY') ||'</p>';
    end if;
    v_body := v_body || '<p style=''color:black''><strong style=''color:black''>- Ghi Chú/ Note:</strong> '|| rec.NOTE ||'</p>';
    v_body := v_body || '</ul><br>';
    v_body := v_body || '<p style=''color:black''>Đơn xin nghỉ phép của bạn đã bị từ chối!</p>';
    v_body := v_body || '<p style=''color:black''>Your leave request has been rejected!</p><br>';

    v_body := v_body || '<p style=''color:black''>Nếu bạn có bất kỳ câu hỏi nào hoặc cần thêm sự hỗ trợ, xin đừng ngần ngại liên hệ với phòng Nhân sự Hành chính.</p>';
    v_body := v_body || '<p style=''color:black''>If you have any questions or need further assistance, please feel free to reach out to the HRA department.</p>';
    v_body := v_body || '<p style=''color:black''>Trân trọng,</p>';
    v_body := v_body || '<p style=''color:black''>Phòng Nhân sự Hành chính</p>';
    v_body := v_body || '<p style=''color:black''>Best regards,</p>';
    v_body := v_body || '<p style=''color:black''>HR & Admin Department </p>';
    v_body := v_body || '<img style=''width:100%'' src=''https://hcm01.vstorage.vngcloud.vn/v1/AUTH_77c1e15122904b63990a9da99711590d/LXP_Media/ERP/images/footer.jpg''></img>';

    SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', rec.USER_NAME, 'Từ chối đơn xin nghỉ phép', v_body);
    SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'thviet615@gmail.com', 'Từ chối đơn xin nghỉ phép', v_body);
    end loop;
end;

-- ----------------------------------------
-- Application Process: Set_language_reference > Source > PL/SQL Code

Declare
   v_url varchar2(1000); 
Begin
   v_url :=apex_util.prepare_url('f?p='||:APP_ID||':'||:APP_PAGE_ID||':'||:APP_SESSION);
 
   apex_util.redirect_url (
     p_url => v_url );
End;

-- ----------------------------------------
-- Application Process: UPDATE_EMP_CERTIFICATE_ATTACHMENT > Source > PL/SQL Code

DECLARE
    v_emp_certificate_id NUMBER := :P10102_EMP_CERTIFICATE_ID;
    v_attachment_url VARCHAR2(4000) := :P10102_ATTACHMENT_URL;
    v_attachment_name VARCHAR2(500) := :P10102_ATTACHMENT_NAME;
begin
    v_emp_certificate_id := apex_application.g_x01;
    v_attachment_url := apex_application.g_x02;
    v_attachment_name := apex_application.g_x03;

    UPDATE EMP_CERTIFICATE
    SET ATTACHMENT_URL = v_attachment_url,
        ATTACHMENT_NAME = v_attachment_name
    WHERE ID = v_emp_certificate_id;
end;

-- ----------------------------------------
-- Application Process: Update_request > Source > PL/SQL Code

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

r_inserted_status number;

begin
v_request_id := apex_application.g_x01;

-- update EMPLOYEE_REQUESTS EMP_REQ set emp_req_status = 3 where EMP_REQ.ID = v_request_id;
-- update EMPLOYEE_REQUESTS EMP_REQ set man_res_status = 3 where EMP_REQ.ID = v_request_id;
-- update EMPLOYEE_REQUESTS EMP_REQ set emp_req_status = 3, man_res_status = 3 where EMP_REQ.ID = v_request_id;

-- update EMPLOYEE_REQUESTS EMP_REQ set emp_req_status = 3 where EMP_REQ.REQUEST_ID = v_request_id;
-- update EMPLOYEE_REQUESTS EMP_REQ set man_res_status = 3 where EMP_REQ.REQUEST_ID = v_request_id;
-- update EMPLOYEE_REQUESTS EMP_REQ set emp_req_status = 3, man_res_status = 3 where EMP_REQ.REQUEST_ID = v_request_id;


for rec in (select er.*,age.BENEFIT_ACCRUAL_PLAN,age.CF_BENEFIT_ACCRUAL_PLAN,age.CARRY_FORWARD_AVALABLE,age.CARRY_FORWORD_EXP_DATE FROM EMPLOYEE_REQUESTS er 
                join ABSENCE_GROUP_EMPLOYEE age on age.employee_code = er.EMPLOYEE_CODE_REQ where er.id = v_request_id and age.EXPIRATION_DATE >= to_char(sysdate,'MM/DD/YYYY'))loop
                        
                            if rec.BENEFIT_CODE like 'ALPL%,ALCF%' then
                                --SP_CREATE_REQUEST_FIN(rec.EMPLOYEE_CODE_REQ, v_request_id,rec.CF_BENEFIT_ACCRUAL_PLAN,rec.CF_BENEFIT_ACCRUAL_PLAN,rec.CRF_DAY_TEMP);
                                --SP_CREATE_REQUEST_FIN(rec.EMPLOYEE_CODE_REQ, v_request_id,rec.BENEFIT_ACCRUAL_PLAN,rec.BENEFIT_ACCRUAL_PLAN,rec.ANNUAL_DAY_TEMP);
                                SP_CREATE_REQUEST_FIN_BOTH(rec.EMPLOYEE_CODE_REQ, v_request_id);
                            else                                
                                SP_CREATE_REQUEST_FIN(rec.EMPLOYEE_CODE_REQ, v_request_id);
                            end if;                        
                end loop;

end;

