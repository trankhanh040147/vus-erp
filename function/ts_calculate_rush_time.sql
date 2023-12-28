create or replace FUNCTION ts_calculate_rush_time(
    at_in1 IN VARCHAR2,
    at_out1 IN VARCHAR2,
    at_in2 IN VARCHAR2,
    at_out2 IN VARCHAR2,
    p_profile_id IN VARCHAR2,
    p_date IN DATE default null
) RETURN NUMBER IS
    start_time_1 DATE;
    end_time_1 DATE;
    start_time_2 DATE;
    end_time_2 DATE;
    loop_rush_time_start DATE;
    loop_rush_time_end DATE;
    total_rush_time NUMBER(5,2) := 0;
    is_public_holiday NUMBER(1,0) := 0;

    -- Get Rush time of the profile
    CURSOR c_rush_times IS
        SELECT TO_DATE(wpl.START_TIME, 'HH24:MI') as rush_start, 
               TO_DATE(wpl.END_TIME, 'HH24:MI') as rush_end
        FROM WORKING_PROFILE_LINES wpl
        JOIN PROFILE_TYPES pt ON CUSTOM_TRIM_V2(pt.PROFILE_TYPE_ID) = wpl.PROFILE_TYPE_ID
        WHERE wpl.PROFILE_ID = p_profile_id
        AND pt.PROFILE_TYPE_GROUP = 'rush';
BEGIN
    -- Convert the time strings to DATE data type
    start_time_1 := to_date_hh24mi(at_in1);
    end_time_1 := to_date_hh24mi(at_out1);
    start_time_2 := to_date_hh24mi(at_in2);
    end_time_2 := to_date_hh24mi(at_out2);

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

    -- Calculate total times overlapped with Rush time
    -- Loop through each rush time and calculate the overlap
    FOR rush_record IN c_rush_times LOOP
        loop_rush_time_start := rush_record.rush_start;
        loop_rush_time_end := rush_record.rush_end;

        IF loop_rush_time_start <= end_time_1 AND loop_rush_time_end >= start_time_1 THEN
            total_rush_time := total_rush_time + (LEAST(end_time_1, loop_rush_time_end) - GREATEST(start_time_1, loop_rush_time_start)) * 24;
        END IF;

        IF loop_rush_time_start <= end_time_2 AND loop_rush_time_end >= start_time_2 THEN
            total_rush_time := total_rush_time + (LEAST(end_time_2, loop_rush_time_end) - GREATEST(start_time_2, loop_rush_time_start)) * 24;
        END IF;
    END LOOP;

    if(at_out2 = '24:00') then
        return total_rush_time + ts_calculate_rush_time('23:58', '23:59', '00:00', '00:00', p_profile_id);
    end if;

    RETURN total_rush_time;
END;

-- testing
-- BEGIN
--     DBMS_OUTPUT.PUT_LINE(ts_calculate_rush_time('04:00', '05:30', '20:00', '21:00', 'TestTS-R'));
-- END;
/