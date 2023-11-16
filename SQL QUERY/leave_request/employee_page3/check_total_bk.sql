DECLARE
    v_maximum_days NUMBER;
    v_total_of_year NUMBER;
    v_max_per_year NUMBER;
    v_total_month NUMBER;
    flag boolean;

BEGIN
    flag := TRUE; 
    v_total_of_year := 0;

    -- Calculate maximum total month for other leave types
    IF trim(:P3_ANNUAL_LEAVE) != 'APL' THEN
        SELECT MAXIMUM_MONTHS_LIMIT_PER_TIME into v_total_month FROM ABSENCE_CODE_LIST 
        WHERE lower(ACL_ABSENCECODE_ID) = lower(:P3_LEAVE_DETAIL) AND ROWNUM=1;
    END IF;

    IF trim(:P3_ANNUAL_LEAVE) = 'APL' THEN
        SELECT TO_NUMBER(:P3_ANNUAL_LEAVE_BALANCE)
        INTO v_maximum_days
        FROM DUAL;
    ELSIF v_total_month != 99999 THEN
        v_maximum_days := TO_DATE(:P3_FROM_DATE, 'DD/MM/YYYY') + interval '1' month * v_total_month - TO_DATE(:P3_FROM_DATE, 'DD/MM/YYYY');
    ELSE
        -- Check MAXIMUM_LIMIT_PER_TIME of other types
        SELECT MAXIMUM_LIMIT_PER_TIME
        INTO v_maximum_days
        FROM ABSENCE_CODE_LIST
        WHERE TRIM(LOWER(ACL_ABSENCECODE_ID)) = TRIM(LOWER(:P3_LEAVE_DETAIL));

        -- Check MAXIMUM_LIMIT_PER_YEAR of other types
        SELECT NVL(SUM(er.TOTAL_DAYS),0) INTO v_total_of_year FROM EMPLOYEE_REQUESTS er
        WHERE EMPLOYEE_CODE_REQ = :P3_EMPLOYEE_CODE 
        AND EMP_REQ_STATUS in (2,3) 
        AND LOWER(er.BENEFIT_CODE) = TRIM(LOWER(:P3_LEAVE_DETAIL))
        AND EXTRACT(YEAR FROM er.FROM_DATE) = EXTRACT(YEAR FROM TO_DATE(:P3_FROM_DATE, 'DD/MM/YYYY'));

        SELECT MAXIMUM_LIMIT_PER_YEAR INTO v_max_per_year FROM ABSENCE_CODE_LIST  
        WHERE TRIM(LOWER(ACL_ABSENCECODE_ID)) = TRIM(LOWER(:P3_LEAVE_DETAIL));

    END IF;

    -- Validate total days APL & total days per time
    IF (to_number(:P3_TOTAL_DAYS) <= v_maximum_days) THEN
        flag := TRUE;
    ELSE
        flag := FALSE;
    END IF;

    -- Validate total days per year of other types
    IF (trim(:P3_ANNUAL_LEAVE) != 'APL') AND (to_number(:P3_TOTAL_DAYS) + v_total_of_year > v_max_per_year) THEN 
        flag := FALSE;
    END IF;


    return flag;
END;