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
-- Page: 25 - Scholarship Request pk > Region: SCHOLARSHIP REQUEST I-GRID > Source > SQL Query

select sr.ID,
       er.STATUS,
       sr.RECIPIENT_TYPE,
       sr.PROGRAM,
       --sr.REQUESTER_CODE,
       --sr.REQUESTER_DEPARTMENT,
       --sr.REQUESTER_LEVEL,
       sr.PARTNER_NAME,
       sr.PARTNER_PHONE,
       sr.PARTNER_TITLE,
       sr.PARTNER_DEPARTMENT,
       sr.PARTNER_FIELD,
       sr.PARTNER_WORKPLACE,
       sr.RECIPIENT_NAME,
       sr.RECIPIENT_DOB,
       sr.RECIPIENT_PHONE,
       sr.RECIPIENT_RELATIONSHIP,
       sr.RECIPIENT_CAMPUS,
       sr.ATTACH_NAME,
       sr.ATTACH_FILE,
       sr.RECIPIENT_REPLACEMENT,
       sr.RECIPIENT_VOUCHER_CODE_REPLACEMENT,
       sr.RECIPIENT_EXPIRATION_DATE_REPLACEMENT,
       sr.RECIPIENT_NOTE,
       sr.RECIPIENT_REASON_REQUEST,
       sr.DISCOUNT_RATE,
       sr.VOUCHER_CODE,
       sr.NUMBER_OF_COURSES,
       sr.EFFECTIVE_DATE,
       sr.EXPIRATION_DATE,
       sr.APPROVED_DATE,
       sr.CREATED_DATE,
       emp.FULL_NAME,
       emp.LEVEL_DESCRIPTION,
       emp.EMPLOYEE_CODE,
       emp.START_DATE,
       emp.TERMINATE_DATE,
       emp.DEPARTMENT_ID,
       emp.DEPARTMENT_NAME
  from SCHOLARSHIP_REQUEST sr
  join EMP_REQUESTS er on er.REQUEST_DETAIL_ID = sr.ID
  join EMPLOYEES emp on sr.REQUESTER_CODE = emp.EMPLOYEE_CODE
  Where sr.REQUESTER_CODE = :APP_EMP_CODE;

-- ----------------------------------------
-- Page: 25 - Scholarship Request pk > Region: SCHOLARSHIP REQUEST I-GRID > Column: STATUS > List of Values > SQL Query

SELECT STATUS, ID AS ID
FROM STATUS;

-- ----------------------------------------
-- Page: 25 - Scholarship Request pk > Page Item: P25_DATE_TO > Default > SQL Query

SELECT TO_CHAR(SYSDATE, 'MM/DD/YYYY') AS formatted_date FROM DUAL;

-- ----------------------------------------
-- Page: 25 - Scholarship Request pk > Page Item: P25_DATE_FROM > Default > SQL Query

SELECT TRUNC(SYSDATE, 'YEAR') AS first_day_of_current_year FROM DUAL;

