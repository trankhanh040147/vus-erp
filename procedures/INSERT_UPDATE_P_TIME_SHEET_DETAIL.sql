create or replace PROCEDURE "INSERT_UPDATE_P_TIME_SHEET_DETAIL"

IS

n_count_1 NUMBER;
n_TS_ID NUMBER;

wt_in1 nvarchar2;
wt_out1 nvarchar2;
wt_in2 nvarchar2;
wt_out2 nvarchar2;

BEGIN

    -- FOR rec_ets IN (SELECT EMPLOYEE_CODE, WORKER, PROFILE_DATE, TS_HEADER_REC_ID, TRANSFERRED, PROFILE_ID  FROM EMP_TIME_SHEET)
    FOR rec_ets IN (SELECT *  FROM EMP_TIME_SHEET)
    
    LOOP
        SELECT ID into n_TS_ID FROM P_TIME_SHEET pts where pts.TS_HEADER_ID = rec_ets.TS_HEADER_REC_ID;
        SELECT COUNT(*) into n_count_1 FROM P_TIME_SHEET_DETAIL ptsd WHERE ptsd.TS_HEADER_ID = rec_ets.TS_HEADER_REC_ID;

        -- Insert/Update P_TIME_SHEET_DETAIL(WT_STANDARD_HOURS,WT_FLEX,WT_RUSH,WT_OT)
        if n_count_1 > 0 then
            -- DBMS_OUTPUT.put_line('Update disabled! :' || rec_ets.TS_HEADER_REC_ID);
            UPDATE
                P_TIME_SHEET_DETAIL ptsd
            SET
                WT_STANDARD_HOURS = rec_ets.PAY_TIME,
                WT_FLEX = rec_ets.FLEX_MORE + rec_ets.FLEX_LESS,
                -- WT_RUSH = rec_ets.PAY_TIME,
                WT_OT = rec_ets.PAY_OVERTIME
            WHERE
                ptsd.TS_HEADER_ID = rec_ets.TS_HEADER_REC_ID;
        else
            INSERT INTO P_TIME_SHEET_DETAIL(
                TS_ID,
                WT_STANDARD_HOURS,
                WT_FLEX,
                -- WT_RUSH,
                WT_OT,
                TS_HEADER_ID
            )
            VALUES(
                n_TS_ID,
                rec_ets.PAY_TIME,
                rec_ets.FLEX_MORE + rec_ets.FLEX_LESS,
                rec_ets.PAY_OVERTIME,
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
                if n_current_in = 1 then wt_in1 := rec_etsl.start_time end if
                if n_current_in = 2 then wt_in2 := rec_etsl.start_time end if
                n_current_in := n_current_in + 1;
            end if;
            if rec_etsl.reg_type like '%clock out%' then
                if n_current_out = 1 then wt_out1 := rec_etsl.start_time end if;
                if n_current_out = 2 then wt_out2 := rec_etsl.start_time end if;
                n_current_out := n_current_out + 1;
            end if;
        END LOOP;

        COMMIT;
    END LOOP;
END "INSERT_UPDATE_P_TIME_SHEET_DETAIL";
/