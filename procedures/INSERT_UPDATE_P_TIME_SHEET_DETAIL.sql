create or replace PROCEDURE "INSERT_UPDATE_P_TIME_SHEET_DETAIL"
(
    date_from DATE,
    date_to DATE
)
IS

n_count_1 NUMBER;
n_TS_ID NUMBER;
n_current_in NUMBER;
n_current_out NUMBER;
n_wt_in1 varchar2(10);
n_wt_out1 varchar2(10);
n_wt_in2 varchar2(10);
n_wt_out2 varchar2(10);
n_wt_in1_line_id varchar2(50);
n_wt_out1_line_id varchar2(50);
n_wt_in2_line_id varchar2(50);
n_wt_out2_line_id varchar2(50);

l_count_is_rush_profile NUMBER;
l_count_is_overtime_profile NUMBER;

BEGIN

    -- FOR rec_ets IN (SELECT EMPLOYEE_CODE, WORKER, PROFILE_DATE, TS_HEADER_REC_ID, TRANSFERRED, PROFILE_ID  FROM EMP_TIME_SHEET)
    -- Loop DATE_TS in time (date_from, date_to)
    FOR rec_ets IN (SELECT *  FROM EMP_TIME_SHEET WHERE PROFILE_DATE >= date_from AND PROFILE_DATE <= date_to)
    
    LOOP
        -- DBMS_OUTPUT.put_line('');
        SELECT ID into n_TS_ID FROM P_TIME_SHEET pts where pts.TS_HEADER_ID = rec_ets.TS_HEADER_REC_ID;
        SELECT COUNT(*) into n_count_1 FROM P_TIME_SHEET_DETAIL ptsd WHERE ptsd.TS_HEADER_ID = rec_ets.TS_HEADER_REC_ID;

        -- Check rush/ot profile
        SELECT COUNT(*) INTO l_count_is_overtime_profile FROM WORKING_PROFILE wp
        WHERE wp.PROFILE_ID = CUSTOM_TRIM_V3(rec_ets.PROFILE_ID) and wp.IS_OVERTIME_PROFILE = 1;

        SELECT COUNT(*) INTO l_count_is_rush_profile FROM WORKING_PROFILE wp
        WHERE wp.PROFILE_ID = CUSTOM_TRIM_V3(rec_ets.PROFILE_ID) and wp.IS_RUSH_PROFILE = 1;

        -- reset time variables
        n_wt_in1 := NULL;
        n_wt_out1 := NULL;
        n_wt_in2 := NULL;
        n_wt_out2 := NULL;
        

        -- Insert/Update P_TIME_SHEET_DETAIL(WT_STANDARD_HOURS,WT_FLEX,WT_RUSH,WT_OT)
        if n_count_1 > 0 then
            -- DBMS_OUTPUT.put_line('Update disabled! :' || rec_ets.TS_HEADER_REC_ID);
            UPDATE
                P_TIME_SHEET_DETAIL ptsd
            SET
                WT_STANDARD_HOURS = rec_ets.PAY_TIME,
                WT_FLEX = rec_ets.FLEX_MORE - rec_ets.FLEX_LESS,
                WT_RUSH = CASE WHEN l_count_is_rush_profile > 0 THEN rec_ets.PAY_OVERTIME ELSE 0 END,
                WT_OT = CASE WHEN l_count_is_overtime_profile > 0 THEN rec_ets.PAY_OVERTIME ELSE 0 END,
                APPROVED_LEAVES = rec_ets.ABSENCE_TIME
            WHERE
                ptsd.TS_HEADER_ID = rec_ets.TS_HEADER_REC_ID;
        else
            -- Insert new timesheet record
            INSERT INTO P_TIME_SHEET_DETAIL(
                TS_ID,
                WT_STANDARD_HOURS,
                WT_FLEX,
                WT_RUSH,
                WT_OT,
                APPROVED_LEAVES,
                TS_HEADER_ID
            )
            VALUES(
                n_TS_ID,
                rec_ets.PAY_TIME,
                rec_ets.FLEX_MORE - rec_ets.FLEX_LESS,
                CASE WHEN l_count_is_rush_profile > 0 THEN rec_ets.PAY_OVERTIME ELSE 0 END,
                CASE WHEN l_count_is_overtime_profile > 0 THEN rec_ets.PAY_OVERTIME ELSE 0 END,
                rec_ets.ABSENCE_TIME,
                rec_ets.TS_HEADER_REC_ID                
            );
        END IF;

        -- Update P_TIME_SHEET_DETAIL(WT_IN1,WT_OUT1,WT_IN2,WT_OUT2)
        -- [Not tested yet]
        n_current_in := 1;
        n_current_out := 1;
        for rec_etsl in (SELECT * FROM EMP_TIME_SHEET_LINE etsl where etsl.TS_HEADER_REC_ID = rec_ets.TS_HEADER_REC_ID order by etsl.TS_LINE_REC_ID)
        LOOP
            if rec_etsl.reg_type like '%clock in%' then
                if n_current_in = 1 then n_wt_in1 := rec_etsl.start_time; n_wt_in1_line_id := rec_etsl.TS_LINE_REC_ID; end if;
                if n_current_in = 2 then n_wt_in2 := rec_etsl.start_time; n_wt_in2_line_id := rec_etsl.TS_LINE_REC_ID; end if;
                n_current_in := n_current_in + 1;
            end if;
            if rec_etsl.reg_type like '%clock out%' then
                if n_current_out = 1 then n_wt_out1 := rec_etsl.start_time; n_wt_out1_line_id:= rec_etsl.TS_LINE_REC_ID; end if;
                if n_current_out = 2 then n_wt_out2 := rec_etsl.start_time; n_wt_out2_line_id:= rec_etsl.TS_LINE_REC_ID; end if;
                n_current_out := n_current_out + 1;
            end if;
        END LOOP;

        -- DBMS_OUTPUT.put_line('');
        -- DBMS_OUTPUT.put_line(rec_ets.TS_HEADER_REC_ID);

    -- P_TIME_SHEET_DETAIL
    -- ID	NUMBER(6,0)
    -- TS_ID	NUMBER(6,0)
    -- WT_IN1	VARCHAR2(10 CHAR)
    -- WT_OUT1	VARCHAR2(10 CHAR)
    -- WT_IN2	VARCHAR2(10 CHAR)
    -- WT_OUT2	VARCHAR2(10 CHAR)
    -- WT_STANDARD_HOURS	NUMBER(5,2)
    -- WT_FLEX	NUMBER(5,2)
    -- WT_RUSH	NUMBER(5,2)
    -- WT_OT	NUMBER(5,2)
    -- AT_IN1	VARCHAR2(10 CHAR)
    -- AT_OUT1	VARCHAR2(10 CHAR)
    -- AT_IN2	VARCHAR2(10 CHAR)
    -- AT_OUT2	VARCHAR2(10 CHAR)
    -- AT_STANDARD_HOURS	NUMBER(5,2)
    -- AT_FLEX	NUMBER(5,2)
    -- AT_RUSH	NUMBER(5,2)
    -- AT_OT	NUMBER(5,2)
    -- IN1_TS_LINE_ID	VARCHAR2(30 CHAR)
    -- OUT1_TS_LINE_ID	VARCHAR2(30 CHAR)
    -- IN2_TS_LINE_ID	VARCHAR2(30 CHAR)
    -- OUT2_TS_LINE_ID	VARCHAR2(30 CHAR)
    -- TS_HEADER_ID	NVARCHAR2(30 CHAR)
    -- APPROVED_LEAVES	NUMBER(5,2)
    -- APPROVED_OT	NUMBER(5,2)

        -- Update timesheet details with in and out times
        UPDATE P_TIME_SHEET_DETAIL ptsd
        SET
            ptsd.WT_IN1 = n_wt_in1,
            ptsd.WT_OUT1 = n_wt_out1,
            ptsd.WT_IN2 = n_wt_in2,
            ptsd.WT_OUT2 = n_wt_out2,
            ptsd.IN1_TS_LINE_ID = n_wt_in1_line_id,
            ptsd.OUT1_TS_LINE_ID = n_wt_out1_line_id,
            ptsd.IN2_TS_LINE_ID = n_wt_in2_line_id,
            ptsd.OUT2_TS_LINE_ID = n_wt_out2_line_id,
            -- Set AT_IN1, AT_OUT1, AT_IN2, AT_OUT2 to WT_IN1, WT_OUT1, WT_IN2, WT_OUT2 if they are null
            ptsd.AT_IN1 = CASE WHEN ptsd.AT_IN1 IS NOT NULL THEN n_wt_in1 ELSE ptsd.AT_IN1 END,
            ptsd.AT_OUT1 = CASE WHEN ptsd.AT_OUT1 IS NOT NULL THEN n_wt_out1 ELSE ptsd.AT_OUT1 END,
            ptsd.AT_IN2 = CASE WHEN ptsd.AT_IN2 IS NOT NULL THEN n_wt_in2 ELSE ptsd.AT_IN2 END,
            ptsd.AT_OUT2 = CASE WHEN ptsd.AT_OUT2 IS NOT NULL THEN n_wt_out2 ELSE ptsd.AT_OUT2 END
        WHERE ptsd.TS_HEADER_ID = rec_ets.TS_HEADER_REC_ID;


        -- COMMIT;
    END LOOP;
END "INSERT_UPDATE_P_TIME_SHEET_DETAIL";