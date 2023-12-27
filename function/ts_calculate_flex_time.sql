create or replace FUNCTION ts_calculate_flex_time(
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
    loop_flex_time_start DATE;
    loop_flex_time_end DATE;
    total_flex_minus_time NUMBER(5,2) := 0;
    total_flex_time NUMBER(5,2) := 0;
    standard_start DATE;
    standard_end DATE;

    -- Get Flex time of the profile
    CURSOR c_flex_times IS
        SELECT TO_DATE(START_TIME, 'HH24:MI') as flex_start, 
               TO_DATE(END_TIME, 'HH24:MI') as flex_end
        FROM WORKING_PROFILE_LINES
        WHERE PROFILE_ID = p_profile_id
        AND PROFILE_TYPE_ID LIKE '%flex%';

    CURSOR c_standard IS
        SELECT TO_DATE(START_TIME, 'HH24:MI') AS standard_start, 
               TO_DATE(END_TIME, 'HH24:MI') AS standard_end
        FROM WORKING_PROFILE_LINES
        WHERE PROFILE_TYPE_ID LIKE '%standardtime%'
        AND PROFILE_ID = p_profile_id;
BEGIN
    -- Convert the time strings to DATE data type
    start_time_1 := to_date_hh24mi(at_in1);
    end_time_1 := to_date_hh24mi(at_out1);
    start_time_2 := to_date_hh24mi(at_in2);
    end_time_2 := to_date_hh24mi(at_out2);

    -- Calculate total times overlapped with Flex time
    -- Loop through each flex time and calculate the overlap
    FOR flex_record IN c_flex_times LOOP
        loop_flex_time_start := flex_record.flex_start;
        loop_flex_time_end := flex_record.flex_end;

        IF loop_flex_time_start <= end_time_1 AND loop_flex_time_end >= start_time_1 THEN
            total_flex_time := total_flex_time + (LEAST(end_time_1, loop_flex_time_end) - GREATEST(start_time_1, loop_flex_time_start)) * 24;
        END IF;

        IF loop_flex_time_start <= end_time_2 AND loop_flex_time_end >= start_time_2 THEN
            total_flex_time := total_flex_time + (LEAST(end_time_2, loop_flex_time_end) - GREATEST(start_time_2, loop_flex_time_start)) * 24;
        END IF;
    END LOOP;

    -- Calculate total_flex_minus_time: total time that missing from the standard time
    -- Calculate the time missing from standard time
    FOR standard_record IN c_standard LOOP
        standard_start := standard_record.standard_start;
        standard_end := standard_record.standard_end;

        -- Calculate the non-overlapping time between standard and flex time
        IF standard_start < end_time_1 AND standard_end > start_time_1 THEN
            IF standard_start < start_time_1 THEN
                total_flex_minus_time := total_flex_minus_time + (start_time_1 - standard_start) * 24;
            END IF;
            IF standard_end > end_time_1 THEN
                total_flex_minus_time := total_flex_minus_time + (standard_end - end_time_1) * 24;
            END IF;
        END IF;

        IF standard_start < end_time_2 AND standard_end > start_time_2 THEN
            IF standard_start < start_time_2 THEN
                total_flex_minus_time := total_flex_minus_time + (start_time_2 - standard_start) * 24;
            END IF;
            IF standard_end > end_time_2 THEN
                total_flex_minus_time := total_flex_minus_time + (standard_end - end_time_2) * 24;
            END IF;
        END IF;
    END LOOP;

    if(at_out2 = '24:00') then
        return (total_flex_time - total_flex_minus_time) + ts_calculate_flex_time('23:58', '23:59', '00:00', '00:00', p_profile_id);
    end if;
    
    RETURN total_flex_time - total_flex_minus_time;
END;

-- test cases
-- SELECT ts_calculate_flex_time('08:00', '16:00', '08:00', '16:00', 'TestTS-OT') FROM DUAL;
/