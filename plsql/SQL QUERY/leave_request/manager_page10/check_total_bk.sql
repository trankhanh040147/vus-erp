-- DECLARE
--     v_maximum_days NUMBER;
-- BEGIN

--     IF trim(:P10_ANNUAL_LEAVE) = 'APL' THEN
--         SELECT TO_NUMBER(:P10_ANNUAL_LEAVE_BALANCE)
--         INTO v_maximum_days
--         FROM DUAL;
--     ELSE
--         SELECT MAXIMUM_LIMIT_PER_TIME
--         INTO v_maximum_days
--         FROM ABSENCE_CODE_LIST
--         WHERE TRIM(LOWER(ACL_ABSENCECODE_ID)) = TRIM(LOWER(:P10_LEAVE_DETAIL));
--     END IF;

--     IF :P10_TOTAL_DAYS <= v_maximum_days THEN
--         RETURN TRUE;
--     ELSE
--         RETURN FALSE;
--     END IF;
    
-- END;

DECLARE
    v_maximum_days NUMBER;
    v_total_of_year NUMBER;
    v_max_per_year NUMBER;
    flag boolean;
BEGIN
    flag := TRUE; 
    v_total_of_year := 0;

    IF trim(:P10_ANNUAL_LEAVE) = 'APL' THEN
        SELECT TO_NUMBER(:P10_ANNUAL_LEAVE_BALANCE)
        INTO v_maximum_days
        FROM DUAL;
    ELSE
        -- Check MAXIMUM_LIMIT_PER_TIME of other types
        SELECT MAXIMUM_LIMIT_PER_TIME
        INTO v_maximum_days
        FROM ABSENCE_CODE_LIST
        WHERE TRIM(LOWER(ACL_ABSENCECODE_ID)) = TRIM(LOWER(:P10_LEAVE_DETAIL));

        -- Check MAXIMUM_LIMIT_PER_YEAR of other types
        SELECT NVL(SUM(er.TOTAL_DAYS),0) INTO v_total_of_year FROM EMPLOYEE_REQUESTS er
        WHERE EMPLOYEE_CODE_REQ = :P10_EMPLOYEE_CODE 
        AND EMP_REQ_STATUS in (2,3) 
        AND LOWER(er.BENEFIT_CODE) = TRIM(LOWER(:P10_LEAVE_DETAIL))
        AND EXTRACT(YEAR FROM er.FROM_DATE) = EXTRACT(YEAR FROM TO_DATE(:P10_FROM_DATE, 'DD/MM/YYYY'));

        SELECT MAXIMUM_LIMIT_PER_YEAR INTO v_max_per_year FROM ABSENCE_CODE_LIST  
        WHERE TRIM(LOWER(ACL_ABSENCECODE_ID)) = TRIM(LOWER(:P10_LEAVE_DETAIL));

    END IF;

    -- Validate total days APL & total days per time
    IF (:P10_TOTAL_DAYS <= v_maximum_days) THEN
        flag := TRUE;
    ELSE
        flag := FALSE;
    END IF;

    -- Validate total days per year of other types
    IF (trim(:P10_ANNUAL_LEAVE) != 'APL') AND (:P10_TOTAL_DAYS + v_total_of_year > v_max_per_year) THEN 
        flag := FALSE;
    END IF;


    return flag;
END;