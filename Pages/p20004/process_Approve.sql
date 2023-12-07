declare
    pro_code nvarchar2(100);
    id_replace number;      -- id của voucher code bị replace
    emp_manager nvarchar2(200);
    emp_requests_id number;
    emp_requests_id_replace number;
-- send mail
    v_body_emp clob := '';
    v_body_man clob := '';
    v_result nvarchar2(100);
    manager_email nvarchar2(200);
    manager_name nvarchar2(100);
    emp_email nvarchar2(200);
    emp_name nvarchar2(100);
    -- p_REQUESTER_CODE nvarchar2(100);
    -- p_RECIPIENT_NAME nvarchar2(100);
    -- p_RECIPIENT_DOB date;
    -- p_RECIPIENT_PHONE nvarchar2(20);
    -- p_PROGRAM nvarchar2(50);
    -- p_DISCOUNT_RATE nvarchar2(100);
    -- p_EFFECTIVE_DATE date;
    -- p_EXPIRATION_DATE date;
    current_emp_name nvarchar2(100);
    v_id NUMBER := 1;
begin

    -- Get emp_requests_id
    select ID
    into emp_requests_id
    from EMP_REQUESTS er where :P20004_REQUEST_ID = er.REQUEST_DETAIL_ID and  REQUEST_TYPE = :P20004_FEATURE;

    -- lấy promotion_code mới
    -- select cp.PROMOTION_CODE
    -- into pro_code
    -- from COREEDU_PROMOTION cp
    -- where cp.PROGRAM = :P20004_PROGRAM and cp.DISCOUNT_RATE = :P20004_DISCOUNT_RATE;

    for rec in (
    --     with temp as (
    --     select wa.WA_GROUP from EMP_REQUESTS er
    --         join WORKFLOW_APPROVAL wa on wa.WF_PROCESS_ID = er.WF_PROCESS_ID
    --         join employees emp on emp.APPROVAL_GROUP = wa.WA_GROUP
    --         where emp.EMPLOYEE_CODE = :APP_EMP_CODE
    --         group by wa.WA_GROUP
    -- )
        select er.CURRENT_STEP,er.NEXT_STEP,
            count(wa.WA_SEQUENCE_NUMBER) as SEQ 
        from EMP_REQUESTS er
        join WORKFLOW_APPROVAL wa on wa.WF_PROCESS_ID = er.WF_PROCESS_ID
            -- join WORKFLOW_APPROVAL tmp on tmp.WA_GROUP = wa.WA_GROUP
        where er.REQUEST_DETAIL_ID = :P20004_REQUEST_ID and er.REQUEST_TYPE = :P20004_FEATURE
            and er.STATUS <> 3 
        group by er.CURRENT_STEP,er.NEXT_STEP
    )
        loop
            if rec.NEXT_STEP < rec.SEQ then
                --select wa.WA_SEQUENCE_NUMBER into n_step from EMPLOYEES emp join WORKFLOW_APPROVAL wa on wa.WA_GROUP = emp.APPROVAL_GROUP and employee_code = :APP_EMP_CODE;
                
                -- cập nhật bảng EMP_REQUESTS về trạng thái 'in-review'
                update EMP_REQUESTS 
                set MODIFIED_DATE = sysdate,
                    CURRENT_STEP = rec.NEXT_STEP,
                    MODIFIED_BY_CODE = :APP_EMP_CODE,
                    NEXT_STEP = rec.NEXT_STEP + 1,
                    STATUS = 6 
                where REQUEST_DETAIL_ID = :P20004_REQUEST_ID and REQUEST_TYPE = :P20004_FEATURE;

                -- cập nhật bảng SCHOLARSHIP_REQUEST về trạng thái 'in-review'
                update SCHOLARSHIP_REQUEST 
                set STATUS = 6,
                    RECIPIENT_CAMPUS = :P20004_CAMPUS,
                    RECIPIENT_REPLACEMENT = :P20004_REPLACEMENT,
                    RECIPIENT_VOUCHER_CODE_REPLACEMENT = :P20004_VOUCHER_CODE_REPLACEMENT,
                    RECIPIENT_EXPIRATION_DATE_REPLACEMENT = :P20004_EXPIRATION_DATE_REPLACEMENT,
                    RECIPIENT_NOTE = :P20004_NOTE,
                    RECIPIENT_REASON_REQUEST = :P20004_REASON_REQUEST,
                    DISCOUNT_RATE = :P20004_DISCOUNT_RATE,
                    VOUCHER_CODE = :P20004_VOUCHER_CODE,
                    NUMBER_OF_COURSES = :P20004_NUMBER_OF_COURSES,
                    EFFECTIVE_DATE = :P20004_EFFECTIVE_DATE,
                    EXPIRATION_DATE = :P20004_EXPIRATION_DATE,
                    PROMOTION_CODE = pro_code,
                    ATTACH_FILE = :P20004_URL_FILES,
                    ATTACH_NAME = :P20004_NAME_FILES
                where id = :P20004_REQUEST_ID;

                -- thêm dòng mới vào bảng 'WORKFLOW_DETAIL' khi có thao tác 'approve'
                insert into WORKFLOW_DETAIL(
                    WD_MODIFIED_DATE,
                    WD_MODIFIED_CODE,
                    STATUS,
                    REQUEST_ID,
                    SEQUENCE,
                    WD_COMMENT
                ) 
                values(
                    sysdate,
                    :APP_EMP_CODE,
                    6,
                    emp_requests_id,
                    rec.NEXT_STEP,
                    :P20004_COMMENT
                    );

            -- gửi mail cho nhân viên duyệt tiếp theo
                -- lấy mã nhân viên duyệt tiếp theo
                v_result := get_manager_next_sequence(emp_requests_id);

                -- lấy mail nhân viên duyệt tiếp theo
                SELECT USER_NAME, FULL_NAME INTO manager_email, manager_name FROM EMPLOYEES emp WHERE emp.EMPLOYEE_CODE = v_result;

                -- --lấy thông tin của scholarship_request để gửi mail
                -- SELECT
                --     sr.REQUESTER_CODE,
                --     sr.RECIPIENT_NAME,
                --     sr.RECIPIENT_DOB,
                --     sr.RECIPIENT_PHONE,
                --     sr.PROGRAM,
                --     sr.DISCOUNT_RATE,
                --     sr.EFFECTIVE_DATE,
                --     sr.EXPIRATION_DATE
                -- INTO
                --     p_REQUESTER_CODE,
                --     p_RECIPIENT_NAME,
                --     p_RECIPIENT_DOB,
                --     p_RECIPIENT_PHONE,
                --     p_PROGRAM,
                --     p_DISCOUNT_RATE,
                --     p_EFFECTIVE_DATE,
                --     p_EXPIRATION_DATE
                -- FROM SCHOLARSHIP_REQUEST sr
                -- WHERE :P20004_REQUEST_ID = sr.ID
                
                -- lấy tên nhân viên
                SELECT FULL_NAME, USER_NAME INTO emp_name, emp_email FROM EMPLOYEES emp WHERE emp.EMPLOYEE_CODE = :P20004_EMPLOYEE_CODE;

                    -- v_body_man := v_body_man || '<img style=''width:100%'' src=''https://hcm01.vstorage.vngcloud.vn/v1/AUTH_77c1e15122904b63990a9da99711590d/LXP_Media/ERP/images/header.png''></img>';
                v_body_man := v_body_man || '<h3 style=''color:black;text-align:center''>[PHÒNG NHÂN SỰ HÀNH CHÍNH - VUS] – ĐƠN XIN CẤP HỌC BỔNG</h3>';
                v_body_man := v_body_man || '<h3 style=''color:black;text-align:center''>[HRA DEPARTMENT - VUS] – REQUEST FOR SCHOLARSHIP LETTER</h3>';
                v_body_man := v_body_man || '<p style=''color:black;margin-top:20px''>Anh/Chị '|| manager_name ||' thân mến,</p>';
                v_body_man := v_body_man || '<p style=''color:black;margin-top:0''>Dear Mr/Ms. '|| manager_name ||',</p>';
                v_body_man := v_body_man || '<p style=''color:black''>Hệ thống nhận được đề nghị xin cấp học bổng của nhân viên như sau:</p>';
                v_body_man := v_body_man || '<p style=''color:black''>Employee Portal system has received a request for scholarship as below:</p>';
                v_body_man := v_body_man || '<br>';
                v_body_man := v_body_man || '<p style=''color:black''><strong style=''color:black''>Thông tin người yêu cầu/ Bộ phận đề nghị</strong></p>';
                v_body_man := v_body_man || '<p style=''color:black''><i>Requester / Department Request</i></p>';
                -- v_body_man := v_body_man || '<ul>';
                v_body_man := v_body_man || '<p style=''color:black''><strong style=''color:black''>- Họ và tên nhân viên/ Employee Full Name:</strong> '|| emp_name ||'</p>';
                v_body_man := v_body_man || '<p style=''color:black''><strong style=''color:black''>- Mã số nhân viên/ Employee Code:</strong> '|| :P20004_EMPLOYEE_CODE ||'</p>';
                v_body_man := v_body_man || '<br>';
                v_body_man := v_body_man || '<p style=''color:black''><strong style=''color:black''>Thông tin người được miễn giảm (học viên)</strong></p>';
                v_body_man := v_body_man || '<p style=''color:black''><i>Information Of Recipient</i></p>';
                -- v_body_man := v_body_man || '<ul>';
                v_body_man := v_body_man || '<p style=''color:black''><strong style=''color:black''>- Họ và tên người nhận/ Recipient Full Name:</strong> '|| :P20004_RECIPIENT_NAME ||'</p>'; 
                v_body_man := v_body_man || '<p style=''color:black''><strong style=''color:black''>- Ngày tháng năm sinh người nhận/ Recipient DOB:</strong> '|| :P20004_RECIPIENT_DOB ||'</p>';
                v_body_man := v_body_man || '<p style=''color:black''><strong style=''color:black''>- Số điện thoại người nhận/ Recipient Phone:</strong> '|| :P20004_RECIPIENT_PHONE ||'</p>';
                v_body_man := v_body_man || '<br>';
                v_body_man := v_body_man || '<p style=''color:black''><strong style=''color:black''>Thông tin miễn giảm</strong></p>';
                v_body_man := v_body_man || '<p style=''color:black''><i>Scholarship Information</i></p>';
                -- v_body_man := v_body_man || '<ul>';
                v_body_man := v_body_man || '<p style=''color:black''><strong style=''color:black''>- Chương trình/ Program:</strong> '|| :P20004_PROGRAM ||'</p>'; 
                v_body_man := v_body_man || '<p style=''color:black''><strong style=''color:black''>- Mức miễn giảm/ Discount Rate:</strong> '|| :P20004_DISCOUNT_RATE ||'</p>';
                v_body_man := v_body_man || '<p style=''color:black''><strong style=''color:black''>- Ngày có hiệu lực/ Effective Date:</strong> '|| :P20004_EFFECTIVE_DATE ||'</p>';
                v_body_man := v_body_man || '<p style=''color:black''><strong style=''color:black''>- Ngày hết hạn/ Expiration Date:</strong> '|| :P20004_EXPIRATION_DATE ||'</p>';
                v_body_man := v_body_man || '<br>';

                v_body_man := v_body_man || '<p style=''color:black''>Vui lòng đăng nhập vào Hệ thống Quản lý nghỉ phép để xem xét và phản hồi yêu cầu. Bạn có thể phản hồi yêu cầu cấp học bổng bằng cách nhấp vào liên kết sau:</p>';
                v_body_man := v_body_man || '<p style=''color:black''>Please log in to The leave management system to review and respond the leave request. You can respond the scholarship request by clicking on the following link: <a href=\"https://erp-pilot.vus.edu.vn/ords/r/erp/erp/approve-scholarship-request?request_id=' || to_char(v_id) || '\"> link to respond the scholarship request ↗.</a></p><br>';

                v_body_man := v_body_man || '<p style=''color:black''>Nếu bạn có bất kỳ câu hỏi nào hoặc cần thêm sự hỗ trợ, xin đừng ngần ngại liên hệ với phòng Nhân sự Hành chính.</p>';
                v_body_man := v_body_man || '<p style=''color:black''>If you have any questions or need further assistance, please feel free to reach out to the HRA department.</p>';
                v_body_man := v_body_man || '<p style=''color:black''>Trân trọng,</p>';
                v_body_man := v_body_man || '<p style=''color:black''>Phòng Nhân sự Hành chính</p>';
                v_body_man := v_body_man || '<p style=''color:black''>Best regards,</p>';
                v_body_man := v_body_man || '<p style=''color:black''>HR & Admin Department </p>';
                -- v_body_man := v_body_man || '<img style=''width:100%'' src=''https://hcm01.vstorage.vngcloud.vn/v1/AUTH_77c1e15122904b63990a9da99711590d/LXP_Media/ERP/images/footer.jpg''></img>';

                SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', manager_email, 'Yêu cầu duyệt đơn xin cấp học bổng', v_body_man);
                SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'thviet615@gmail.com', 'Yêu cầu duyệt đơn xin cấp học bổng', v_body_man);

             -- gửi mail cho nhân viên tạo thông báo thành công
                -- lấy thông tin của người duyệt hiện tại
                SELECT FULL_NAME INTO current_emp_name FROM EMPLOYEES emp WHERE emp.EMPLOYEE_CODE = :APP_EMP_CODE;

                v_body_emp := v_body_emp || '<h3 style=''color:black;text-align:center''>[PHÒNG NHÂN SỰ HÀNH CHÍNH - VUS] – ĐƠN XIN CẤP HỌC BỔNG</h3>';
                v_body_emp := v_body_emp || '<h3 style=''color:black;text-align:center''>[HRA DEPARTMENT - VUS] – REQUEST FOR SCHOLARSHIP LETTER</h3>';
                v_body_emp := v_body_emp || '<p style=''color:black;margin-top:20px''>Anh/Chị '|| emp_name ||' thân mến,</p>';
                v_body_emp := v_body_emp || '<p style=''color:black;margin-top:0''>Dear Mr/Ms. '|| emp_name ||',</p>';
                v_body_emp := v_body_emp || '<p style=''color:black''>Đơn của anh/chị đã được duyệt bởi nhân viên quản lý có thông tin sau:</p>';
                v_body_emp := v_body_emp || '<p style=''color:black''>Your application has been approved by a manager with the following information as below:</p>';
                v_body_emp := v_body_emp || '<p style=''color:black''><strong style=''color:black''>- Họ và tên quản lý/ Manager Full Name:</strong> '|| current_emp_name ||'</p>';
                v_body_emp := v_body_emp || '<p style=''color:black''><strong style=''color:black''>- Mã số quản lý/ Manager Code:</strong> '|| :APP_EMP_CODE ||'</p>';
                v_body_emp := v_body_emp || '<br>';

                v_body_emp := v_body_emp || '<p style=''color:black''>Vui lòng tiếp tục chờ đợi lượt phê duyệt tiếp theo trong 3 - 5 ngày:</p>';
                v_body_emp := v_body_emp || '<p style=''color:black''>Please log in to The leave management system to review and respond the leave request. You can respond the scholarship request by clicking on the following link: <a href=\"https://erp-pilot.vus.edu.vn/ords/r/erp/erp/approve-scholarship-request?request_id=' || to_char(v_id) || '\"> link to respond the scholarship request ↗.</a></p><br>';

                v_body_emp := v_body_emp || '<p style=''color:black''>Nếu bạn có bất kỳ câu hỏi nào hoặc cần thêm sự hỗ trợ, xin đừng ngần ngại liên hệ với phòng Nhân sự Hành chính.</p>';
                v_body_emp := v_body_emp || '<p style=''color:black''>If you have any questions or need further assistance, please feel free to reach out to the HRA department.</p>';
                v_body_emp := v_body_emp || '<p style=''color:black''>Trân trọng,</p>';
                v_body_emp := v_body_emp || '<p style=''color:black''>Phòng Nhân sự Hành chính</p>';
                v_body_emp := v_body_emp || '<p style=''color:black''>Best regards,</p>';
                v_body_emp := v_body_emp || '<p style=''color:black''>HR & Admin Department </p>';
                -- v_body_emp := v_body_emp || '<img style=''width:100%'' src=''https://hcm01.vstorage.vngcloud.vn/v1/AUTH_77c1e15122904b63990a9da99711590d/LXP_Media/ERP/images/footer.jpg''></img>';

                SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', emp_email, 'Thông báo trạng thái đơn xin cấp học bổng', v_body_emp);
                SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'thviet615@gmail.com', 'Thông báo trạng thái đơn xin cấp học bổng', v_body_emp);

            else
                -- cập nhật bảng EMP_REQUESTS về trạng thái 'active'                
                update EMP_REQUESTS 
                set MODIFIED_DATE = sysdate,
                    CURRENT_STEP = rec.NEXT_STEP,
                    MODIFIED_BY_CODE = :APP_EMP_CODE,
                    STATUS = 3 
                where REQUEST_DETAIL_ID = :P20004_REQUEST_ID and REQUEST_TYPE = :P20004_FEATURE;

                -- cập nhật bảng SCHOLARSHIP_REQUEST về trạng thái 'active'
                update SCHOLARSHIP_REQUEST 
                set STATUS = 3,
                    RECIPIENT_CAMPUS = :P20004_CAMPUS,
                    RECIPIENT_REPLACEMENT = :P20004_REPLACEMENT,
                    RECIPIENT_VOUCHER_CODE_REPLACEMENT = :P20004_VOUCHER_CODE_REPLACEMENT,
                    RECIPIENT_EXPIRATION_DATE_REPLACEMENT = :P20004_EXPIRATION_DATE_REPLACEMENT,
                    RECIPIENT_NOTE = :P20004_NOTE,
                    RECIPIENT_REASON_REQUEST = :P20004_REASON_REQUEST,
                    DISCOUNT_RATE = :P20004_DISCOUNT_RATE,
                    VOUCHER_CODE = :P20004_VOUCHER_CODE,
                    NUMBER_OF_COURSES = :P20004_NUMBER_OF_COURSES,
                    EFFECTIVE_DATE = :P20004_EFFECTIVE_DATE,
                    EXPIRATION_DATE = :P20004_EXPIRATION_DATE,
                    PROMOTION_CODE = pro_code,
                    ATTACH_FILE = :P20004_URL_FILES,
                    ATTACH_NAME = :P20004_NAME_FILES
                where id = :P20004_REQUEST_ID;

                -- thêm dòng mới vào bảng 'WORKFLOW_DETAIL' khi 'active'
                insert into WORKFLOW_DETAIL(
                    WD_MODIFIED_DATE,
                    WD_MODIFIED_CODE,
                    STATUS,
                    REQUEST_ID,
                    SEQUENCE,
                    WD_COMMENT
                ) 
                values(
                    sysdate,
                    :APP_EMP_CODE,
                    3,
                    emp_requests_id,
                    rec.NEXT_STEP,
                    :P20004_COMMENT
                    );

                -- trường hợp replacement được chấp nhận, đổi status của voucher bị replace thành in-active (7)
                if :P20004_REPLACEMENT is not null then
                    select id into id_replace from SCHOLARSHIP_REQUEST where VOUCHER_CODE = :P20004_REPLACEMENT;
                    select id into emp_requests_id_replace from EMP_REQUESTS where REQUEST_DETAIL_ID = id_replace and  REQUEST_TYPE = :P20004_FEATURE;

                    update SCHOLARSHIP_REQUEST
                    set STATUS = 7
                    where id = id_replace;

                    update EMP_REQUESTS 
                    set STATUS = 7 
                    where REQUEST_DETAIL_ID = id_replace and REQUEST_TYPE = :P20004_FEATURE;
                    
                    -- thêm trạng thái in-active vào workflow_detail
                    insert into WORKFLOW_DETAIL(
                        WD_MODIFIED_DATE,
                        WD_MODIFIED_CODE,
                        STATUS,
                        REQUEST_ID,
                        WD_COMMENT
                    ) 
                    values(
                        sysdate,
                        :APP_EMP_CODE,
                        7,
                        emp_requests_id_replace,
                        :P20004_COMMENT
                        );
                end if;
            end if;
            
            -- insert into WORKFLOW_DETAIL(
            --     WD_MODIFIED_DATE,
            --     WD_MODIFIED_CODE,
            --     STATUS,
            --     REQUEST_ID,
            --     SEQUENCE,
            --     WD_COMMENT
            --     ) 
            -- values(
            --     sysdate,
            --     :APP_EMP_CODE,
            --     3,
            --     :P20004_REQUEST_ID,
            --     rec.NEXT_STEP,
            --     :P20004_COMMENT
            --     );
        end loop;


-- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'thviet613@gmail.com', 'Scholarship Request Submitted Successfully', '<p> Dear '|| :APP_USER_NAME ||', </p>' ||
-- '<p> Your Scholarship Request has been submitted successfully. Here are the details: </p>' ||

-- '<p> If you have any questions or need further assistance, please feel free to reach out to the HR department. </p>' ||
-- '<br>' || 
-- '<p> Thank you, </p>' ||
-- '<p> VUS </p>');

end;