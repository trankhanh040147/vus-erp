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
-- Page: 8 - Staff List > Region: Detail > Source > SQL Query

-- SELECT
--     -- columns from EMPLOYEES table
--     emp.EMPLOYEE_CODE,
--     emp.FULL_NAME,
--     CASE 
--         WHEN emp.GENDER = '1' THEN 'Male'
--         WHEN emp.GENDER = '2' THEN 'Female'
--         ELSE 'Other'
--     END AS GENDER,
--     emp.TITLE,
--     emp.PHONE_NUMBER,
--     emp.USER_NAME as Email,
--     emp.DOB,
--     CASE 
--         WHEN emp.DATAAREA = 'V01' THEN 'Hồ Chí Minh'
--         WHEN emp.DATAAREA = 'V02' THEN 'Hà Nội'
--     END AS LEGAL_ENTITY,
--     emp.START_DATE as Start_date,
--     CASE
--         WHEN emp.TERMINATE_DATE = '12/31/2154' THEN 'Never'
--     END AS TERMINATE_DATE,
--     (PLAN_YEAR_ACCRUED + CARRY_FORWARD) as LEAVE_ENTITLEMENT,
--     (PLAN_YEAR_USED + CARRY_FORWARD_USED) as ANPL_USEDED,
--     (AVAILABLE + CARRY_FORWARD_AVALABLE) as ANPL_BALANCE
-- FROM EMPLOYEES emp
-- JOIN ABSENCE_GROUP_EMPLOYEE AGE ON emp.EMPLOYEE_CODE = AGE.EMPLOYEE_CODE
-- WHERE emp.MANAGER_ID = (SELECT EMPLOYEE_CODE FROM EMPLOYEES ee WHERE ee.USER_NAME = :APP_USER_NAME ) AND HRM_ABSENCE_CODE_ID LIKE 'ALPL%';


SELECT
    -- columns from EMPLOYEES table
    emp.EMPLOYEE_CODE,
    emp.FULL_NAME,
    CASE 
        WHEN emp.GENDER = '1' THEN 'Male'
        WHEN emp.GENDER = '2' THEN 'Female'
        ELSE 'Other'
    END AS GENDER,
    emp.TITLE,
    emp.PHONE_NUMBER,
    emp.USER_NAME as Email,
    emp.DOB,
    CASE 
        WHEN emp.DATAAREA = 'V01' THEN 'Hồ Chí Minh'
        WHEN emp.DATAAREA = 'V02' THEN 'Hà Nội'
    END AS LEGAL_ENTITY,
    emp.START_DATE as Start_date,
    CASE
        WHEN emp.TERMINATE_DATE = '12/31/2154' THEN 'Never'
    END AS TERMINATE_DATE,
    CASE
            WHEN age.CARRY_FORWORD_EXP_DATE >= TO_CHAR(SYSDATE, 'MM/DD/YYYY')
                THEN to_char((age.PLAN_YEAR_ACCRUED + age.CARRY_FORWARD),'90.9')
            ELSE to_char(age.PLAN_YEAR_ACCRUED,'90.9')
            -- ELSE to_char(LEAST(age.PLAN_YEAR_ACCRUED, MAXIMUM_ACCRUAL_LIMIT),'90.9')
    END AS LEAVE_ENTITLEMENT,
        CASE
            WHEN age.CARRY_FORWORD_EXP_DATE >= TO_CHAR(SYSDATE, 'MM/DD/YYYY')
                THEN to_char((age.PLAN_YEAR_USED + age.CARRY_FORWARD_USED),'90.9')
            ELSE to_char(age.PLAN_YEAR_USED,'90.9')
        END AS ANPL_USED,
    CASE
            WHEN age.CARRY_FORWORD_EXP_DATE >= TO_CHAR(SYSDATE, 'MM/DD/YYYY')
                THEN to_char(age.AVAILABLE + age.CARRY_FORWARD_AVALABLE,'90.9')
            ELSE to_char(age.AVAILABLE,'90.9')
    END AS ANPL_BALANCE
FROM EMPLOYEES emp
JOIN ABSENCE_GROUP_EMPLOYEE AGE ON emp.EMPLOYEE_CODE = AGE.EMPLOYEE_CODE
WHERE emp.MANAGER_ID = (SELECT EMPLOYEE_CODE FROM EMPLOYEES ee WHERE ee.USER_NAME = :APP_USER_NAME ) AND HRM_ABSENCE_CODE_ID LIKE 'ALPL%';

