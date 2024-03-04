create or replace procedure "SP_SWITCH_ACOUNT"
(
    p_emp_code_first in employees.employee_code%type,
    p_emp_code_second in employees.employee_code%type
)
is
    n_user_name_first employees.user_name%type;
    n_user_name_second employees.user_name%type;
begin

    -- TABLE: EMPLOYEES
    -- Columns: EMPLOYEE_CODE, USER_NAME

    -- swap user_name
    select user_name into n_user_name_first from employees where employee_code = p_emp_code_first;
    select user_name into n_user_name_second from employees where employee_code = p_emp_code_second;

    update employees set user_name = n_user_name_second where employee_code = p_emp_code_first;
    update employees set user_name = n_user_name_first where employee_code = p_emp_code_second;

    -- print out log
    dbms_output.put_line('User name of employee ' || p_emp_code_first || ' is changed to ' || n_user_name_second);
    dbms_output.put_line('User name of employee ' || p_emp_code_second || ' is changed to ' || n_user_name_first);
    
end "SP_SWITCH_ACOUNT";
/