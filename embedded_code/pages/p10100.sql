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
-- Page: 10100 - TEST FORM > Dynamic Action: Load Employee Data > Action: Execute Server-side Code > Settings > PL/SQL Code

DECLARE
l_json_data JSON_OBJECT_T := JSON_OBJECT_T();
BEGIN
    FOR emp IN (SELECT ID, S_CODE, SD_SENIORITY_FROM, SD_SENIORITY_TO FROM SCHOLARSHIP_DETAIL) LOOP
        l_json_data.PUT('ID', emp.ID);
        l_json_data.PUT('S_CODE', emp.S_CODE);
        l_json_data.PUT('SD_SENIORITY_FROM', emp.SD_SENIORITY_FROM);
        l_json_data.PUT('SD_SENIORITY_TO', emp.SD_SENIORITY_TO);
        DBMS_OUTPUT.PUT_LINE(l_json_data.TO_STRING());
    END LOOP;

    -- :P10100_DATA_JSON := l_json_data.TO_STRING();
    -- return l_json_data.TO_STRING();
    -- DBMS_OUTPUT.PUT_LINE(l_json_data.TO_STRING());
END;

-- ----------------------------------------
-- Page: 10100 - TEST FORM > Process: Save when submit > Source > PL/SQL Code

DECLARE
-- temp nvarchar2(20);
begin
    -- temp = to_char(:P10100_DAY, 'DD-MM-YYYY');
    insert into TABLE_DEMO_1 (
        NAME, GENDER, DATE_BIRTH
    ) values (
        :P10100_NAME, :P10100_GENDER, TO_DATE(:P10100_DAY, 'DD/MM/YYYY')--TO_DATE(TO_CHAR(TO_DATE(:P10100_DAY, 'DD/MM/YYYY'), 'MM/DD/YYYY'), 'MM/DD/YYYY')
    );
end;

