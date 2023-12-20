create or replace procedure "SP_TIMESHEET_CALCULATE_WORKING_TIME"(
    -- p_header_id NVARCHAR2(50)
)
is
    in1 VARCHAR2(20);
    out1 VARCHAR2(20);
    in2 VARCHAR2(20);
    out2 VARCHAR2(20);
BEGIN
    for rec in (
        select ptsd.TS_HEADER_ID, pts.PROFILE_ID, ptsd.WT_IN1, ptsd.WT_OUT1, ptsd.WT_IN2, ptsd.WT_OUT2
        from P_TIME_SHEET_DETAIL ptsd
        join P_TIME_SHEET pts on ptsd.TS_HEADER_ID = pts.TS_HEADER_ID
    ) loop

        in1 := case when rec.WT_IN1 = '24:00' then '23:59' else rec.WT_IN1 end;
        out1 := case when rec.WT_OUT1 = '24:00' then '23:59' else rec.WT_OUT1 end;
        in2 := case when rec.WT_IN2 = '24:00' then '23:59' else rec.WT_IN2 end;
        out2 := case when rec.WT_OUT2 = '24:00' then '23:59' else rec.WT_OUT2 end;

        
        update P_TIME_SHEET_DETAIL ptsd
        -- set WT_STANDARD_HOURS = ts_calculate_standard_hours(rec.WT_IN1, rec.WT_OUT1, rec.WT_IN2, rec.WT_OUT2, rec.PROFILE_ID)
        set WT_STANDARD_HOURS = ts_calculate_standard_hours(in1, out1, in2, out2, rec.PROFILE_ID),
            WT_FLEX = ts_calculate_flex_time(in1, out1, in2, out2, rec.PROFILE_ID),
            WT_OT = ts_calculate_overtime(in1, out1, in2, out2, rec.PROFILE_ID),
            WT_RUSH = TS_CALCULATE_RUSH_TIME(in1, out1, in2, out2, rec.PROFILE_ID)
        where ptsd.TS_HEADER_ID = rec.TS_HEADER_ID;
    end loop;
END;
/