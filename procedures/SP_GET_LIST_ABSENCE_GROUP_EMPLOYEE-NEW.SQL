CREATE OR REPLACE PROCEDURE "SP_GET_LIST_ABSENCE_GROUP_EMPLOYEE_2" (
    p_token NVARCHAR2
) IS
    l_token_type NVARCHAR2(2000);
    l_access_token NVARCHAR2(2000);
    l_body NVARCHAR2(2000);
    l_response_clob CLOB;
    l_authorization NVARCHAR2(2000);
    l_response CLOB;
    l_numrow NUMBER;
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
BEGIN
    apex_web_service.g_request_headers.delete();
    
    apex_web_service.g_request_headers(1).name := 'Authorization';
    apex_web_service.g_request_headers(1).value := 'Bearer '|| p_token;
    
    apex_web_service.g_request_headers(2).name := 'Content-Type';
    apex_web_service.g_request_headers(2).value := 'application/json; charset=utf-8';

    FOR r IN (SELECT EMPLOYEE_CODE, DATAAREA FROM EMPLOYEES WHERE EMPLOYEE_CODE = '488') LOOP
        l_body := '{"_jsonRequest":{"EmployeeCode":"' || r.EMPLOYEE_CODE || '","legal_entity":"' || r.DATAAREA || '"} }';

        DBMS_OUTPUT.put_line(l_body);

        l_response := apex_web_service.make_rest_request(
            p_url => 'https://hra.sandbox.operations.dynamics.com/api/services/VUSTC_AbsenceGroupEmployeeServiceGroup/AbsenceGroupEmployeeService/GetAbsenceGroupEmployee',
            p_http_method => 'POST',
            p_body => l_body,
            p_transfer_timeout => 3600
        );

        APEX_JSON.parse(l_response);

        l_numrow := APEX_JSON.get_count(p_path => '.');
        FOR i IN 1..l_numrow LOOP
            n_legal_entity := apex_json.get_varchar2('[%d].Legal_entity', i);
            l_response_clob := apex_json.get_clob('[%d].Benefitaccrualplan', i);
            l_rowsub := apex_json.get_count('[%d].Benefit_accrual_transactions', i);
            DBMS_OUTPUT.put_line('đếm số chuỗi trả về :' || TO_CHAR(l_numrow) || ' Benefit accrual: ' || TO_CHAR(l_rowsub) || ' n_legal_entity:' || n_legal_entity);

            FOR j IN 1..l_rowsub LOOP
                n_carryforward := NVL(apex_json.get_number('[%d].Benefit_accrual_transactions[%d].Carryforward', i, j), 0);
                n_planyearaccrued := NVL(apex_json.get_number('[%d].Benefit_accrual_transactions[%d].Planyearaccrued', i, j), 0);
                n_planyearused := NVL(apex_json.get_number('[%d].Benefit_accrual_transactions[%d].Planyearused', i, j), 0);
                DBMS_OUTPUT.put_line('Item number ' || TO_CHAR(j) || '; Carryforward: ' || TO_CHAR(n_carryforward) || '; Planyearaccrued: ' || TO_CHAR(n_planyearaccrued) || '; Planyearused: ' || TO_CHAR(n_planyearused));

                SELECT MAX(ID) + 1 INTO l_max FROM ABSENCE_GROUP_EMPLOYEE;
                INSERT INTO ABSENCE_GROUP_EMPLOYEE (
                    ID,
                    EMPLOYEE_CODE,
                    LEGAL_ENTITY,
                    BENEFIT_ACCRUAL_PLAN,
                    DESCRIPTION,
                    -- PLAN_YEAR_START,
                    CARRY_FORWARD,
                    PLAN_YEAR_ACCRUED,
                    PLAN_YEAR_USED,
                    MAXIMUM_ACCRUAL_LIMIT,
                    AVAILABLE,
                    HRM_ABSENCE_CODE_ID,
                    HRM_ABSENCE_CODE_GROUP_ID,
                    -- EXPIRATION_DATE
                )
                VALUES (
                    l_max,
                    r.EMPLOYEE_CODE,
                    n_legal_entity,
                    apex_json.get_varchar2('[%d].Benefitaccrualplan', i),
                    apex_json.get_varchar2('[%d].Description', i),
                    -- TO_DATE(apex_json.get_varchar2('[%d].Planyearstart', i), 'YYYY-MM-DD"T"HH24:MI:SS'),
                    n_carryforward,
                    n_planyearaccrued,
                    n_planyearused,
                    apex_json.get_number('[%d].Maximumaccruallimit', i),
                    apex_json.get_number('[%d].Available', i),
                    apex_json.get_varchar2('[%d].HRMAbsenceCodeId', i),
                    apex_json.get_varchar2('[%d].HRMAbsenceCodeGroupId', i),
                    -- TO_DATE(apex_json.get_varchar2('[%d].ExpirationDate', i), 'YYYY-MM-DD"T"HH24:MI:SS')
                );
            END LOOP;
        END LOOP;
    END LOOP;
END;
/
