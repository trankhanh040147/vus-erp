declare
c_date date := to_char(sysdate,'MM/DD/YYYY');
-- SCHOLARSHIP_REQUEST_ID NUMBER;
line_manager_code nvarchar2(50);
emp_requests_id number;
response_log nvarchar2(1000); 
response_status nvarchar2(100);
-- for sending mail
v_body_man clob := '';
manager_email nvarchar2(100);
manager_name nvarchar2(100);
emp_name nvarchar2(100);

discount_rate number;

begin

    -- Get emp_requests_id
    select ID
    into emp_requests_id
    from EMP_REQUESTS er where :P20002_REQUEST_ID = er.REQUEST_DETAIL_ID and lower(REQUEST_TYPE) = lower(:P20002_FEATURE);

    SELECT MANAGER_ID INTO line_manager_code 
    FROM EMPLOYEES 
    WHERE EMPLOYEE_CODE = :APP_EMP_CODE;

    -- lấy giá trị của discount_rate bằng id
    SELECT DISCOUNT_RATE INTO discount_rate
    FROM COREEDU_PROMOTION
    WHERE :P20002_DISCOUNT_RATE = ID;

    -- cập nhật bảng SCHOLARSHIP_REQUEST 
    UPDATE SCHOLARSHIP_REQUEST sr
    SET STATUS = 2,
        -- REQUESTER_CODE = 
        --     CASE 
        --         WHEN :P20002_SCHOLARSHIP_RECIPIENT = 'D' THEN :P20002_REQUEST_NAME
        --         ELSE :P20002_EMPLOYEE_CODE
        --     END,
        -- REQUESTER_DEPARTMENT = :P20002_DEPARTMENT,
        -- REQUESTER_DEPARTMENT_CODE = :P20002_DEPARTMENT_CODE,
        -- REQUESTER_LEVEL = :P20002_LEVEL,
        PARTNER_NAME = :P20002_PARTNER_NAME,
        PARTNER_PHONE = :P20002_PARTNER_PHONE,
        PARTNER_TITLE = :P20002_TITLE,
        PARTNER_DEPARTMENT = :P20002_PARTNER_DEPARTMENT,
        PARTNER_FIELD = :P20002_FIELD,
        PARTNER_WORKPLACE = :P20002_WORKPLACE,
        RECIPIENT_NAME = :P20002_RECIPIENT_NAME,
        RECIPIENT_DOB = :P20002_RECIPIENT_DOB,
        RECIPIENT_PHONE = :P20002_RECIPIENT_PHONE,
        RECIPIENT_RELATIONSHIP = :P20002_RELATIONSHIP,
        RECIPIENT_CAMPUS = :P20002_CAMPUS,
        ATTACH_NAME = :P20002_NAME_FILES,
        ATTACH_FILE = :P20002_URL_FILES,
        RECIPIENT_REPLACEMENT = :P20002_REPLACEMENT,
        RECIPIENT_VOUCHER_CODE_REPLACEMENT = :P20002_VOUCHER_CODE_REPLACEMENT,
        RECIPIENT_EXPIRATION_DATE_REPLACEMENT = :P20002_EXPIRATION_DATE_REPLACEMENT,
        RECIPIENT_NOTE = :P20002_NOTE,
        RECIPIENT_REASON_REQUEST = :P20002_REASON_REQUEST,
        DISCOUNT_RATE = discount_rate,
        VOUCHER_CODE = :P20002_VOUCHER_CODE,
        NUMBER_OF_COURSES = :P20002_NUMBER_OF_COURSES,
        EFFECTIVE_DATE = :P20002_EFFECTIVE_DATE,
        EXPIRATION_DATE = :P20002_EXPIRATION_DATE,
        APPROVED_DATE = :P20002_APPROVED_DATE,
        CREATED_DATE = c_date,
        ID_COREEDU_PROMOTION = :P20002_DISCOUNT_RATE
    WHERE :P20002_REQUEST_ID = sr.ID;

    -- Insert into EMP_REQUEST
        
   UPDATE EMP_REQUESTS emp
   SET
        STATUS = 2,
        NOTE = 
            CASE 
                WHEN :P20002_SCHOLARSHIP_RECIPIENT = 'A' OR :P20002_SCHOLARSHIP_RECIPIENT = 'B' THEN :P20002_NOTE
                ELSE :P20002_REASON_REQUEST
            END
    WHERE :P20002_REQUEST_ID = emp.REQUEST_DETAIL_ID and LOWER(REQUEST_TYPE) = LOWER(:P20002_FEATURE);

    -- Insert into workflow_detail
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
        2,
        emp_requests_id,
        CASE 
            WHEN :P20002_SCHOLARSHIP_RECIPIENT = 'A' OR :P20002_SCHOLARSHIP_RECIPIENT = 'B' THEN :P20002_NOTE
            ELSE :P20002_REASON_REQUEST
        END
        );

    -- Insert ATTACHMENT_HISTORY
    IF(remove_first_semicolon(:P20002_DEFAULT_IMAGES_URL) != :P20002_URL_FILES or
       ( :P20002_REQUEST_ID is null and :P20002_URL_FILES is not null )) 
    THEN
        INSERT INTO ATTACHMENT_HISTORY (ATTACHMENT_DATE, EMPLOYEE_CODE, ATTACHMENT_URL, ATTACHMENT_NAME, REQUEST_ID)
        VALUES(sysdate, :APP_EMP_CODE, :P20002_URL_FILES, :P20002_NAME_FILES, emp_requests_id);
    END IF;

    -- Write log attachments
    -- INSERT INTO OUTPUT_LOGS(NUMBER1, STR1, STR2, STR3)
    -- VALUES (emp_requests_id, 'submit_scho', :P20002_DEFAULT_IMAGES_URL, :P20002_URL_FILES);
    
    if :P20002_IS_HR_ADMIN = 1 and :P20002_SCHOLARSHIP_RECIPIENT = 'D' then
        UPDATE EMP_REQUESTS
        SET STATUS = 3
        WHERE REQUEST_DETAIL_ID = :P20002_REQUEST_ID AND lower(REQUEST_TYPE) = lower(:P20002_FEATURE);

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
            3,
            emp_requests_id,
            'Auto Approve'
            );

        SP_SAVE_SPEACIAL_CUSTOMER_COREEDU(:P20002_REQUEST_ID, lower(:P20002_FEATURE), response_log, response_status);
    else

        -- send mail to line line_manager
        -- SELECT USER_NAME, FULL_NAME INTO manager_email, manager_name FROM EMPLOYEES emp WHERE emp.EMPLOYEE_CODE = line_manager_code;
        if lower(:P20002_LEVEL_ID) = 'c' and :P20002_SCHOLARSHIP_RECIPIENT = 'D' then
            SELECT USER_NAME, FULL_NAME INTO manager_email, manager_name FROM EMPLOYEES emp WHERE IS_HR_ADMIN = 1 AND ROWNUM = 1;
        else
            SELECT USER_NAME, FULL_NAME INTO manager_email, manager_name FROM EMPLOYEES emp WHERE emp.EMPLOYEE_CODE = line_manager_code;
        end if;

        SELECT FULL_NAME INTO emp_name FROM EMPLOYEES emp WHERE emp.EMPLOYEE_CODE = :APP_EMP_CODE;

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
        v_body_man := v_body_man || '<p style=''color:black''><strong style=''color:black''>- Họ và tên nhân viên / Employee Full Name:</strong> '|| emp_name ||'</p>';
        
        if :P20002_SCHOLARSHIP_RECIPIENT = 'A' OR :P20002_SCHOLARSHIP_RECIPIENT = 'B' then 
            v_body_man := v_body_man || '<p style=''color:black''><strong style=''color:black''>- Mã số nhân viên / Employee Code:</strong> '|| :APP_EMP_CODE ||'</p>';
        else
            v_body_man := v_body_man || '<p style=''color:black''><strong style=''color:black''>- Phòng ban / Department:</strong> '|| :P20002_DEPARTMENT ||'</p>';
        end if;

        v_body_man := v_body_man || '<br>';
        v_body_man := v_body_man || '<p style=''color:black''><strong style=''color:black''>Thông tin người nhận học bổng (học viên)</strong></p>';
        v_body_man := v_body_man || '<p style=''color:black''><i>Information Of Recipient</i></p>';
        -- v_body_man := v_body_man || '<ul>';
        v_body_man := v_body_man || '<p style=''color:black''><strong style=''color:black''>- Họ và tên người nhận / Recipient Full Name:</strong> '|| :P20002_RECIPIENT_NAME ||'</p>'; 
        v_body_man := v_body_man || '<p style=''color:black''><strong style=''color:black''>- Ngày tháng năm sinh người nhận / Recipient DOB:</strong> '|| :P20002_RECIPIENT_DOB ||'</p>';
        v_body_man := v_body_man || '<p style=''color:black''><strong style=''color:black''>- Số điện thoại người nhận / Recipient Phone:</strong> '|| :P20002_RECIPIENT_PHONE ||'</p>';
        v_body_man := v_body_man || '<br>';
        v_body_man := v_body_man || '<p style=''color:black''><strong style=''color:black''>Thông tin học bổng</strong></p>';
        v_body_man := v_body_man || '<p style=''color:black''><i>Scholarship Information</i></p>';
        -- v_body_man := v_body_man || '<ul>';
        v_body_man := v_body_man || '<p style=''color:black''><strong style=''color:black''>- Chương trình / Program:</strong> '|| :P20002_PROGRAM ||'</p>'; 
        v_body_man := v_body_man || '<p style=''color:black''><strong style=''color:black''>- Mức miễn giảm / Discount Rate:</strong> '|| discount_rate ||'%</p>';
        v_body_man := v_body_man || '<p style=''color:black''><strong style=''color:black''>- Ngày có hiệu lực / Effective Date:</strong> '|| :P20002_EFFECTIVE_DATE ||'</p>';
        v_body_man := v_body_man || '<p style=''color:black''><strong style=''color:black''>- Ngày hết hạn / Expiration Date:</strong> '|| :P20002_EXPIRATION_DATE ||'</p>';
        v_body_man := v_body_man || '<br>';

        v_body_man := v_body_man || '<p style=''color:black''>Vui lòng đăng nhập vào Hệ thống Quản lý Học bổng để xem xét và phản hồi yêu cầu. Bạn có thể phản hồi yêu cầu cấp học bổng bằng cách nhấp vào liên kết sau:</p>';
        v_body_man := v_body_man || '<p style=''color:black''>Please log in to The scholarship management system to review and respond the scholarship request. You can respond the scholarship request by clicking on the following link: <a href=\"https://erp-pilot.vus.edu.vn/ords/r/erp/erp/approve-scholarship-request?request_id=' || to_char(:P20002_REQUEST_ID) || '\"> link to respond the scholarship request ↗.</a></p><br>';

        v_body_man := v_body_man || '<p style=''color:black''>Nếu bạn có bất kỳ câu hỏi nào hoặc cần thêm sự hỗ trợ, xin đừng ngần ngại liên hệ với phòng Nhân sự Hành chính.</p>';
        v_body_man := v_body_man || '<p style=''color:black''>If you have any questions or need further assistance, please feel free to reach out to the HRA department.</p>';
        v_body_man := v_body_man || '<p style=''color:black''>Trân trọng,</p>';
        v_body_man := v_body_man || '<p style=''color:black''>Phòng Nhân sự Hành chính</p>';
        v_body_man := v_body_man || '<p style=''color:black''>Best regards,</p>';
        v_body_man := v_body_man || '<p style=''color:black''>HR & Admin Department </p>';
        -- v_body_man := v_body_man || '<img style=''width:100%'' src=''https://hcm01.vstorage.vngcloud.vn/v1/AUTH_77c1e15122904b63990a9da99711590d/LXP_Media/ERP/images/footer.jpg''></img>';

        SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', manager_email, 'Yêu cầu duyệt đơn xin cấp học bổng', v_body_man);
        SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'thviet615@gmail.com', 'Yêu cầu duyệt đơn xin cấp học bổng', v_body_man);
    end if;
end;