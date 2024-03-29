create or replace PROCEDURE SP_UPDATE_APPROVAL_GROUP(
    p_exclude_user_name_list IN VARCHAR2 DEFAULT NULL
) IS
    TYPE array_t IS TABLE OF VARCHAR2(100) INDEX BY BINARY_INTEGER;
    TYPE approval_rec IS RECORD (
        employee_code VARCHAR2(100),
        approval_group VARCHAR2(200)
    );
    current_emp_code varchar2(100);
    current_manager_id varchar2(100);
    current_manager_level varchar2(50);
    current_manager_department varchar2(50);

    -- department of the requester
    root_department varchar2(50);
    last_manager_id varchar2(100);
    last_manager_level varchar2(50);
    last_manager_department varchar2(50);

    approval_group_result VARCHAR2(200);
    approval_group_update VARCHAR2(200);

    array_list_directors array_t;
    approval_updates approval_rec;
    array_size number := 0;

    n_count_emp number;

    FUNCTION is_excluded(p_user_name VARCHAR2) RETURN BOOLEAN IS
    BEGIN
        RETURN INSTR(p_exclude_user_name_list, p_user_name) > 0;
    END;

    FUNCTION append_approval_group(p_existing_groups VARCHAR2, p_department VARCHAR2) RETURN VARCHAR2 IS
    BEGIN
        IF p_existing_groups IS NULL OR p_existing_groups = '' THEN
            RETURN p_department;
        ELSIF INSTR(p_existing_groups, p_department) = 0 THEN
            RETURN p_existing_groups || ',' || p_department;
        ELSE
            RETURN p_existing_groups;
        END IF;
    END;

BEGIN
    FOR r IN (SELECT * FROM employees) LOOP
        -- IF is_excluded(r.user_name) THEN
        --     CONTINUE;
        -- END IF;

        --- <BEGIN> Determine last_manager_id and root_department

        -- print info of current employee
        -- dbms_output.put_line('>>>current_user_name: ' || r.user_name 
        --     || ' - ' || r.employee_code || ' - requester-level:' || r.level_id || ' - ' || r.department_id);

        -- find recursive manager to the root for current employee
        select manager_id, department_id into current_manager_id, root_department
        from employees
        where employee_code = r.employee_code;

        -- set default for last_manager_id (empty)
        last_manager_id := '-1';

        -- get department name from department id. Ex: V01_PUR --> PUR
        root_department := get_departmentname_from_departmentid(root_department);

        while length(current_manager_id) > 0
        loop
            current_emp_code := current_manager_id;

            -- if there is no employee with current_manager_id, then break the loop
            select count(*) into n_count_emp from EMPLOYEES where employee_code = current_emp_code;
            if n_count_emp = 0 then
                exit;
            end if;

            -- get manager info
            select manager_id, level_id, department_id 
            into current_manager_id, current_manager_level, current_manager_department
            from employees
            where employee_code = current_emp_code;
            
            -- print info of current manager
            -- dbms_output.put_line('manager recursive: ' || current_emp_code 
            --     || ' - mana-level:' || current_manager_level || ' - ' || current_manager_department);

            if(trim(lower(current_manager_level)) = 'd') then 
                last_manager_id := current_emp_code;
                last_manager_level := current_manager_level;
                last_manager_department := current_manager_department;
            end if;
        end loop;
        -- <END> Determine last_manager_id and root_department

        -- Update logic
        approval_group_result := 'head_of_' || root_department;
        IF last_manager_id != '-1' THEN
            SELECT approval_groups INTO approval_updates.approval_group
            FROM employees
            WHERE employee_code = last_manager_id;

            approval_updates.approval_group := append_approval_group(approval_updates.approval_group, approval_group_result);

            UPDATE employees
            SET approval_groups = approval_updates.approval_group
            WHERE employee_code = last_manager_id;
        END IF;
    END LOOP;

    -- custom setting
    --- update approval group for specific employees
    --- user_name: 'hrtest06@vus-etsc.edu.vn' --> append 'head_of_HRA' to approval_groups
    -- SELECT approval_groups INTO approval_group_update
    -- FROM employees
    -- WHERE lower(trim(user_name)) = 'hrtest06@vus-etsc.edu.vn';

    -- approval_group_update := append_approval_group(approval_group_update, 'head_of_HRA');

    -- UPDATE employees
    -- SET approval_groups = approval_group_update
    -- WHERE lower(trim(user_name)) = 'hrtest06@vus-etsc.edu.vn';

    -- remove approval group for specific employees
    -- remove 'head_of_BOD' from approval_groups for employee with user_name: '%hrtest04%'

    -- select approval_groups into approval_group_update
    -- from employees
    -- where lower(trim(user_name)) like '%hrtest04%';

    -- approval_group_update := replace(approval_group_update, 'head_of_BOD', '');

    -- UPDATE employees
    -- SET approval_groups = approval_group_update
    -- WHERE lower(trim(user_name)) like '%hrtest04%';


    -- Print all employees that have approval_groups
    dbms_output.put_line('Employees that have approval_groups: ');
    for r in (
        select *
        from employees e
        where length(e.approval_groups) > 0
    ) loop
        dbms_output.put_line(r.employee_code || ' - ' || r.approval_groups);
    end loop;

END;

-- TABLE: EMPLOYEES
-- ID	NUMBER(10,0)
-- USER_NAME	NVARCHAR2(100 CHAR)
-- FULL_NAME	NVARCHAR2(1000 CHAR)
-- EMPLOYEE_CODE	NVARCHAR2(100 CHAR)
-- LEVEL_ID	NVARCHAR2(20 CHAR)
-- DEPARTMENT_ID	NVARCHAR2(20 CHAR)
-- APPROVAL_GROUP	NVARCHAR2(50 CHAR)
-- MANAGER_ID	NVARCHAR2(100 CHAR) : This is employee code of manager
-- APPROVAL_GROUPS	NVARCHAR2(200 CHAR) : A delimited string that store departments this employee is the head of
-- APPROVAL_GROUPS data: 'head_of_HRA,head_of_MKT,head_of_IT,...';
/