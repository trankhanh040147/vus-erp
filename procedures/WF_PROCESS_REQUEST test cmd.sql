declare 
    p_request_status_out number;
begin
    -- call procedure
    -- wf_process_request('099', 743, 1, 'approve 1st', p_request_status_out);
    wf_process_request('2741', 743, 1, 'approve 2st', p_request_status_out);
end;

delete from WORKFLOW_DETAIL WHERE request_id = 743;



-- 

declare 
    p_request_status_out number;
begin
    -- call procedure
    wf_process_request(:APP_EMP_CODE, :P29_REQUEST_ID, 1, :P29_COMMENT, p_request_status_out);
    
    -- Update convert type
    update EMP_REQUESTS
    set CONVERT_TYPE = :P29_COVERTED
    where ID = :P29_REQUEST_ID;

    SELECT STATUS INTO p_request_status_out
    FROM EMP_REQUESTS where ID = :P29_REQUEST_ID;

    IF p_request_status_out = 6 THEN 
        -- Send mail for managers in next sequence
        for rec in (
            SELECT * FROM EMPLOYEES 
            WHERE wf_is_in_next_sequence(:APP_EMP_CODE, :P29_REQUEST_ID) = 1
        ) loop

        -- Send mail for employee
        v_body_emp := '';

        -- -- lấy thông tin của người duyệt hiện tại
        -- SELECT FULL_NAME INTO current_emp_name FROM EMPLOYEES emp WHERE emp.EMPLOYEE_CODE = :APP_EMP_CODE;

        -- -- v_body_emp := v_body_emp || '<img style=''width:100%'' src=''https://hcm01.vstorage.vngcloud.vn/v1/AUTH_77c1e15122904b63990a9da99711590d/LXP_Media/ERP/images/header.png''></img>';
        -- v_body_emp := v_body_emp || '<h3 style=''color:black;text-align:center''>[PHÒNG NHÂN SỰ HÀNH CHÍNH - VUS] – ĐƠN XIN CẤP HỌC BỔNG</h3>';
        -- v_body_emp := v_body_emp || '<h3 style=''color:black;text-align:center''>[HRA DEPARTMENT - VUS] – REQUEST FOR SCHOLARSHIP LETTER</h3>';
        -- v_body_emp := v_body_emp || '<p style=''color:black;margin-top:20px''>Anh/Chị '|| emp_name ||' thân mến,</p>';
        -- v_body_emp := v_body_emp || '<p style=''color:black;margin-top:0''>Dear Mr/Ms. '|| emp_name ||',</p>';
        -- v_body_emp := v_body_emp || '<p style=''color:black''>Đơn của anh/chị đã được duyệt bởi nhân viên quản lý có thông tin sau:</p>';
        -- v_body_emp := v_body_emp || '<p style=''color:black''>Your application has been approved by a manager with the following information as below:</p>';
        -- v_body_emp := v_body_emp || '<p style=''color:black''><strong style=''color:black''>- Họ và tên quản lý / Manager Full Name:</strong> '|| current_emp_name ||'</p>';
        -- v_body_emp := v_body_emp || '<p style=''color:black''><strong style=''color:black''>- Mã số quản lý / Manager Code:</strong> '|| :APP_EMP_CODE ||'</p>';
        -- v_body_emp := v_body_emp || '<br>';

        -- v_body_emp := v_body_emp || '<p style=''color:black''>Vui lòng tiếp tục chờ đợi lượt phê duyệt tiếp theo trong 3 - 5 ngày!</p>';
        -- v_body_emp := v_body_emp || '<p style=''color:black''>Please continue to wait for the next approval in 3 - 5 days!</p><br>';

        -- v_body_emp := v_body_emp || '<p style=''color:black''>Nếu bạn có bất kỳ câu hỏi nào hoặc cần thêm sự hỗ trợ, xin đừng ngần ngại liên hệ với phòng Nhân sự Hành chính.</p>';
        -- v_body_emp := v_body_emp || '<p style=''color:black''>If you have any questions or need further assistance, please feel free to reach out to the HRA department.</p>';
        -- v_body_emp := v_body_emp || '<p style=''color:black''>Trân trọng,</p>';
        -- v_body_emp := v_body_emp || '<p style=''color:black''>Phòng Nhân sự Hành chính</p>';
        -- v_body_emp := v_body_emp || '<p style=''color:black''>Best regards,</p>';
        -- v_body_emp := v_body_emp || '<p style=''color:black''>HR & Admin Department </p>';
        -- -- v_body_emp := v_body_emp || '<img style=''width:100%'' src=''https://hcm01.vstorage.vngcloud.vn/v1/AUTH_77c1e15122904b63990a9da99711590d/LXP_Media/ERP/images/footer.jpg''></img>';

        -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', emp_email, 'Thông báo trạng thái đơn xin cấp học bổng', v_body_emp);
        -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'thviet615@gmail.com', 'Thông báo trạng thái đơn xin cấp học bổng', v_body_emp);   

        ----------------------------------------------------------------------
        
        -- Send mail for next manager
        -- lấy mail nhân viên duyệt tiếp theo
        -- SELECT USER_NAME, FULL_NAME INTO manager_email, manager_name FROM EMPLOYEES emp WHERE emp.EMPLOYEE_CODE = token.token;

        -- -- v_body_man := v_body_man || '<img style=''width:100%'' src=''https://hcm01.vstorage.vngcloud.vn/v1/AUTH_77c1e15122904b63990a9da99711590d/LXP_Media/ERP/images/header.png''></img>';
        -- v_body_man := v_body_man || '<h3 style=''color:black;text-align:center''>[PHÒNG NHÂN SỰ HÀNH CHÍNH - VUS] – ĐƠN XIN CẤP HỌC BỔNG</h3>';
        -- v_body_man := v_body_man || '<h3 style=''color:black;text-align:center''>[HRA DEPARTMENT - VUS] – REQUEST FOR SCHOLARSHIP LETTER</h3>';
        -- v_body_man := v_body_man || '<p style=''color:black;margin-top:20px''>Anh/Chị '|| manager_name ||' thân mến,</p>';
        -- v_body_man := v_body_man || '<p style=''color:black;margin-top:0''>Dear Mr/Ms. '|| manager_name ||',</p>';
        -- v_body_man := v_body_man || '<p style=''color:black''>Hệ thống nhận được đề nghị xin cấp học bổng của nhân viên như sau:</p>';
        -- v_body_man := v_body_man || '<p style=''color:black''>Employee Portal system has received a request for scholarship as below:</p>';
        -- v_body_man := v_body_man || '<br>';
        -- v_body_man := v_body_man || '<p style=''color:black''><strong style=''color:black''>Thông tin người yêu cầu/ Bộ phận đề nghị</strong></p>';
        -- v_body_man := v_body_man || '<p style=''color:black''><i>Requester/ Department Request</i></p>';
        -- -- v_body_man := v_body_man || '<ul>';
        -- v_body_man := v_body_man || '<p style=''color:black''><strong style=''color:black''>- Họ và tên nhân viên / Employee Full Name:</strong> '|| emp_name ||'</p>';

        -- if :P20002_SCHOLARSHIP_RECIPIENT = 'A' OR :P20002_SCHOLARSHIP_RECIPIENT = 'B' then 
        --     v_body_man := v_body_man || '<p style=''color:black''><strong style=''color:black''>- Mã số nhân viên / Employee Code:</strong> '|| :P20004_EMPLOYEE_CODE ||'</p>';
        -- else
        --     v_body_man := v_body_man || '<p style=''color:black''><strong style=''color:black''>- Phòng ban / Department:</strong> '|| :P20004_DEPARTMENT ||'</p>';
        -- end if;

        -- v_body_man := v_body_man || '<br>';
        -- v_body_man := v_body_man || '<p style=''color:black''><strong style=''color:black''>Thông tin người được nhận học bổng (học viên)</strong></p>';
        -- v_body_man := v_body_man || '<p style=''color:black''><i>Information Of Recipient</i></p>';
        -- -- v_body_man := v_body_man || '<ul>';
        -- v_body_man := v_body_man || '<p style=''color:black''><strong style=''color:black''>- Họ và tên người nhận / Recipient Full Name:</strong> '|| :P20004_RECIPIENT_NAME ||'</p>'; 
        -- v_body_man := v_body_man || '<p style=''color:black''><strong style=''color:black''>- Ngày tháng năm sinh người nhận / Recipient DOB:</strong> '|| :P20004_RECIPIENT_DOB ||'</p>';
        -- v_body_man := v_body_man || '<p style=''color:black''><strong style=''color:black''>- Số điện thoại người nhận / Recipient Phone:</strong> '|| :P20004_RECIPIENT_PHONE ||'</p>';
        -- v_body_man := v_body_man || '<br>';
        -- v_body_man := v_body_man || '<p style=''color:black''><strong style=''color:black''>Thông tin học bổng</strong></p>';
        -- v_body_man := v_body_man || '<p style=''color:black''><i>Scholarship Information</i></p>';
        -- -- v_body_man := v_body_man || '<ul>';
        -- v_body_man := v_body_man || '<p style=''color:black''><strong style=''color:black''>- Chương trình / Program:</strong> '|| :P20004_PROGRAM ||'</p>'; 
        -- v_body_man := v_body_man || '<p style=''color:black''><strong style=''color:black''>- Mức miễn giảm / Discount Rate:</strong> '|| :P20004_DISCOUNT_RATE ||'</p>';
        -- v_body_man := v_body_man || '<p style=''color:black''><strong style=''color:black''>- Ngày có hiệu lực / Effective Date:</strong> '|| :P20004_EFFECTIVE_DATE ||'</p>';
        -- v_body_man := v_body_man || '<p style=''color:black''><strong style=''color:black''>- Ngày hết hạn / Expiration Date:</strong> '|| :P20004_EXPIRATION_DATE ||'</p>';
        -- v_body_man := v_body_man || '<br>';

        -- v_body_man := v_body_man || '<p style=''color:black''>Vui lòng đăng nhập vào Hệ thống Quản lý Học bổng để xem xét và phản hồi yêu cầu. Bạn có thể phản hồi yêu cầu cấp học bổng bằng cách nhấp vào liên kết sau:</p>';
        -- v_body_man := v_body_man || '<p style=''color:black''>Please log in to The scholarship management system to review and respond the scholarship request. You can respond the scholarship request by clicking on the following link: <a href=\"https://erp-pilot.vus.edu.vn/ords/r/erp/erp/approve-scholarship-request?request_id=' || to_char(emp_requests_id) || '\"> link to respond the scholarship request ↗.</a></p><br>';

        -- v_body_man := v_body_man || '<p style=''color:black''>Nếu bạn có bất kỳ câu hỏi nào hoặc cần thêm sự hỗ trợ, xin đừng ngần ngại liên hệ với phòng Nhân sự Hành chính.</p>';
        -- v_body_man := v_body_man || '<p style=''color:black''>If you have any questions or need further assistance, please feel free to reach out to the HRA department.</p>';
        -- v_body_man := v_body_man || '<p style=''color:black''>Trân trọng,</p>';
        -- v_body_man := v_body_man || '<p style=''color:black''>Phòng Nhân sự Hành chính</p>';
        -- v_body_man := v_body_man || '<p style=''color:black''>Best regards,</p>';
        -- v_body_man := v_body_man || '<p style=''color:black''>HR & Admin Department </p>';
        -- -- v_body_man := v_body_man || '<img style=''width:100%'' src=''https://hcm01.vstorage.vngcloud.vn/v1/AUTH_77c1e15122904b63990a9da99711590d/LXP_Media/ERP/images/footer.jpg''></img>';

        -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', manager_email, 'Yêu cầu duyệt đơn xin cấp học bổng', v_body_man);
        -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'thviet615@gmail.com', 'Yêu cầu duyệt đơn xin cấp học bổng', v_body_man);

        end loop
    elsif p_request_status_out = 3 THEN
        -- Send mail for employee

    END IF;
end;