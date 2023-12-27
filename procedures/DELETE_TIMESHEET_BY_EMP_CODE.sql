create or replace procedure "DELETE_TIMESHEET_BY_EMP_CODE"(
    p_emp_code NVARCHAR2,
    p_date_from date default null,
    p_date_to date default null
)
is
    n_date_from date := p_date_from;
    n_date_to date := p_date_to;
begin
    if n_date_from is null and n_date_to is null then
        -- delete all

        --- delete from EMP_TIME_SHEET_LINE and EMP_TIME_SHEET
        delete from EMP_TIME_SHEET_LINE where TS_HEADER_REC_ID in (
            select TS_HEADER_REC_ID from EMP_TIME_SHEET where EMPLOYEE_CODE = p_emp_code
        );
        delete from EMP_TIME_SHEET where EMPLOYEE_CODE = p_emp_code;

        --- delete from P_TIME_SHEET_DETAIL and P_TIME_SHEET
        delete from P_TIME_SHEET_DETAIL where TS_HEADER_ID in (
            select TS_HEADER_ID from P_TIME_SHEET where EMPLOYEE_CODE = p_emp_code
        );
        delete from P_TIME_SHEET where EMPLOYEE_CODE = p_emp_code;

        DBMS_OUTPUT.PUT_LINE('DELETE_TIMESHEET_BY_EMP_CODE: delete all');
        return;
    elsif n_date_from is not null and n_date_to is null then
        n_date_to := n_date_from;
    elsif n_date_from is null and n_date_to is not null then
        n_date_from := n_date_to;
    end if;

    DBMS_OUTPUT.PUT_LINE('DELETE_TIMESHEET_BY_EMP_CODE: delete from ' || n_date_from || ' to ' || n_date_to);

    -- delete from EMP_TIME_SHEET_LINE and EMP_TIME_SHEET
    delete from EMP_TIME_SHEET_LINE where TS_HEADER_REC_ID in (
        select TS_HEADER_REC_ID from EMP_TIME_SHEET where EMPLOYEE_CODE = p_emp_code and PROFILE_DATE >= n_date_from and PROFILE_DATE <= n_date_to
    );
    delete from EMP_TIME_SHEET where EMPLOYEE_CODE = p_emp_code and PROFILE_DATE >= n_date_from and PROFILE_DATE <= n_date_to;

    -- delete from P_TIME_SHEET_DETAIL and P_TIME_SHEET
    delete from P_TIME_SHEET_DETAIL where TS_HEADER_ID in (
        select TS_HEADER_ID from P_TIME_SHEET where EMPLOYEE_CODE = p_emp_code and DATE_TS >= n_date_from and DATE_TS <= n_date_to
    );
    delete from P_TIME_SHEET where EMPLOYEE_CODE = p_emp_code and DATE_TS >= n_date_from and DATE_TS <= n_date_to;

    DBMS_OUTPUT.PUT_LINE('DELETE_TIMESHEET_BY_EMP_CODE: done');

end;

-- EMP_TIME_SHEET
-- ID	NUMBER(10,0)
-- EMPLOYEE_CODE	NVARCHAR2(100 CHAR)
-- PROFILE_DATE	DATE
-- PROFILE_ID	NVARCHAR2(50 CHAR)
-- WORKER	NVARCHAR2(20 CHAR)
-- TS_HEADER_REC_ID	NVARCHAR2(100 CHAR)

-- EMP_TIME_SHEET_LINE
-- ID	NUMBER(10,0)
-- TS_LINE_REC_ID	NVARCHAR2(100 CHAR)
-- REG_TYPE	NVARCHAR2(200 CHAR)
-- JOB_REF	NVARCHAR2(200 CHAR)
-- JOD_ID	NVARCHAR2(200 CHAR)
-- START_TIME	NVARCHAR2(20 CHAR)
-- END_TIME	NVARCHAR2(20 CHAR)
-- DESCRIPTION	NVARCHAR2(200 CHAR)
-- TRANS_ID	VARCHAR2(100 CHAR)
-- TIME	NUMBER(5,2)
-- TS_HEADER_REC_ID	VARCHAR2(100 CHAR)

-- P_TIME_SHEET
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

-- P_TIME_SHEET_DETAIL
-- ID	NUMBER(6,0)
-- TS_ID	NUMBER(6,0)
-- WT_IN1	VARCHAR2(20 CHAR)
-- WT_OUT1	VARCHAR2(20 CHAR)
-- WT_IN2	VARCHAR2(20 CHAR)
-- WT_OUT2	VARCHAR2(20 CHAR)
-- WT_STANDARD_HOURS	NUMBER(5,2)
-- WT_FLEX	NUMBER(5,2)
-- WT_RUSH	NUMBER(5,2)
-- WT_OT	NUMBER(5,2)
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