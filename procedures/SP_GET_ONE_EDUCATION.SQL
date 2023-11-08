create or replace PROCEDURE "SP_GET_ONE_EDUCATION"
(
    p_employee_code nvarchar2
)
is
l_token_type NVARCHAR2(2000);
l_access_token NVARCHAR2(2000);
l_body NVARCHAR2(2000);
l_response_clob clob;
l_authorization NVARCHAR2(2000);
l_response clob;
l_numrow number;
l_count_idemp number;
l_count_iduser number;
l_body_json clob;

n_id NUMBER;
n_primary NUMBER;
n_employee_id NUMBER;
n_PrimaryEducation NUMBER;
n_code NVARCHAR2(100 CHAR);
n_level_edu_description NVARCHAR2(2000);
n_level_of_edu NVARCHAR2(100 CHAR);
n_major NVARCHAR2(100 CHAR);
n_school_name VARCHAR2(2000);
n_end_date DATE;
n_rec_id NVARCHAR2(50 CHAR);
n_DisciplineId NVARCHAR2(30 CHAR);
n_InstitutionId NVARCHAR2(10 CHAR);
p_token NVARCHAR2(10000);
BEGIN
    SP_GET_TOKEN(p_token);

    apex_web_service.g_request_headers.delete();
    apex_web_service.g_request_headers(1).name := 'Content-Type';
    apex_web_service.g_request_headers(1).value := 'application/json';
    apex_web_service.g_request_headers(2).name := 'Content-Length';
    apex_web_service.g_request_headers(2).value := 0;
    apex_web_service.g_request_headers(3).name := 'Authorization';
    apex_web_service.g_request_headers(3).value := 'Bearer '|| p_token;
    --apex_web_service.g_request_headers(4).name := 'Content-Type';
    --apex_web_service.g_request_headers(4).value := 'application/json';
    APEX_JSON.parse(

    apex_web_service.make_rest_request(
            p_url => global_vars.get_resource_url || '/api/services/HRPortalServices/EmployeeProfileService/getListEducation',
            p_http_method => 'POST',
            p_transfer_timeout => 3600
            ) --;
    );

    -- Delete from EMP_EDUCATION where EMPLOYEE_CODE = p_employee_code;

    l_numrow := APEX_JSON.get_count (p_path =>'.'); --Đếm tổng số chuỗi trả về
    
    FOR i IN 1 .. l_numrow
    LOOP
        n_id := TO_NUMBER(apex_json.get_varchar2('[%d].$id', i));
        n_employee_id := i;
        n_code := apex_json.get_varchar2('[%d].EmployeeCode', i);
        n_level_edu_description := apex_json.get_varchar2('[%d].LevelOfEduDescription', i);
       
        n_level_of_edu := apex_json.get_varchar2('[%d].HcmEducationLevelId', i);
        -- n_level_of_edu := 1;

        n_major := apex_json.get_varchar2('[%d].VUSTC_Major', i);
        n_school_name := apex_json.get_varchar2('[%d].NameOfSchool', i);
        n_end_date := CASE WHEN apex_json.get_varchar2('[%d].EndDate', i) LIKE '%1900-01-01%' THEN NULL ELSE TO_CHAR(TO_DATE(apex_json.get_varchar2('[%d].EndDate', i), 'YYYY-MM-DD"T"HH24:MI:SS'), 'MM/DD/YYYY') END;
        n_primary := TO_NUMBER(apex_json.get_varchar2('[%d].PrimaryEducation', i));
        -- "EducationRecId": 5637174580
        n_rec_id := apex_json.get_varchar2('[%d].EducationRecId', i); 
        n_DisciplineId := apex_json.get_varchar2('[%d].DisciplineId', i);
        n_InstitutionId := apex_json.get_varchar2('[%d].InstitutionId', i);

        if n_code != p_employee_code then
            -- Skip this row, go to next row
            CONTINUE;
        end if;

        -- SELECT COUNT(ID) INTO l_count_idemp FROM EMP_EDUCATION WHERE ID = i and n_code = EMPLOYEE_CODE ;
        SELECT COUNT(ID) INTO l_count_idemp FROM EMP_EDUCATION WHERE REC_ID = n_rec_id ;

        If l_count_idemp > 0 Then
            UPDATE
                EMP_EDUCATION
            SET
                LEVEL_OF_EDU = n_level_of_edu,
                MAJOR = n_major,
                PLACE = n_school_name,
                GRADUATED_DATE = n_end_date,
                EMPLOYEE_CODE = n_code,
                PRIMARY_EDUCATION = n_primary,
                REC_ID = n_rec_id,
                DISCIPLINE_ID = n_DisciplineId,
                INSTITUTION_ID = n_InstitutionId
            WHERE
                -- ID = i;
                REC_ID = n_rec_id;
        Else
            INSERT INTO
                EMP_EDUCATION(
                    -- ID,
                    LEVEL_OF_EDU,
                    MAJOR,
                    PLACE,
                    GRADUATED_DATE,
                    EMPLOYEE_CODE,
                    PRIMARY_EDUCATION,
                    REC_ID,
                    DISCIPLINE_ID,
                    INSTITUTION_ID
                )
            VALUES
            (
                    -- i,
                    n_level_of_edu,
                    n_major,
                    n_school_name,
                    n_end_date,
                    n_code,
                    n_primary,
                    n_rec_id,
                    n_DisciplineId,
                    n_InstitutionId
                );
        End If;

        COMMIT; 
         
    END LOOP;
    --DBMS_OUTPUT.put_line(TO_CHAR(n_primary)||n_name||TO_CHAR(n_managerPosition));
    
END;
/