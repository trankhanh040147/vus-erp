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
-- Page: 32 - TEST_EDUCAITON > Region: education_grid > Source > SQL Query

SELECT 
    edu.ID,
    edu.EMPLOYEE_ID,
    edu.TYPE,
    edu.LEVEL_OF_EDU,
    edu.MAJOR,
    edu.PLACE,
    edu.GRADUATED_DATE,
    edu.ATTACH_FILE,
    edu.EMPLOYEE_CODE,
    --IS_DEL,
    --EXPIRATION_DATE,
    --EFFECTIVE_DATE,
    '#' as Action,
    '<span><i class="fa fa-upload"></span>' as Upload,
    TO_HREF_HTML_ATTACHMENT(edu.ATTACH_URL, edu.ATTACH_NAME) as edu_attachment,
    edu.TEMP_ID,
    '<span class="t-Icon fa fa-gears change-status" aria-hidden="true"></span>' LINKCOLUMN

from EMP_EDUCATION edu where edu.EMPLOYEE_CODE = :APP_EMP_CODE and edu.IS_DEL = 0
/*
INNER JOIN 
  EMPLOYEES e ON edu.EMPLOYEE_CODE = e.EMPLOYEE_CODE
WHERE e.USER_NAME = :APP_USER_NAME and edu.IS_DEL = 0
*/;

