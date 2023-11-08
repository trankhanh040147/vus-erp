-- ORACLE APEX 23.1.5
-- TABLE: EMP_EDUCATION
-- ID	NUMBER(10,0)
-- EMPLOYEE_ID	NUMBER(10,0)
-- TYPE	NVARCHAR2(100 CHAR)
-- LEVEL_OF_EDU	NCHAR(50 CHAR)
-- MAJOR	NVARCHAR2(100 CHAR)
-- PLACE	NVARCHAR2(500 CHAR)
-- GRADUATED_DATE	DATE
-- ATTACH_FILE	NVARCHAR2(100 CHAR)
-- IS_DEL	NUMBER(2,0)
-- EXPIRATION_DATE	DATE
-- EFFECTIVE_DATE	DATE
-- CERTIFICATE_NAME	NVARCHAR2(100 CHAR)
-- EMPLOYEE_CODE	NVARCHAR2(100 CHAR)
-- PRIMARY_EDUCATION	NUMBER(1,0)
-- ATTACH_NAME	VARCHAR2(1000 BYTE)
-- REC_ID	NVARCHAR2(50 CHAR)
-- DISCIPLINE_ID	NVARCHAR2(30 CHAR)
-- INSTITUTION_ID	NVARCHAR2(10 CHAR)
-- ATTACH_URL	NVARCHAR2(2000 CHAR)

-- Create a json array of objects from EMP_EDUCATION
SELECT JSON_ARRAYAGG(
    JSON_OBJECT(
        'id' VALUE ID,
        'employee_id' VALUE EMPLOYEE_ID,
        'type' VALUE TYPE,
        'level_of_edu' VALUE LEVEL_OF_EDU,
        'major' VALUE MAJOR,
        'place' VALUE PLACE,
        'graduated_date' VALUE GRADUATED_DATE,
        'attach_file' VALUE ATTACH_FILE,
        'is_del' VALUE IS_DEL,
        'expiration_date' VALUE EXPIRATION_DATE,
        'effective_date' VALUE EFFECTIVE_DATE,
        'certificate_name' VALUE CERTIFICATE_NAME,
        'employee_code' VALUE EMPLOYEE_CODE,
        'primary_education' VALUE PRIMARY_EDUCATION,
        'attach_name' VALUE ATTACH_NAME,
        'rec_id' VALUE REC_ID,
        'discipline_id' VALUE DISCIPLINE_ID,
        'institution_id' VALUE INSTITUTION_ID,
        'attach_url' VALUE ATTACH_URL
    )
) as json_data
FROM EMP_EDUCATION
WHERE EMPLOYEE_CODE = :APP_EMP_CODE

-- Loop through the json array and insert into the table
declare
    emp_education_id number;
    l_numrows number;
begin
    -- Data from json item :P5_EMP_CURRENT_EDUCATION is old data, data from the current table is new one.
    -- So we need to compare the data from json item and the current table to determine which data is new, which data is deleted and which data is updated.

    APEX_JSON.PARSE(:P5_EMP_CURRENT_EDUCATION);
    l_numrows := APEX_JSON.GET_COUNT(p_path => '.');
    if l_numrows > 0 then
        for i in 1..l_numrows loop
            emp_education_id := to_number(APEX_JSON.get_varchar2(p_path => '[%d].id', p0 => i));

            
        end loop;
    end if;
end;
    