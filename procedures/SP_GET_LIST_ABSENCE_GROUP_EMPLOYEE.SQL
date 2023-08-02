create or replace PROCEDURE "SP_GET_LIST_ABSENCE_GROUP_EMPLOYEE"
(p_token nvarchar2)
is
l_token_type NVARCHAR2(2000);
l_access_token NVARCHAR2(2000);
l_body NVARCHAR2(2000);
l_response_clob clob;
l_authorization NVARCHAR2(2000);
l_response clob;
l_numrow number;
l_rowsub number;
l_count_idemp number;
l_max number;
l_body_json clob;
n_id number;
n_carryforward number;
n_planyearaccrued number;
n_planyearused number;
n_employeeCode NVARCHAR2(200);
l_list clob;
n_legal_entity NVARCHAR2(200);
BEGIN
    apex_web_service.g_request_headers.delete();    
    
    apex_web_service.g_request_headers(1).name := 'Authorization';
    apex_web_service.g_request_headers(1).value := 'Bearer '|| p_token;
    
    apex_web_service.g_request_headers(2).name := 'Content-Type';
    apex_web_service.g_request_headers(2).value := 'application/json; charset=utf-8';

    FOR r in(SELECT EMPLOYEE_CODE, DATAAREA FROM EMPLOYEES WHERE EMPLOYEE_CODE = '488')
    LOOP

        l_body := '{"_jsonRequest":{"EmployeeCode":"'||r.EMPLOYEE_CODE||'","legal_entity":"'||r.DATAAREA||'"} }';

        DBMS_OUTPUT.put_line(l_body);
        --APEX_JSON.parse(

        l_response := apex_web_service.make_rest_request(
                p_url => 'https://hra.sandbox.operations.dynamics.com/api/services/VUSTC_AbsenceGroupEmployeeServiceGroup/AbsenceGroupEmployeeService/GetAbsenceGroupEmployee',
                p_http_method => 'POST',
                p_body => l_body,
                p_transfer_timeout => 3600
                ) ;
        --);
        
        l_response := TO_CLOB('['||REGEXP_REPLACE(TO_CHAR(l_response), 'Benefit accrual', 'Benefit_accrual')||']');
        APEX_JSON.parse(l_response);
        --l_list := APEX_JSON.json_list(l_response.get('Benefit accrual'));

        l_numrow := APEX_JSON.get_count (p_path =>'.');
        FOR i IN 1..l_numrow LOOP
            n_legal_entity := apex_json.get_varchar2('[%d].legal_entity', i);
            l_response_clob := apex_json.get_varchar2('[%d].Benefit accrual', i);
            l_rowsub := apex_json.get_count('[%d].Benefit accrual');
            DBMS_OUTPUT.put_line('đếm số chuỗi trả về :' ||to_char(l_numrow) ||' Benefit accrual: '||to_char(l_rowsub)||' n_legal_entity:'||n_legal_entity);
        END LOOP;
        
        --FOR i IN 1 .. l_rowsub LOOP
            
            --n_carryforward := NVL(TO_NUMBER(apex_json.GET_NUMBER('Benefit accrual[%d].Planyearstart', i)), 0);
            --n_planyearaccrued := NVL(TO_NUMBER(apex_json.GET_NUMBER('Benefit accrual[%d].Carryforward', i)), 0);
            --n_planyearused := NVL(TO_NUMBER(apex_json.GET_NUMBER('Benefit accrual[%d].Planyearaccrued', i)), 0);
            --dbms_output.put_line ('Item number ' || TO_CHAR(i)||'; '|| TO_CHAR(n_carryforward)||'; '||TO_CHAR(n_planyearaccrued)||'; '||TO_CHAR(n_planyearused));
            --SELECT MAX(ID) + 1 INTO l_max FROM EMP_ANNUAL_LEAVE;

            --INSERT INTO EMP_ANNUAL_LEAVE(ID, EMPLOYEE_CODE, LEVEA_OLD_YEAR, LEAVE_ENTITLEMENT, LEAVE_BALANCE)
                    --VALUES(l_max, r.EMPLOYEE_CODE, n_carryforward, n_planyearaccrued, n_planyearused);

        --END LOOP;
        --COMMIT;
    END LOOP;
    --DBMS_OUTPUT.put_line(TO_CHAR(n_id)||n_name||TO_CHAR(n_managerPosition));
    
END;
/