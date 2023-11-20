-- TEMP_UPLOAD
-- ID	NUMBER(10,0)
-- TABLE_NAME	NVARCHAR2(30 CHAR)
-- TEMP_ID	NUMBER(10,0)
-- ATTACHMENT_URL	VARCHAR2(2000 CHAR)
-- ATTACHMENT_NAME	VARCHAR2(1000 CHAR)

DECLARE
    v_start_time NUMBER;
    v_end_time NUMBER;

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

    COMMIT;

END;


begin
            -- -- Update attachment for new row in EMP_EDUCATION from TEMP_UPLOAD through TEMP_ID
            -- Update EMP_EDUCATION edu
            -- set edu.ATTACH_NAME = (select att.ATTACHMENT_NAME from TEMP_UPLOAD att where att.TEMP_ID = edu.TEMP_ID),
            --     edu.ATTACH_URL = (select att.ATTACHMENT_URL from TEMP_UPLOAD att where att.TEMP_ID = edu.TEMP_ID)
            -- where edu.ID = add_ids(rec);

    -- Update attachment for new row in EMP_CERTIFICATE from TEMP_UPLOAD through TEMP_ID
    Update EMP_CERTIFICATE cert
    set cert.ATTACHMENT_NAME = (select att.ATTACHMENT_NAME from TEMP_UPLOAD att where att.TEMP_ID = cert.TEMP_ID),
        cert.ATTACHMENT_URL = (select att.ATTACHMENT_URL from TEMP_UPLOAD att where att.TEMP_ID = cert.TEMP_ID)
    where cert.ID = add_ids(rec);
end;