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
-- Page: 101 - Personal Infor Clone 1 > Region: Degree > Source > SQL Query

SELECT 
    edu.ID,
    edu.EMPLOYEE_ID,
    edu.TYPE,
    edu.LEVEL_OF_EDU,
    edu.MAJOR,
    edu.PLACE,
    edu.GRADUATED_DATE,
    edu.ATTACH_FILE,
    --IS_DEL,
    --EXPIRATION_DATE,
    --EFFECTIVE_DATE,
    '#' as Action
from EMP_EDUCATION edu
INNER JOIN 
  EMPLOYEES e ON edu.EMPLOYEE_CODE = e.EMPLOYEE_CODE
WHERE e.USER_NAME = :APP_USER_NAME;

-- ----------------------------------------
-- Page: 101 - Personal Infor Clone 1 > Dynamic Action: New > Action: Execute Server-side Code > Settings > PL/SQL Code

DECLARE
    p_header NVARCHAR2(200);
    p_body NVARCHAR2(200);
    p_send_to NVARCHAR2(200);
    o_bank_acc NVARCHAR2(200);
BEGIN
    -- Select the value into o_bank_acc
    SELECT :P101_BANK_ACC_NUM INTO o_bank_acc FROM DUAL;

    p_header := 'Test email';
    -- p_body := 'Test email for ' || o_bank_acc || ' and old: ' || :P101_BANK_ACC_NUM;
    p_body := '"Test email for ' || o_bank_acc || '"';
    p_send_to := 'trankhanh040147@gmail.com';
    SP_SEND_EMAIL(p_header, p_body, p_send_to);
END;


-- ----------------------------------------
-- Page: 101 - Personal Infor Clone 1 > Page Item: P101_COMPANY_EMAIL > Default > SQL Query

select USER_NAME from employees where USER_NAME = :APP_USER_NAME;

-- ----------------------------------------
-- Page: 101 - Personal Infor Clone 1 > Page Item: P101_TITLE > Default > SQL Query

select TITLE from employees where USER_NAME = :APP_USER_NAME;

-- ----------------------------------------
-- Page: 101 - Personal Infor Clone 1 > Page Item: P101_PERSONAL_EMAIL > Default > SQL Query

select PERSONAL_EMAIL from employees where USER_NAME = :APP_USER_NAME;

-- ----------------------------------------
-- Page: 101 - Personal Infor Clone 1 > Page Item: P101_PHONE_NUMBER > Default > SQL Query

select PHONE_NUMBER from employees where USER_NAME = :APP_USER_NAME;

-- ----------------------------------------
-- Page: 101 - Personal Infor Clone 1 > Page Item: P101_SOC_INS_RELATIONS > Default > SQL Query

select SOC_RELATIONSHIP from EMP_SOCICAL_INSURANCE EMP_SI where EMP_SI.EMPLOYEE_CODE = 
(select EMPLOYEE_CODE from EMPLOYEES where USER_NAME = :APP_USER_NAME  );

-- ----------------------------------------
-- Page: 101 - Personal Infor Clone 1 > Page Item: P101_TERMINATE_DATE > Default > SQL Query

-- SELECT
--   CASE
--     WHEN TERMINATE_DATE = TO_DATE('12/31/2154', 'MM/DD/YYYY') THEN 'Never'
--     ELSE TO_CHAR(TERMINATE_DATE, 'MM/DD/YYYY')
--   END AS TERMINATE_DATE
-- FROM EMPLOYEES
-- WHERE USER_NAME = :APP_USER_NAME;

SELECT
TERMINATE_DATE
FROM EMPLOYEES
WHERE USER_NAME = :APP_USER_NAME;

-- ----------------------------------------
-- Page: 101 - Personal Infor Clone 1 > Page Item: P101_SOC_INS_HOU_ID > Default > SQL Query

select SOC_HOU_ID from EMP_SOCICAL_INSURANCE EMP_SI where EMP_SI.EMPLOYEE_CODE = 
(select EMPLOYEE_CODE from EMPLOYEES where USER_NAME = :APP_USER_NAME  );

-- ----------------------------------------
-- Page: 101 - Personal Infor Clone 1 > Page Item: P101_PLACE_DATE_ID > Default > SQL Query

SELECT ISSUE_PLACE
FROM EMP_ID_NUMBER emp_id
INNER JOIN 
    EMPLOYEES e on e.EMPLOYEE_CODE = emp_id.EMPLOYEE_CODE
WHERE ID_TYPE = 0 AND e.USER_NAME = :APP_USER_NAME;

-- ----------------------------------------
-- Page: 101 - Personal Infor Clone 1 > Page Item: P101_START_DATE > Default > SQL Query

SELECT
  CASE
    WHEN START_DATE = TO_DATE('1/1/1900', 'MM/DD/YYYY') THEN ''
    ELSE TO_CHAR(START_DATE, 'MM/DD/YYYY')
  END AS START_DATE
FROM EMPLOYEES
WHERE USER_NAME = :APP_USER_NAME;

-- ----------------------------------------
-- Page: 101 - Personal Infor Clone 1 > Page Item: P101_PER_DETAIL > Default > SQL Query

select PERSONAL_EMAIL from employees where PERSONAL_EMAIL = :APP_USER_NAME;

-- ----------------------------------------
-- Page: 101 - Personal Infor Clone 1 > Page Item: P101_SOC_INS_HOU_DOB > Default > SQL Query

select SOC_HOU_DOB from EMP_SOCICAL_INSURANCE EMP_SI where EMP_SI.EMPLOYEE_CODE = 
(select EMPLOYEE_CODE from EMPLOYEES where USER_NAME = :APP_USER_NAME  );

-- ----------------------------------------
-- Page: 101 - Personal Infor Clone 1 > Page Item: P101_SOC_INS_HOU_NAME > Default > SQL Query

select SOC_HOU_NAME from EMP_SOCICAL_INSURANCE EMP_SI where EMP_SI.EMPLOYEE_CODE = 
(select EMPLOYEE_CODE from EMPLOYEES where USER_NAME = :APP_USER_NAME  );

-- ----------------------------------------
-- Page: 101 - Personal Infor Clone 1 > Page Item: P101_EXP_DATE_ID > Default > SQL Query

SELECT
  CASE
    WHEN EXPIRATION_DATE = TO_DATE('1/1/1900', 'MM/DD/YYYY') THEN ''
    ELSE TO_CHAR(EXPIRATION_DATE, 'MM/DD/YYYY')
  END AS EXPIRATION_DATE
FROM EMP_ID_NUMBER emp_id
INNER JOIN 
    EMPLOYEES e on e.EMPLOYEE_CODE = emp_id.EMPLOYEE_CODE
WHERE ID_TYPE = 0 AND e.USER_NAME = :APP_USER_NAME;

-- ----------------------------------------
-- Page: 101 - Personal Infor Clone 1 > Page Item: P101_GENDER > Default > SQL Query

SELECT 
    CASE 
        WHEN GENDER = 0 THEN 'Others'
        WHEN GENDER = 1 THEN 'Male'
        WHEN GENDER = 2 THEN 'Female'
        ELSE 'Unknown' -- Optional, handle any other values not in the mapping
    END AS GENDER_LABEL
FROM 
    employees
WHERE 
    USER_NAME = :APP_USER_NAME;

-- ----------------------------------------
-- Page: 101 - Personal Infor Clone 1 > Page Item: P101_ISSUE_PLACE_WP > Default > SQL Query

SELECT ISSUE_PLACE
FROM EMP_ID_NUMBER emp_id
INNER JOIN 
    EMPLOYEES e on e.EMPLOYEE_CODE = emp_id.EMPLOYEE_CODE
WHERE ID_TYPE = 2 AND e.USER_NAME = :APP_USER_NAME;

-- ----------------------------------------
-- Page: 101 - Personal Infor Clone 1 > Page Item: P101_DOB > Default > SQL Query

select DOB from employees where USER_NAME = :APP_USER_NAME;

-- ----------------------------------------
-- Page: 101 - Personal Infor Clone 1 > Page Item: P101_EXP_WP_DATE > Default > SQL Query

SELECT EXPIRATION_DATE
FROM EMP_ID_NUMBER emp_id
INNER JOIN 
    EMPLOYEES e on e.EMPLOYEE_CODE = emp_id.EMPLOYEE_CODE
WHERE ID_TYPE = 2 AND e.USER_NAME = :APP_USER_NAME;

-- ----------------------------------------
-- Page: 101 - Personal Infor Clone 1 > Page Item: P101_SOC_INS_HOS_CODE > Default > SQL Query

select SOC_HOSPITAL_CODE from EMP_SOCICAL_INSURANCE EMP_SI where EMP_SI.EMPLOYEE_CODE = 
(select EMPLOYEE_CODE from EMPLOYEES where USER_NAME = :APP_USER_NAME  );

-- ----------------------------------------
-- Page: 101 - Personal Infor Clone 1 > Page Item: P101_ISSUE_DATE_ID > Default > SQL Query

SELECT
  CASE
    WHEN ISSUE_DATE = TO_DATE('1/1/1900', 'MM/DD/YYYY') THEN ''
    ELSE TO_CHAR(ISSUE_DATE, 'MM/DD/YYYY')
  END AS ISSUE_DATE
FROM EMP_ID_NUMBER emp_id
INNER JOIN 
    EMPLOYEES e on e.EMPLOYEE_CODE = emp_id.EMPLOYEE_CODE
WHERE ID_TYPE = 0 AND e.USER_NAME = :APP_USER_NAME;

-- ----------------------------------------
-- Page: 101 - Personal Infor Clone 1 > Page Item: P101_BANK_BRANCHR > Default > SQL Query

SELECT
    eb.BANK_BRANCH
FROM
    EMP_BANK eb
INNER JOIN
    EMPLOYEES e ON eb.EMPLOYEE_CODE = e.EMPLOYEE_CODE
WHERE 
    e.USER_NAME = :APP_USER_NAME;

-- ----------------------------------------
-- Page: 101 - Personal Infor Clone 1 > Page Item: P101_EME_PHONE_NUMBER > Default > SQL Query

select EME_PHONE_NUMBER from EMP_EMERGENCY_CONTACT EMP_EC where EMP_EC.EMPLOYEE_CODE = 
(select EMPLOYEE_CODE from EMPLOYEES where USER_NAME = :APP_USER_NAME  );

-- ----------------------------------------
-- Page: 101 - Personal Infor Clone 1 > Page Item: P101_EMPLOYEE_CODE > Default > SQL Query

select EMPLOYEE_CODE from employees where USER_NAME = :APP_USER_NAME;

-- ----------------------------------------
-- Page: 101 - Personal Infor Clone 1 > Page Item: P101_ISSUE_WP_DATE > Default > SQL Query

SELECT ISSUE_DATE
FROM EMP_ID_NUMBER emp_id
INNER JOIN 
    EMPLOYEES e on e.EMPLOYEE_CODE = emp_id.EMPLOYEE_CODE
WHERE ID_TYPE = 2 AND e.USER_NAME = :APP_USER_NAME;

-- ----------------------------------------
-- Page: 101 - Personal Infor Clone 1 > Page Item: P101_ISS_DATE_PIT_NUM > Default > SQL Query

SELECT ISSUE_DATE
FROM EMP_ID_NUMBER emp_id
INNER JOIN 
    EMPLOYEES e on e.EMPLOYEE_CODE = emp_id.EMPLOYEE_CODE
WHERE ID_TYPE = 3 AND e.USER_NAME = :APP_USER_NAME;

-- ----------------------------------------
-- Page: 101 - Personal Infor Clone 1 > Page Item: P101_SOC_INS_PRI_HEAL > Default > SQL Query

select PRI_HEAL_SERVICE from EMP_SOCICAL_INSURANCE EMP_SI where EMP_SI.EMPLOYEE_CODE = 
(select EMPLOYEE_CODE from EMPLOYEES where USER_NAME = :APP_USER_NAME  );

-- ----------------------------------------
-- Page: 101 - Personal Infor Clone 1 > Page Item: P101_BANK_NAME > Default > SQL Query

SELECT
    eb.BANK_NAME
FROM
    EMP_BANK eb
INNER JOIN
    EMPLOYEES e ON eb.EMPLOYEE_CODE = e.EMPLOYEE_CODE
WHERE 
    e.USER_NAME = :APP_USER_NAME;

-- ----------------------------------------
-- Page: 101 - Personal Infor Clone 1 > Page Item: P101_EME_RELATIONSHIP > Default > SQL Query

select RELATION_SHIP from EMP_EMERGENCY_CONTACT EMP_EC where EMP_EC.EMPLOYEE_CODE = 
(select EMPLOYEE_CODE from EMPLOYEES where USER_NAME = :APP_USER_NAME  );

-- ----------------------------------------
-- Page: 101 - Personal Infor Clone 1 > Page Item: P101_TEMP_ADDRESS > Default > SQL Query

select TEMPORARY_ADDRESS from employees where USER_NAME = :APP_USER_NAME;

-- ----------------------------------------
-- Page: 101 - Personal Infor Clone 1 > Page Item: P101_PLACE_DATE_ID_1 > Default > SQL Query

SELECT ISSUE_PLACE
FROM EMP_ID_NUMBER emp_id
INNER JOIN 
    EMPLOYEES e on e.EMPLOYEE_CODE = emp_id.EMPLOYEE_CODE
WHERE ID_TYPE = 1 AND e.USER_NAME = :APP_USER_NAME;

-- ----------------------------------------
-- Page: 101 - Personal Infor Clone 1 > Page Item: P101_EXP_DATE_ID_1 > Default > SQL Query

SELECT EXPIRATION_DATE
FROM EMP_ID_NUMBER emp_id
INNER JOIN 
    EMPLOYEES e on e.EMPLOYEE_CODE = emp_id.EMPLOYEE_CODE
WHERE ID_TYPE = 1 AND e.USER_NAME = :APP_USER_NAME;

-- ----------------------------------------
-- Page: 101 - Personal Infor Clone 1 > Page Item: P101_ISSUE_DATE_ID_1 > Default > SQL Query

-- SELECT ISSUE_DATE
-- FROM EMP_ID_NUMBER emp_id
-- INNER JOIN 
--     EMPLOYEES e on e.EMPLOYEE_CODE = emp_id.EMPLOYEE_CODE
-- WHERE ID_TYPE = 1 AND e.USER_NAME = :APP_USER_NAME 

SELECT
  CASE
    WHEN ISSUE_DATE = TO_DATE('1/1/1900', 'MM/DD/YYYY') THEN ''
    ELSE TO_CHAR(ISSUE_DATE, 'MM/DD/YYYY')
  END AS ISSUE_DATE
FROM EMP_ID_NUMBER emp_id
INNER JOIN 
    EMPLOYEES e on e.EMPLOYEE_CODE = emp_id.EMPLOYEE_CODE
WHERE ID_TYPE = 1 AND e.USER_NAME = :APP_USER_NAME;

-- ----------------------------------------
-- Page: 101 - Personal Infor Clone 1 > Page Item: P101_ID_PP_NUMBER_1 > Default > SQL Query

SELECT ID_NUMBER
FROM EMP_ID_NUMBER emp_id
INNER JOIN 
    EMPLOYEES e on e.EMPLOYEE_CODE = emp_id.EMPLOYEE_CODE
WHERE ID_TYPE = 1 AND e.USER_NAME = :APP_USER_NAME;

-- ----------------------------------------
-- Page: 101 - Personal Infor Clone 1 > Page Item: P101_PRIMARY_ADDRESS > Default > SQL Query

select PERMANENT_ADDRESS from employees where USER_NAME = :APP_USER_NAME;

-- ----------------------------------------
-- Page: 101 - Personal Infor Clone 1 > Page Item: P101_WP_NUMBER > Default > SQL Query

SELECT ID_NUMBER
FROM EMP_ID_NUMBER emp_id
INNER JOIN 
    EMPLOYEES e on e.EMPLOYEE_CODE = emp_id.EMPLOYEE_CODE
WHERE ID_TYPE = 2 AND e.USER_NAME = :APP_USER_NAME;

-- ----------------------------------------
-- Page: 101 - Personal Infor Clone 1 > Page Item: P101_ID_PP_NUMBER > Default > SQL Query

SELECT ID_NUMBER
FROM EMP_ID_NUMBER emp_id
INNER JOIN 
    EMPLOYEES e on e.EMPLOYEE_CODE = emp_id.EMPLOYEE_CODE
WHERE ID_TYPE = 0 AND e.USER_NAME = :APP_USER_NAME;

-- ----------------------------------------
-- Page: 101 - Personal Infor Clone 1 > Page Item: P101_PIT_NUMBER > Default > SQL Query

SELECT ID_NUMBER
FROM EMP_ID_NUMBER emp_id
INNER JOIN 
    EMPLOYEES e on e.EMPLOYEE_CODE = emp_id.EMPLOYEE_CODE
WHERE ID_TYPE = 3 AND e.USER_NAME = :APP_USER_NAME;

-- ----------------------------------------
-- Page: 101 - Personal Infor Clone 1 > Page Item: P101_SOC_INS_NUMBER > Default > SQL Query

select SOC_INS_NUMBER from EMP_SOCICAL_INSURANCE EMP_SI where EMP_SI.EMPLOYEE_CODE = 
(select EMPLOYEE_CODE from EMPLOYEES where USER_NAME = :APP_USER_NAME  );

-- ----------------------------------------
-- Page: 101 - Personal Infor Clone 1 > Page Item: P101_BANK_ACC_NUM > Default > SQL Query

SELECT
    eb.BANK_ACC_NUM
FROM
    EMP_BANK eb
INNER JOIN
    EMPLOYEES e ON eb.EMPLOYEE_CODE = e.EMPLOYEE_CODE
WHERE 
    e.USER_NAME = :APP_USER_NAME;

-- ----------------------------------------
-- Page: 101 - Personal Infor Clone 1 > Page Item: P101_EME_NAME > Default > SQL Query

select EME_FULL_NAME from EMP_EMERGENCY_CONTACT EMP_EC where EMP_EC.EMPLOYEE_CODE = 
(select EMPLOYEE_CODE from EMPLOYEES where USER_NAME = :APP_USER_NAME  );

-- ----------------------------------------
-- Page: 101 - Personal Infor Clone 1 > Page Item: P101_FULL_NAME > Default > SQL Query

select FULL_NAME from employees where USER_NAME = :APP_USER_NAME;

-- ----------------------------------------
-- Page: 101 - Personal Infor Clone 1 > Region: Other certificates > Source > SQL Query

select 
       cert.ID,
       cert.EMPLOYEE_ID,
       cert.CERTIFICATE_DESCRIPTION,
       cert.END_DATE,
       cert.START_DATE,  
       cert.SHORT_NOTE,     
       cert.CERTIFICATE_TYPE,
       '#' as Action
from EMP_CERTIFICATE cert
INNER JOIN 
    EMPLOYEES e ON cert.EMPLOYEE_CODE = e.EMPLOYEE_CODE
WHERE e.USER_NAME = :APP_USER_NAME;

