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
-- Page: 18 - New workflow > Region: Aprroval_Workflow > Source > SQL Query

SELECT 
       WF_PROCESS_ID,
       WA_ID,
       WA_SEQUENCE_NUMBER,
       WA_GROUP,
       WA_USER,
       WA_TEMPLATE_EMAIL_ID
FROM WORKFLOW_APPROVAL
WHERE WF_PROCESS_ID = :P18_WF_PROCESS_ID;

-- ----------------------------------------
-- Page: 18 - New workflow > Region: Aprroval_Workflow > Column: WA_USER > List of Values > SQL Query

SELECT USER_NAME, e.ID AS ID
FROM EMPLOYEES e 
where USER_NAME is not NULL;

-- ----------------------------------------
-- Page: 18 - New workflow > Process: Update WORKFLOW > Source > PL/SQL Code

Update WORKFLOW
Set
    WF_NAME = :P18_WF_NAME,
    WF_DESCRIPTION = :P18_WF_DESCRIPTION,
    WF_FEATURE_APPLY = :P18_WF_FEATURE_APPLY,
    WF_MODIFIER_CODE = :APP_EMP_CODE,
    WF_EFFECTIVE_DATE = :P18_WF_EFFECTIVE_DATE,
    WF_EXPIRATION_DATE = :P18_WF_EXPIRATION_DATE
Where
    ID = :P18_ID;

-- ----------------------------------------
-- Page: 18 - New workflow > Dynamic Action: Add Approval > Action: Increase Total_Approval > Settings > SQL Statement

SELECT :TOTAL_APPROVAL + 1 FROM DUAL;

-- ----------------------------------------
-- Page: 18 - New workflow > Dynamic Action: Gen Sequence Number > Action: Gen Sequence Number > Settings > SQL Statement

SELECT :TOTAL_APPROVAL + 1 FROM DUAL;

-- ----------------------------------------
-- Page: 18 - New workflow > Dynamic Action: DA_DELETEROW > Action: Execute PLSQL > Settings > PL/SQL Code

Delete from WORKFLOW_CONDITION where id = :P18_CONDITION_ID;

-- ----------------------------------------
-- Page: 18 - New workflow > Page Item: P18_WORKFLOW_NUMBER > Default > SQL Query

SELECT MAX(WORKFLOW_NO) + 1 FROM WORKFLOW;

-- ----------------------------------------
-- Page: 18 - New workflow > Page Item: P18_WF_DESCRIPTION > Default > SQL Query

SELECT WF_DESCRIPTION FROM  WORKFLOW 
WHERE WF_PROCESS_ID = :P18_WF_PROCESS_ID;

-- ----------------------------------------
-- Page: 18 - New workflow > Page Item: P18_WF_NAME > Default > SQL Query

SELECT WF_NAME FROM  WORKFLOW 
WHERE WF_PROCESS_ID = :P18_WF_PROCESS_ID;

-- ----------------------------------------
-- Page: 18 - New workflow > Page Item: P18_WF_EXPIRATION_DATE > Default > SQL Query

SELECT WF_EXPIRATION_DATE FROM  WORKFLOW 
WHERE WF_PROCESS_ID = :P18_WF_PROCESS_ID;

-- ----------------------------------------
-- Page: 18 - New workflow > Page Item: P18_WF_EFFECTIVE_DATE > Default > SQL Query

SELECT WF_EFFECTIVE_DATE FROM  WORKFLOW 
WHERE WF_PROCESS_ID = :P18_WF_PROCESS_ID;

-- ----------------------------------------
-- Page: 18 - New workflow > Page Item: P18_WF_PROCESS_ID > Default > PL/SQL Function Body

DECLARE
   v_new_val VARCHAR2(50);
   this_year VARCHAR2(50);
BEGIN
   SELECT TO_CHAR(EXTRACT(YEAR FROM SYSDATE)) into this_year FROM DUAL;
   SELECT 'WORKFLOW' || this_year || '-' || LPAD(MAX(WORKFLOW_NO) + 1, 3, '0')
   INTO v_new_val
   FROM Workflow;
   
   IF :P18_WF_PROCESS_ID IS NULL THEN
      RETURN v_new_val;
   ELSE
      RETURN :P18_WF_PROCESS_ID;
   END IF;
END;


-- ----------------------------------------
-- Page: 18 - New workflow > Page Item: P18_WF_FEATURE_APPLY > Default > SQL Query

SELECT WF_FEATURE_APPLY FROM  WORKFLOW 
WHERE WF_PROCESS_ID = :P18_WF_PROCESS_ID;

