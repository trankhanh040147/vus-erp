-- DEMO_UPLOAD_FILE
-- ID	NUMBER(3,0)
-- ATTACHMENT_URL	NVARCHAR2(2000 CHAR)
-- ATTACHMENT_NAME	NVARCHAR2(500 CHAR)
DECLARE
    v_start_time NUMBER;
    v_end_time NUMBER;

BEGIN    
    
    v_start_time := DBMS_UTILITY.GET_TIME;  -- Current time in 1/100ths of a second
    LOOP
        v_end_time := DBMS_UTILITY.GET_TIME;
        EXIT WHEN (v_end_time - v_start_time) > (1 * 100);  -- 5 seconds
    END LOOP;


    UPDATE EMP_EDUCATION 
    SET ATTACH_URL = :P10101_ATTACHMENT_URL, 
        ATTACH_NAME = :P10101_ATTACHMENT_NAME 
    WHERE ID = :P10101_EMP_EDUCATION_ID;    

END;