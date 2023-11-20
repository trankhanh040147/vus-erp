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
-- Page: 10102 - EMP_CERTIFICATE_UPLOAD_FILE > Page Item: P10102_DEFAULT_IMAGES_NAME > Default > SQL Query

SELECT CASE
    WHEN :P10102_EMP_CERTIFICATE_ID IS NOT NULL AND :P10102_EMP_CERTIFICATE_ID != 't1000' THEN
        (SELECT ATTACHMENT_NAME FROM EMP_CERTIFICATE WHERE ID = :P10102_EMP_CERTIFICATE_ID)
    ELSE (SELECT ATTACHMENT_NAME FROM TEMP_UPLOAD WHERE TEMP_ID = to_number(:P10102_TEMP_ID) AND TABLE_NAME = 'EMP_CERTIFICATE')
END AS ATTACHMENT_NAME
FROM DUAL;

-- ----------------------------------------
-- Page: 10102 - EMP_CERTIFICATE_UPLOAD_FILE > Process: SUBMIT > Source > PL/SQL Code

-- TEMP_UPLOAD
-- ID	NUMBER(10,0)
-- TABLE_NAME	NVARCHAR2(30 CHAR)
-- TEMP_ID	NUMBER(10,0)
-- ATTACHMENT_URL	VARCHAR2(2000 CHAR)
-- ATTACHMENT_NAME	VARCHAR2(1000 CHAR)

-- LOGS_UPLOAD_FILE
-- ID	NUMBER
-- ATTACH_URL	CLOB
-- ATTACH_NAME	CLOB
-- EMPLOYEE_CODE	NVARCHAR2(30 CHAR)
-- TABLE_NAME	NVARCHAR2(30 CHAR)
-- TIMESTAMP	TIMESTAMP(6)
-- NOTE	NVARCHAR2(100 CHAR)
-- TABLE_ID	NUMBER(7,0)

DECLARE
    v_start_time NUMBER;
    v_end_time NUMBER;
    l_count_temp_id number;
BEGIN    
    
    v_start_time := DBMS_UTILITY.GET_TIME;  -- Current time in 1/100ths of a second
    LOOP
        v_end_time := DBMS_UTILITY.GET_TIME;
        EXIT WHEN (v_end_time - v_start_time) > (1 * 100);  -- 5 seconds
    END LOOP;

    -- if :P10101_EMP_EDUCATION_ID IS NOT NULL AND :P10101_EMP_EDUCATION_ID != 't1000' then
    --     -- Update attachment in EMP_EDUCATION when ID is not null (existing record)
    --     UPDATE
    --         EMP_EDUCATION
    --     SET
    --         ATTACH_URL = :P10101_ATTACHMENT_URL,
    --         ATTACH_NAME = :P10101_ATTACHMENT_NAME
    --     WHERE ID = :P10101_EMP_EDUCATION_ID;
    -- else
    --     -- Insert/Update TEMP_UPLOAD when ID is null (new record)
    --     SELECT COUNT(*) INTO l_count_temp_id FROM TEMP_UPLOAD WHERE TEMP_ID = :P10101_TEMP_ID AND TABLE_NAME = 'EMP_EDUCATION';
    --     if l_count_temp_id > 0 then
    --         UPDATE
    --             TEMP_UPLOAD
    --         SET
    --             ATTACHMENT_URL = :P10101_ATTACHMENT_URL,
    --             ATTACHMENT_NAME = :P10101_ATTACHMENT_NAME
    --         WHERE TEMP_ID = :P10101_TEMP_ID AND TABLE_NAME = 'EMP_EDUCATION';
    --     else
    --         INSERT INTO TEMP_UPLOAD
    --         (
    --             TABLE_NAME,
    --             TEMP_ID,
    --             ATTACHMENT_URL,
    --             ATTACHMENT_NAME
    --         )
    --         SELECT
    --             'EMP_EDUCATION',
    --             :P10101_TEMP_ID,
    --             :P10101_ATTACHMENT_URL,
    --             :P10101_ATTACHMENT_NAME
    --         FROM
    --             DUAL;
    --     end if;
    -- end if;
     
    IF :P10102_EMP_CERTIFICATE_ID IS NOT NULL AND :P10102_EMP_CERTIFICATE_ID != 't1000' THEN
        -- Update attachment in EMP_CERTIFICATE when ID is not null (existing record)
        UPDATE EMP_CERTIFICATE 
        SET ATTACHMENT_URL = :P10102_ATTACHMENT_URL, 
            ATTACHMENT_NAME = :P10102_ATTACHMENT_NAME 
        WHERE ID = :P10102_EMP_CERTIFICATE_ID;
    ELSE
        -- Insert/Update TEMP_UPLOAD when ID is null (new record)
        SELECT COUNT(*) INTO l_count_temp_id FROM TEMP_UPLOAD WHERE TEMP_ID = :P10102_TEMP_ID AND TABLE_NAME = 'EMP_CERTIFICATE';
        IF l_count_temp_id > 0 THEN
            UPDATE TEMP_UPLOAD 
            SET ATTACHMENT_URL = :P10102_ATTACHMENT_URL, 
                ATTACHMENT_NAME = :P10102_ATTACHMENT_NAME 
            WHERE TEMP_ID = :P10102_TEMP_ID AND TABLE_NAME = 'EMP_CERTIFICATE';
        ELSE
            INSERT INTO TEMP_UPLOAD 
            (
                TABLE_NAME, 
                TEMP_ID, 
                ATTACHMENT_URL, 
                ATTACHMENT_NAME
            ) 
            SELECT 
                'EMP_CERTIFICATE', 
                :P10102_TEMP_ID, 
                :P10102_ATTACHMENT_URL, 
                :P10102_ATTACHMENT_NAME 
            FROM DUAL;
        END IF;
    END IF;

    -- write logs 
    INSERT INTO LOGS_UPLOAD_FILE
    (
        ATTACH_URL,
        ATTACH_NAME,
        EMPLOYEE_CODE,
        TABLE_NAME,
        TIMESTAMP,
        NOTE,
        TABLE_ID
    )
    SELECT
        :P10102_ATTACHMENT_URL,
        :P10102_ATTACHMENT_NAME,
        :P10102_EMPLOYEE_CODE,
        'EMP_CERTIFICATE',
        SYSDATE,
        'page 10102',
        :P10102_EMP_CERTIFICATE_ID
    FROM DUAL;

    COMMIT;

END;
-- ----------------------------------------
-- Page: 10102 - EMP_CERTIFICATE_UPLOAD_FILE > Page Item: P10102_FULL_NAME > Default > SQL Query

select FULL_NAME from EMPLOYEES where EMPLOYEE_CODE = :P10102_EMPLOYEE_CODE;

-- ----------------------------------------
-- Page: 10102 - EMP_CERTIFICATE_UPLOAD_FILE > Page Item: P10102_DEFAULT_IMAGES_URL > Default > SQL Query

SELECT CASE
    WHEN :P10102_EMP_CERTIFICATE_ID IS NOT NULL AND :P10102_EMP_CERTIFICATE_ID != 't1000' THEN
        (SELECT ATTACHMENT_URL FROM EMP_CERTIFICATE WHERE ID = :P10102_EMP_CERTIFICATE_ID)
    ELSE (SELECT ATTACHMENT_URL FROM TEMP_UPLOAD WHERE TEMP_ID = to_number(:P10102_TEMP_ID) AND TABLE_NAME = 'EMP_CERTIFICATE')
END AS ATTACHMENT_URL
FROM DUAL;

