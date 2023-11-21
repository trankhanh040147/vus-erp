DECLARE
    v_maximum_days NUMBER;
    v_total_of_year NUMBER;
    v_max_per_year NUMBER;
    v_total_month NUMBER;
    flag boolean;

    n_total_days NUMBER;
BEGIN
    flag := TRUE; 
    v_total_of_year := 0;

    -- Calculate maximum total month for other leave types
    IF trim(:P10_ANNUAL_LEAVE) != 'APL' THEN
        SELECT MAXIMUM_MONTHS_LIMIT_PER_TIME into v_total_month FROM ABSENCE_CODE_LIST 
        WHERE lower(ACL_ABSENCECODE_ID) = lower(:P10_LEAVE_DETAIL) AND ROWNUM=1;
    END IF;

    IF trim(:P10_ANNUAL_LEAVE) = 'APL' THEN
        SELECT TO_NUMBER(:P10_ANNUAL_LEAVE_BALANCE)
        INTO v_maximum_days
        FROM DUAL;
    ELSIF v_total_month != 99999 THEN
        v_maximum_days := TO_DATE(:P10_FROM_DATE, 'DD/MM/YYYY') + interval '1' month * v_total_month - TO_DATE(:P10_FROM_DATE, 'DD/MM/YYYY');
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

    -- There will be a case :P10_TOTAL_DAYS = '0.5', so we need to convert it to number

    IF :P10_TOTAL_DAYS = '0.5' THEN
        n_total_days := 0.5;
    ELSE
        n_total_days := to_number(:P10_TOTAL_DAYS);
    END IF;

    -- Validate total days APL & total days per time
    IF (n_total_days <= v_maximum_days) THEN
        flag := TRUE;
    ELSE
        flag := FALSE;
    END IF;

    -- Validate total days per year of other types
    IF (trim(:P10_ANNUAL_LEAVE) != 'APL') AND (n_total_days + v_total_of_year > v_max_per_year) THEN 
        flag := FALSE;
    END IF;


    return flag;
END;