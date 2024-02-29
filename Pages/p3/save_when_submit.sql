declare
v_request_id_temp number:=1;
v_id NUMBER:=1;
v_name_type nvarchar2(100);
v_benefit_code nvarchar2(100):='';
v_annual_temp float:=0;
v_crf_temp float:=0;
v_crf_balance number;
manager_email nvarchar2(100);
manager_name nvarchar2(100);
requester_schedule NVARCHAR2(50);
v_body_emp clob := '';
v_body_man clob:= '';
p3_total_days FLOAT;
leave_type nvarchar2(200);
begin

    requester_schedule := LOWER(TRIM(:P3_LEAVE_TYPE_DEPT));

    -- Waiting for the end to come
    -- dbms_session.sleep(1);

    -- INSERT INTO DEMO_ATTACHMENT(URL) VALUES(:P3_URL_FILES);

    p3_total_days := case when :P3_TOTAL_DAYS = '0.5' then 0.5 else TO_NUMBER(:P3_TOTAL_DAYS) end;

    if :P3_ANNUAL_LEAVE = 'APL' then
        for rec in ( select * from ABSENCE_GROUP_EMPLOYEE where employee_code = :APP_EMP_CODE and EXPIRATION_DATE >= to_char(sysdate,'MM/DD/YYYY'))loop
            

            if rec.CARRY_FORWORD_EXP_DATE >= to_char(sysdate,'MM/DD/YYYY') then
                -- CF not expired
                if  p3_total_days <= rec.CARRY_FORWARD_AVALABLE and rec.CARRY_FORWARD_AVALABLE > 0 then
                    -- CF enough, but expired before the end date
                    v_benefit_code := rec.CF_BENEFIT_ACCRUAL_PLAN;
                    v_crf_temp := p3_total_days;
                elsif p3_total_days <= rec.CARRY_FORWARD_AVALABLE and rec.CARRY_FORWARD_AVALABLE > 0 then
                    -- CF enough
                    v_benefit_code := rec.CF_BENEFIT_ACCRUAL_PLAN;
                    v_crf_temp := p3_total_days;
                elsif rec.CARRY_FORWARD_AVALABLE > 0 and p3_total_days > rec.CARRY_FORWARD_AVALABLE then
                    -- CF not enough
                    v_benefit_code := rec.BENEFIT_ACCRUAL_PLAN||','||rec.CF_BENEFIT_ACCRUAL_PLAN;
                    v_crf_temp := rec.CARRY_FORWARD_AVALABLE;
                    v_annual_temp := p3_total_days - rec.CARRY_FORWARD_AVALABLE;
                elsif rec.CARRY_FORWARD_AVALABLE <= 0 THEN
                    -- CF not expired, CF = 0
                    v_benefit_code := rec.BENEFIT_ACCRUAL_PLAN;
                    v_annual_temp := p3_total_days;
                end if;
            else
                v_benefit_code := rec.BENEFIT_ACCRUAL_PLAN;
                v_annual_temp := p3_total_days;
            end if;
        end loop;
    else 
        v_annual_temp := p3_total_days;
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
    --         :P3_END_DATE,to_char(:P3_ALL_DAY),:P3_NOTE,p3_total_days,2,:P3_ANNUAL_LEAVE,:P3_APPROVED_MANAGER,:P3_MANAGER_CODE,
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
            CASE WHEN :P3_END_DATE IS NULL OR :P3_END_DATE = '' THEN to_date(:P3_FROM_DATE, 'DD/MM/YYYY') ELSE to_date(:P3_END_DATE, 'DD/MM/YYYY') END,to_char(:P3_ALL_DAY),:P3_NOTE,p3_total_days,2,:P3_ANNUAL_LEAVE,:P3_APPROVED_MANAGER,:P3_MANAGER_CODE,
            CASE WHEN requester_schedule = 'ho' THEN :P3_START_TIME_HO ELSE :P3_START_TIME END,:P3_END_TIME,sysdate,v_benefit_code,v_crf_temp,v_annual_temp,nvl(:P3_NAME_FILES,''),:P3_URL_FILES, :P3_ANNUAL_LEAVE_BALANCE
        ) returning ID into v_id;

    :P3_REQUEST_ID_IMPORTED := v_id;


    -- -- -- Log data into tables
    -- INSERT INTO OUTPUT_LOGS(DATE1, DATE2, STR1, STR2)
    -- VALUES (TO_DATE(:P3_FROM_DATE, 'DD/MM/YYYY'),TO_DATE(:P3_END_DATE, 'DD/MM/YYYY'), :P3_FROM_DATE, :P3_END_DATE);


    -- Send mail

    SELECT USER_NAME, FULL_NAME INTO manager_email, manager_name FROM EMPLOYEES WHERE (SELECT MANAGER_ID FROM EMPLOYEES WHERE EMPLOYEE_CODE = :P3_EMPLOYEE_CODE) = EMPLOYEE_CODE;
    SELECT ACGL_DESCRIPTION INTO leave_type from ABSENCE_CODE_GROUP_LIST where :P3_ANNUAL_LEAVE = ACGL_ABSENCE_GROUP_ID;
    --For employee

    -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'thviet615@gmail.com', 'Leave Request Submitted Successfully', '<p> Dear '|| :P3_EMPLOYEE ||', </p>' ||
    -- -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', :APP_USER_NAME, 'Leave Request Submitted Successfully', '<p> Dear '|| :P3_EMPLOYEE ||', </p>' ||
    -- '<p>Successfully submitted. Kindly return <b>My leave history page</b> to follow your leave request. Here are the details: </p>' ||
    -- '<p>Employee Code: '|| :P3_EMPLOYEE_CODE ||' </p>' ||
    -- -- '<p> Total Days: '|| CASE
    -- --            WHEN p3_total_days = 0.5 THEN to_char(p3_total_days, '0.0')
    -- --            ELSE p3_total_days
    -- --        END ||' </p>' ||
    -- '<p>Total Days: '|| to_char(p3_total_days, '0.0') ||' </p>' ||
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
    -- v_body_emp := v_body_emp || '<p style=''color:black''><strong style=''color:black''>- Loại phép/ Leave Type:</strong> '|| :P3_ANNUAL_LEAVE ||'</p>';
    v_body_emp := v_body_emp || '<p style=''color:black''><strong style=''color:black''>- Loại phép/ Leave Type:</strong> '|| leave_type ||'</p>';
    if (p3_total_days <= 0.5) then
        v_body_emp := v_body_emp || '<p style=''color:black''><strong style=''color:black''>- Tổng Số Ngày/ Total Days:</strong> '|| to_char(p3_total_days, '0.0') ||'</p>';
        v_body_emp := v_body_emp || '<p style=''color:black''><strong style=''color:black''>- Từ Ngày/ From Date:</strong> '|| :P3_FROM_DATE ||'</p>';
        v_body_emp := v_body_emp || '<p style=''color:black''><strong style=''color:black''>- Đến Ngày/ To Date:</strong> '|| :P3_END_DATE ||'</p>';
        v_body_emp := v_body_emp || '<p style=''color:black''><strong style=''color:black''>- Từ/ Start Time:</strong> '|| :P3_START_TIME ||'</p>';
        v_body_emp := v_body_emp || '<p style=''color:black''><strong style=''color:black''>- Đến/ To Time:</strong> '|| :P3_END_TIME ||'</p>';
    else
        v_body_emp := v_body_emp || '<p style=''color:black''><strong style=''color:black''>- Tổng Số Ngày/ Total Days:</strong> '|| p3_total_days ||'</p>';
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
    -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'thviet615@gmail.com', 'Gửi đơn xin nghỉ phép thành công', v_body_emp);

    --For manager

    -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'thviet615@gmail.com', 'Leave Request Approval Required', '<p>Dear '|| manager_name ||',</p>' ||
    -- -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', manager_email, 'Leave Request Approval Required', '<p>Dear '|| manager_name ||',</p>' ||
    --     '<p>A leave request from '|| :P3_EMPLOYEE ||' requires your approval. Here are the details:</p>' ||
    --     '<p>Employee Code: '|| :P3_EMPLOYEE_CODE ||'</p>' ||
    --     -- '<p>Total Days: '|| CASE
    --     --        WHEN p3_total_days = 0.5 THEN to_char(p3_total_days, '0.0')
    --     --        ELSE p3_total_days
    --     --    END ||'</p>' ||
    --     '<p>Total Days: '|| to_char(p3_total_days, '0.0') ||' </p>' ||
    --     '<p>From Date: '|| :P3_FROM_DATE ||'</p>' ||
    --     '<p>To Date: '|| :P3_END_DATE ||'</p>' ||
    --     '<br>' || 
    --     '<p>Please log in to the leave management system to review and approve the request. You can approve the leave by clicking on the following link: <a href=\"https://erp-pilot.vus.edu.vn/ords/r/erp/erp/approve-leave?request_id=' || to_char(v_id) || '\"> link to approve the leave ↗.</a></p>' ||
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
    -- v_body_man := v_body_man || '<p style=''color:black''><strong style=''color:black''>- Loại phép/ Leave Type:</strong> '|| :P3_ANNUAL_LEAVE ||'</p>';
    v_body_man := v_body_man || '<p style=''color:black''><strong style=''color:black''>- Loại phép/ Leave Type:</strong> '|| leave_type ||'</p>';
    if (p3_total_days <= 0.5) then
        v_body_man := v_body_man || '<p style=''color:black''><strong style=''color:black''>- Tổng Số Ngày/ Total Days:</strong> '|| to_char(p3_total_days, '0.0') ||'</p>';
        v_body_man := v_body_man || '<p style=''color:black''><strong style=''color:black''>- Từ Ngày/ From Date:</strong> '|| :P3_FROM_DATE ||'</p>';
        v_body_man := v_body_man || '<p style=''color:black''><strong style=''color:black''>- Đến Ngày/ To Date:</strong> '|| :P3_END_DATE ||'</p>';
        v_body_man := v_body_man || '<p style=''color:black''><strong style=''color:black''>- Từ/ Start Time:</strong> '|| :P3_START_TIME ||'</p>';
        v_body_man := v_body_man || '<p style=''color:black''><strong style=''color:black''>- Đến/ To Time:</strong> '|| :P3_END_TIME ||'</p>';
    else
        v_body_man := v_body_man || '<p style=''color:black''><strong style=''color:black''>- Tổng Số Ngày/ Total Days:</strong> '|| p3_total_days ||'</p>';
        v_body_man := v_body_man || '<p style=''color:black''><strong style=''color:black''>- Từ Ngày/ From Date:</strong> '|| :P3_FROM_DATE ||'</p>';
        v_body_man := v_body_man || '<p style=''color:black''><strong style=''color:black''>- Đến Ngày/ To Date:</strong> '|| :P3_END_DATE ||'</p>';
    end if;
    v_body_man := v_body_man || '<p style=''color:black''><strong style=''color:black''>- Ghi Chú/ Note:</strong> '|| :P3_NOTE ||'</p>';
    v_body_man := v_body_man || '</ul><br>';
    v_body_man := v_body_man || '<p style=''color:black''>Vui lòng đăng nhập vào Hệ thống Quản lý nghỉ phép để xem xét và phản hồi yêu cầu. Bạn có thể phản hồi yêu cầu nghỉ phép bằng cách nhấp vào liên kết sau: <a href=\"https://erp-uat.vus.edu.vn/ords/r/erp/erp/approve-leave?request_id=' || to_char(v_id) || '\"> link to respond the leave request ↗.</a></p><br>';
    v_body_man := v_body_man || '<p style=''color:black''>Please log in to The leave management system to review and respond the leave request. You can respond the leave request by clicking on the following link: <a href=\"https://erp-uat.vus.edu.vn/ords/r/erp/erp/approve-leave?request_id=' || to_char(v_id) || '\"> link to respond the leave request ↗.</a></p><br>';

    v_body_man := v_body_man || '<p style=''color:black''>Nếu bạn có bất kỳ câu hỏi nào hoặc cần thêm sự hỗ trợ, xin đừng ngần ngại liên hệ với phòng Nhân sự Hành chính.</p>';
    v_body_man := v_body_man || '<p style=''color:black''>If you have any questions or need further assistance, please feel free to reach out to the HRA department.</p>';
    v_body_man := v_body_man || '<p style=''color:black''>Trân trọng,</p>';
    v_body_man := v_body_man || '<p style=''color:black''>Phòng Nhân sự Hành chính</p>';
    v_body_man := v_body_man || '<p style=''color:black''>Best regards,</p>';
    v_body_man := v_body_man || '<p style=''color:black''>HR & Admin Department </p>';
    -- v_body_man := v_body_man || '<img style=''width:100%'' src=''https://hcm01.vstorage.vngcloud.vn/v1/AUTH_77c1e15122904b63990a9da99711590d/LXP_Media/ERP/images/footer.jpg''></img>';

    SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', manager_email, 'Yêu cầu duyệt đơn nghỉ phép', v_body_man);
    -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'thviet615@gmail.com', 'Yêu cầu duyệt đơn nghỉ phép', v_body_man);

end;