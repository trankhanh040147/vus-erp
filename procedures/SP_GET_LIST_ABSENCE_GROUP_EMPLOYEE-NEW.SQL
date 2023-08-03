CREATE OR REPLACE PROCEDURE "SP_GET_LIST_ABSENCE_GROUP_EMPLOYEE_2" (
    p_token NVARCHAR2
) IS
    -- Declare variables
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
            n_plan_year_start := TO_DATE(apex_json.get_varchar2('Benefit_accrual[%d].Planyearstart', i), 'YYYY-MM-DD"T"HH24:MI:SS');
            n_carry_forward := apex_json.get_number('Benefit_accrual[%d].Carryforward', i);
            n_plan_year_accrued := apex_json.get_number('Benefit_accrual[%d].Planyearaccrued', i);
            n_plan_year_used := apex_json.get_number('Benefit_accrual[%d].Planyearused', i);
            n_maximum_accrual_limit := apex_json.get_number('Benefit_accrual[%d].Maximumaccruallimit', i);
            n_available := apex_json.get_number('Benefit_accrual[%d].Available', i);
            n_hrm_absence_code_id := apex_json.get_varchar2('Benefit_accrual[%d].HRMAbsenceCodeId', i);
            n_hrm_absence_code_group_id := apex_json.get_varchar2('Benefit_accrual[%d].HRMAbsenceCodeGroupId', i);
            n_expiration_date := TO_DATE(apex_json.get_varchar2('Benefit_accrual[%d].ExpirationDate', i), 'YYYY-MM-DD"T"HH24:MI:SS');

            DBMS_OUTPUT.put_line('Values:' || TO_CHAR(l_numrow) || ' n_benefit_accrual_plan:' || n_benefit_accrual_plan);

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

        END LOOP;
    END LOOP;
END;
/

request.setbody('------WebKitFormBoundary7MA4YWxkTrZu0gW\r\nContent-Disposition: form-data; name=\"Full_Card_Number__c\"\r\n\r\n'+Reg[i].Full_Card_Number__c+'\r\n------WebKitFormBoundary7MA4YWxkTrZu0gW\r\nContent-Disposition: form-data; name=\"Salutation__c\"\r\n\r\n'+Reg[i].Salutation__c+'\r\n------WebKitFormBoundary7MA4YWxkTrZu0gW\r\nContent-Disposition: form-data; name=\"First_Name__c\"\r\n\r\n'+Reg[i].First_Name__C+'\r\n------WebKitFormBoundary7MA4YWxkTrZu0gW\r\nContent-Disposition: form-data; name=\"Last_Name__c\"\r\n\r\n'+Reg[i].Last_Name__C+'\r\n------WebKitFormBoundary7MA4YWxkTrZu0gW\r\nContent-Disposition: form-data; name=\"Account_Name__c\"\r\n\r\n'+ Reg[i].Account_Name__C+'\r\n------WebKitFormBoundary7MA4YWxkTrZu0gW\r\nContent-Disposition: form-data; name=\"Contact_Email__c\"\r\n\r\n'+Reg[i].Contact_Email__C+'\r\n------WebKitFormBoundary7MA4YWxkTrZu0gW\r\nContent-Disposition: form-data; name=\"Category__c\"\r\n\r\n'+Reg[i].Category__C+'\r\n------WebKitFormBoundary7MA4YWxkTrZu0gW\r\nContent-Disposition: form-data; name=\"Conference_Type__c\"\r\n\r\n'+Reg[i].Conference_Type__C+'\r\n------WebKitFormBoundary7MA4YWxkTrZu0gW\r\nContent-Disposition: form-data; name=\"Conference_Selection__c\"\r\n\r\n'+Reg[i].Conference_Selection__C+'\r\n------WebKitFormBoundary7MA4YWxkTrZu0gW\r\nContent-Disposition: form-data; name=\"Payment_Status_Interface__c\"\r\n\r\n'+Reg[i].Payment_Status_Interface__C+'\r\n------WebKitFormBoundary7MA4YWxkTrZu0gW--');
