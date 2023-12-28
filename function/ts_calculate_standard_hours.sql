CREATE OR REPLACE FUNCTION ts_calculate_standard_hours(
    at_in1 IN VARCHAR2,
    at_out1 IN VARCHAR2,
    at_in2 IN VARCHAR2,
    at_out2 IN VARCHAR2,
    p_profile_id IN VARCHAR2,
    p_date IN DATE default null
) RETURN NUMBER IS
    in1 DATE;
    out1 DATE;
    in2 DATE;
    out2 DATE;

    total_flex NUMBER(5,2) := 0;
    overlap_flex NUMBER(5,2) := 0;
    total_standard NUMBER(5,2) := 0;
    is_public_holiday NUMBER(1,0) := 0;

BEGIN
    in1 := to_date_hh24mi(at_in1);
    out1 := to_date_hh24mi(at_out1);
    in2 := to_date_hh24mi(at_in2);
    out2 := to_date_hh24mi(at_out2);

    -- If the date is not null
    IF p_date IS NOT NULL THEN
        -- check if the date is public holiday
        -- if the mm/dd is in column PH_DATE of table PUBLIC_HOLIDAYS, then it is public holiday
        -- Case: PH_DATE = 12/25/2023, PH_DATE is 12/25/2020. Then it is public holiday
        SELECT COUNT(*) INTO is_public_holiday
        FROM PUBLIC_HOLIDAYS
        WHERE TO_CHAR(PH_DATE, 'MMDD') = TO_CHAR(p_date, 'MMDD');
    
        IF is_public_holiday > 0 THEN
            -- total time = end_time - start_time
            DBMS_OUTPUT.PUT_LINE('Public holiday');
            RETURN 0; 
            -- RETURN (end_time_1 - start_time_1) * 24 + (end_time_2 - start_time_2) * 24;
        END IF;
    END IF;


    FOR r_flex IN (SELECT TO_DATE(START_TIME, 'HH24:MI') AS flex_start, 
                         TO_DATE(END_TIME, 'HH24:MI') AS flex_end
                   FROM WORKING_PROFILE_LINES
                   WHERE PROFILE_TYPE_ID LIKE '%flex%'
                   AND PROFILE_ID = p_profile_id) LOOP
        IF r_flex.flex_start <= out1 AND r_flex.flex_end >= in1 THEN
            overlap_flex := overlap_flex + (LEAST(out1, r_flex.flex_end) - GREATEST(in1, r_flex.flex_start)) * 24; 
        END IF;
        IF r_flex.flex_start <= out2 AND r_flex.flex_end >= in2 THEN
            overlap_flex := overlap_flex + (LEAST(out2, r_flex.flex_end) - GREATEST(in2, r_flex.flex_start)) * 24;
        END IF;
    END LOOP;

    FOR r_standard IN (SELECT TO_DATE(START_TIME, 'HH24:MI') AS standard_start, 
                            TO_DATE(END_TIME, 'HH24:MI') AS standard_end
                      FROM WORKING_PROFILE_LINES
                      WHERE PROFILE_TYPE_ID LIKE '%standardtime%'
                      AND PROFILE_ID = p_profile_id) LOOP
        IF r_standard.standard_start <= out1 AND r_standard.standard_end >= in1 THEN
            total_standard := total_standard + (LEAST(out1, r_standard.standard_end) - GREATEST(in1, r_standard.standard_start)) * 24;
        END IF;
        IF r_standard.standard_start <= out2 AND r_standard.standard_end >= in2 THEN
            total_standard := total_standard + (LEAST(out2, r_standard.standard_end) - GREATEST(in2, r_standard.standard_start)) * 24;
        END IF;
    END LOOP;

    -- total_standard := total_standard - overlap_flex;

    if(at_out2 = '24:00') then
        return total_standard + ts_calculate_standard_hours('23:58', '23:59', '00:00', '00:00', p_profile_id);
    end if;


    RETURN total_standard;
END;


-- testing
-- SELECT ts_calculate_standard_hours('05:00', '12:00', '14:00', '23:00', 'TestTS-OT') FROM DUAL;

