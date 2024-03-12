create or replace PROCEDURE "SP_CREATE_REQUEST_FIN_TESTING"
(
p_employeeCode nvarchar2,
p_request_id number
)
is
l_token_type NVARCHAR2(2000);
l_body NVARCHAR2(2000);
l_response clob;
l_response_clob clob;
l_numrow number;
l_rowsub number;
l_body_mail NVARCHAR2(2000);
n_id number;
n_employeeCode NVARCHAR2(200);
n_legal_entity NVARCHAR2(200);
n_request_type_name NVARCHAR2(200);
n_company_email NVARCHAR2(200);
n_full_name NVARCHAR2(200);
n_token_value NVARCHAR2(2000);
n_token NVARCHAR2(5000);
n_approve_date nvarchar2(200);
n_carry_forward_code nvarchar2(200);
n_accrual_id nvarchar2(100);
n_total_day number:= 0;
leave_id nvarchar2(100);
leave_groupid nvarchar2(100);
transaction_date nvarchar2(100);
adjustment_type nvarchar2(20) := 'Amount Used';
rsp_status nvarchar2(50);
leave_type nvarchar2(200);
v_body clob := ''; -- body of mail
BEGIN

    SELECT TO_CHAR(SYSDATE, 'MM/DD/YYYY') INTO n_approve_date FROM DUAL;
    SELECT VALUE INTO n_token_value FROM APPLICATIONS_CONFIGS WHERE KEY = 'TOKEN' AND ROWNUM = 1;
    SP_GET_TOKEN(n_token);
    apex_web_service.g_request_headers.delete();    
    apex_web_service.g_request_headers(1).name := 'Authorization';
    apex_web_service.g_request_headers(1).value := 'Bearer '|| n_token;
    
    apex_web_service.g_request_headers(2).name := 'Content-Type';
    apex_web_service.g_request_headers(2).value := 'application/json; charset=utf-8';

            
    -- SELECT USER_NAME INTO n_manager_company_email FROM EMPLOYEES WHERE EMPLOYEE_CODE = (SELECT MANAGER_ID FROM EMPLOYEES WHERE EMPLOYEE_CODE = p_employeeCode) AND NVL(USER_NAME, '0') <> '0';
    SELECT USER_NAME, FULL_NAME INTO n_company_email, n_full_name FROM EMPLOYEES WHERE EMPLOYEE_CODE = p_employeeCode;

    SELECT BENEFIT_CODE, LEAVE_TYPE INTO leave_id, leave_groupid FROM EMPLOYEE_REQUESTS WHERE ID = p_request_id;
    SELECT TO_CHAR(SYSDATE, 'MM/DD/YYYY') INTO transaction_date  FROM DUAL;

    DBMS_OUTPUT.put_line('id: ' || leave_id);
    DBMS_OUTPUT.put_line('group_id: ' || leave_groupid);
    DBMS_OUTPUT.put_line('trans_date: ' || transaction_date);

    
    for rec in (select er.*,emp.DATAAREA,age.DAY_APPROVE,age.BENEFIT_ACCRUAL_PLAN,age.HRM_ABSENCE_CODE_GROUP_ID,
    age.HRM_ABSENCE_CODE_ID,age.CARRY_FORWORD_EXP_DATE,age.CARRY_FORWARD_CODE,age.CF_BENEFIT_ACCRUAL_PLAN,age.CARRY_FORWARD_AVALABLE,
        -- case 
        -- when age.HRM_ABSENCE_CODE_ID like 'ALPL%' then
        --     'Amount Used'
        -- when age.HRM_ABSENCE_CODE_ID like 'ALCF%' then
        --     'Amount Used'
        -- else
        --     -- null     cũ
        --     'Amount Used'       -- 29/2/24-Viet
        -- end as ADJUSTMENTTYPE,
        case 
        when er.ALL_DAY like 'Y' then
            'Yes'
        else
            'No'
        end as ALLDAY,
        case 
            when age.HRM_ABSENCE_CODE_GROUP_ID = 'APL' then
                'Leave'
        end as CONVERTED_HRM_ABSENCE_CODE_GROUP_ID,
        case 
            when er.ALL_DAY like 'N' then er.FROM_DATE -- Set END_DATE to FROM_DATE if ALLDAY is 'N'
            else er.END_DATE
        end as MODIFIED_END_DATE

        from EMPLOYEE_REQUESTS er join ABSENCE_GROUP_EMPLOYEE age on er.EMPLOYEE_CODE_REQ = age.EMPLOYEE_CODE
        join EMPLOYEES emp on emp.EMPLOYEE_CODE = age.EMPLOYEE_CODE
        where er.ID = p_request_id and emp.EMPLOYEE_CODE = p_employeeCode 
        and lower(er.LEAVE_TYPE) = lower(age.HRM_ABSENCE_CODE_GROUP_ID)
    )loop
    
    if rec.CRF_DAY_TEMP > 0 then
        n_carry_forward_code := rec.CARRY_FORWARD_CODE;
        n_accrual_id := rec.CF_BENEFIT_ACCRUAL_PLAN;
    else
        n_carry_forward_code := rec.HRM_ABSENCE_CODE_ID;
        n_accrual_id := rec.BENEFIT_ACCRUAL_PLAN;
    end if;
    n_total_day := rec.TOTAL_DAYS;

    if leave_groupid = 'APL' then
        l_body := '{
        "_jsonRequest":{
            "LegalEntityID": "'||rec.DATAAREA||'",
            "AdjustedHours": "'||to_char(n_total_day,'90.9')||'",
            "AdjustmentType": "'||adjustment_type||'",
            "TransactionDate": "'||rec.FROM_DATE||'",
            "Description": "'||rec.NOTE||'",
            "EmployeeCode": "'||p_employeeCode||'", 
            "AccrualId": "'||n_accrual_id||'", 
            "IDPortal": "'||rec.ID||'",
            "IDStrPortal": "'||rec.ID||'",
            "FromDate": "'||rec.FROM_DATE||'",
            "ToDate": "'||rec.MODIFIED_END_DATE||'",
            "NumberDayOff": "'||to_char(n_total_day,'90.9')||'",
            "StartTime": "'||rec.START_TIME||':00",
            "EndTime": "'||rec.END_TIME||':00",
            "HRMAbsenceCodeGroupId": "'||rec.CONVERTED_HRM_ABSENCE_CODE_GROUP_ID||'",
            "HRMAbsenceCodeId": "'||n_carry_forward_code||'",
            "AllDay": "'||rec.ALLDAY||'",
            "AttachmentURL": "'||rec.ATTATCH_FILE||'"
        }}';
    else 
        l_body := '{
        "_jsonRequest":{
            "LegalEntityID": "'||rec.DATAAREA||'",
            "AdjustedHours": "'||to_char(n_total_day,'90.9')||'",
            "AdjustmentType": "'||adjustment_type||'",
            "TransactionDate": "'||rec.FROM_DATE||'",
            "Description": "'||rec.NOTE||'",
            "EmployeeCode": "'||p_employeeCode||'", 
            "AccrualId": "'||leave_id||'", 
            "IDStrPortal": "'||rec.ID||'",
            "FromDate": "'||rec.FROM_DATE||'",
            "ToDate": "'||rec.MODIFIED_END_DATE||'",
            "NumberDayOff": "'||to_char(n_total_day,'90.9')||'",
            "StartTime": "'||rec.START_TIME||':00",
            "EndTime": "'||rec.END_TIME||':00",
            "HRMAbsenceCodeGroupId": "'||leave_groupid||'",
            "HRMAbsenceCodeId": "'||leave_id||'",
            "AllDay": "'||rec.ALLDAY||'",
            "AttachmentURL": "'||rec.ATTATCH_FILE||'"
        }}';
    end if;


    -- Send mail
    -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', n_company_email, 'Leave Request Approved', '<p> Dear '|| n_full_name ||', </p>' ||
    --     '<p>Your leave request has been approved. Here are the details:</p>' ||
    --     '<p> Employee Code: '|| p_employeeCode ||' </p>' ||
    --     '<p> Total Days: '|| n_total_day ||' </p>' ||
    --     '<p> From Date: '|| rec.FROM_DATE ||' </p>' ||
    --     '<p> To Date: '|| rec.MODIFIED_END_DATE ||' </p>' ||
    --     '<br>' || 
    --     '<p>Feel free to proceed with your leave plans accordingly.</p>' ||
    --     '<br>' || 
    --     '<p> If you have any questions or need further assistance, please feel free to reach out to the HR department. </p>' ||
    --     '<br>' || 
    --     '<p> Thank you, </p>' ||
    --     '<p> VUS </p>');

    end loop;

/*
{
    "_jsonRequest":{
        "LegalEntityID": "V01",
        "AdjustedHours": "  1.0",
        "AdjustmentType": "Amount Used",
        "TransactionDate": "08/23/2023",
        "Description": "TEST LEAVEREQUEST 01",
        "EmployeeCode": "000053", 
        "AccrualId": "ALPL18 2023", 
        "IDPortal": "437",
        "IDStrPortal": "437a",
        "FromDate": "08/23/2023",
        "ToDate": "08/23/2023",
        "NumberDayOff": "  1.0",
        "StartTime": "00:00:00",
        "EndTime": "00:00:00",
        "HRMAbsenceCodeGroupId": "Leave",
        "HRMAbsenceCodeId": "ALPL18",
        "AllDay": "Yes"
    }}
*/       
        DBMS_OUTPUT.put_line('body: ');
        DBMS_OUTPUT.put_line(l_body);
        DBMS_OUTPUT.put_line('-----------------');
        --APEX_JSON.parse(

    -- Send mail
    for rec in (select er.*,emp.DATAAREA,age.DAY_APPROVE,age.BENEFIT_ACCRUAL_PLAN,age.HRM_ABSENCE_CODE_GROUP_ID,
    age.HRM_ABSENCE_CODE_ID,age.CARRY_FORWORD_EXP_DATE,age.CARRY_FORWARD_CODE,age.CF_BENEFIT_ACCRUAL_PLAN,age.CARRY_FORWARD_AVALABLE,
        -- case 
        -- when age.HRM_ABSENCE_CODE_ID like 'ALPL%' then
        --     'Amount Used'
        -- when age.HRM_ABSENCE_CODE_ID like 'ALCF%' then
        --     'Amount Used'
        -- else
        --     null
        -- end as ADJUSTMENTTYPE,
        case 
        when er.ALL_DAY like 'Y' then
            'Yes'
        else
            'No'
        end as ALLDAY,
        case 
            when age.HRM_ABSENCE_CODE_GROUP_ID = 'APL' then
                'Leave'
        end as CONVERTED_HRM_ABSENCE_CODE_GROUP_ID,
        case 
            when er.ALL_DAY like 'N' then er.FROM_DATE -- Set END_DATE to FROM_DATE if ALLDAY is 'N'
            else er.END_DATE
        end as MODIFIED_END_DATE

        from EMPLOYEE_REQUESTS er join ABSENCE_GROUP_EMPLOYEE age on er.EMPLOYEE_CODE_REQ = age.EMPLOYEE_CODE
        join EMPLOYEES emp on emp.EMPLOYEE_CODE = age.EMPLOYEE_CODE
        where er.ID = p_request_id and emp.EMPLOYEE_CODE = p_employeeCode and EXPIRATION_DATE >= to_char(sysdate,'MM/DD/YYYY')
    )loop
            if rec.CARRY_FORWORD_EXP_DATE >= to_char(sysdate,'MM/DD/YYYY') then
                if rec.CARRY_FORWARD_AVALABLE > 0 then
                    n_carry_forward_code := rec.CARRY_FORWARD_CODE;
                    n_accrual_id := rec.CF_BENEFIT_ACCRUAL_PLAN;
                    n_total_day := rec.TOTAL_DAYS;
                else
                    n_carry_forward_code := rec.HRM_ABSENCE_CODE_ID;
                    n_accrual_id := rec.BENEFIT_ACCRUAL_PLAN;
                    n_total_day := rec.TOTAL_DAYS;
                end if;
                    
            else
                    n_carry_forward_code := rec.HRM_ABSENCE_CODE_ID;
                    n_accrual_id := rec.BENEFIT_ACCRUAL_PLAN;
                    n_total_day := rec.TOTAL_DAYS;
            end if;

            -- select leave type description
            SELECT ACGL_DESCRIPTION INTO leave_type from ABSENCE_CODE_GROUP_LIST where rec.LEAVE_TYPE = ACGL_ABSENCE_GROUP_ID;

    -- SP_SENDGRID_EMAIL
        -- v_body := v_body || '<img style=''width:100%'' src=''https://hcm01.vstorage.vngcloud.vn/v1/AUTH_77c1e15122904b63990a9da99711590d/LXP_Media/ERP/images/header.png''></img>';
        -- v_body := v_body || '<h3 style=''color:black;text-align:center''>[PHÒNG NHÂN SỰ HÀNH CHÍNH - VUS] – ĐƠN XIN NGHỈ PHÉP</h3>';
        -- v_body := v_body || '<h3 style=''color:black;text-align:center''>[HRA DEPARTMENT - VUS] – REQUEST FOR LEAVE LETTER</h3>';
        -- v_body := v_body || '<p style=''color:black;margin-top:20px''>Anh/Chị '|| n_full_name ||' thân mến,</p>';
        -- v_body := v_body || '<p style=''color:black;margin-top:0''>Dear Mr/Ms. '|| n_full_name ||',</p>';
        -- v_body := v_body || '<p style=''color:black''>Hệ thống nhận được đề nghị xin nghỉ phép của nhân viên như sau:</p>';
        -- v_body := v_body || '<p style=''color:black''>Employee Portal system has received a request for leave as below:</p>';
        -- v_body := v_body || '<ul>';
        -- v_body := v_body || '<p style=''color:black''><strong style=''color:black''>- Họ và tên/ Full name:</strong> '|| n_full_name ||'</p>';
        -- v_body := v_body || '<p style=''color:black''><strong style=''color:black''>- Mã số nhân viên/ Employee Code:</strong> '|| p_employeeCode ||'</p>';
        -- v_body := v_body || '<p style=''color:black''><strong style=''color:black''>- Loại phép/ Leave Type:</strong> '|| leave_type ||'</p>';
        -- if (rec.TOTAL_DAYS <= 0.5) then
        --     v_body := v_body || '<p style=''color:black''><strong style=''color:black''>- Tổng Số Ngày/ Total Days:</strong> '|| to_char(rec.TOTAL_DAYS,'0.0') ||'</p>';
        --     v_body := v_body || '<p style=''color:black''><strong style=''color:black''>- Từ Ngày/ From Date:</strong> '|| to_char(rec.FROM_DATE, 'DD/MM/YYYY') ||'</p>';
        --     v_body := v_body || '<p style=''color:black''><strong style=''color:black''>- Đến Ngày/ To Date:</strong> '|| to_char(rec.MODIFIED_END_DATE, 'DD/MM/YYYY') ||'</p>';
        --     v_body := v_body || '<p style=''color:black''><strong style=''color:black''>- Từ/ Start Time:</strong> '|| rec.START_TIME ||'</p>';
        --     v_body := v_body || '<p style=''color:black''><strong style=''color:black''>- Đến/ To Time:</strong> '|| rec.END_TIME ||'</p>';
        -- else
        --     v_body := v_body || '<p style=''color:black''><strong style=''color:black''>- Tổng Số Ngày/ Total Days:</strong> '|| rec.TOTAL_DAYS ||'</p>';
        --     v_body := v_body || '<p style=''color:black''><strong style=''color:black''>- Từ Ngày/ From Date:</strong> '|| to_char(rec.FROM_DATE, 'DD/MM/YYYY') ||'</p>';
        --     v_body := v_body || '<p style=''color:black''><strong style=''color:black''>- Đến Ngày/ To Date:</strong> '|| to_char(rec.MODIFIED_END_DATE, 'DD/MM/YYYY') ||'</p>';
        -- end if;
        -- v_body := v_body || '<p style=''color:black''><strong style=''color:black''>- Ghi Chú/ Note:</strong> '|| rec.NOTE ||'</p>';
        -- v_body := v_body || '</ul><br>';
        -- v_body := v_body || '<p style=''color:black''>Đơn xin nghỉ phép của bạn đã được phê duyệt!</p>';
        -- v_body := v_body || '<p style=''color:black''>Your leave request has been approved!</p>';
        -- v_body := v_body || '<p style=''color:black''>Hãy thoải mái thực hiện kế hoạch nghỉ phép của bạn.</p>';
        -- v_body := v_body || '<p style=''color:black''>Feel free to proceed with your leave plans accordingly.</p><br>';

        -- v_body := v_body || '<p style=''color:black''>Nếu bạn có bất kỳ câu hỏi nào hoặc cần thêm sự hỗ trợ, xin đừng ngần ngại liên hệ với phòng Nhân sự Hành chính.</p>';
        -- v_body := v_body || '<p style=''color:black''>If you have any questions or need further assistance, please feel free to reach out to the HRA department.</p>';
        -- v_body := v_body || '<p style=''color:black''>Trân trọng,</p>';
        -- v_body := v_body || '<p style=''color:black''>Phòng Nhân sự Hành chính</p>';
        -- v_body := v_body || '<p style=''color:black''>Best regards,</p>';
        -- v_body := v_body || '<p style=''color:black''>HR & Admin Department </p>';
        -- v_body := v_body || '<img style=''width:100%'' src=''https://hcm01.vstorage.vngcloud.vn/v1/AUTH_77c1e15122904b63990a9da99711590d/LXP_Media/ERP/images/footer.jpg''></img>';

        -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', n_company_email, 'Phê duyệt đơn xin nghỉ phép', v_body);
        -- -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'thviet615@gmail.com', 'Phê duyệt đơn xin nghỉ phép', v_body);
        v_body := v_body || 
            '<img style=''width:100%'' src=''https://hcm01.vstorage.vngcloud.vn/v1/AUTH_77c1e15122904b63990a9da99711590d/LXP_Media/ERP/images/header.png''></img>';
        v_body := v_body || 
            '<h3 style=''text-align: center; margin: 0px; padding: 0px''>[PHÒNG NHÂN SỰ HÀNH CHÍNH - VUS] – XÁC NHẬN YÊU CẦU NGHỈ</h3>';
        v_body := v_body || 
            '<h3 style=''text-align: center; margin: 0px; padding: 0px; font-style: italic; font-weight: 400;''>[HRA DEPARTMENT - VUS] – LEAVE REQUEST CONFIRMATION</h3>';
        v_body := v_body || 
            -- '<p style=''color:black;margin-top:20px''>Anh/Chị '|| n_full_name ||' thân mến,</p>';
            '<p style=''padding-top: 20px; margin: 0''>Anh/Chị '|| n_full_name ||' thân mến,</p>';
        v_body := v_body || 
            -- '<p style=''color:black;margin-top:0''>Dear Mr/Ms. '|| n_full_name ||',</p>';
            '<p style=''margin: 0; font-style: italic''>Dear Mr/Ms. '|| n_full_name ||',</p>';
        v_body := v_body || 
            -- '<p style=''color:black''>Hệ thống nhận được đề nghị xin nghỉ phép của nhân viên như sau:</p>';
            '<p style=''padding-top: 20px; margin: 0''>Đơn yêu cầu nghỉ của Anh/Chị đã được phê duyệt:</p>';
        v_body := v_body || 
            -- '<p style=''color:black''>Employee Portal system has received a request for leave as below:</p>';
            '<p style=''margin: 0; font-style: italic''>Your leave request has been approved:</p>';
        v_body := v_body || 
            '<ul>';
        v_body := v_body || 
            -- '<p style=''color:black''><strong style=''color:black''>- Họ và tên/ Full name:</strong> '|| n_full_name ||'</p>';
            '<p><strong>- Họ Và Tên/ <i>Full Name: </i></strong>'|| n_full_name ||'</p>';
        v_body := v_body || 
            -- '<p style=''color:black''><strong style=''color:black''>- Mã số nhân viên/ Employee Code:</strong> '|| p_employeeCode ||'</p>';
            '<p><strong>- Mã Số Nhân Viên/ <i>Employee Code: </i></strong>'|| p_employeeCode ||'</p>';
        v_body := v_body || 
            -- '<p style=''color:black''><strong style=''color:black''>- Loại phép/ Leave Type:</strong> '|| leave_type ||'</p>';
            '<p><strong>- Loại Phép/ <i>Leave Type: </i></strong>'|| leave_type ||'</p>';
        if (rec.TOTAL_DAYS <= 0.5) then
            v_body := v_body || 
                '<p><strong>- Tổng Số Ngày/ <i>Total Days: </i></strong>'|| to_char(rec.TOTAL_DAYS,'0.0') ||'</p>';
            v_body := v_body || 
                '<p><strong>- Từ Ngày/ <i>From Date: </i></strong>'|| to_char(rec.FROM_DATE, 'DD/MM/YYYY') ||'</p>';
            v_body := v_body || 
                '<p><strong>- Đến Ngày/ <i>To Date: </i></strong>'|| to_char(rec.MODIFIED_END_DATE, 'DD/MM/YYYY') ||'</p>';
            v_body := v_body || 
                '<p><strong>- Thời Gian/ <i>Time: </i></strong>'|| rec.START_TIME ||' - '|| rec.END_TIME ||'</p>';
        else
            v_body := v_body || 
                '<p><strong>- Tổng Số Ngày/ <i>Total Days: </i></strong>'|| rec.TOTAL_DAYS ||'</p>';
            v_body := v_body || 
                '<p><strong>- Từ Ngày/ <i>From Date: </i></strong>'|| to_char(rec.FROM_DATE, 'DD/MM/YYYY') ||'</p>';
            v_body := v_body || 
                '<p><strong>- Đến Ngày/ <i>To Date: </i></strong>'|| to_char(rec.MODIFIED_END_DATE, 'DD/MM/YYYY') ||'</p>';
        end if; 
        v_body := v_body || 
            '<p><strong>- Ghi Chú/ <i>Note: </i></strong>'|| rec.NOTE ||'</p>';
        v_body := v_body || 
            '</ul>';

        v_body := v_body || 
            '<p style=''margin: 20px 0 0 0''>Nếu Anh/Chị có nguyện vọng thay đổi hoặc hủy kế hoạch nghỉ, vui lòng thông báo đến quản lý trực tiếp để thực hiện thao tác “Hủy” trên màn hình của Quản lý và Anh/Chị thực hiện thao tác tạo yêu cầu nghỉ mới trên giao diện cá nhân.</p>';
        v_body := v_body ||
            '<p style=''margin: 0; font-style: italic''>If you need to adjust or cancel your leave request, please inform your line manager to press “Cancel” button in “Approve leave request” screen and you must submit new leave request (if any).</p>';
        v_body := v_body ||
            '<p style=''margin: 20px 0 0 0''>Nếu Anh/Chị có bất kỳ câu hỏi nào hoặc cần thêm sự hỗ trợ, xin đừng ngần ngại liên hệ với phòng Nhân sự Hành chính.</p>';
        v_body := v_body ||
            '<p style=''margin: 0; font-style: italic''>If you have any questions or need further assistance, please feel free to reach out to the HRA department.</p>';
        v_body := v_body ||
            '<p style=''margin: 60px 0 0 0''>Trân trọng/<i>Your sincerely,</i></p>';
        v_body := v_body ||
            '<p style=''margin: 0''>Phòng Nhân sự Hành chính/<i>HR & Admin Department</i></p>';
        v_body := v_body || '<img style=''width:100%'' src=''https://hcm01.vstorage.vngcloud.vn/v1/AUTH_77c1e15122904b63990a9da99711590d/LXP_Media/ERP/images/footer.jpg''></img>';

        SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', n_company_email, 'Phê duyệt đơn xin nghỉ phép', v_body);
        -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'thviet615@gmail.com', 'Phê duyệt đơn xin nghỉ phép', v_body);
    end loop;

    DBMS_OUTPUT.put_line(v_body);

END;
/