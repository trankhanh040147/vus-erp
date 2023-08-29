create or replace PROCEDURE "SP_GET_ONE_ABSENCE_GROUP_EMPLOYEE_BACKUP" (
    p_employee_code NVARCHAR2
) IS
    -- Declare variables
    l_token_type NVARCHAR2(2000);
    l_access_token NVARCHAR2(2000);
    l_body NVARCHAR2(2000);
    l_response_clob CLOB;
    l_authorization NVARCHAR2(2000);
    l_response CLOB;
    l_numrow NUMBER;
    l_trans_numrow NUMBER;
    l_rowsub NUMBER;
    l_count_idemp NUMBER;
    l_max NUMBER;
    l_body_json CLOB;
    n_id NUMBER;
    n_carryforward NUMBER;
    n_planyearaccrued NUMBER;
    n_planyearused NUMBER;
    n_employeeCode NVARCHAR2(200);
    l_list CLOB;
    n_legal_entity NVARCHAR2(200);
    -- Add additional variables for extracting data from JSON
    n_benefit_accrual_plan NVARCHAR2(50);
    n_description NVARCHAR2(100);
    n_plan_year_start DATE;
    n_carry_forward NUMBER;
    n_plan_year_accrued NUMBER;
    n_plan_year_used NUMBER;
    n_maximum_accrual_limit NUMBER;
    n_available NUMBER;
    n_hrm_absence_code_id NVARCHAR2(50);
    n_hrm_absence_code_group_id NVARCHAR2(50);
    n_expiration_date DATE;
    p_token NVARCHAR2(10000);
    -- transactions
    t_worker NVARCHAR2(200);
    t_trans_date DATE;
    t_trans_Carryforward FLOAT;
    t_trans_Planyearaccrued FLOAT;
    t_trans_Planyearused FLOAT;
    t_total_days FLOAT;
    t_all_day NVARCHAR2(10);
BEGIN
    SP_GET_TOKEN(p_token);
    apex_web_service.g_request_headers.delete();

    apex_web_service.g_request_headers(1).name := 'Authorization';
    apex_web_service.g_request_headers(1).value := 'Bearer ' || p_token;

    apex_web_service.g_request_headers(2).name := 'Content-Type';
    apex_web_service.g_request_headers(2).value := 'application/json; charset=utf-8';

    -- Delete D365 leaves
    DELETE from EMPLOYEE_REQUESTS where IS_D365 = 1;

    FOR r IN (SELECT EMPLOYEE_CODE, DATAAREA FROM EMPLOYEES WHERE EMPLOYEE_CODE = p_employee_code) LOOP
        l_body := '{"_jsonRequest":{"EmployeeCode":"' || r.EMPLOYEE_CODE || '","legal_entity":"' || r.DATAAREA || '"} }';

        DBMS_OUTPUT.put_line(l_body);

        l_response := apex_web_service.make_rest_request(
            p_url => 'https://hra.sandbox.operations.dynamics.com/api/services/VUSTC_AbsenceGroupEmployeeServiceGroup/AbsenceGroupEmployeeService/GetAbsenceGroupEmployee',
            p_http_method => 'POST',
            p_body => l_body,
            p_transfer_timeout => 3600
        );

        APEX_JSON.parse(l_response);

        l_numrow := APEX_JSON.get_count(p_path => 'Benefit_accrual');
        FOR i IN 1..l_numrow LOOP
            -- 
            n_benefit_accrual_plan := apex_json.get_varchar2('Benefit_accrual[%d].Benefitaccrualplan', i);
            n_description := apex_json.get_varchar2('Benefit_accrual[%d].Description', i);
            n_plan_year_start := TO_DATE(apex_json.get_varchar2('Benefit_accrual[%d].Planyearstart', i), 'YYYY-MM-DD"T"HH24:MI:SS');
            n_carry_forward := apex_json.get_number('Benefit_accrual[%d].Carryforward', i);
            n_plan_year_accrued := apex_json.get_number('Benefit_accrual[%d].Planyearaccrued', i);
            n_plan_year_used := apex_json.get_number('Benefit_accrual[%d].Planyearused', i);
            n_maximum_accrual_limit := apex_json.get_number('Benefit_accrual[%d].Maximumaccruallimit', i);
            n_available := apex_json.get_number('Benefit_accrual[%d].Available', i);
            n_hrm_absence_code_id := apex_json.get_varchar2('Benefit_accrual[%d].HRMAbsenceCodeId', i);
            n_hrm_absence_code_group_id := apex_json.get_varchar2('Benefit_accrual[%d].HRMAbsenceCodeGroupId', i);
            n_expiration_date := TO_DATE(apex_json.get_varchar2('Benefit_accrual[%d].ExpirationDate', i), 'YYYY-MM-DD"T"HH24:MI:SS');
            -- for Leaves from D365

            DBMS_OUTPUT.put_line('Values:' || TO_CHAR(l_numrow) || ' n_benefit_accrual_plan:' || n_benefit_accrual_plan);
            DBMS_OUTPUT.PUT_LINE('');

            -- Insert data into the table ABSENCE_GROUP_EMPLOYEE
            SELECT MAX(ID) + 1 INTO l_max FROM ABSENCE_GROUP_EMPLOYEE;
            INSERT INTO ABSENCE_GROUP_EMPLOYEE (
                ID,
                EMPLOYEE_CODE,
                LEGAL_ENTITY,
                BENEFIT_ACCRUAL_PLAN,
                DESCRIPTION,
                PLAN_YEAR_START,
                CARRY_FORWARD,
                PLAN_YEAR_ACCRUED,
                PLAN_YEAR_USED,
                MAXIMUM_ACCRUAL_LIMIT,
                AVAILABLE,
                HRM_ABSENCE_CODE_ID,
                HRM_ABSENCE_CODE_GROUP_ID,
                EXPIRATION_DATE
            )
            VALUES (
                l_max,
                r.EMPLOYEE_CODE,
                r.DATAAREA,
                n_benefit_accrual_plan,
                n_description,
                n_plan_year_start,
                n_carry_forward,
                n_plan_year_accrued,
                n_plan_year_used,
                n_maximum_accrual_limit,
                n_available,
                n_hrm_absence_code_id,
                n_hrm_absence_code_group_id,
                n_expiration_date
            );

            -- Insert LEAVES from D365 into the table EMPLOYEE_REQUESTS
            l_trans_numrow := APEX_JSON.get_count(p_path => 'Benefit_accrual[' || i || '].Benefit_accrual_transactions');
            DBMS_OUTPUT.put_line('Values:' || TO_CHAR(l_trans_numrow) || ' Benefit_accrual_transactions:' || n_benefit_accrual_plan);
            DBMS_OUTPUT.PUT_LINE('');

            FOR j IN 1..l_trans_numrow LOOP
                -- t_worker := apex_json.get_varchar2('Benefit_accrual[' || i || '].Benefit_accrual_transactions[' || j || '].Worker');
                t_worker := apex_json.get_varchar2('Benefit_accrual[%d].Benefit_accrual_transactions[%d].Worker', i, j);
                t_trans_date := TO_DATE(apex_json.get_varchar2('Benefit_accrual[%d].Benefit_accrual_transactions[%d].TransDate', i, j), 'YYYY-MM-DD"T"HH24:MI:SS');
                t_trans_Carryforward := apex_json.get_varchar2('Benefit_accrual[%d].Benefit_accrual_transactions[%d].Carryforward', i, j);
                t_trans_Planyearaccrued := apex_json.get_varchar2('Benefit_accrual[%d].Benefit_accrual_transactions[%d].Planyearaccrued', i, j);
                t_trans_Planyearused := apex_json.get_varchar2('Benefit_accrual[%d].Benefit_accrual_transactions[%d].Planyearused', i, j);
                
                t_total_days := t_trans_Planyearused + t_trans_Carryforward;

                -- t_all_day := CASE WHEN t_total_days = 0.5 THEN 'N' ELSE 'Y' END;
                t_all_day := CASE WHEN t_total_days = 0.5 THEN 'N' ELSE 'Y' END;

                -- t_end_date :=
                -- t_status :=
                -- t_responser_id :=
                -- n_hrm_absence_code_group_id :=
                -- t_target_code :=
                -- t_trans_date :=
                -- n_benefit_accrual_plan :=
                -- t_end_date = t_trans_date + 
                
                DBMS_OUTPUT.put_line('Transaction ' || j || ' details:');
                DBMS_OUTPUT.put_line('Worker-name: ' || t_worker);
                DBMS_OUTPUT.put_line('Transaction Date: ' || TO_CHAR(t_trans_date, 'YYYY-MM-DD HH24:MI:SS'));
                DBMS_OUTPUT.put_line('Carryforward: ' || t_trans_Carryforward);
                DBMS_OUTPUT.put_line('Planyearaccrued: ' || t_trans_Planyearaccrued);
                DBMS_OUTPUT.put_line('Planyearused: ' || t_trans_Planyearused);
                DBMS_OUTPUT.put_line('Total Days: ' || t_total_days);
                DBMS_OUTPUT.put_line('All Day: ' || t_all_day);
                DBMS_OUTPUT.PUT_LINE('');

                -- If planyearaccrued > 0, do not create leave
                if t_trans_Planyearaccrued > 0 then
                    continue;
                end if;

                -- INSERT INTO ABSENCE_GROUP_EMPLOYEE (
                --     REQUESTOR_ID,
                --     EMPLOYEE_CODE_REQ,
                --     EMPLOYEE_NAME,
                --     FROM_DATE,
                --     END_DATE,
                --     ALL_DAY,
                --     TOTAL_DAYS,
                --     EMP_REQ_STATUS,
                --     RESPONSER_ID,
                --     LEAVE_TYPE,
                --     TARGET_CODE,
                --     SUBMIT_DATE,
                --     BENEFIT_CODE,
                --     IS_D365
                -- )
                -- VALUES (
                --     n_emp_id,
                --     n_employeeCode,
                --     t_worker,
                --     t_trans_date,
                --     t_end_date,
                --     t_all_day,
                --     t_total_days,
                --     t_status,
                --     t_responser_id,
                --     n_hrm_absence_code_group_id,
                --     t_target_code,
                --     t_trans_date,
                --     n_benefit_accrual_plan,
                --     1
                -- );

            END LOOP;

        END LOOP;
    END LOOP;
END;
/