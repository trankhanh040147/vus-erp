
create or replace function ot_calculate_total_dayoff (p_detail_id in number) return number is
-- function ot_calculate_total_dayoff (p_request_id in number) return number is
-- total day off = (TOTAL_HOUR_WK*1.5 + TOTAL_HOUR_REST_WK*2 + TOTAL_HOUR_PUBLIC*3)/8
    v_total_dayoff number;
begin
    with  total_hour as (
        select sum(TOTAL_HOUR_WK) as TOTAL_HOUR_WK,
            sum(TOTAL_HOUR_REST_WK) as TOTAL_HOUR_REST_WK,
            sum(TOTAL_HOUR_PUBLIC) as TOTAL_HOUR_PUBLIC,
            DETAIL_ID
            from EMP_OVERTIME_REQUESTS
            where DETAIL_ID = p_detail_id
            group by DETAIL_ID
    )
    select (TOTAL_HOUR_WK*1.5 + TOTAL_HOUR_REST_WK*2 + TOTAL_HOUR_PUBLIC*3)/8
    into v_total_dayoff
    from total_hour;
    DBMS_OUTPUT.PUT_LINE('v_total_dayoff: ' || custom_round(v_total_dayoff));
    return custom_round(v_total_dayoff);
end;


-- table: EMP_OVERTIME_REQUESTS
-- ID	NUMBER(10,0)	N
-- EMPLOYEE_CODE	NVARCHAR2(500 CHAR)	Y
-- CREATED_DATE	DATE	Y
-- TOTAL_HOUR_WK	FLOAT(10)	Y
-- TOTAL_HOUR_REST_WK	FLOAT(10)	Y
-- TOTAL_HOUR_PUBLIC	FLOAT(10)	Y
-- STATUS	NVARCHAR2(100 CHAR)	Y
-- NOTE	NVARCHAR2(2000 CHAR)	Y
-- MODIFIED_BY_CODE	NVARCHAR2(500 CHAR)	Y
-- MODIFIED_DATE	DATE	Y
-- WORKING_PLACE	NVARCHAR2(200 CHAR)	Y
-- START_TIME	NVARCHAR2(100 CHAR)	Y
-- END_TIME	NVARCHAR2(100 CHAR)	Y
-- PROFILE_TIME	NVARCHAR2(100 CHAR)	Y
-- REASON	NVARCHAR2(2000 CHAR)	Y
-- MANAGER_CODE	NVARCHAR2(200 CHAR)	Y
-- DETAIL_ID	NUMBER(10,0)	Y

-- declare
--     v_total_dayoff number;
-- begin
--     v_total_dayoff := ot_calculate_total_dayoff(977);
-- end;