DECLARE
    TOTAL_OVERLAP_DAYS NUMBER := 0;
    V_TOTAL_DAYS       NUMBER;
    V_EMP_REQ_STATUS   NUMBER;
    flag BOOLEAN := true;
BEGIN
    IF(:P3_ALL_DAY = 'N') THEN
        :P3_END_DATE := :P3_FROM_DATE;
        :P3_TOTAL_DAYS := 0.5;
    END IF;

    FOR REC IN (
        SELECT
            ER.TOTAL_DAYS,
            ER.EMP_REQ_STATUS,
            ER.FROM_DATE,
            ER.END_DATE
        FROM
            EMPLOYEE_REQUESTS ER
        WHERE
            ER.EMPLOYEE_CODE_REQ = :APP_EMP_CODE 
            AND (TO_DATE(:P3_END_DATE, 'DD/MM/YYYY') >= TO_DATE(ER.FROM_DATE, 'MM/DD/YYYY') 
            AND TO_DATE(:P3_FROM_DATE, 'DD/MM/YYYY') <= TO_DATE(ER.END_DATE, 'MM/DD/YYYY'))
    ) LOOP
        -- INSERT INTO OUTPUT_LOGS(STR1) VALUES (rec.FROM_DATE || '->' || rec.END_DATE || ':' || rec.EMP_REQ_STATUS);
        DBMS_OUTPUT.put_line(rec.FROM_DATE || ' -> ' || rec.END_DATE || ' : ' || rec.EMP_REQ_STATUS);

        IF REC.EMP_REQ_STATUS = 5 THEN
            -- V_TOTAL_DAYS := -REC.TOTAL_DAYS;
            V_TOTAL_DAYS := 0;
        ELSIF REC.EMP_REQ_STATUS = 2 OR REC.EMP_REQ_STATUS = 3 THEN
            V_TOTAL_DAYS := TO_NUMBER(REC.TOTAL_DAYS);
        ELSE
            V_TOTAL_DAYS := 0;
        END IF;
        TOTAL_OVERLAP_DAYS := TOTAL_OVERLAP_DAYS + V_TOTAL_DAYS;
    END LOOP;
        
    DBMS_OUTPUT.put_line('TOTAL_OVERLAP_DAYS = ' || TOTAL_OVERLAP_DAYS);

    IF TOTAL_OVERLAP_DAYS >= 1 
        OR (TO_NUMBER(:P3_TOTAL_DAYS) = 0.5 AND TOTAL_OVERLAP_DAYS > 0.5)
        OR (TOTAL_OVERLAP_DAYS = 0.5 AND TO_NUMBER(:P3_TOTAL_DAYS) >= 1 ) THEN
        flag := FALSE;
    ELSE
        flag := TRUE;
    END IF;
    
    -- IF flag THEN DBMS_OUTPUT.put_line('TRUE'); ELSE DBMS_OUTPUT.put_line('FALSE'); END IF;

    return flag;
    
END;