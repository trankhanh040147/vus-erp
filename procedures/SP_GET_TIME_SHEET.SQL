create or replace procedure "SP_GET_TIME_SHEET"
(
    p_legal_entity_id NVARCHAR2,
    p_from_date NVARCHAR2,
    P_to_date NVARCHAR2,
    P_transffered NVARCHAR2
)
is
l_method_url NVARCHAR2(500);
l_body NVARCHAR2(10000);
l_num_row_i NUMBER;
l_num_row_j NUMBER;
l_count_unit_i NUMBER;
l_count_unit_j NUMBER;

n_profile_date DATE;       -- trong API dữ liệu là kiểu dd/mm/yyyy
n_profile NVARCHAR2(50);
n_worker NVARCHAR2(20);
n_header_rec_id NVARCHAR2(100);
n_calculated NUMBER;
n_approved NUMBER;
n_transferred NUMBER;
n_special_day_id NVARCHAR2(20);
n_profile_paid_hours NUMBER;
n_pay_time NUMBER;
n_pay_overtime NUMBER;
n_absencetime NUMBER;
n_flex_more NUMBER;          -- trong API là Flex+
n_flex_less NUMBER;          -- trong API là Flex-
n_WorkTime NUMBER;
n_LegalAbsence NUMBER;
n_IllegalAbsence NUMBER;
n_PaidBreakTime NUMBER;
n_NonPaidBreakTime NUMBER;
n_TotalBreakTime NUMBER;
n_emp_code nvarchar2(30);

n_line_rec_id NVARCHAR2(100);
n_reg_type NVARCHAR2(200);
n_job_ref NVARCHAR2(200);
n_job_id NVARCHAR2(200);
n_start_time NVARCHAR2(20);
n_end_time NVARCHAR2(20);
n_description NVARCHAR2(200);
n_trans_id NVARCHAR2(100);
n_time NVARCHAR2(20);

p_token nvarchar2(10000);

-- test_code VARCHAR2(50);
-- test_count NUMBER;

BEGIN
    l_method_url := global_vars.get_resource_url || '/api/services/VUSTC_TimSheetServiceGroup/TimeSheetService/GetTimeSheet';

    SP_GET_TOKEN(p_token);

    apex_web_service.g_request_headers.delete();
    apex_web_service.g_request_headers(1).name := 'Content-Type';
    apex_web_service.g_request_headers(1).value := 'application/json';
    apex_web_service.g_request_headers(2).name := 'Authorization';
    apex_web_service.g_request_headers(2).value := 'Bearer ' || p_token;

    l_body := '{"_jsonRequest":{"LegalEntityID":"' || p_legal_entity_id || '","FromDate":"' || p_from_date || '","ToDate":"' || p_to_date || '","Transffered":"' || P_transffered || '"}}';

    --DBMS_OUTPUT.put_line(l_body);

    apex_json.parse(
        apex_web_service.make_rest_request(
            p_url => l_method_url,
            p_http_method => 'POST',
            p_body => l_body,
            p_transfer_timeout => 3600
        )
    );

    l_num_row_i := apex_json.get_count (p_path => 'TimeSheetHeader');

    --DBMS_OUTPUT.put_line(l_num_row_i);
    
    FOR i in 1..l_num_row_i
    LOOP
        n_profile_date := to_date(apex_json.get_varchar2('TimeSheetHeader[%d].ProfileDate', i), 'MM-DD-YYYY');
        n_profile := apex_json.get_varchar2('TimeSheetHeader[%d].Profile', i);
        n_worker := to_char(apex_json.get_number('TimeSheetHeader[%d].Worker', i));
        n_header_rec_id := to_char(apex_json.get_number('TimeSheetHeader[%d].TimeSheetHeaderRecId', i));
        n_calculated := apex_json.get_number('TimeSheetHeader[%d].Calculated', i);
        n_approved := apex_json.get_number('TimeSheetHeader[%d].Approved', i);
        n_transferred := apex_json.get_number('TimeSheetHeader[%d].Transferred', i);
        n_special_day_id := apex_json.get_varchar2('TimeSheetHeader[%d].SpecialDayId', i);
        n_profile_paid_hours := to_number(apex_json.get_varchar2('TimeSheetHeader[%d].ProfilePaidHours', i), '99999.99');
        --n_profile_paid_hours := to_number('23.888', '99999.999');
        n_pay_time := to_number(apex_json.get_varchar2('TimeSheetHeader[%d].PayTime', i), '99999.99');
        n_pay_overtime := to_number(apex_json.get_varchar2('TimeSheetHeader[%d].PayOvertime', i), '99999.99');
        n_absencetime := to_number(apex_json.get_varchar2('TimeSheetHeader[%d].Absencetime', i), '99999.99');
        n_flex_more := to_number(apex_json.get_varchar2('TimeSheetHeader[%d]."Flex+"', i), '99999.99');
        n_flex_less := to_number(apex_json.get_varchar2('TimeSheetHeader[%d]."Flex-"', i), '99999.99');         -- phải thêm dấu ngoặc kép "" do có kí tự + đặc biệt
        --n_flex_less := to_number('88.88', '99999.99');
        n_WorkTime := to_number(apex_json.get_varchar2('TimeSheetHeader[%d].WorkTime', i), '99999.99');
        n_LegalAbsence := to_number(apex_json.get_varchar2('TimeSheetHeader[%d].LegalAbsence', i), '99999.99');
        n_IllegalAbsence := to_number(apex_json.get_varchar2('TimeSheetHeader[%d].IllegalAbsence', i), '99999.99');
        n_PaidBreakTime := to_number(apex_json.get_varchar2('TimeSheetHeader[%d].PaidBreakTime', i), '99999.99');
        n_NonPaidBreakTime := to_number(apex_json.get_varchar2('TimeSheetHeader[%d].NonPaidBreakTime', i), '99999.99');
        n_TotalBreakTime := to_number(apex_json.get_varchar2('TimeSheetHeader[%d].TotalBreakTime', i), '99999.99');

        -- Sử dụng EXCEPTION nên phải có BEGIN...END; bao quanh
        BEGIN
            SELECT EMPLOYEE_CODE INTO n_emp_code FROM EMPLOYEES WHERE WORKER_ID = n_worker FETCH FIRST 1 ROW ONLY;
            -- nếu 'n_worker' không có trong 'EMPLOYEES' thì 'e_emp_code' gắn bằng NULL 
            EXCEPTION WHEN NO_DATA_FOUND THEN n_emp_code := NULL;
        END;

        -- test_code := n_worker;       --($) đoạn code trong dấu ($)...($) kiểm tra và in ra những worker_id không có trong bảng EMPLOYEES

        -- SELECT COUNT(*) INTO test_count
        -- FROM EMPLOYEES
        -- WHERE WORKER_ID = test_code;

        --   IF test_count = 0 THEN
        --     DBMS_OUTPUT.PUT_LINE('Giá trị không tồn tại trong cột CODE: ' || test_code);
        --   END IF;        --($)

        -- DBMS_OUTPUT.put_line('ProfileDate : "' || n_profile_date || ' "');
        -- DBMS_OUTPUT.put_line('Profile : "' || n_profile || ' "');
        --DBMS_OUTPUT.put_line('Worker : "' || n_worker || ' "');
        -- DBMS_OUTPUT.put_line('TimeSheetHeaderRecId : "' || n_header_rec_id || ' "');
        -- DBMS_OUTPUT.put_line('Calculated : "' || n_calculated || ' "');
        -- DBMS_OUTPUT.put_line('Approved : "' || n_approved || ' "');
        -- DBMS_OUTPUT.put_line('Transferred : "' || n_transferred || ' "');
        -- DBMS_OUTPUT.put_line('SpecialDayId : "' || n_special_day_id || ' "');
        -- DBMS_OUTPUT.put_line('ProfilePaidHours : "' || n_profile_paid_hours || ' "');
        -- DBMS_OUTPUT.put_line('PayTime : "' || n_pay_time || ' "');
        -- DBMS_OUTPUT.put_line('PayOvertime : "' || n_pay_overtime || ' "');
        -- DBMS_OUTPUT.put_line('Absencetime : "' || n_absencetime || ' "');
        -- DBMS_OUTPUT.put_line('Flex+ : "' || n_flex_more || ' "');
        -- DBMS_OUTPUT.put_line('Flex- : "' || n_flex_less || ' "');
        -- DBMS_OUTPUT.put_line('Employee code : "' || n_emp_code || ' "');

        --DBMS_OUTPUT.put_line('---------------------------');

        SELECT
            COUNT(*) INTO l_count_unit_i
        FROM
            EMP_TIME_SHEET
        WHERE
            TS_HEADER_REC_ID = n_header_rec_id;

        if l_count_unit_i > 0 then
        UPDATE
            EMP_TIME_SHEET
        SET
            PROFILE_DATE = n_profile_date,
            PROFILE_ID = n_profile,
            WORKER = n_worker,
            TS_HEADER_REC_ID = n_header_rec_id,
            CALCULATED = n_calculated,
            APPROVED = n_approved,
            TRANSFERRED = n_transferred,
            SPECIAL_DAY_ID = n_special_day_id,
            PROFILE_PAID_HOURS = n_profile_paid_hours,
            PAY_TIME = n_pay_time,
            PAY_OVERTIME = n_pay_overtime,
            ABSENCE_TIME = n_absencetime,
            FLEX_MORE = n_flex_more,
            FLEX_LESS = n_flex_less,
            WORK_TIME = n_WorkTime,
            LEGAL_ABSENCE = n_LegalAbsence,
            ILLEGAL_ABSENCE = n_IllegalAbsence,
            PAID_BREAKTIME = n_PaidBreakTime,
            NON_PAID_BREAKTIME = n_NonPaidBreakTime,
            TOTAL_BREAKTIME = n_TotalBreakTime
        WHERE
            TS_HEADER_REC_ID = n_header_rec_id;

        else
        INSERT INTO EMP_TIME_SHEET(
            EMPLOYEE_CODE,
            PROFILE_DATE,
            PROFILE_ID,
            WORKER,
            TS_HEADER_REC_ID,
            CALCULATED,
            APPROVED,
            TRANSFERRED,
            SPECIAL_DAY_ID,
            PROFILE_PAID_HOURS,
            PAY_TIME,
            PAY_OVERTIME,
            ABSENCE_TIME,
            FLEX_MORE,
            FLEX_LESS,
            WORK_TIME,
            LEGAL_ABSENCE,
            ILLEGAL_ABSENCE,
            PAID_BREAKTIME,
            NON_PAID_BREAKTIME,
            TOTAL_BREAKTIME
            )
        VALUES
        (
            n_emp_code,
            n_profile_date,
            n_profile,
            n_worker,
            n_header_rec_id,
            n_calculated,
            n_approved,
            n_transferred,
            n_special_day_id,
            n_profile_paid_hours,
            n_pay_time,
            n_pay_overtime,
            n_absencetime,
            n_flex_more,
            n_flex_less,
            n_WorkTime,
            n_LegalAbsence,
            n_IllegalAbsence,
            n_PaidBreakTime,
            n_NonPaidBreakTime,
            n_TotalBreakTime
        );

        end if;

        l_num_row_j := apex_json.get_count ('TimeSheetHeader[%d].TimeSheetLine', i);

        --DBMS_OUTPUT.put_line('j = ' || l_num_row_j);

        FOR j IN 1..l_num_row_j
        LOOP

            n_line_rec_id := apex_json.get_varchar2('TimeSheetHeader[%d].TimeSheetLine[%d].TimeSheetLineRecId', i, j);
            n_reg_type := apex_json.get_varchar2('TimeSheetHeader[%d].TimeSheetLine[%d].RegType', i, j);
            n_job_ref := apex_json.get_varchar2('TimeSheetHeader[%d].TimeSheetLine[%d].JobRef', i, j);
            n_job_id := apex_json.get_varchar2('TimeSheetHeader[%d].TimeSheetLine[%d].JobId', i, j);
            n_start_time := apex_json.get_varchar2('TimeSheetHeader[%d].TimeSheetLine[%d].StartTime', i, j);
            n_end_time := apex_json.get_varchar2('TimeSheetHeader[%d].TimeSheetLine[%d].EndTime', i, j);
            n_description := apex_json.get_varchar2('TimeSheetHeader[%d].TimeSheetLine[%d].Description', i, j);
            n_trans_id := apex_json.get_varchar2('TimeSheetHeader[%d].TimeSheetLine[%d].TransId', i, j);
            n_time := to_number(apex_json.get_varchar2('TimeSheetHeader[%d].TimeSheetLine[%d].Time', i, j), '99999.99');
            
            n_start_time := TO_CHAR(TO_TIMESTAMP(REPLACE(TRIM(n_start_time), ' ', ''), 'HH:MI:SSPM'), 'HH24:MI');
            n_end_time := TO_CHAR(TO_TIMESTAMP(REPLACE(TRIM(n_end_time), ' ', ''), 'HH:MI:SSPM'), 'HH24:MI');


            -- DBMS_OUTPUT.put_line('n_line_rec_id : "' || n_line_rec_id || ' "');
            -- DBMS_OUTPUT.put_line('n_reg_type : "' || n_reg_type || ' "');
            -- DBMS_OUTPUT.put_line('n_job_ref : "' || n_job_ref || ' "');
            -- DBMS_OUTPUT.put_line('n_job_id : "' || n_job_id || ' "');
            -- DBMS_OUTPUT.put_line('n_start_time : "' || n_start_time || ' "');
            -- DBMS_OUTPUT.put_line('n_end_time : "' || n_end_time || ' "');
            -- DBMS_OUTPUT.put_line('n_description : "' || n_description || ' "');
            -- DBMS_OUTPUT.put_line('n_trans_id : "' || n_trans_id || ' "');
            -- DBMS_OUTPUT.put_line('n_time : "' || n_time || ' "');
            
            -- DBMS_OUTPUT.put_line('---------------------------');

            SELECT
                COUNT(*) INTO l_count_unit_j
            FROM
                EMP_TIME_SHEET_LINE
            WHERE
                TS_LINE_REC_ID = n_line_rec_id;

            if l_count_unit_j > 0 then
                UPDATE
                    EMP_TIME_SHEET_LINE
                SET
                    TS_LINE_REC_ID = n_line_rec_id,
                    REG_TYPE = LOWER(n_reg_type),
                    JOB_REF = LOWER(n_job_ref),
                    JOD_ID = LOWER(n_job_id),
                    START_TIME = n_start_time,
                    END_TIME = n_end_time,
                    DESCRIPTION = n_description,
                    TRANS_ID = n_trans_id,
                    TIME = n_time,
                    TS_HEADER_REC_ID = n_header_rec_id
                WHERE
                    TS_LINE_REC_ID = n_line_rec_id;

                else
                INSERT INTO EMP_TIME_SHEET_LINE(
                    TS_LINE_REC_ID,
                    REG_TYPE,
                    JOB_REF,
                    JOD_ID,
                    START_TIME,
                    END_TIME,
                    DESCRIPTION,
                    TRANS_ID,
                    TIME,
                    TS_HEADER_REC_ID
                    )
                VALUES
                (
                    n_line_rec_id,
                    LOWER(n_reg_type),
                    LOWER(n_job_ref),
                    LOWER(n_job_id),
                    n_start_time,
                    n_end_time,
                    n_description,
                    n_trans_id,
                    n_time,
                    n_header_rec_id
                );

            end if;

            COMMIT;
        
        END LOOP;

        COMMIT;

    END LOOP;

END "SP_GET_TIME_SHEET";
/