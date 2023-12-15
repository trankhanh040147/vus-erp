declare 
    start_time_1 DATE;
    end_time_1 DATE;
    start_time_2 DATE;
    end_time_2 DATE;
    loop_flex_time_start DATE;
    loop_flex_time_end DATE;
    total_flex_minus_time NUMBER(5,2) := 0;
    total_flex_time NUMBER(5,2) := 0;

    -- Get Flex time of the profile
    cursor c_flex_times is
        SELECT TO_DATE(START_TIME, 'HH24:MI') as flex_start, 
               TO_DATE(END_TIME, 'HH24:MI') as flex_end
        FROM WORKING_PROFILE_LINES
        WHERE PROFILE_ID = :PROFILE_ID
        AND PROFILE_TYPE_ID LIKE '%flex%';

    CURSOR c_standard IS
        SELECT TO_DATE(START_TIME, 'HH24:MI') AS standard_start, 
               TO_DATE(END_TIME, 'HH24:MI') AS standard_end
        FROM WORKING_PROFILE_LINES
        WHERE PROFILE_TYPE_ID LIKE '%standardtime%'
        AND PROFILE_ID = :PROFILE_ID;
begin
    -- Convert the time strings to DATE data type
    -- start_time_1 := TO_DATE(:AT_IN1, 'HH24:MI');
    -- end_time_1 := TO_DATE(:AT_OUT1, 'HH24:MI');
    -- start_time_2 := TO_DATE(:AT_IN2, 'HH24:MI');
    -- end_time_2 := TO_DATE(:AT_OUT2, 'HH24:MI');
    start_time_1 := TO_DATE('05:00', 'HH24:MI');
    end_time_1 := TO_DATE('12:00', 'HH24:MI');
    start_time_2 := TO_DATE('14:00', 'HH24:MI');
    end_time_2 := TO_DATE('23:59', 'HH24:MI');

    -- Calculate total times overlapped with Flex time
    -- Loop through each flex time and calculate the overlap
    for flex_record in c_flex_times loop
        loop_flex_time_start := flex_record.flex_start;
        loop_flex_time_end := flex_record.flex_end;

        IF loop_flex_time_start <= end_time_1 AND loop_flex_time_end >= start_time_1 THEN
            total_flex_time := total_flex_time + (LEAST(end_time_1, loop_flex_time_end) - GREATEST(start_time_1, loop_flex_time_start)) * 24;
        END IF;

        IF loop_flex_time_start <= end_time_2 AND loop_flex_time_end >= start_time_2 THEN
            total_flex_time := total_flex_time + (LEAST(end_time_2, loop_flex_time_end) - GREATEST(start_time_2, loop_flex_time_start)) * 24;
        END IF;
    end loop;

    -- Calculate total_flex_minus_time: total time that missing from the standard time
    -- Calculate the time missing from standard time
    for standard_record in c_standard loop
        standard_start := standard_record.standard_start;
        standard_end := standard_record.standard_end;

        IF standard_start > end_time_1 AND standard_end < start_time_2 THEN
            total_flex_minus_time := total_flex_minus_time + (standard_end - standard_start) * 24;
        ELSEIF standard_start < start_time_1 AND standard_end > end_time_2 THEN
            total_flex_minus_time := total_flex_minus_time + (end_time_1 - start_time_1) * 24 + (end_time_2 - start_time_2) * 24;
        ELSE
            IF standard_start < start_time_1 THEN
                total_flex_minus_time := total_flex_minus_time + (end_time_1 - start_time_1) * 24;
            END IF;
            
            IF standard_end > end_time_2 THEN
                total_flex_minus_time := total_flex_minus_time + (end_time_2 - start_time_2) * 24;
            END IF;
        END IF;
    end loop;

    :AT_FLEX := total_flex_time;

    return total_flex_time;

    -- Output the result
    -- DBMS_OUTPUT.PUT_LINE('Total Flex Time:' || total_flex_time);
    DBMS_OUTPUT.PUT_LINE('Total Flex minus Time:' || total_flex_minus_time);
end;
