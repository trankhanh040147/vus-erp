    declare 
    from_date date;
    end_date date;
    total_month number;

    begin 

        from_date := to_date('05/06/2018', 'MM/DD/YYYY');
        total_month := 4;
        -- calculate end date = from_date + month(total_month) - 1(day), the result should be 09/05/2018
        end_date := from_date + interval '1' month * total_month - interval '1' day;
        dbms_output.put_line(end_date);

    end;
    /

declare
    v_start_time NUMBER;
    v_end_time NUMBER;
    o_end_date DATE;
    total_month number;
begin
    -- v_start_time := DBMS_UTILITY.GET_TIME;  -- Current time in 1/100ths of a second
    -- LOOP
    --     v_end_time := DBMS_UTILITY.GET_TIME;
    --     EXIT WHEN (v_end_time - v_start_time) > (1 * 100);  -- 5 seconds
    -- END LOOP;
    
    -- SELECT MAXIMUM_LIMIT_PER_TIME INTO v_total_maxium_date FROM ABSENCE_CODE_LIST WHERE lower(ACL_ABSENCECODE_ID) = lower(:P3_LEAVE_DETAIL) AND ROWNUM=1;
    -- return TO_CHAR((to_date(:P3_FROM_DATE,'DD/MM/YYYY') + INTERVAL '1' DAY * (FLOOR(abs(v_total_maxium_date)) - 1)),'DD/MM/YYYY');

    SELECT MAXIMUM_MONTHS_LIMIT_PER_TIME into total_month FROM ABSENCE_CODE_LIST WHERE lower(ACL_ABSENCECODE_ID) = lower(:P3_LEAVE_DETAIL) AND ROWNUM=1;
    DBMS_OUTPUT.PUT_LINE(total_month);

    o_end_date := to_date(:P3_FROM_DATE, 'DD/MM/YYYY') + interval '1' month * total_month - interval '1' day;

    DBMS_OUTPUT.PUT_LINE(TO_CHAR(o_end_date,'DD/MM/YYYY'));

    -- return TO_CHAR(o_end_date,'DD/MM/YYYY');    

end;