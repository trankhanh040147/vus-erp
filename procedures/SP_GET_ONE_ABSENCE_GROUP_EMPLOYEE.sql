create or replace PROCEDURE "SP_GET_ONE_ABSENCE_GROUP_EMPLOYEE" (
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
    l_count_leave_portal_id NUMBER;
    l_max NUMBER;
    l_body_json CLOB;
    n_id NUMBER;
    n_emp_id NUMBER;
    n_carryforward NUMBER;
    n_can_cf NUMBER;
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
    t_end_date DATE;
    t_trans_Carryforward NUMBER;
    t_trans_Planyearaccrued NUMBER;
    t_trans_Planyearused NUMBER;
    t_total_days NUMBER;
    t_all_day NVARCHAR2(10);
    t_responser_id NUMBER;
    t_target_code NVARCHAR2(100);
    t_status NUMBER;
    t_trans_IdPortalStr NUMBER;

    total_exist_leave number;
    
BEGIN
    SP_GET_TOKEN(p_token);
    apex_web_service.g_request_headers.delete();

    apex_web_service.g_request_headers(1).name := 'Authorization';
    apex_web_service.g_request_headers(1).value := 'Bearer ' || p_token;

    apex_web_service.g_request_headers(2).name := 'Content-Type';
    apex_web_service.g_request_headers(2).value := 'application/json; charset=utf-8';

    -- Delete current Absence_groups of this employee OR update it
    DELETE FROM ABSENCE_GROUP_EMPLOYEE WHERE EMPLOYEE_CODE = p_employee_code;

    -- DELETE from EMPLOYEE_REQUESTS where IS_D365 = 1 and EMPLOYEE_CODE_REQ = p_employee_code;

    -- Pending: Delete all current waiting leaves 
    -- DELETE from EMPLOYEE_REQUESTS 
    -- WHERE IS_D365 = 0 and EMPLOYEE_CODE_REQ = p_employee_code 
    -- AND EMP_REQ_STATUS = 2;


    FOR r IN (SELECT EMPLOYEE_CODE, DATAAREA FROM EMPLOYEES WHERE EMPLOYEE_CODE = p_employee_code) LOOP
        l_body := '{"_jsonRequest":{"EmployeeCode":"' || r.EMPLOYEE_CODE || '","legal_entity":"' || r.DATAAREA || '"} }';

        DBMS_OUTPUT.put_line(l_body);

        l_response := apex_web_service.make_rest_request(
            p_url => global_vars.get_resource_url || '/api/services/VUSTC_AbsenceGroupEmployeeServiceGroup/AbsenceGroupEmployeeService/GetAbsenceGroupEmployee',
            p_http_method => 'POST',
            p_body => l_body,
            p_transfer_timeout => 3600
        );

        APEX_JSON.parse(l_response);

        l_numrow := APEX_JSON.get_count(p_path => 'Benefit_accrual');
        FOR i IN 1..l_numrow LOOP
            n_benefit_accrual_plan := apex_json.get_varchar2('Benefit_accrual[%d].Benefitaccrualplan', i);
            n_description := apex_json.get_varchar2('Benefit_accrual[%d].Description', i);
            n_plan_year_start := TO_DATE(apex_json.get_varchar2('Benefit_accrual[%d].Planyearstart', i), 'YYYY-MM-DD"T"HH24:MI:SS');
            n_carry_forward := apex_json.get_number('Benefit_accrual[%d].Carryforward', i);
            n_plan_year_accrued := apex_json.get_number('Benefit_accrual[%d].Planyearaccrued', i);
            -- n_plan_year_used := TO_NUMBER(apex_json.get_varchar2('Benefit_accrual[%d].Planyearused', i));
            n_plan_year_used := TO_NUMBER(apex_json.get_varchar2('Benefit_accrual[%d].Planyearused', i), '9999999999.9999999999');
            n_maximum_accrual_limit := apex_json.get_number('Benefit_accrual[%d].Maximumaccruallimit', i);
            n_available := apex_json.get_number('Benefit_accrual[%d].Available', i);
            n_hrm_absence_code_id := apex_json.get_varchar2('Benefit_accrual[%d].HRMAbsenceCodeId', i);
            n_hrm_absence_code_group_id := apex_json.get_varchar2('Benefit_accrual[%d].HRMAbsenceCodeGroupId', i);
            n_expiration_date := TO_DATE(apex_json.get_varchar2('Benefit_accrual[%d].ExpirationDate', i), 'YYYY-MM-DD"T"HH24:MI:SS');
            n_can_cf := apex_json.get_number('Benefit_accrual[%d].CanCarryForward', i);

            -- Get value min
            if(n_plan_year_accrued > n_maximum_accrual_limit) then
                n_plan_year_accrued := n_maximum_accrual_limit;
            end if;


            -- Convert Group 'Leave' to 'APL'
            if n_hrm_absence_code_group_id = 'Leave' then
                n_hrm_absence_code_group_id := 'APL';
            end if;
            DBMS_OUTPUT.put_line('Values:' || TO_CHAR(l_numrow) || ' n_benefit_accrual_plan:' || n_benefit_accrual_plan);

            DBMS_OUTPUT.put_line('Plan_used: ' || to_char(n_plan_year_used));

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
                EXPIRATION_DATE,
                CAN_CARRY_FORWARD
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
                n_expiration_date,
                n_can_cf
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
                t_trans_IdPortalStr := TO_NUMBER(REGEXP_REPLACE(apex_json.get_varchar2('Benefit_accrual[%d].Benefit_accrual_transactions[%d].IdPortalStr', i, j), '[^0-9]', ''));
                
                t_total_days := t_trans_Planyearused + t_trans_Carryforward;

                t_status := CASE WHEN t_total_days <0 THEN 5 ELSE 3 END;

                IF t_total_days = 0 or t_total_days = 0.5 or t_total_days = -0.5 then
                    t_all_day := 'N';
                    t_end_date := t_trans_date;
                ELSE
                    t_all_day := 'Y';
                    t_end_date := t_trans_date + INTERVAL '1' DAY * (FLOOR(abs(t_total_days)) - 1);
                END IF;
                
                SELECT EMPLOYEE_ID INTO n_emp_id FROM EMPLOYEES WHERE EMPLOYEE_CODE = p_employee_code;
                -- SELECT EMPLOYEE_ID INTO t_responser_id FROM EMPLOYEES WHERE EMPLOYEE_CODE = (SELECT MANAGER_ID FROM EMPLOYEES WHERE EMPLOYEE_CODE = p_employee_code);
                BEGIN
                    SELECT EMPLOYEE_ID 
                    INTO t_responser_id 
                    FROM EMPLOYEES 
                    WHERE EMPLOYEE_CODE = (SELECT MANAGER_ID FROM EMPLOYEES WHERE EMPLOYEE_CODE = p_employee_code);
                EXCEPTION
                    WHEN NO_DATA_FOUND THEN
                        t_responser_id := NULL;
                END;        

                BEGIN
                    SELECT MANAGER_POSITION_ID 
                    INTO t_target_code 
                    FROM EMPLOYEES 
                    WHERE EMPLOYEE_CODE = (SELECT MANAGER_ID FROM EMPLOYEES WHERE EMPLOYEE_CODE = p_employee_code);
                EXCEPTION
                    WHEN NO_DATA_FOUND THEN
                        t_target_code := NULL;
                END;       
                if t_total_days <= 0 then
                    -- continue;
                    t_total_days := -t_total_days;
                end if;         
                
                -- SELECT MANAGER_POSITION_ID INTO t_target_code FROM EMPLOYEES WHERE EMPLOYEE_CODE = (SELECT MANAGER_ID FROM EMPLOYEES WHERE EMPLOYEE_CODE = p_employee_code);
                
                -- DBMS_OUTPUT.put_line('Transaction ' || j || ' details:');
                -- DBMS_OUTPUT.put_line('Worker-name: ' || t_worker);
                -- DBMS_OUTPUT.put_line('Transaction Date: ' || TO_CHAR(t_trans_date, 'YYYY-MM-DD HH24:MI:SS'));
                -- DBMS_OUTPUT.put_line('End Date: ' || TO_CHAR(t_end_date, 'YYYY-MM-DD HH24:MI:SS'));
                -- DBMS_OUTPUT.put_line('Carryforward: ' || t_trans_Carryforward);
                -- DBMS_OUTPUT.put_line('Planyearaccrued: ' || t_trans_Planyearaccrued);
                -- DBMS_OUTPUT.put_line('Planyearused: ' || t_trans_Planyearused);
                -- DBMS_OUTPUT.put_line('Total Days: ' || t_total_days);
                -- DBMS_OUTPUT.put_line('All Day: ' || t_all_day);
                -- DBMS_OUTPUT.put_line('Status: ' || t_status);
                -- DBMS_OUTPUT.put_line('Responer Id: ' || t_responser_id);
                -- DBMS_OUTPUT.put_line('Target Code: ' || t_target_code);
                -- DBMS_OUTPUT.PUT_LINE('');

                -- Count leaves from D365 that inserted before, do not insert theses again
                SELECT COUNT(ID) INTO total_exist_leave FROM EMPLOYEE_REQUESTS
                WHERE (EMPLOYEE_CODE_REQ = p_employee_code AND FROM_DATE = t_trans_date AND
                TOTAL_DAYS = t_total_days AND EMP_REQ_STATUS = t_status
                AND BENEFIT_CODE = n_benefit_accrual_plan) 
                OR (ID = t_trans_IdPortalStr);

                -- Count leaves from D365


                -- Insert leaves that do not have t_trans_IdPortalStr
                IF (total_exist_leave <= 0) and (t_trans_IdPortalStr is NULL or t_trans_IdPortalStr = '') THEN

                    INSERT INTO EMPLOYEE_REQUESTS (
                        REQUESTOR_ID,
                        EMPLOYEE_CODE_REQ,
                        EMPLOYEE_NAME,
                        FROM_DATE,
                        END_DATE,
                        ALL_DAY,
                        TOTAL_DAYS,
                        EMP_REQ_STATUS,
                        RESPONSER_ID,
                        LEAVE_TYPE,
                        TARGET_CODE,
                        SUBMIT_DATE,
                        BENEFIT_CODE,
                        IS_D365,
                        ID_PORTAL_STR
                    )
                    VALUES (
                        n_emp_id,
                        p_employee_code,
                        t_worker,
                        t_trans_date,
                        t_end_date,
                        t_all_day,
                        t_total_days,
                        t_status,
                        t_responser_id,
                        CASE WHEN n_hrm_absence_code_group_id ='Leave' THEN 'APL' ELSE to_char(n_hrm_absence_code_group_id) END,
                        t_target_code,
                        t_trans_date,
                        n_benefit_accrual_plan,
                        1, -- IS LEAVE FROM D365,
                        0
                    );
                    
                ELSIF (total_exist_leave <= 0) and (t_trans_IdPortalStr is NOT NULL or t_trans_IdPortalStr != '') THEN
                    INSERT INTO EMPLOYEE_REQUESTS (
                        ID,
                        REQUESTOR_ID,
                        EMPLOYEE_CODE_REQ,
                        EMPLOYEE_NAME,
                        FROM_DATE,
                        END_DATE,
                        ALL_DAY,
                        TOTAL_DAYS,
                        EMP_REQ_STATUS,
                        RESPONSER_ID,
                        LEAVE_TYPE,
                        TARGET_CODE,
                        SUBMIT_DATE,
                        BENEFIT_CODE,
                        IS_D365,
                        ID_PORTAL_STR
                    )
                    VALUES (
                        t_trans_IdPortalStr,
                        n_emp_id,
                        p_employee_code,
                        t_worker,
                        t_trans_date,
                        t_end_date,
                        t_all_day,
                        t_total_days,
                        t_status,
                        t_responser_id,
                        CASE WHEN n_hrm_absence_code_group_id ='Leave' THEN 'APL' ELSE to_char(n_hrm_absence_code_group_id) END,
                        t_target_code,
                        t_trans_date,
                        n_benefit_accrual_plan,
                        0, -- LEAVE FROM PORTAL,
                        t_trans_IdPortalStr
                    );
                END IF;

            END LOOP;

        END LOOP;

    END LOOP;


    -- Merge AL & CF 
    FOR r1 IN (SELECT * FROM ABSENCE_GROUP_EMPLOYEE WHERE EMPLOYEE_CODE = p_employee_code) LOOP 
        IF r1.HRM_ABSENCE_CODE_GROUP_ID = 'APL' AND r1.CAN_CARRY_FORWARD = 0 THEN
            FOR r2 IN (SELECT * FROM ABSENCE_GROUP_EMPLOYEE WHERE EMPLOYEE_CODE = p_employee_code) LOOP
                IF r2.HRM_ABSENCE_CODE_GROUP_ID = 'APL' AND r2.CAN_CARRY_FORWARD = 1 THEN
                    -- Perform the updates
                    -- r1.CARRY_FORWARD := r1.CARRY_FORWARD + r2.CARRY_FORWARD;
                    r1.CARRY_FORWARD_AVALABLE := r2.AVAILABLE;
                    r1.CARRY_FORWARD_CODE := r2.HRM_ABSENCE_CODE_ID;
                    r1.CARRY_FORWORD_EXP_DATE := r2.EXPIRATION_DATE;
                    r1.CF_BENEFIT_ACCRUAL_PLAN := r2.BENEFIT_ACCRUAL_PLAN;
                    r1.PLAN_YEAR_USED := r1.PLAN_YEAR_USED + r2.PLAN_YEAR_USED;

                    -- Update r1 in database
                    UPDATE ABSENCE_GROUP_EMPLOYEE
                    SET CARRY_FORWARD = r2.CARRY_FORWARD,
                        CARRY_FORWARD_AVALABLE = r1.CARRY_FORWARD_AVALABLE,
                        CARRY_FORWARD_CODE = r1.CARRY_FORWARD_CODE,
                        CARRY_FORWORD_EXP_DATE = r1.CARRY_FORWORD_EXP_DATE,
                        CF_BENEFIT_ACCRUAL_PLAN = r1.CF_BENEFIT_ACCRUAL_PLAN,
                        -- PLAN_YEAR_USED = r1.PLAN_YEAR_USED
                        CARRY_FORWARD_USED = r2.PLAN_YEAR_USED,
                        PLAN_YEAR_ACCRUED = PLAN_YEAR_ACCRUED + r1.CARRY_FORWARD

                    WHERE EMPLOYEE_CODE = p_employee_code
                    AND HRM_ABSENCE_CODE_GROUP_ID = 'APL'
                    AND CAN_CARRY_FORWARD = 0;

                    -- Delete r2 from database
                    DELETE FROM ABSENCE_GROUP_EMPLOYEE WHERE EMPLOYEE_CODE = p_employee_code AND HRM_ABSENCE_CODE_GROUP_ID = 'APL' AND CAN_CARRY_FORWARD = 1;

                    EXIT; -- Exit the inner loop after updating and deleting
                END IF;
            END LOOP;
            
            EXIT; -- Exit the outer loop after finding the first record
        END IF;
    END LOOP;


END;
/