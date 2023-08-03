select --ID,
       --EMPLOYEE_ID,
       emp.EMPLOYEE_CODE,
       emp.FIRST_NAME||' '||emp.LAST_NAME as Full_name,
       --PERSONAL_EMAIL,
       jd.NAME as Title,
       emp.PHONE_NUMBER,
       emp.USER_NAME as Email,
       emp.DOB,
       emp.HIDE_DATE as Start_date,
       eal.Leave_Entitlement as Annual_Leave_Entitlement,
       (eal.Used + eal.LEAVE_USED_OLD) as Annual_Used,
       (eal.Leave_Balance + eal.LEVEA_OLD_YEAR) as Annual_Leave_Balance,
       --HIDE_DATE,      
       --SALARY,
       --COMISSION_PCT,
       emp.MANAGER_ID,
       --DEPARTMENT_ID,
       --FULL_NAME,    
       --GENDER,
       --TERMINATE_DATE,
       --PERMANENT_ADDRESS,
       --TEMPORARY_ADDRESS,
       --EMERGENCY_CONTACT_ID,
       --AVATAR_ID,      
       emp.ROLE
       --CURRENT_LANG,
       --PERSON_TYPE
from EMPLOYEES emp join JOB_DETAIL jd on jd.id = emp.JOB_ID
--join EMPLOYEE_REQUESTS er on emp.EMPLOYEE_ID = er.REQUESTOR_ID
left join EMP_ANNUAL_LEAVE eal on emp.EMPLOYEE_ID = eal.EMPLOYEE_ID
where emp.MANAGER_POSITION_ID = :APP_POSITION_ID and emp.IS_DEL = 0
