create or replace FUNCTION ts_calculate_overtime(
    at_in1 IN VARCHAR2,
    at_out1 IN VARCHAR2,
    at_in2 IN VARCHAR2,
    at_out2 IN VARCHAR2,
    p_profile_id IN VARCHAR2
) RETURN NUMBER IS
    start_time_1 DATE;
    end_time_1 DATE;
    start_time_2 DATE;
    end_time_2 DATE;
    loop_overtime_start DATE;
    loop_overtime_end DATE;
    total_overtime_time NUMBER(5,2) := 0;

    -- Get Overtime period of the profile
    CURSOR c_overtime_times IS
        SELECT TO_DATE(START_TIME, 'HH24:MI') as overtime_start, 
               TO_DATE(END_TIME, 'HH24:MI') as overtime_end
        FROM WORKING_PROFILE_LINES
        WHERE PROFILE_ID = p_profile_id
        AND PROFILE_TYPE_ID LIKE '%ot%';
BEGIN
    -- Convert the time strings to DATE data type
    start_time_1 := to_date_hh24mi(at_in1);
    end_time_1 := to_date_hh24mi(at_out1);
    start_time_2 := to_date_hh24mi(at_in2);
    -- end_time_2 := TO_DATE(at_out2, 'HH24:MI');
    end_time_2 := to_date_hh24mi(at_out2);

    -- print to_char to see the time
    DBMS_OUTPUT.PUT_LINE(to_char(start_time_1, 'HH24:MI'));
    DBMS_OUTPUT.PUT_LINE(to_char(end_time_1, 'HH24:MI'));
    DBMS_OUTPUT.PUT_LINE(to_char(start_time_2, 'HH24:MI'));
    DBMS_OUTPUT.PUT_LINE(to_char(end_time_2, 'HH24:MI'));


    -- Calculate total times overlapped with Overtime time
    -- Loop through each overtime time and calculate the overlap
    FOR overtime_record IN c_overtime_times LOOP
        loop_overtime_start := overtime_record.overtime_start;
        loop_overtime_end := overtime_record.overtime_end;

        IF loop_overtime_start <= end_time_1 AND loop_overtime_end >= start_time_1 THEN
            total_overtime_time := total_overtime_time + (LEAST(end_time_1, loop_overtime_end) - GREATEST(start_time_1, loop_overtime_start)) * 24;
        END IF;

        IF loop_overtime_start <= end_time_2 AND loop_overtime_end >= start_time_2 THEN
            total_overtime_time := total_overtime_time + (LEAST(end_time_2, loop_overtime_end) - GREATEST(start_time_2, loop_overtime_start)) * 24;
        END IF;
    END LOOP;

    if(at_out2 = '24:00') then
        return total_overtime_time + ts_calculate_overtime('23:58', '23:59', '00:00', '00:00', p_profile_id);
    end if;

    RETURN total_overtime_time;
END;

-- testing 
-- BEGIN
--     DBMS_OUTPUT.PUT_LINE(ts_calculate_overtime('5:00', '12:00', '20:00', '24:00', 'TestDayOff'));
-- END;

/