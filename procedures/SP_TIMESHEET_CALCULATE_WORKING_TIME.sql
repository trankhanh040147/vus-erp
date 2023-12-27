create or replace procedure "SP_TIMESHEET_CALCULATE_WORKING_TIME"
is
    wt_in1 VARCHAR2(20);
    wt_out1 VARCHAR2(20);
    wt_in2 VARCHAR2(20);
    wt_out2 VARCHAR2(20);
    at_in1 VARCHAR2(20);
    at_out1 VARCHAR2(20);
    at_in2 VARCHAR2(20);
    at_out2 VARCHAR2(20);
BEGIN
    for rec in (
        select ptsd.TS_HEADER_ID, pts.PROFILE_ID, 
            ptsd.WT_IN1, ptsd.WT_OUT1, ptsd.WT_IN2, ptsd.WT_OUT2, 
            ptsd.AT_IN1, ptsd.AT_OUT1, ptsd.AT_IN2, ptsd.AT_OUT2
        from P_TIME_SHEET_DETAIL ptsd
        join P_TIME_SHEET pts on ptsd.TS_HEADER_ID = pts.TS_HEADER_ID
    ) loop

        wt_in1 := case when rec.WT_IN1 = '24:00' then '23:59' else rec.WT_IN1 end;
        wt_out1 := case when rec.WT_OUT1 = '24:00' then '23:59' else rec.WT_OUT1 end;
        wt_in2 := case when rec.WT_IN2 = '24:00' then '23:59' else rec.WT_IN2 end;
        wt_out2 := case when rec.WT_OUT2 = '24:00' then '23:59' else rec.WT_OUT2 end;
        
        at_in1 := case when rec.AT_IN1 = '24:00' then '23:59' else rec.AT_IN1 end;
        at_out1 := case when rec.AT_OUT1 = '24:00' then '23:59' else rec.AT_OUT1 end;
        at_in2 := case when rec.AT_IN2 = '24:00' then '23:59' else rec.AT_IN2 end;
        at_out2 := case when rec.AT_OUT2 = '24:00' then '23:59' else rec.AT_OUT2 end;
        
        update P_TIME_SHEET_DETAIL ptsd
        -- set WT_STANDARD_HOURS = ts_calculate_standard_hours(rec.WT_IN1, rec.WT_OUT1, rec.WT_IN2, rec.WT_OUT2, rec.PROFILE_ID)
        set WT_STANDARD_HOURS = ts_calculate_standard_hours(wt_in1, wt_out1, wt_in2, wt_out2, rec.PROFILE_ID),
            WT_FLEX = ts_calculate_flex_time(wt_in1, wt_out1, wt_in2, wt_out2, rec.PROFILE_ID),
            WT_OT = ts_calculate_overtime(wt_in1, wt_out1, wt_in2, wt_out2, rec.PROFILE_ID),
            WT_RUSH = TS_CALCULATE_RUSH_TIME(wt_in1, wt_out1, wt_in2, wt_out2, rec.PROFILE_ID),
            AT_STANDARD_HOURS = ts_calculate_standard_hours(at_in1, at_out1, at_in2, at_out2, rec.PROFILE_ID),
            AT_FLEX = ts_calculate_flex_time(at_in1, at_out1, at_in2, at_out2, rec.PROFILE_ID),
            AT_OT = ts_calculate_overtime(at_in1, at_out1, at_in2, at_out2, rec.PROFILE_ID),
            AT_RUSH = TS_CALCULATE_RUSH_TIME(at_in1, at_out1, at_in2, at_out2, rec.PROFILE_ID)
        where ptsd.TS_HEADER_ID = rec.TS_HEADER_ID;


    end loop;
END;
-- table: P_TIME_SHEET_DETAIL
-- AT_IN1	VARCHAR2(20 CHAR)
-- AT_OUT1	VARCHAR2(20 CHAR)
-- AT_IN2	VARCHAR2(20 CHAR)
-- AT_OUT2	VARCHAR2(20 CHAR)
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

-- table: P_TIME_SHEET
-- ID	NUMBER(8,0)
-- EMPLOYEE_CODE	NVARCHAR2(50 CHAR)
-- WORKER_ID	NVARCHAR2(50 CHAR)
-- DATE_TS	DATE
-- REASON_ADJUSTMENT	NVARCHAR2(100 CHAR)
-- IS_OK	NUMBER(1,0)
-- STATUS	NUMBER
-- NOTE	NVARCHAR2(100 CHAR)
-- TS_HEADER_ID	NVARCHAR2(50 CHAR)
-- PROFILE_ID	NVARCHAR2(30 CHAR)