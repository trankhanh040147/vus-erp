-- --------------------------------------------------------------------------------
-- 
-- Oracle APEX source export file
-- 
-- The contents of this file are intended for review and analysis purposes only.
-- Developers must use the Application Builder to make modifications to an
-- application. Changes to this file will not be reflected in the application.
-- 
-- --------------------------------------------------------------------------------

-- ----------------------------------------
-- Page: 2 - Dashboard > Dynamic Action: On load > Action: Sync data from D365 > Settings > PL/SQL Code

DECLARE
    v_total_emp NUMBER;
    v_employee_code NVARCHAR2(100);
    total_leaves NUMBER;
BEGIN   
    -- Sync Employee information
    v_employee_code := NVL(:APP_EMP_CODE, -1);
    SELECT count(id) into v_total_emp FROM EMPLOYEES WHERE EMPLOYEE_CODE = v_employee_code;
    IF v_total_emp < 1 THEN 
        SP_GET_ONE_EMPLOYEE(v_employee_code);
    END IF;

    -- SELECT EMPLOYEE_CODE INTO v_employee_code FROM EMPLOYEES WHERE USER_NAME = :APP_USER_NAME;
    SELECT COUNT(ID) INTO total_leaves FROM EMPLOYEE_REQUESTS  where EMPLOYEE_CODE_REQ = v_employee_code;
    IF(total_leaves <= 0) then
        SP_GET_ONE_ABSENCE_GROUP_EMPLOYEE(v_employee_code);
    END IF;
END;


