-- TABLE: EMPLOYEES
-- ID	NUMBER(10,0)
-- USER_NAME	NVARCHAR2(100 CHAR)
-- FULL_NAME	NVARCHAR2(1000 CHAR)
-- EMPLOYEE_CODE	NVARCHAR2(100 CHAR)
-- LEVEL_ID	NVARCHAR2(20 CHAR)
-- DEPARTMENT_ID	NVARCHAR2(20 CHAR)
-- APPROVAL_GROUP	NVARCHAR2(50 CHAR)
-- MANAGER_ID	NVARCHAR2(100 CHAR) : This is employee code of manager

-- Update Approval_group for all employees based on level_id; have params to exclude certain USER_NAME
create or replace procedure "SP_UPDATE_APPROVAL_GROUP"
(
    p_exclude_user_name_list in varchar2 default null
)
as

declare 
current_emp_code varchar2(100);
begin

    -- 1. Print data to check: 
    -- Loop through all employees, find recursive manager to the root for each employee
    -- ex: 
    -- current_user_name := 'hrtest04';
    -- manager recursive list: hrtest04 <- hrtest01 <- t06 <- null 
    for r in (
        select *
        from employees e
    ) loop
        dbms_output.put_line('current_user_name: ' || r.user_name 
            -- || ' - name: ' || r.FULL_NAME 
            -- || ' - level_id: ' || r.level_id || ' - department_id: ' || r.department_id);
            || ' - ' || r.level_id || ' - ' || r.department_id);
        current_emp_code := r.employee_code;
        while current_emp_code is not null loop
            select manager_id into current_emp_code
            from employees
            where employee_code = current_emp_code;
            dbms_output.put_line('manager recursive: ' || current_emp_code 
                -- || ' - name: ' || r.FULL_NAME 
                -- || ' - level_id: ' || r.level_id || ' - department_id: ' || r.department_id);
                || ' - ' || r.level_id || ' - ' || r.department_id);
        end loop;
    end loop;
    -- .NEW

end;
