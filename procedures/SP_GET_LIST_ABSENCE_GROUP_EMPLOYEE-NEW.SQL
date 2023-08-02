create or replace PROCEDURE "SP_GET_LIST_ABSENCE_GROUP_EMPLOYEE_2" (
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
    apex_web_service.g_request_headers(1).value := 'Bearer ' || p_token;
    
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

        l_numrow := APEX_JSON.get_count(p_path => 'Benefit_accrual');
        FOR i IN 1..l_numrow LOOP
            n_benefit_accrual_plan := apex_json.get_varchar2('Benefit_accrual[%d].Benefitaccrualplan', i);
            n_description := apex_json.get_varchar2('Benefit_accrual[%d].Description', i);
            n_plan_year_start :=
            n_carry_forward := 
            n_plan_year_accrued :=
            ...
            DBMS_OUTPUT.put_line('Values:' || TO_CHAR(l_numrow) || ' n_benefit_accrual_plan:' || n_benefit_accrual_plan);

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
                    i,
                    r.EMPLOYEE_CODE,
                    r.DATAAREA,
                    n_benefit_accrual_plan,
                    n_description,
                    ...
                );

        END LOOP;
    END LOOP;
END;
/