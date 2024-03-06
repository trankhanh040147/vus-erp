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
    l_count_temp_id NUMBER;
BEGIN    
    
    v_start_time := DBMS_UTILITY.GET_TIME;  -- Current time in 1/100ths of a second
    LOOP
        v_end_time := DBMS_UTILITY.GET_TIME;
        EXIT WHEN (v_end_time - v_start_time) > (1 * 100);  -- 5 seconds
    END LOOP;

    if :P10101_EMP_EDUCATION_ID IS NOT NULL AND :P10101_EMP_EDUCATION_ID != 't1000' then
        -- Update attachment in EMP_EDUCATION when ID is not null (existing record)
        UPDATE
            EMP_EDUCATION
        SET
            ATTACH_URL = :P10101_ATTACHMENT_URL,
            ATTACH_NAME = :P10101_ATTACHMENT_NAME
        WHERE ID = :P10101_EMP_EDUCATION_ID;
    else
        -- Insert/Update TEMP_UPLOAD when ID is null (new record)
        SELECT COUNT(*) INTO l_count_temp_id FROM TEMP_UPLOAD WHERE TEMP_ID = :P10101_TEMP_ID AND TABLE_NAME = 'EMP_EDUCATION';
        if l_count_temp_id > 0 then
            UPDATE
                TEMP_UPLOAD
            SET
                ATTACHMENT_URL = :P10101_ATTACHMENT_URL,
                ATTACHMENT_NAME = :P10101_ATTACHMENT_NAME
            WHERE TEMP_ID = :P10101_TEMP_ID AND TABLE_NAME = 'EMP_EDUCATION';
        else
            INSERT INTO TEMP_UPLOAD
            (
                TABLE_NAME,
                TEMP_ID,
                ATTACHMENT_URL,
                ATTACHMENT_NAME
            )
            SELECT
                'EMP_EDUCATION',
                :P10101_TEMP_ID,
                :P10101_ATTACHMENT_URL,
                :P10101_ATTACHMENT_NAME
            FROM
                DUAL;
        end if;
    end if;

    -- write log 

    -- *store P10101_ATTACHMENT_URL, P10101_ATTACHMENT_NAME
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
        :P10101_ATTACHMENT_URL,
        :P10101_ATTACHMENT_NAME,
        :P10101_EMPLOYEE_CODE,
        'EMP_EDUCATION',
        SYSDATE,
        'Upload file - P10101_ATTACHMENT_URL, P10101_ATTACHMENT_NAME',
        :P10101_EMP_EDUCATION_ID
    FROM
        DUAL;

    -- * store P10101_DEFAULT_IMAGES_URL, P10101_DEFAULT_IMAGES_NAME
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
        :P10101_DEFAULT_IMAGES_URL,
        :P10101_DEFAULT_IMAGES_NAME,
        :P10101_EMPLOYEE_CODE,
        'EMP_EDUCATION',
        SYSDATE,
        'Upload file - P10101_DEFAULT_IMAGES_URL, P10101_DEFAULT_IMAGES_NAME',
        :P10101_EMP_EDUCATION_ID
    FROM
        DUAL;
        
    COMMIT;

END;