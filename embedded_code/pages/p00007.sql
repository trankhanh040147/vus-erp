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
-- Page: 7 - My Leave History > Region: Top Content > Source > SQL Query

-- SELECT
--     CASE
--         WHEN age.CARRY_FORWORD_EXP_DATE >= TO_CHAR(SYSDATE, 'MM/DD/YYYY')
--             THEN to_char((age.PLAN_YEAR_ACCRUED + age.CARRY_FORWARD),'90.9')
--         ELSE to_char(age.PLAN_YEAR_ACCRUED,'90.9')
--     END AS LEAVE_ENTITLEMENT,
--     to_char(age.PLAN_YEAR_ACCRUED,'90.9') as PLAN_YEAR_ACCRUED,
--     CASE
--         WHEN age.CARRY_FORWORD_EXP_DATE >= TO_CHAR(SYSDATE, 'MM/DD/YYYY')
--             THEN to_char(age.CARRY_FORWARD,'90.9')
--         ELSE '0'
--     END AS CARRY_FORWARD,
--     to_char((age.PLAN_YEAR_USED + age.CARRY_FORWARD_USED),'90.9') AS ANPL_USED,
--     CASE
--         WHEN age.CARRY_FORWORD_EXP_DATE >= TO_CHAR(SYSDATE, 'MM/DD/YYYY')
--             THEN to_char(age.AVAILABLE + age.CARRY_FORWARD_AVALABLE,'90.9')
--         ELSE to_char(age.AVAILABLE,'90.9')
--     END AS ANPL_BALANCE
-- FROM
--     ABSENCE_GROUP_EMPLOYEE age
-- WHERE
--     age.EMPLOYEE_CODE = :APP_EMP_CODE
--     AND age.HRM_ABSENCE_CODE_GROUP_ID LIKE 'APL';



WITH DataValues AS (
    SELECT
        CASE
            WHEN age.CARRY_FORWORD_EXP_DATE >= TO_CHAR(SYSDATE, 'MM/DD/YYYY')
                THEN to_char((age.PLAN_YEAR_ACCRUED + age.CARRY_FORWARD),'90.9')
            ELSE to_char(age.PLAN_YEAR_ACCRUED,'90.9')
            -- ELSE to_char(LEAST(age.PLAN_YEAR_ACCRUED, MAXIMUM_ACCRUAL_LIMIT),'90.9')
        END AS LEAVE_ENTITLEMENT,
        -- to_char(LEAST(age.PLAN_YEAR_ACCRUED, MAXIMUM_ACCRUAL_LIMIT),'90.9') as PLAN_YEAR_ACCRUED,
        to_char(age.PLAN_YEAR_ACCRUED,'90.9') as PLAN_YEAR_ACCRUED,
        CASE
            WHEN age.CARRY_FORWORD_EXP_DATE >= TO_CHAR(SYSDATE, 'MM/DD/YYYY')
                THEN to_char(age.CARRY_FORWARD,'90.9')
            ELSE '0'
        END AS CARRY_FORWARD,
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
    FROM
        ABSENCE_GROUP_EMPLOYEE age
    WHERE
        age.EMPLOYEE_CODE = :APP_EMP_CODE
        AND age.HRM_ABSENCE_CODE_GROUP_ID LIKE 'APL'
)

-- First, select from DataValues if it has values
SELECT 
    LEAVE_ENTITLEMENT,
    PLAN_YEAR_ACCRUED,
    CARRY_FORWARD,
    ANPL_USED,
    ANPL_BALANCE
FROM DataValues

UNION ALL

-- If DataValues does not have any records, select default values
SELECT
    '0' AS LEAVE_ENTITLEMENT,
    '0' AS PLAN_YEAR_ACCRUED,
    '0' AS CARRY_FORWARD,
    '0' AS ANPL_USED,
    '0' AS ANPL_BALANCE
FROM dual
WHERE NOT EXISTS (SELECT 1 FROM DataValues);

-- ----------------------------------------
-- Page: 7 - My Leave History > Page Item: P7_END_DATE > Default > SQL Query

SELECT TO_CHAR(SYSDATE, 'DD/MM/YYYY') AS formatted_date FROM DUAL;

-- ----------------------------------------
-- Page: 7 - My Leave History > Page Item: P7_FROM_DATE > Default > SQL Query

SELECT TRUNC(SYSDATE, 'YEAR') AS first_day_of_current_year FROM DUAL;

-- ----------------------------------------
-- Page: 7 - My Leave History > Region: Detail > Source > SQL Query

select er.ID,
       CASE
           WHEN er.LEAVE_TYPE = 'APL' THEN 'Leave'
           ELSE to_char(er.LEAVE_TYPE)
       END AS TYPE,
       er.REQUESTOR_ID,
       er.REQUEST_ID,
       er.EMPLOYEE_CODE_REQ,
       er.EMPLOYEE_NAME,
       er.ALL_DAY,
       er.FROM_DATE,
       er.END_DATE,
       er.NOTE,
       er.TOTAL_DAYS,
       s.status as STATUS,
        case er.emp_req_status
        when 2 then
        'Delete' 
        else
        null
        end as Action,
       case er.is_d365
       when 1 then '<span class="fa fa-check"></span>'
       else
       null
       end as hr_update
  from EMPLOYEE_REQUESTS er
  join STATUS s on er.emp_req_status = s.id
  where er.IS_DEL = 0 and er.EMPLOYEE_CODE_REQ = :APP_EMP_CODE
  and FROM_DATE between to_date(:P7_FROM_DATE,'DD/MM/YYYY') and to_date(:P7_END_DATE,'DD/MM/YYYY')
  AND ( :P7_STATUS = 99 OR er.emp_req_status = :P7_STATUS);

-- ----------------------------------------
-- Page: 7 - My Leave History > Region: Detail_BK > Source > SQL Query

select er.ID,
       CASE
           WHEN er.LEAVE_TYPE = 'APL' THEN 'Leave'
           ELSE to_char(er.LEAVE_TYPE)
       END AS TYPE,
       er.REQUESTOR_ID,
       er.REQUEST_ID,
       er.EMPLOYEE_CODE_REQ,
       er.EMPLOYEE_NAME,
       er.ALL_DAY,
       er.FROM_DATE,
       er.END_DATE,
       er.NOTE,
       er.TOTAL_DAYS,
       s.status as STATUS,
        case er.emp_req_status
        when 2 then
        'Delete' 
        else
        null
        end as Action
  from EMPLOYEE_REQUESTS er
  join STATUS s on er.emp_req_status = s.id
  where er.IS_DEL = 0 and er.EMPLOYEE_CODE_REQ = :APP_EMP_CODE
  and to_date(FROM_DATE,'MM/DD/YYYY') between to_date(:P7_FROM_DATE,'MM/DD/YYYY') and to_date(:P7_END_DATE,'MM/DD/YYYY')
  and :P7_STATUS = 99
  union
  select er.ID,
       CASE
           WHEN er.LEAVE_TYPE = 'APL' THEN 'Leave'
           ELSE to_char(er.LEAVE_TYPE)
       END AS TYPE,
       er.REQUESTOR_ID,
       er.REQUEST_ID,
       er.EMPLOYEE_CODE_REQ,
       er.EMPLOYEE_NAME,
       er.ALL_DAY,
       er.FROM_DATE,
       er.END_DATE,
       er.NOTE,
       er.TOTAL_DAYS,
       s.status as STATUS,
        case er.emp_req_status
        when 2 then
        'Delete' 
        else
        null
        end as Action
  from EMPLOYEE_REQUESTS er
  join STATUS s on er.emp_req_status = s.id
  where er.IS_DEL = 0 and er.EMPLOYEE_CODE_REQ = :APP_EMP_CODE
  and to_date(FROM_DATE,'MM/DD/YYYY') between to_date(:P7_FROM_DATE,'MM/DD/YYYY') and to_date(:P7_END_DATE,'MM/DD/YYYY')
  and :P7_STATUS = er.emp_req_status
  and :P7_STATUS <> 99;

-- ----------------------------------------
-- Page: 7 - My Leave History > Region: Top Content > Source > PL/SQL Function Body returning SQL Query

return q'~
    select nvl(sum(AVAILABLE),0) as TOTAL_AL
    from ABSENCE_GROUP_EMPLOYEE emp_al
    INNER JOIN EMPLOYEES e ON emp_al.EMPLOYEE_CODE = e.EMPLOYEE_CODE
    where e.USER_NAME = :APP_USER_NAME and HRM_ABSENCE_CODE_GROUP_ID = 'APL' and EXPIRATION_DATE >= to_char(sysdate,'MM/DD/YYYY');
~';

return q'~
    select nvl(sum(CARRY_FORWARD),0) as TOTAL_CF
    from ABSENCE_GROUP_EMPLOYEE emp_al
    INNER JOIN EMPLOYEES e ON emp_al.EMPLOYEE_CODE = e.EMPLOYEE_CODE
    where e.USER_NAME = :APP_USER_NAME and HRM_ABSENCE_CODE_GROUP_ID = 'APL' and EXPIRATION_DATE >= to_char(sysdate,'MM/DD/YYYY');
~';


-- ----------------------------------------
-- Page: 7 - My Leave History > Region: Top Content > Server-side Condition (Function Body) > PL/SQL Function Body

begin
----tam dong
return false;
end;

