create or replace procedure "SP_SWITCH_ACOUNT"
(
    p_emp_code_first,
    p_emp_code_second
)
is
    n_user_name_first NVARCHAR2,
    n_user_name_second NVARCHAR2
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