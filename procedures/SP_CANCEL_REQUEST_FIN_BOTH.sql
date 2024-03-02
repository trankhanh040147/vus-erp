create or replace PROCEDURE "SP_CANCEL_REQUEST_FIN_BOTH"
(
p_employeeCode nvarchar2,
p_request_id number
)
is
l_token_type NVARCHAR2(2000);
l_body NVARCHAR2(2000);
l_body_annual NVARCHAR2(2000);
l_body_crf NVARCHAR2(2000);
l_response clob;
l_response_annual clob;
l_response_crf clob;
l_response_clob clob;
l_numrow number;
l_rowsub number;
l_body_mail NVARCHAR2(2000);
n_id number;
n_employeeCode NVARCHAR2(200);
n_legal_entity NVARCHAR2(200);
n_request_type_name NVARCHAR2(200);
n_personal_email NVARCHAR2(200);
n_token_value NVARCHAR2(2000);
n_token NVARCHAR2(5000);
n_approve_date NVARCHAR2(200);
n_carry_forward_code nvarchar2(200);
n_employee_email NVARCHAR2(200);     -- email để send
n_full_name NVARCHAR2(200);
num_check float := 0.5;
rsp_status NVARCHAR2(10);
n_AccrualId_pl  NVARCHAR2(200);
n_AccrualId_crf NVARCHAR2(200);
n_IDStrPortal_pl NVARCHAR2(200);
n_IDStrPortal_crf NVARCHAR2(200);
n_from_date_pl date;
n_to_date_pl date;
n_from_date_crf date;
n_to_date_crf date;
n_NumberDayOff_pl NUMBER;   
n_NumberDayOff_crf  NUMBER;
n_HRMAbsenceCodeId_pl NVARCHAR2(200);
n_HRMAbsenceCodeId_crf NVARCHAR2(200);

v_body clob := '';      -- body of mail

BEGIN

    SELECT TO_CHAR(SYSDATE, 'MM/DD/YYYY') INTO n_approve_date FROM DUAL;
    SELECT VALUE INTO n_token_value FROM APPLICATIONS_CONFIGS WHERE KEY = 'TOKEN' AND ROWNUM = 1;
    SP_GET_TOKEN(n_token);
    apex_web_service.g_request_headers.delete();    
    apex_web_service.g_request_headers(1).name := 'Authorization';
    apex_web_service.g_request_headers(1).value := 'Bearer '|| n_token;
    
    apex_web_service.g_request_headers(2).name := 'Content-Type';
    apex_web_service.g_request_headers(2).value := 'application/json; charset=utf-8';
    
    for rec in (select er.*,emp.DATAAREA,age.DAY_APPROVE,age.BENEFIT_ACCRUAL_PLAN,age.HRM_ABSENCE_CODE_GROUP_ID,age.HRM_ABSENCE_CODE_ID,age.CARRY_FORWORD_EXP_DATE,age.CARRY_FORWARD_CODE,
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
        end as ALLDAY
        from EMPLOYEE_REQUESTS er join ABSENCE_GROUP_EMPLOYEE age on er.EMPLOYEE_CODE_REQ = age.EMPLOYEE_CODE
        join EMPLOYEES emp on emp.EMPLOYEE_CODE = age.EMPLOYEE_CODE
        where er.ID = p_request_id and emp.EMPLOYEE_CODE = p_employeeCode -- and EXPIRATION_DATE >= to_char(sysdate,'MM/DD/YYYY')
        -- AND (er.BENEFIT_CODE LIKE ('%'||age.BENEFIT_ACCRUAL_PLAN||'%') or er.BENEFIT_CODE LIKE ('%'||age.CF_BENEFIT_ACCRUAL_PLAN ||'%')
        -- or er.LEAVE_TYPE = age.HRM_ABSENCE_CODE_GROUP_ID
        AND er.LEAVE_TYPE = age.HRM_ABSENCE_CODE_GROUP_ID
    )loop

    -- BENEFIT_CODE = ALPL12 2024,ALCF 3Ma2024
    -- n_AccrualId_pl = ALPL12 2024
    -- n_AccrualId_crf = ALCF 3Ma2024

    -- calculate from date and end date of both leave
    n_from_date_crf := rec.FROM_DATE;
    n_to_date_pl := rec.END_DATE;

    n_to_date_crf := n_from_date_crf + INTERVAL '1' DAY * (rec.CRF_DAY_TEMP-1);
    n_from_date_pl := n_to_date_crf + INTERVAL '1' DAY;

    n_AccrualId_pl := TRIM(SUBSTR(rec.BENEFIT_CODE, 1, INSTR(rec.BENEFIT_CODE, ',') - 1));
    n_AccrualId_crf := TRIM(SUBSTR(rec.BENEFIT_CODE, INSTR(rec.BENEFIT_CODE, ',') + 1));
    n_IDStrPortal_pl := TO_CHAR(rec.ID) || 'PL';
    n_IDStrPortal_crf := TO_CHAR(rec.ID);
    n_NumberDayOff_pl := REC.ANNUAL_DAY_TEMP;
    n_NumberDayOff_crf := REC.CRF_DAY_TEMP;
    n_HRMAbsenceCodeId_pl := rec.HRM_ABSENCE_CODE_ID;
    n_HRMAbsenceCodeId_crf := rec.CARRY_FORWARD_CODE;

    l_body_annual := '{
    "_jsonRequest":{
        "LegalEntityID": "'||rec.DATAAREA||'",
        "AdjustedHours": "'||to_char(n_NumberDayOff_pl,'90.9')||'",
        "AdjustmentType": "'||rec.ADJUSTMENTTYPE||'",
        "TransactionDate": "'||rec.FROM_DATE||'",
        "Description": "'||rec.NOTE || ' PL'||'",
        "EmployeeCode": "'||p_employeeCode||'", 
        "AccrualId": "'||n_AccrualId_pl ||'", 
        "IDStrPortal": "'||n_IDStrPortal_pl||'",
        "FromDate": "'||n_from_date_pl||'",
        "ToDate": "'||n_to_date_pl||'",
        "NumberDayOff": "'||to_char(n_NumberDayOff_pl,'90.9')||'",
        "StartTime": "'|| CASE when (rec.START_TIME is null or rec.START_TIME = '') THEN '' ELSE (rec.START_TIME||':00') END || '",
        "EndTime": "'|| CASE when (rec.END_TIME is null or rec.END_TIME = '') THEN '' ELSE (rec.END_TIME||':00') END || '",
        "HRMAbsenceCodeGroupId": "'|| CASE WHEN rec.LEAVE_TYPE = 'APL' Then 'Leave' else rec.LEAVE_TYPE END ||'",
        "HRMAbsenceCodeId": "'|| CASE WHEN lower(n_AccrualId_pl) not like 'alcf%' THEN rec.HRM_ABSENCE_CODE_ID ELSE rec.CARRY_FORWARD_CODE END  ||'",
        "AllDay": "'||rec.ALLDAY||'"
    }}';

    l_body_crf := '{
    "_jsonRequest":{
        "LegalEntityID": "'||rec.DATAAREA||'",
        "AdjustedHours": "'||to_char(n_NumberDayOff_crf,'90.9')||'",
        "AdjustmentType": "'||rec.ADJUSTMENTTYPE||'",
        "TransactionDate": "'||rec.FROM_DATE||'",
        "Description": "'||rec.NOTE||'",
        "EmployeeCode": "'||p_employeeCode||'", 
        "AccrualId": "'||n_AccrualId_crf ||'", 
        "IDStrPortal": "'||n_IDStrPortal_crf||'",
        "FromDate": "'||n_from_date_crf||'",
        "ToDate": "'||n_to_date_crf||'",
        "NumberDayOff": "'||to_char(n_NumberDayOff_crf,'90.9')||'",
        "StartTime": "'|| CASE when (rec.START_TIME is null or rec.START_TIME = '') THEN '' ELSE (rec.START_TIME||':00') END || '",
        "EndTime": "'|| CASE when (rec.END_TIME is null or rec.END_TIME = '') THEN '' ELSE (rec.END_TIME||':00') END || '",
        "HRMAbsenceCodeGroupId": "'|| CASE WHEN rec.LEAVE_TYPE = 'APL' Then 'Leave' else rec.LEAVE_TYPE END ||'",
        "HRMAbsenceCodeId": "'|| CASE WHEN lower(n_AccrualId_crf) not like 'alcf%' THEN rec.HRM_ABSENCE_CODE_ID ELSE rec.CARRY_FORWARD_CODE END  ||'",
        "AllDay": "'||rec.ALLDAY||'"
    }}';

    DBMS_OUTPUT.put_line('l_body_annual: ' || l_body_annual);
    DBMS_OUTPUT.put_line('-------------------');
    DBMS_OUTPUT.put_line('l_body_crf: ' || l_body_crf);

    l_response_annual := apex_web_service.make_rest_request(
            p_url => global_vars.get_resource_url || '/api/services/VUSTC_AbsenceGroupEmployeeServiceGroup/AbsenceGroupEmployeeService/CancelLeaverequest',
            p_http_method => 'POST',
            p_body => l_body_annual,
            p_transfer_timeout => 3600
            ) ;

    -- print response 
    DBMS_OUTPUT.put_line('l_response_annual: ');
    DBMS_OUTPUT.put_line(l_response_annual);
    APEX_JSON.parse(l_response_annual);
    DBMS_OUTPUT.put_line('----------------------------');

    l_response_crf := apex_web_service.make_rest_request(
            p_url => global_vars.get_resource_url || '/api/services/VUSTC_AbsenceGroupEmployeeServiceGroup/AbsenceGroupEmployeeService/CancelLeaverequest',
            p_http_method => 'POST',
            p_body => l_body_crf,
            p_transfer_timeout => 3600
            ) ;

    -- print response 
    DBMS_OUTPUT.put_line('l_response_crf: ');
    DBMS_OUTPUT.put_line(l_response_crf);
    APEX_JSON.parse(l_response_crf);
    DBMS_OUTPUT.put_line('----------------------------');
            
    end loop;

    -- Get the value of the response Status 
    rsp_status := apex_json.get_varchar2('Status', 1);
    
    -- update status of request 
    UPDATE EMPLOYEE_REQUESTS SET INSERTED_STATUS = TO_NUMBER(rsp_status) WHERE ID = p_request_id;
    UPDATE EMPLOYEE_REQUESTS SET EMP_REQ_STATUS = 5 WHERE ID = p_request_id and rsp_status = '1';

    -- SP_GET_ONE_ABSENCE_GROUP_EMPLOYEE(p_employeeCode);
    SELECT USER_NAME, FULL_NAME INTO n_employee_email, n_full_name FROM EMPLOYEES WHERE EMPLOYEE_CODE = p_employeeCode;
    
    -- Restore balance days, update used day
    IF rsp_status = '1' THEN
        FOR REC IN (SELECT 
                        CRF_DAY_TEMP, ANNUAL_DAY_TEMP, EMPLOYEE_CODE_REQ, BENEFIT_CODE, TOTAL_DAYS, FROM_DATE, NOTE, LEAVE_TYPE, START_TIME, END_TIME,
                        case 
                            when ALL_DAY like 'N' then FROM_DATE -- Set END_DATE to FROM_DATE if ALLDAY is 'N'
                            else END_DATE
                        end as MODIFIED_END_DATE 
                    FROM 
                        EMPLOYEE_REQUESTS ER 
                    WHERE 
                        ID = p_request_id
                    )LOOP

            -- Restore balance days when cancel APL leaves
            UPDATE ABSENCE_GROUP_EMPLOYEE AGE
            SET
                CARRY_FORWARD_USED = CARRY_FORWARD_USED - REC.CRF_DAY_TEMP,
                CARRY_FORWARD_AVALABLE = CARRY_FORWARD_AVALABLE + REC.CRF_DAY_TEMP,
                AVAILABLE = AVAILABLE + REC.ANNUAL_DAY_TEMP,
                PLAN_YEAR_USED = PLAN_YEAR_USED - REC.ANNUAL_DAY_TEMP
            WHERE
                EMPLOYEE_CODE = REC.EMPLOYEE_CODE_REQ
                AND AGE.BENEFIT_ACCRUAL_PLAN = REC.BENEFIT_CODE;

            -- Send mail

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
            -- v_body := v_body || '<p style=''color:black''><strong style=''color:black''>- Tổng Số Ngày/ Total Days:</strong> '|| to_char(rec.TOTAL_DAYS,'9999.9') ||'</p>';
            -- v_body := v_body || '<p style=''color:black''><strong style=''color:black''>- Từ Ngày/ From Date:</strong> '|| to_char(rec.FROM_DATE, 'DD/MM/YYYY') ||'</p>';
            -- v_body := v_body || '<p style=''color:black''><strong style=''color:black''>- Đến Ngày/ To Date:</strong> '|| to_char(rec.MODIFIED_END_DATE, 'DD/MM/YYYY') ||'</p>';
            -- if (rec.TOTAL_DAYS <= 0.5) then
            --     v_body := v_body || '<p style=''color:black''><strong style=''color:black''>- Từ/ Start Time:</strong> '|| rec.START_TIME ||'</p>';
            --     v_body := v_body || '<p style=''color:black''><strong style=''color:black''>- Đến/ To Time:</strong> '|| rec.END_TIME ||'</p>';
            -- end if;

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
            v_body := v_body || '<p style=''color:black''>Đơn xin nghỉ phép của bạn đã bị huỷ bỏ!</p>';
            v_body := v_body || '<p style=''color:black''>Your leave request has been canceled!</p><br>';

            v_body := v_body || '<p style=''color:black''>Nếu bạn có bất kỳ câu hỏi nào hoặc cần thêm sự hỗ trợ, xin đừng ngần ngại liên hệ với phòng Nhân sự Hành chính.</p>';
            v_body := v_body || '<p style=''color:black''>If you have any questions or need further assistance, please feel free to reach out to the HRA department.</p>';
            v_body := v_body || '<p style=''color:black''>Trân trọng,</p>';
            v_body := v_body || '<p style=''color:black''>Phòng Nhân sự Hành chính</p>';
            v_body := v_body || '<p style=''color:black''>Best regards,</p>';
            v_body := v_body || '<p style=''color:black''>HR & Admin Department </p>';
            v_body := v_body || '<img style=''width:100%'' src=''https://hcm01.vstorage.vngcloud.vn/v1/AUTH_77c1e15122904b63990a9da99711590d/LXP_Media/ERP/images/footer.jpg''></img>';

            SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', n_employee_email, 'Huỷ bỏ đơn xin nghỉ phép', v_body);
            -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'thviet615@gmail.com', 'Huỷ bỏ đơn xin nghỉ phép', v_body);

        END LOOP;
    END IF;

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
        'CancelLeaverequest', -- Endpoint you just called
        apex_web_service.g_request_headers(1).value, -- This is a simplification, you may need to concatenate all headers
        l_body, -- The request body you sent
        apex_web_service.g_status_code, -- Response status code
        l_response, -- The response body you received
        SYSDATE, -- The current timestamp
        'id=' || p_request_id || ' employeeCode=' || p_employeeCode || ' status=' || rsp_status -- Any additional notes
    );

    COMMIT; -- Commit the transaction to save the log

END;
/