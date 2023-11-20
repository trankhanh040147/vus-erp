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
-- Page: 20006 - scholarship_configuration > Region: New > Source > SQL Query

SELECT ROWNUM AS ROW_NUMBER,
       s.ID as ID,
       s.S_CODE,
       s.S_NAME,
       s.S_DESCRIPTION,
       s.S_MODIFIER_CODE,
       s.S_EFFECTIVE_DATE,
       s.S_EXPIRATION_DATE,
       s.S_MODIFIED_DATE,
       e.FULL_NAME,
       s.SCHOLARSHIP_ID
FROM SCHOLARSHIP s
JOIN EMPLOYEES e ON e.EMPLOYEE_CODE = s.S_MODIFIER_CODE;

-- ----------------------------------------
-- Page: 20006 - scholarship_configuration > Page Item: P20006_FROM_DATE > Default > SQL Query

SELECT TO_CHAR(TRUNC(SYSDATE, 'YEAR'), 'DD/MM/YYYY') FROM DUAL;

-- ----------------------------------------
-- Page: 20006 - scholarship_configuration > Page Item: P20006_TO_DATE > Default > SQL Query

SELECT TO_CHAR(SYSDATE, 'DD/MM/YYYY') FROM DUAL;

