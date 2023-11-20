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
-- Page: 28 - DEMO_EDUCATION_ATTACHMENT > Region: iGrid > Source > SQL Query

SELECT 
    edu.ID,
    edu.EMPLOYEE_ID,
    edu.TYPE,
    edu.LEVEL_OF_EDU,
    edu.MAJOR,
    edu.PLACE,
    edu.GRADUATED_DATE,
    -- edu.ATTACH_URL,
    -- edu.ATTACH_NAME,
    edu.EMPLOYEE_CODE,
    -- create a column ATTACHMENT to display a list of href link to download file with ATTACH_NAME and ATTACH_URL
    -- (SELECT LISTAGG('<a href="' || ATTACH_URL || '" target="_blank">' || ATTACH_NAME || '</a>', ', ') WITHIN GROUP (ORDER BY ATTACH_NAME) FROM EMP_EDUCATION WHERE ID = edu.ID) AS ATTACHMENT,
    '#' as Action
from EMP_EDUCATION edu where edu.IS_DEL = 0

-- SELECT 
--     edu.ID,
--     edu.EMPLOYEE_ID,
--     edu.TYPE,
--     edu.LEVEL_OF_EDU,
--     edu.MAJOR,
--     edu.PLACE,
--     edu.GRADUATED_DATE,
--     -- edu.ATTACH_FILE,
--     edu.ATTACH_NAME,
--     edu.EMPLOYEE_CODE,
--     --IS_DEL,
--     --EXPIRATION_DATE,
--     --EFFECTIVE_DATE,
--     '#' as Action
-- from EMP_EDUCATION edu where edu.IS_DEL = 0;

