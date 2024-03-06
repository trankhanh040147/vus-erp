-- APEX ORACLE 23.2.3
-- Call many SP_GET_ONE_ABSENCE_GROUP_EMPLOYEE
create or replace PROCEDURE "SP_GET_MANY_ABSENCE_GROUP_EMPLOYEE" (
    p_from_num IN NUMBER,
    p_to_num IN NUMBER
) IS
    -- Declare variables
    n_emp_code NVARCHAR2(50);
    
BEGIN

    -- Loop from p_from_num to p_to_num
    FOR i IN p_from_num..p_to_num LOOP
        -- Get employee code
        n_emp_code := '';
        
        -- Select employee code, if no data found, then continue to next loop
        BEGIN
            SELECT EMPLOYEE_CODE INTO n_emp_code FROM EMPLOYEES WHERE ID = i;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                CONTINUE;
        END;

        -- Call SP_GET_ONE_ABSENCE_GROUP_EMPLOYEE
        SP_GET_ONE_ABSENCE_GROUP_EMPLOYEE(n_emp_code);
    END LOOP;

EXCEPTION
    -- Exception handling code goes here, if needed
    WHEN OTHERS THEN
        -- Handle the exception
        NULL;

END;