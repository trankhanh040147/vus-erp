select --ID,
       --EMPLOYEE_ID,
       emp.EMPLOYEE_CODE,
       emp.FIRST_NAME||' '||emp.LAST_NAME as Full_name,
       --PERSONAL_EMAIL,
       emp.PHONE_NUMBER,
       emp.USER_NAME as Email,
       emp.DOB,
       emp.START_DATE as Start_date,
from EMPLOYEES emp
where emp.MANAGER_ID = (SELECT EMPLOYEE_CODE FROM EMPLOYEES ee WHERE ee.USER_NAME = :APP_USER_NAME )