-- *ajax call handle pattern
-- DECLARE
--     l_json_output CLOB;
--     v_parameter_in   VARCHAR2(1000);
--     v_result   VARCHAR2(1000);
-- BEGIN

--     v_parameter_in := :P10101_ATTACHMENT_URL;

--     INSERT INTO TABLE_DEMO_1(NAME) 
--     VALUES (v_parameter_in);
    
--    SELECT v_parameter_in || '-COMPLETED'

--     INTO v_result

--     FROM DUAL;

--     apex_json.open_object;

--     apex_json.write('success', true);

--     apex_json.write('result', v_result);

--     apex_json.close_object;

    

-- EXCEPTION WHEN OTHERS

-- THEN

--     apex_json.open_object;

--     apex_json.write('success', false);

--     apex_json.write('result', SQLERRM);

--     apex_json.close_object;
-- END;


DECLARE
    v_start_time NUMBER;
    v_end_time NUMBER;
    l_count_temp_id NUMBER;

    -- param inputs
    v_attachment_url VARCHAR2(1000) := :P10101_ATTACHMENT_URL;
    v_attachment_name VARCHAR2(1000) := :P10101_ATTACHMENT_NAME;
    v_emp_education_id VARCHAR2(1000) := :P10101_EMP_EDUCATION_ID;
    v_temp_id VARCHAR2(1000) := :P10101_TEMP_ID;

    -- json outputs and other variables
    v_json_output CLOB;
    v_result VARCHAR2(1000);
    v_error VARCHAR2(1000);

BEGIN    
    
    v_start_time := DBMS_UTILITY.GET_TIME;  -- Current time in 1/100ths of a second
    LOOP
        v_end_time := DBMS_UTILITY.GET_TIME;
        EXIT WHEN (v_end_time - v_start_time) > (1 * 100);  -- 5 seconds
    END LOOP;

    if v_emp_education_id IS NOT NULL AND v_emp_education_id != 't1000' then
        -- Update attachment in EMP_EDUCATION when ID is not null (existing record)
        UPDATE
            EMP_EDUCATION
        SET
            ATTACH_URL = v_attachment_url,
            ATTACH_NAME = v_attachment_name
        WHERE ID = v_emp_education_id;
    else
        -- Insert/Update TEMP_UPLOAD when ID is null (new record)
        SELECT COUNT(*) INTO l_count_temp_id FROM TEMP_UPLOAD WHERE TEMP_ID = :P10101_TEMP_ID AND TABLE_NAME = 'EMP_EDUCATION';
        if l_count_temp_id > 0 then
            UPDATE
                TEMP_UPLOAD
            SET
                ATTACHMENT_URL = v_attachment_url,
                ATTACHMENT_NAME = v_attachment_name
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
                v_attachment_url,
                v_attachment_name
            FROM
                DUAL;
        end if;
    end if;

    COMMIT;

    -- Return result as JSON 
    v_result := 'Attachment URL: ' || v_attachment_url || ' - COMPLETED';
    apex_json.open_object;
    apex_json.write('success', true);
    apex_json.write('result', v_result);
    apex_json.close_object;

EXCEPTION
    WHEN OTHERS THEN
        v_error := SQLERRM;
        apex_json.open_object;
        apex_json.write('success', false);
        apex_json.write('result', v_error);
        apex_json.close_object;

END;