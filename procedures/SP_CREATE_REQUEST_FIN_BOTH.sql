create or replace PROCEDURE "SP_CREATE_REQUEST_FIN_BOTH"
(
p_employeeCode nvarchar2,
p_request_id number
)
is
l_token_type NVARCHAR2(2000);
l_body_annual NVARCHAR2(2000);
l_response_annual clob;
l_response_crf clob;
l_response_clob clob;
l_numrow number;
l_rowsub number;
l_body_mail NVARCHAR2(2000);
n_id number;
n_employeeCode NVARCHAR2(200);
n_legal_entity NVARCHAR2(200);
n_full_name NVARCHAR2(200);
n_company_email NVARCHAR2(200);
n_request_type_name NVARCHAR2(200);
n_personal_email NVARCHAR2(200);
n_token_value NVARCHAR2(2000);
n_token NVARCHAR2(5000);
n_approve_date nvarchar2(200);
n_carry_forward_code nvarchar2(200);
n_accrual_id nvarchar2(100);
n_total_day number:= 0;
n_extra_id number;
n_from_date_pl date;
n_to_date_pl date;
n_from_date_crf date;
n_to_date_crf date;
l_body_crf nvarchar2(2000);
l_job_name VARCHAR2(30);
rsp_status VARCHAR2(30);

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

    n_extra_id := p_request_id + 1;
    
    for rec in (select er.*,emp.DATAAREA,age.DAY_APPROVE,age.BENEFIT_ACCRUAL_PLAN,age.HRM_ABSENCE_CODE_GROUP_ID,
    age.HRM_ABSENCE_CODE_ID,age.CARRY_FORWORD_EXP_DATE,age.CARRY_FORWARD_CODE,age.CF_BENEFIT_ACCRUAL_PLAN,age.CARRY_FORWARD_AVALABLE,
        case 
        when age.HRM_ABSENCE_CODE_ID like 'ALPL%' then
            'Amount Used'
        when age.HRM_ABSENCE_CODE_ID like 'ALCF%' then
            'Amount Used'
        else
            -- null     cũ
            'Amount Used'       -- 29/2/24-Viet
        end as ADJUSTMENTTYPE,
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

        from EMPLOYEE_REQUESTS er 
        join ABSENCE_GROUP_EMPLOYEE age on er.EMPLOYEE_CODE_REQ = age.EMPLOYEE_CODE
        join EMPLOYEES emp on emp.EMPLOYEE_CODE = age.EMPLOYEE_CODE
        where er.ID = p_request_id and emp.EMPLOYEE_CODE = p_employeeCode 
        and lower(er.LEAVE_TYPE) = lower(age.HRM_ABSENCE_CODE_GROUP_ID)
    )loop

        -- calculate from date and end date of both leave
        n_from_date_crf := rec.FROM_DATE;
        n_to_date_pl := rec.MODIFIED_END_DATE;

        n_to_date_crf := n_from_date_crf + INTERVAL '1' DAY * (rec.CRF_DAY_TEMP-1);
        n_from_date_pl := n_to_date_crf + INTERVAL '1' DAY;

l_body_annual := '{
    "_jsonRequest":{
        "LegalEntityID": "'||rec.DATAAREA||'",
        "AdjustedHours": "'||to_char(rec.ANNUAL_DAY_TEMP,'90.9')||'",
        "AdjustmentType": "'||rec.ADJUSTMENTTYPE||'",
        "TransactionDate": "'||n_from_date_pl||'",
        "Description": "'||rec.NOTE||'",
        "EmployeeCode": "'||p_employeeCode||'", 
        "AccrualId": "'||rec.BENEFIT_ACCRUAL_PLAN||'", 
        "IDStrPortal": "'||rec.ID|| 'PL' ||'",
        "FromDate": "'||n_from_date_pl||'",
        "ToDate": "'||n_to_date_pl||'",
        "NumberDayOff": "'||to_char(rec.ANNUAL_DAY_TEMP,'90.9')||'",
        "StartTime": "'||rec.START_TIME||':00",
        "EndTime": "'||rec.END_TIME||':00",
        "HRMAbsenceCodeGroupId": "'||rec.CONVERTED_HRM_ABSENCE_CODE_GROUP_ID||'",
        "HRMAbsenceCodeId": "'||rec.HRM_ABSENCE_CODE_ID||'",
        "AllDay": "'||rec.ALLDAY||'",
        "AttachmentURL": "'||rec.ATTATCH_FILE||'"

    }}';

l_body_crf := '{
    "_jsonRequest":{
        "LegalEntityID": "'||rec.DATAAREA||'",
        "AdjustedHours": "'||to_char(rec.CRF_DAY_TEMP,'90.9')||'",
        "AdjustmentType": "'||rec.ADJUSTMENTTYPE||'",
        "TransactionDate": "'||n_from_date_crf||'",
        "Description": "'||rec.NOTE||'",
        "EmployeeCode": "'||p_employeeCode||'", 
        "AccrualId": "'||rec.CF_BENEFIT_ACCRUAL_PLAN||'", 
        "IDStrPortal": "'||rec.ID||'",
        "FromDate": "'||n_from_date_crf||'",
        "ToDate": "'||n_to_date_crf||'",
        "NumberDayOff": "'||to_char(rec.CRF_DAY_TEMP,'90.9')||'",
        "StartTime": "'||rec.START_TIME||':00",
        "EndTime": "'||rec.END_TIME||':00",
        "HRMAbsenceCodeGroupId": "'||rec.CONVERTED_HRM_ABSENCE_CODE_GROUP_ID||'",
        "HRMAbsenceCodeId": "'||rec.CARRY_FORWARD_CODE||'",
        "AllDay": "'||rec.ALLDAY||'",
        "AttachmentURL": "'||rec.ATTATCH_FILE||'"
    }}';
    -- -- tesst
    -- dbms_output.put_line(rec.ADJUSTMENTTYPE);
    -- dbms_output.put_line(rec.DATAAREA);
    end loop;


    -- Create an extra leave
    -- INSERT INTO EMPLOYEE_REQUESTS(IS_EXTRA) VALUES(1);
    INSERT INTO EMPLOYEE_REQUESTS
    (
        ID,
        REQUESTOR_ID,
        REQUEST_ID,
        EMPLOYEE_CODE_REQ,
        EMPLOYEE_NAME,
        FROM_DATE,
        END_DATE,
        ALL_DAY,
        NOTE,
        TOTAL_DAYS,
        EMP_REQ_STATUS,
        TYPE,
        IS_DEL,
        MAN_RES_STATUS,
        RESPONSER_ID,
        LEAVE_TYPE,
        TARGET_CODE,
        START_TIME,
        END_TIME,
        SUBMIT_DATE,
        BENEFIT_CODE,
        CRF_DAY_TEMP,
        ANNUAL_DAY_TEMP,
        ATTACH_NAME,
        ATTATCH_FILE,
        ID_ROOT,
        IS_D365,
        LEAVE_BALANCE,
        INSERTED_STATUS
    )
    SELECT NULL,
           REQUESTOR_ID,
           REQUEST_ID + 1,
           EMPLOYEE_CODE_REQ,
           EMPLOYEE_NAME,
           FROM_DATE,
           END_DATE,
           ALL_DAY,
           NOTE,
           TOTAL_DAYS,
        --    EMP_REQ_STATUS,
           3,
           TYPE,
           IS_DEL,
           MAN_RES_STATUS,
           RESPONSER_ID,
           LEAVE_TYPE,
           TARGET_CODE,
           START_TIME,
           END_TIME,
           SUBMIT_DATE,
           BENEFIT_CODE,
           CRF_DAY_TEMP,
           ANNUAL_DAY_TEMP,
           ATTACH_NAME,
           ATTATCH_FILE, 
           'EX',
           IS_D365,
           LEAVE_BALANCE,
           INSERTED_STATUS
    FROM EMPLOYEE_REQUESTS
    WHERE ID = p_request_id;

    -- UPDATE EMPLOYEE_REQUESTS SET EMP_REQ_STATUS = 3 WHERE ID = p_request_id;
    -- Set status the extra leave too

    
    COMMIT;
     
        DBMS_OUTPUT.put_line('body crf: ');
        DBMS_OUTPUT.put_line(l_body_crf);
        DBMS_OUTPUT.put_line('body annual: ');
        DBMS_OUTPUT.put_line(l_body_annual);

        l_response_crf := apex_web_service.make_rest_request(
                p_url => global_vars.get_resource_url || '//api/services/VUSTC_AbsenceGroupEmployeeServiceGroup/AbsenceGroupEmployeeService/CreateLeaverequest',
                p_http_method => 'POST',
                p_body => l_body_crf,
                p_transfer_timeout => 3600
        ) ;

        l_response_annual := apex_web_service.make_rest_request(
                p_url => global_vars.get_resource_url || '//api/services/VUSTC_AbsenceGroupEmployeeServiceGroup/AbsenceGroupEmployeeService/CreateLeaverequest',
                p_http_method => 'POST',
                p_body => l_body_annual,
                p_transfer_timeout => 3600
        );

        DBMS_OUTPUT.put_line('');
        DBMS_OUTPUT.put_line(l_response_crf);

        DBMS_OUTPUT.put_line('');
        DBMS_OUTPUT.put_line(l_response_annual);

        APEX_JSON.parse(l_response_crf);
        rsp_status := apex_json.get_varchar2('Status', 1);

        UPDATE EMPLOYEE_REQUESTS SET INSERTED_STATUS = TO_NUMBER(rsp_status) WHERE ID = p_request_id;
        UPDATE EMPLOYEE_REQUESTS SET EMP_REQ_STATUS = 3 WHERE ID = p_request_id and rsp_status = '1';
        UPDATE EMPLOYEE_REQUESTS SET EMP_REQ_STATUS = 3 WHERE ID = p_request_id + 1 and rsp_status = '1';

        -- Write API Logs
        -- Insert the log entry after you receive the response
        INSERT INTO LOGS_API_RESPONSE (
            API_ENDPOINT,
            REQUEST_HEADERS,
            REQUEST_BODY,
            RESPONSE_CODE,
            RESPONSE_BODY,
            CALL_TIMESTAMP,
            NOTE
        ) VALUES (
            'CreateLeaverequest_BOTH', -- Endpoint you just called
            apex_web_service.g_request_headers(1).value, -- This is a simplification, you may need to concatenate all headers
            l_body_crf, -- The request body you sent
            apex_web_service.g_status_code, -- Response status code
            l_response_crf, -- The response body you received
            SYSDATE, -- The current timestamp
            'leave_cf | id=' || p_request_id || ' employeeCode=' || p_employeeCode || ' status=' || rsp_status -- Any additional notes
        );

        APEX_JSON.parse(l_response_annual);
        rsp_status := apex_json.get_varchar2('Status', 1);

        -- Log for annual leave
        INSERT INTO LOGS_API_RESPONSE (
            API_ENDPOINT,
            REQUEST_HEADERS,
            REQUEST_BODY,
            RESPONSE_CODE,
            RESPONSE_BODY,
            CALL_TIMESTAMP,
            NOTE
        ) VALUES (
            'CreateLeaverequest_BOTH', -- Endpoint you just called
            apex_web_service.g_request_headers(1).value, -- This is a simplification, you may need to concatenate all headers
            l_body_annual, -- The request body you sent
            apex_web_service.g_status_code, -- Response status code
            l_response_annual, -- The response body you received
            SYSDATE, -- The current timestamp
            'leave_al | id=' || p_request_id || ' employeeCode=' || p_employeeCode || ' status=' || rsp_status -- Any additional notes
        );

        COMMIT; -- Commit the transaction to save the log


    SELECT USER_NAME, FULL_NAME INTO n_company_email, n_full_name FROM EMPLOYEES WHERE EMPLOYEE_CODE = p_employeeCode;

-- Send mail
    for rec in (select er.*,emp.DATAAREA,age.DAY_APPROVE,age.BENEFIT_ACCRUAL_PLAN,age.HRM_ABSENCE_CODE_GROUP_ID,
    age.HRM_ABSENCE_CODE_ID,age.CARRY_FORWORD_EXP_DATE,age.CARRY_FORWARD_CODE,age.CF_BENEFIT_ACCRUAL_PLAN,age.CARRY_FORWARD_AVALABLE,
        case 
        when age.HRM_ABSENCE_CODE_ID like 'ALPL%' then
            'Amount Used'
        when age.HRM_ABSENCE_CODE_ID like 'ALCF%' then
            'Amount Used'
        else
            null
        end as ADJUSTMENTTYPE,
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

    -- SP_SENDGRID_EMAIL

        -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', n_company_email, 'Leave Request Approved', '<p> Dear '|| n_full_name ||', </p>' ||
        -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'thviet615@gmail.com', 'Leave Request Approved', '<p> Dear '|| n_full_name ||', </p>' ||

        --     '<p>Your leave request has been approved. Here are the details:</p>' ||
        --     '<p> Employee Code: '|| p_employeeCode ||' </p>' ||
        --     '<p> Total Days: '|| to_char(rec.TOTAL_DAYS, '0.0') ||' </p>' ||
        --     '<p> From Date: '|| to_date(rec.FROM_DATE, 'DD/MM/YYYY') ||' </p>' ||
        --     '<p> To Date: '|| to_date(rec.MODIFIED_END_DATE, 'DD/MM/YYYY') ||' </p>' ||
        --     '<br>' || 
        --     '<p>Feel free to proceed with your leave plans accordingly.</p>' ||
        --     '<br>' || 
        --     '<p> If you have any questions or need further assistance, please feel free to reach out to the HR department. </p>' ||
        --     '<br>' || 
        --     '<p> Thank you, </p>' ||
        --     '<p> VUS </p>');

        v_body := v_body || '<img style=''width:100%'' src=''https://hcm01.vstorage.vngcloud.vn/v1/AUTH_77c1e15122904b63990a9da99711590d/LXP_Media/ERP/images/header.png''></img>';
        v_body := v_body || '<h3 style=''color:black;text-align:center''>[PHÒNG NHÂN SỰ HÀNH CHÍNH - VUS] – ĐƠN XIN NGHỈ PHÉP</h3>';
        v_body := v_body || '<h3 style=''color:black;text-align:center''>[HRA DEPARTMENT - VUS] – REQUEST FOR LEAVE LETTER</h3>';
        v_body := v_body || '<p style=''color:black;margin-top:20px''>Anh/Chị '|| n_full_name ||' thân mến,</p>';
        v_body := v_body || '<p style=''color:black;margin-top:0''>Dear Mr/Ms. '|| n_full_name ||',</p>';
        v_body := v_body || '<p style=''color:black''>Hệ thống nhận được đề nghị xin nghỉ phép của nhân viên như sau:</p>';
        v_body := v_body || '<p style=''color:black''>Employee Portal system has received a request for leave as below:</p>';
        v_body := v_body || '<ul>';
        v_body := v_body || '<p style=''color:black''><strong style=''color:black''>- Họ và tên/ Full name:</strong> '|| n_full_name ||'</p>';
        v_body := v_body || '<p style=''color:black''><strong style=''color:black''>- Mã số nhân viên/ Employee Code:</strong> '|| p_employeeCode ||'</p>';
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
        v_body := v_body || '<p style=''color:black''>Đơn xin nghỉ phép của bạn đã được phê duyệt!</p>';
        v_body := v_body || '<p style=''color:black''>Your leave request has been approved!</p>';
        v_body := v_body || '<p style=''color:black''>Hãy thoải mái thực hiện kế hoạch nghỉ phép của bạn.</p>';
        v_body := v_body || '<p style=''color:black''>Feel free to proceed with your leave plans accordingly.</p><br>';

        v_body := v_body || '<p style=''color:black''>Nếu bạn có bất kỳ câu hỏi nào hoặc cần thêm sự hỗ trợ, xin đừng ngần ngại liên hệ với phòng Nhân sự Hành chính.</p>';
        v_body := v_body || '<p style=''color:black''>If you have any questions or need further assistance, please feel free to reach out to the HRA department.</p>';
        v_body := v_body || '<p style=''color:black''>Trân trọng,</p>';
        v_body := v_body || '<p style=''color:black''>Phòng Nhân sự Hành chính</p>';
        v_body := v_body || '<p style=''color:black''>Best regards,</p>';
        v_body := v_body || '<p style=''color:black''>HR & Admin Department </p>';
        v_body := v_body || '<img style=''width:100%'' src=''https://hcm01.vstorage.vngcloud.vn/v1/AUTH_77c1e15122904b63990a9da99711590d/LXP_Media/ERP/images/footer.jpg''></img>';

        SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', n_company_email, 'Phê duyệt đơn xin nghỉ phép', v_body);
        -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'thviet615@gmail.com', 'Phê duyệt đơn xin nghỉ phép', v_body);

    end loop;

END;
/