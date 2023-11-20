-- --------------------------------------------------------------------------------
-- 
-- Oracle APEX source export file
-- 
-- The contents of this file are intended for review and analysis purposes only.
-- Developers must use the Application Builder to make modifications to an
-- application. Changes to this file will not be reflected in the application.
-- 
-- --------------------------------------------------------------------------------

-- ----------------------------------------
-- Page: 44 - Time Sheet Approval > Region: P_TIME_SHEET > Source > SQL Query

select ts.ID,
       ts.EMPLOYEE_CODE,
       emp.FULL_NAME,
       ts.WORKER_ID,
       DATE_TS,
       ts.PROFILE_ID,
       REASON_ADJUSTMENT,
       IS_OK,
       STATUS,
       NOTE,
       ts.TS_HEADER_ID,
       -- From P_TIME_SHEET_DETAIL
       WT_IN1,
       WT_OUT1,
       WT_IN2,
       WT_OUT2,
       WT_STANDARD_HOURS,
       WT_FLEX,
       WT_RUSH,
       WT_OT,
       EFB_FLEX_BALANCE,
       AT_IN1,
       AT_OUT1,
       AT_IN2,
       AT_OUT2,
       AT_STANDARD_HOURS,
       AT_FLEX,
       AT_RUSH,
       AT_OT,
       IN1_TS_LINE_ID,
       OUT1_TS_LINE_ID,
       IN2_TS_LINE_ID,
       OUT2_TS_LINE_ID,
       (select MAX(vst.COMBINED_TIME_RANGES) from view_standard_time vst where vst.PROFILE_ID = REPLACE(TRIM(ts.PROFILE_ID), ' ', '')) as standard_time,

    --     (
    --     SELECT 
    --         (
    --             CASE
    --                 WHEN ALL_DAY = 'Y' THEN 24
    --                 WHEN START_TIME IS NOT NULL OR END_TIME IS NOT NULL THEN UTIL_CALC_HOURS(NVL(START_TIME,'00:00'), NVL(END_TIME,'00:00'))     
    --                 ELSE 0
    --             END
    --         )
    --     FROM EMPLOYEE_REQUESTS 
    --     WHERE EMPLOYEE_CODE_REQ = ts.EMPLOYEE_CODE
    --         AND EMP_REQ_STATUS = 3
    --         AND TO_DATE(ts.DATE_TS, 'MM/DD/YYYY') BETWEEN FROM_DATE AND END_DATE
    --     FETCH FIRST 1 ROW ONLY
    --     )
    --     AS TOTAL_LEAVES_APPROVED,
        tsd.APPROVED_LEAVES,
        (
        SELECT TO_NUMBER(NVL(TOTAL_HOUR_WK,0) + NVL(TOTAL_HOUR_REST_WK,0) + NVL(TOTAL_HOUR_PUBLIC,0)) 
        FROM EMP_OVERTIME_REQUESTS eor
        JOIN EMP_REQUESTS er ON er.REQUEST_DETAIL_ID = eor.DETAIL_ID
        WHERE er.EMPLOYEE_CODE = ts.EMPLOYEE_CODE 
        AND eor.CREATED_DATE = TS.DATE_TS
        AND ROWNUM = 1
        )
        AS TOTAL_OT_APPROVED
    --    case STATUS
    --        when 2 then
    --        'Approve' 
    --        else
    --        null
    --    end as Approve,
    --    case STATUS
    --        when 2 then
    --        'Reject' 
    --        else
    --        null
    --    end as Reject,
    --     CASE 
    --         WHEN STATUS IN (2, 3, 4) THEN 'Submit to HR'
    --         ELSE NULL
    --     END as Submit_to_hr,
    --    case STATUS
    --        when 2 then
    --        'Re-confirm' 
    --        else
    --        null
    --    end as Reconfirm
from P_TIME_SHEET ts 
join P_TIME_SHEET_DETAIL tsd on ts.ID = tsd.TS_ID
join EMPLOYEES emp on emp.EMPLOYEE_CODE = ts.EMPLOYEE_CODE
join EMPLOYEE_FLEX_BALANCE on (emp.EMPLOYEE_CODE = EFB_EMPLOYEE_CODE and DATE_TS = EFB_DATE)
where DATE_TS between to_date(:P44_FROM_DATE,'MM/DD/YYYY') and to_date(:P44_TO_DATE,'MM/DD/YYYY')
AND ( TRIM(:P44_STATUS) = 999  OR STATUS = TRIM(:P44_STATUS) )
AND ( TRIM(:P44_OK_CHECK) = 999  OR ts.IS_OK = :P44_OK_CHECK)
-- and lower(STATUS) like '%' || :P44_STATUS || '%'
-- join WORKING_PROFILE_DETAIL wpd on wpd.PROFILE_ID = ts.PROFILE_ID
-- WHERE LOWER(REPLACE(TRIM(wpd.PROFILE_TYPE_ID), ' ', '')) = 'standardtime' and START_DAY = 2 and END_DAY = 2 and DAY_OF_WEEK =2;

-- join WORKING_PROFILE_LINES wpl on wpl.PROFILE_ID = ts.PROFILE_ID
-- WHERE wpl.PROFILE_TYPE_ID = 'standardtime' and START_DAY = 2 and END_DAY = 2 and DAY_OF_WEEK =2;

-- ----------------------------------------
-- Page: 44 - Time Sheet Approval > Process: Send_D365 > Source > PL/SQL Code

declare
    v_start_time NUMBER;
    v_end_time NUMBER;
   header_id nvarchar2(50);
   total_header_id_eligible NUMBER;
begin

  for rec in (select regexp_substr (
           :P44_SELECTED,
           '[^:]+',
           1,
           level
         ) value
  from   dual
  connect by level <= 
    length ( :P44_SELECTED ) - length ( replace ( :P44_SELECTED, ':' ) ) + 1)loop
        -- Approve
        update P_TIME_SHEET set STATUS = 11 where id = rec.value and STATUS in (12);

        SELECT TS_HEADER_ID INTO header_id FROM P_TIME_SHEET where id = rec.value and STATUS in (12);
        -- SELECT TS_HEADER_ID INTO header_id FROM P_TIME_SHEET WHERE ID = rec.value;
        -- SELECT COUNT(*) into total_header_id_eligible FROM P_TIME_SHEET where STATUS in (12) and TS_HEADER_ID = header_id;

        -- SP_UPDATE_TIME_SHEET
        -- IF total_header_id_eligible > 0 THEN
            SP_UPDATE_TIME_SHEET(header_id);
        -- END IF;

        v_start_time := DBMS_UTILITY.GET_TIME;  -- Current time in 1/100ths of a second
        LOOP
            v_end_time := DBMS_UTILITY.GET_TIME;
            EXIT WHEN (v_end_time - v_start_time) > (3 * 100);  -- 5 seconds
        END LOOP;

    end loop;


    end;

-- ----------------------------------------
-- Page: 44 - Time Sheet Approval > Process: SubmitHR > Source > PL/SQL Code

begin

  for rec in (select regexp_substr (
           :P44_SELECTED,
           '[^:]+',
           1,
           level
         ) value
  from   dual
  connect by level <= 
    length ( :P44_SELECTED ) - length ( replace ( :P44_SELECTED, ':' ) ) + 1)loop
        -- Approve
        update P_TIME_SHEET set STATUS = 12 where id = rec.value and STATUS in (3,4) ;
    end loop;


    end;

-- ----------------------------------------
-- Page: 44 - Time Sheet Approval > Process: Reconfirm_selected > Source > PL/SQL Code

begin

  for rec in (select regexp_substr (
           :P44_SELECTED,
           '[^:]+',
           1,
           level
         ) value
  from   dual
  connect by level <= 
    length ( :P44_SELECTED ) - length ( replace ( :P44_SELECTED, ':' ) ) + 1)loop
        -- Approve
        update P_TIME_SHEET set STATUS = 10 where id = rec.value and STATUS in (2,6) ;
    end loop;


    end;

-- ----------------------------------------
-- Page: 44 - Time Sheet Approval > Process: Reject_selected > Source > PL/SQL Code

begin

  for rec in (select regexp_substr (
           :P44_SELECTED,
           '[^:]+',
           1,
           level
         ) value
  from   dual
  connect by level <= 
    length ( :P44_SELECTED ) - length ( replace ( :P44_SELECTED, ':' ) ) + 1)loop
        -- Approve
        update P_TIME_SHEET set STATUS = 4, IS_OK = 1 where id = rec.value and STATUS in (2,6) ;
    end loop;


    end;

-- ----------------------------------------
-- Page: 44 - Time Sheet Approval > Process: Approve_selected > Source > PL/SQL Code

begin

  for rec in (select regexp_substr (
           :P44_SELECTED,
           '[^:]+',
           1,
           level
         ) value
  from   dual
  connect by level <= 
    length ( :P44_SELECTED ) - length ( replace ( :P44_SELECTED, ':' ) ) + 1)loop
        -- Approve
        update P_TIME_SHEET set STATUS = 3, IS_OK = 1 where id = rec.value and STATUS in (2,6) ;
    end loop;


    end;

-- ----------------------------------------
-- Page: 44 - Time Sheet Approval > Dynamic Action: Change AT_OUT1,AT_IN1,AT_IN2,AT_OUT2 > Action: Calculate  AT_STANDARD > Settings > PL/SQL Function Body

DECLARE
    CURSOR c_flex IS
        SELECT TO_DATE(START_TIME, 'HH24:MI') AS flex_start, 
               TO_DATE(END_TIME, 'HH24:MI') AS flex_end
        FROM WORKING_PROFILE_LINES
        WHERE PROFILE_TYPE_ID LIKE '%flex%'
        AND PROFILE_ID = :PROFILE_ID;

    CURSOR c_standard IS
        SELECT TO_DATE(START_TIME, 'HH24:MI') AS standard_start, 
               TO_DATE(END_TIME, 'HH24:MI') AS standard_end
        FROM WORKING_PROFILE_LINES
        WHERE PROFILE_TYPE_ID LIKE '%standardtime%'
        AND PROFILE_ID = :PROFILE_ID;

    in1 DATE;
    out1  DATE;
    in2  DATE;
    out2  DATE;

    total_flex NUMBER(5,2) := 0;
    overlap_flex NUMBER(5,2) := 0;
    total_standard NUMBER(5,2) := 0;

BEGIN

    in1 := TO_DATE(:AT_IN1, 'HH24:MI');
    out1 := TO_DATE(:AT_OUT1, 'HH24:MI');
    in2 := TO_DATE(:AT_IN2, 'HH24:MI');
    out2 := TO_DATE(:AT_OUT2, 'HH24:MI');

    FOR r_flex IN c_flex LOOP
        IF r_flex.flex_start <= out1 AND r_flex.flex_end >= in1 THEN
            total_flex := total_flex + (LEAST(out1, r_flex.flex_end) - GREATEST(in1, r_flex.flex_start)) * 24;
            DBMS_OUTPUT.PUT_LINE('Flex overlap in morning: ' || TO_CHAR(GREATEST(in1, r_flex.flex_start), 'HH24:MI') || ' - ' || TO_CHAR(LEAST(out1, r_flex.flex_end), 'HH24:MI'));
        END IF;
        IF r_flex.flex_start <= out2 AND r_flex.flex_end >= in2 THEN
            total_flex := total_flex + (LEAST(out2, r_flex.flex_end) - GREATEST(in2, r_flex.flex_start)) * 24;
            DBMS_OUTPUT.PUT_LINE('Flex overlap in evening: ' || TO_CHAR(GREATEST(in2, r_flex.flex_start), 'HH24:MI') || ' - ' || TO_CHAR(LEAST(out2, r_flex.flex_end), 'HH24:MI'));
        END IF;
    END LOOP;

    FOR r_standard IN c_standard LOOP
        IF r_standard.standard_start <= out1 AND r_standard.standard_end >= in1 THEN
            total_standard := total_standard + (LEAST(out1, r_standard.standard_end) - GREATEST(in1, r_standard.standard_start)) * 24;
            DBMS_OUTPUT.PUT_LINE('Standard overlap in morning: ' || TO_CHAR(GREATEST(in1, r_standard.standard_start), 'HH24:MI') || ' - ' || TO_CHAR(LEAST(out1, r_standard.standard_end), 'HH24:MI'));
        END IF;
        IF r_standard.standard_start <= out2 AND r_standard.standard_end >= in2 THEN
            total_standard := total_standard + (LEAST(out2, r_standard.standard_end) - GREATEST(in2, r_standard.standard_start)) * 24;
            DBMS_OUTPUT.PUT_LINE('Standard overlap in evening: ' || TO_CHAR(GREATEST(in2, r_standard.standard_start), 'HH24:MI') || ' - ' || TO_CHAR(LEAST(out2, r_standard.standard_end), 'HH24:MI'));
        END IF;
    END LOOP;

    -- total_standard := total_standard - overlap_flex;

    -- DBMS_OUTPUT.PUT_LINE('Total Flex Time: ' || total_flex);
    -- DBMS_OUTPUT.PUT_LINE('Total Standard Time: ' || total_standard);

    return total_standard;

END;

-- ----------------------------------------
-- Page: 44 - Time Sheet Approval > Dynamic Action: Change AT_OUT1,AT_IN1,AT_IN2,AT_OUT2 > Action: Calculate  AT_RUSH > Settings > PL/SQL Function Body

declare 
    start_time_1 DATE;
    end_time_1 DATE;
    start_time_2 DATE;
    end_time_2 DATE;
    loop_flex_time_start DATE;
    loop_flex_time_end DATE;
    total_flex_time NUMBER(5,2) := 0;
    cursor c_flex_times is
        SELECT TO_DATE(START_TIME, 'HH24:MI') as flex_start, 
               TO_DATE(END_TIME, 'HH24:MI') as flex_end
        FROM WORKING_PROFILE_LINES
        WHERE PROFILE_ID = :PROFILE_ID
        AND PROFILE_TYPE_ID LIKE '%rush%';
begin
    -- Convert the time strings to DATE data type
    start_time_1 := TO_DATE(:AT_IN1, 'HH24:MI');
    end_time_1 := TO_DATE(:AT_OUT1, 'HH24:MI');
    start_time_2 := TO_DATE(:AT_IN2, 'HH24:MI');
    end_time_2 := TO_DATE(:AT_OUT2, 'HH24:MI');

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

    :AT_FLEX := total_flex_time;

    return total_flex_time;

    -- Output the result
    -- DBMS_OUTPUT.PUT_LINE('Total Flex Time:' || total_flex_time);
end;


-- ----------------------------------------
-- Page: 44 - Time Sheet Approval > Dynamic Action: Change AT_OUT1,AT_IN1,AT_IN2,AT_OUT2 > Action: Calculate  AT_OT > Settings > PL/SQL Function Body

declare 
    start_time_1 DATE;
    end_time_1 DATE;
    start_time_2 DATE;
    end_time_2 DATE;
    loop_flex_time_start DATE;
    loop_flex_time_end DATE;
    total_flex_time NUMBER(5,2) := 0;
    cursor c_flex_times is
        SELECT TO_DATE(START_TIME, 'HH24:MI') as flex_start, 
               TO_DATE(END_TIME, 'HH24:MI') as flex_end
        FROM WORKING_PROFILE_LINES
        WHERE PROFILE_ID = :PROFILE_ID
        AND PROFILE_TYPE_ID LIKE '%ot%';
begin
    -- Convert the time strings to DATE data type
    start_time_1 := TO_DATE(:AT_IN1, 'HH24:MI');
    end_time_1 := TO_DATE(:AT_OUT1, 'HH24:MI');
    start_time_2 := TO_DATE(:AT_IN2, 'HH24:MI');
    end_time_2 := TO_DATE(:AT_OUT2, 'HH24:MI');

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

    :AT_FLEX := total_flex_time;

    return total_flex_time;

    -- Output the result
    -- DBMS_OUTPUT.PUT_LINE('Total Flex Time:' || total_flex_time);
end;


-- ----------------------------------------
-- Page: 44 - Time Sheet Approval > Dynamic Action: Change AT_OUT1,AT_IN1,AT_IN2,AT_OUT2 > Action: Calculate AT_FLEX > Settings > PL/SQL Function Body

declare 
    start_time_1 DATE;
    end_time_1 DATE;
    start_time_2 DATE;
    end_time_2 DATE;
    loop_flex_time_start DATE;
    loop_flex_time_end DATE;
    total_flex_time NUMBER(5,2) := 0;
    cursor c_flex_times is
        SELECT TO_DATE(START_TIME, 'HH24:MI') as flex_start, 
               TO_DATE(END_TIME, 'HH24:MI') as flex_end
        FROM WORKING_PROFILE_LINES
        WHERE PROFILE_ID = :PROFILE_ID
        AND PROFILE_TYPE_ID LIKE '%flex%';
begin
    -- Convert the time strings to DATE data type
    start_time_1 := TO_DATE(:AT_IN1, 'HH24:MI');
    end_time_1 := TO_DATE(:AT_OUT1, 'HH24:MI');
    start_time_2 := TO_DATE(:AT_IN2, 'HH24:MI');
    end_time_2 := TO_DATE(:AT_OUT2, 'HH24:MI');

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

    :AT_FLEX := total_flex_time;

    return total_flex_time;

    -- Output the result
    -- DBMS_OUTPUT.PUT_LINE('Total Flex Time:' || total_flex_time);
end;


-- ----------------------------------------
-- Page: 44 - Time Sheet Approval > Page Item: P44_TO_DATE > Default > SQL Query

SELECT TO_CHAR(SYSDATE, 'MM/DD/YYYY') AS formatted_date FROM DUAL;

-- ----------------------------------------
-- Page: 44 - Time Sheet Approval > Page Item: P44_FROM_DATE > Default > SQL Query

SELECT TRUNC(SYSDATE, 'YEAR') AS first_day_of_current_year FROM DUAL;

