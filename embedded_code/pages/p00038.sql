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
-- Page: 38 - New Scholarship > Region: Scholarship > Source > SQL Query

select --ROWID,
       ID,
       S_CODE,
       S_NAME,
       S_DESCRIPTION,
       S_MODIFIER_CODE,
       S_EFFECTIVE_DATE,
       S_EXPIRATION_DATE,
       S_MODIFIED_DATE,
       S_RECIPIENT_TYPE,
       SCHOLARSHIP_ID
from SCHOLARSHIP;

-- ----------------------------------------
-- Page: 38 - New Scholarship > Region: Detail > Column: SD_DISCOUNT_RATE > List of Values > SQL Query

select PROMOTION_NAME,ID from COREEDU_PROMOTION;

-- ----------------------------------------
-- Page: 38 - New Scholarship > Region: Detail > Column: SD_LEVEL > List of Values > SQL Query

select LEVEL_CODE,ID from LIST_LEVEL where DATA_AREA is not null;

-- ----------------------------------------
-- Page: 38 - New Scholarship > Dynamic Action: DA_DELETEROW > Action: Execute PLSQL > Settings > PL/SQL Code

Delete from WORKFLOW_CONDITION where id = :P38_CONDITION_ID;

-- ----------------------------------------
-- Page: 38 - New Scholarship > Page Item: P38_SCHOLARSHIP_ID > Default > SQL Query

select SCHOLARSHIP_ID.nextval from dual;

-- ----------------------------------------
-- Page: 38 - New Scholarship > Page Item: P38_S_CODE > Default > PL/SQL Function Body

DECLARE
   v_new_val VARCHAR2(50);
   this_year VARCHAR2(50);
BEGIN
   SELECT TO_CHAR(EXTRACT(YEAR FROM SYSDATE)) into this_year FROM DUAL;
   SELECT 'SCHOLARSHIP'|| this_year || '-' || LPAD(MAX(SCHOLARSHIP_NUM) + 1, 3, '0')
   INTO v_new_val
   FROM SCHOLARSHIP;
   
   IF :P38_S_CODE IS NULL THEN
      RETURN v_new_val;
   ELSE
      RETURN :P38_S_CODE;
   END IF;
END;


