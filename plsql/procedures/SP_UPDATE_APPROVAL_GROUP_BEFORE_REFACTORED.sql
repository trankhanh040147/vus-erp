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
-- APPROVAL_GROUPS data: 'head_of_HRA,head_of_MKT,head_of_IT,...'

-- Update Approval_group for all employees based on level_id; have params to exclude certain USER_NAME
create or replace procedure "SP_UPDATE_APPROVAL_GROUP"
(
    p_exclude_user_name_list in varchar2 default null
)
is 

type array_t is table of varchar2(100) index by binary_integer;

current_emp_code varchar2(100);
current_manager_id varchar2(100);
current_manager_level varchar2(50);
current_manager_department varchar2(50);

-- department of the requester
root_department varchar2(50);

last_manager_id varchar2(100);
last_manager_level varchar2(50);
last_manager_department varchar2(50);

array_list_directors array_t;
array_size number := 0;
array_index number := 0;

begin

    -- Loop through all employees, find recursive manager to the root for each employee
    -- ex: 
    -- current_user_name := 'hrtest04';
    -- manager recursive list: hrtest04 <- hrtest01 <- t06 <- null  
    -- Save info of the last Director of each recursive run, along with the department of the requester
    for r in (
        select *
        from employees e
    ) loop
        -- print info of current employee
        dbms_output.put_line('>>>current_user_name: ' || r.user_name 
            -- || ' - name: ' || r.FULL_NAME 
            -- || ' - level_id: ' || r.level_id || ' - department_id: ' || r.department_id);
            || ' - ' || r.employee_code || ' - requester-level:' || r.level_id || ' - ' || r.department_id);

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

            -- get manager info

            select manager_id, level_id, department_id 
            into current_manager_id, current_manager_level, current_manager_department
            from employees
            where employee_code = current_emp_code;
            
            -- print info of current manager
            dbms_output.put_line('manager recursive: ' || current_emp_code 
                -- || ' - name: ' || r.FULL_NAME 
                -- || ' - level_id: ' || r.level_id || ' - department_id: ' || r.department_id);
                || ' - mana-level:' || current_manager_level || ' - ' || current_manager_department);

            if(trim(lower(current_manager_level)) = 'd') then 
                last_manager_id := current_emp_code;
                last_manager_level := current_manager_level;
                last_manager_department := current_manager_department;
            end if;
        end loop;

        -- BEGIN: insert last_manager_info into array_list_directors
        if(last_manager_id != '-1') then
            -- insert into array_list_directors if not exist yet
            -- check if last_manager_id and root_department is not null using length
            if(length(last_manager_id) > 0 and length(root_department) > 0) then 
                
                if(array_size = 0) then
                    array_size := array_size + 1;
                    array_list_directors(array_size) := last_manager_id || '-' || last_manager_level || '-' || root_department;
                else
                    -- check if last_manager_id is already in array_list_directors
                    array_index := 0;
                    for i in 1..array_size loop
                        if(array_list_directors(i) = last_manager_id || '-' || last_manager_level || '-' || root_department) then
                            array_index := i;
                            exit;
                        end if;
                    end loop;

                    -- if not exist, insert into array_list_directors
                    if(array_index = 0) then
                        array_size := array_size + 1;
                        array_list_directors(array_size) := last_manager_id || '-' || last_manager_level || '-' || root_department;
                    end if;
                end if;

            END IF;
        end if;
        -- END: insert last_manager_info into array_list_directors

        -- BEGIN: update APPROVAL_GROUPS (EMPLOYEES) of the last_manager_id
        if(last_manager_id != '-1') then
            -- insert into array_list_directors if not exist yet
            -- check if last_manager_id and root_department is not null using length
            if(length(last_manager_id) > 0 and length(root_department) > 0) then 
                
                -- check if the department is already in APPROVAL_GROUPS
                if(length(r.approval_groups) > 0) then
                    -- check if the department is already in APPROVAL_GROUPS
                    if(instr(r.approval_groups, root_department) = 0) then
                        -- if not exist, insert into APPROVAL_GROUPS
                        update employees
                        set approval_groups = r.approval_groups || ',' || root_department
                        where employee_code = last_manager_id;
                    end if;
                else
                    -- if APPROVAL_GROUPS is empty, insert into APPROVAL_GROUPS
                    update employees
                    set approval_groups = root_department
                    where employee_code = last_manager_id;
                end if;

            END IF;
        end if;
        -- END: insert last_manager_info into array_list_directors

        dbms_output.put_line('');
    end loop;

    -- Print array_list_directors
    dbms_output.put_line('array_list_directors: ');
    for i in 1..array_size loop
        dbms_output.put_line(array_list_directors(i));
    end loop;

    -- Print all employees that have approval_groups
    dbms_output.put_line('Employees that have approval_groups: ');
    for r in (
        select *
        from employees e
        where length(e.approval_groups) > 0
    ) loop
        dbms_output.put_line(r.employee_code || ' - ' || r.approval_groups);
    end loop;

    -- .NEW
    
end;

-- Expected
-- array_list_directors: 
-- 068-D-TQMCP
-- 2741-D-ITD
-- 1448-D-ASACP
-- 099-D-SSCCP
-- 1448-D-HRA
-- 1448-D-ACC
-- 1448-D-BOD
-- 1110-D-FIN
-- 1110-D-PUR
-- 1448-D-SSCCP
-- 1448-D-SSC
-- 099-D-HRT
-- 099-D-BOD
-- 099-D-TQM
-- 099-D-MKT
-- 099-D-BDD
-- 099-D-ASA
-- 1110-D-ACC
-- 099-D-OPE
-- Employees that have approval_groups: 
-- 1448 - HRA,ACC,BOD,SSCCP,SSC
-- 099 - HRT,BOD,TQM,MKT,BDD,ASA,OPE
-- 1110 - FIN,PUR,ACC

-- Actual result
-- array_list_directors: 
-- 068-D-TQMCP
-- 2741-D-ITD
-- 1448-D-ASACP
-- 099-D-SSCCP
-- 1448-D-HRA
-- 1448-D-ACC
-- 1448-D-BOD
-- 1110-D-FIN
-- 1110-D-PUR
-- 1448-D-SSCCP
-- 1448-D-SSC
-- 099-D-HRT
-- 099-D-BOD
-- 099-D-TQM
-- 099-D-MKT
-- 099-D-BDD
-- 099-D-ASA
-- 1110-D-ACC
-- 099-D-OPE
-- Employees that have approval_groups: 
-- 1448 - ACC
-- 068 - TQMCP
-- 099 - OPE
-- 1110 - PUR
-- 2741 - ITD