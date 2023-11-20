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
-- Page: 21 - DEMO_UPLOAD_FILE > Page Item: P21_DEFAULT_IMAGES_NAME > Default > SQL Query

SELECT ATTACHMENT_NAME from DEMO_UPLOAD_FILE where ID = :P21_ID;

-- ----------------------------------------
-- Page: 21 - DEMO_UPLOAD_FILE > Process: SUBMIT > Source > PL/SQL Code

-- DEMO_UPLOAD_FILE
-- ID	NUMBER(3,0)
-- ATTACHMENT_URL	NVARCHAR2(2000 CHAR)
-- ATTACHMENT_NAME	NVARCHAR2(500 CHAR)

-- table: LOGS_UPLOAD_FILE
-- ID	NUMBER
-- ATTACH_URL	CLOB
-- ATTACH_NAME	CLOB
-- EMPLOYEE_CODE	NVARCHAR2(30 CHAR)
-- TABLE_NAME	NVARCHAR2(30 CHAR)
-- TIMESTAMP	TIMESTAMP(6)
-- NOTE	NVARCHAR2(100 CHAR)

DECLARE
count_id NUMBER;

BEGIN
    select count(*) into count_id FROM DEMO_UPLOAD_FILE where ID = :P21_ID;

    -- :P21_ATTACHMENT_NAME
    -- :P21_ATTACHMENT_URL
    IF count_id = 0 THEN
        INSERT INTO DEMO_UPLOAD_FILE (ID, ATTACHMENT_URL, ATTACHMENT_NAME) VALUES (:P21_ID, :P21_ATTACHMENT_URL, :P21_ATTACHMENT_NAME);
    ELSE
        UPDATE DEMO_UPLOAD_FILE SET ATTACHMENT_URL = :P21_ATTACHMENT_URL, ATTACHMENT_NAME = :P21_ATTACHMENT_NAME WHERE ID = :P21_ID;
    END IF;

    -- Write logs into LOGS_UPLOAD_FILE
    INSERT INTO LOGS_UPLOAD_FILE (
        ATTACH_URL,
        ATTACH_NAME,
        EMPLOYEE_CODE,
        TABLE_NAME,
        TABLE_ID,
        TIMESTAMP,
        NOTE
    ) VALUES (
        :P21_ATTACHMENT_URL,
        :P21_ATTACHMENT_NAME,
        :APP_USER,
        'DEMO_UPLOAD_FILE',
        :P21_ID,
        SYSTIMESTAMP,
        'Upload file'
    );

END;

-- ----------------------------------------
-- Page: 21 - DEMO_UPLOAD_FILE > Page Item: P21_FULL_NAME > Default > SQL Query

select FULL_NAME from EMPLOYEES where EMPLOYEE_CODE = :APP_EMP_CODE;

-- ----------------------------------------
-- Page: 21 - DEMO_UPLOAD_FILE > Page Item: P21_DEFAULT_IMAGES_URL > Default > SQL Query

SELECT ATTACHMENT_URL from DEMO_UPLOAD_FILE where ID = :P21_ID;

