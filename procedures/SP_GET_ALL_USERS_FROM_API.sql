create or replace PROCEDURE "SP_GET_ALL_USERS_FROM_API"
(p_token nvarchar2)
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

n_id number;
n_name NVARCHAR2(2000);
n_code NVARCHAR2(100);
n_firstname NVARCHAR2(2000);
n_lastname NVARCHAR2(2000);
n_middleName NVARCHAR2(2000);
n_phone  NVARCHAR2(100);
n_email NVARCHAR2(200);
n_manager VARCHAR2(2000);
n_managernumber NVARCHAR2(100);
n_managerPosition NVARCHAR2(100);
n_positionId NVARCHAR2(100);
--
n_birth_date DATE;
n_start_date DATE;
n_gender_str NVARCHAR2(100);
n_gender number;
n_country NVARCHAR2(100);
n_title NVARCHAR2(100);
--

-- BANK ACCOUNT fields
n_total_id_types number;
b_acc_num NVARCHAR2(50);
b_name NVARCHAR2(200);
b_branch NVARCHAR2(200);
-- ID number fields
total_id_types number := 4;
CCCD_Id NVARCHAR2(50);
CCCD_Issue_Place NVARCHAR2(100);
CCCD_Issue_Date DATE;
CCCD_Expiration_Date DATE;
CMND_Id NVARCHAR2(50);
CMND_Issue_Place NVARCHAR2(100);
CMND_Issue_Date DATE;
CMND_Expiration_Date DATE;
Passport_Id NVARCHAR2(50);
Passport_Issue_Place NVARCHAR2(100);
Passport_Issue_Date DATE;
Passport_Expiration_Date DATE;
Visa_Id NVARCHAR2(50);
Visa_Issue_Place NVARCHAR2(100);
Visa_Issue_Date DATE;
Visa_Expiration_Date DATE;
EmpWorkPermit_Id NVARCHAR2(50);
EmpWorkPermit_Issue_Place NVARCHAR2(100);
EmpWorkPermit_Issue_Date DATE;
WorkPermit_Expiration_Date DATE;
PIT_Id NVARCHAR2(50);
PIT_Issue_Place NVARCHAR2(100);
PIT_Issue_Date DATE;
PIT_Expiration_Date DATE;
id_index NUMBER;
Temp_Id NVARCHAR2(50);
Temp_Issue_Place NVARCHAR2(100);
Temp_Issue_Date DATE;
Temp_Expiration_Date DATE;

BEGIN
    --apex_web_service.g_request_headers.delete();
    --apex_web_service.g_request_headers(1).name := 'tenant_id';
    --apex_web_service.g_request_headers(1).value := 'd1005fc5-bff9-42d5-81e5-1f3fcb089799';
    --apex_web_service.g_request_headers(2).name := 'client_id';
    --apex_web_service.g_request_headers(2).value := 'c74729ce-651b-41a6-9f44-d65d88c0f5e7';
    --apex_web_service.g_request_headers(3).name := 'client_secret';
    --apex_web_service.g_request_headers(3).value := 'Ddy8Q~2CS45IhZOGRAIINn3xew~Ivo9SecFeybYk';
    --apex_web_service.g_request_headers(4).name := 'resource';
    --apex_web_service.g_request_headers(4).value := 'https://hra.sandbox.operations.dynamics.com/';
    --apex_web_service.g_request_headers(5).name := 'grant_type';
    --apex_web_service.g_request_headers(5).value := 'client_credentials';

    --APEX_JSON.parse(
        --apex_web_service.make_rest_request(
            --p_url => 'https://login.microsoftonline.com/d1005fc5-bff9-42d5-81e5-1f3fcb089799/oauth2/token',
            --p_http_method => 'POST',
            --p_body => l_body,
            --p_transfer_timeout => 3600
            --)
    --);
    --l_numrow := APEX_JSON.get_count (p_path =>'.');
    --FOR i IN 1 .. l_numrow
    --LOOP
        --l_token_type := apex_json.get_varchar2('[%d].token_type', i);
        --l_access_token := apex_json.get_varchar2('[%d].access_token', i);
    --END LOOP;
    --l_authorization := l_token_type + ' ' + l_access_token;
    --DBMS_OUTPUT.put_line(l_authorization);
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
            p_url => 'https://hra.sandbox.operations.dynamics.com/api/services/HRPortalServices/EmployeeProfileService/getAllEmployee',
            p_http_method => 'POST',
            --p_body => l_body,
            p_transfer_timeout => 3600
            ) --;
    );
    --APEX_JSON.parse(l_response_clob);
    --APEX_JSON.parse(:body_text);
    --DBMS_OUTPUT.put_line(l_response_clob);
    l_numrow := APEX_JSON.get_count (p_path =>'.'); --Đếm tổng số chuỗi trả về
    --DBMS_OUTPUT.put_line(TO_CHAR(l_numrow));
    
    FOR i IN 1 .. l_numrow
    LOOP
        n_id := TO_NUMBER(apex_json.get_varchar2('[%d].$id', i));
        n_code := apex_json.get_clob('[%d].Code', i);
        n_firstname := apex_json.get_clob('[%d].FirstName', i);
        n_lastname := apex_json.get_clob('[%d].LastName', i);
        n_name := apex_json.get_clob('[%d].MiddleName', i);
        n_phone := apex_json.get_clob('[%d].Phone', i);
        n_email := NVL(apex_json.get_clob('[%d].Email', i), i||'vus.account.null@vus-etsc.edu.vn');
        n_managernumber := apex_json.get_clob('[%d].ManagerNumber', i);
        n_positionId := apex_json.get_varchar2('[%d].PositionId', i);
        n_managerPosition := apex_json.get_varchar2('[%d].ManagerPosition', i);
        --
        n_birth_date := TO_DATE(apex_json.get_varchar2('[%d].BirthDate', i), 'YYYY-MM-DD"T"HH24:MI:SS');
        n_start_date := TO_DATE(apex_json.get_varchar2('[%d].EmployeeStartDate', i), 'YYYY-MM-DD"T"HH24:MI:SS"Z"');
        n_gender_str := apex_json.get_varchar2('[%d].Gender', i);
        n_gender := CASE 
            WHEN n_gender_str LIKE 'Mr.%' THEN 1
            WHEN n_gender_str LIKE 'Ms.%' OR n_gender_str LIKE 'Mrs.%' THEN 2
            ELSE 0
        END;        
        n_country := apex_json.get_varchar2('[%d].Country', i);
        n_title := apex_json.get_varchar2('[%d].Title', i);

        --Get user bank accounts
        b_acc_num := apex_json.get_varchar2('[%d].BankAccount', i);
        b_name := apex_json.get_varchar2('[%d].BankName', i);
        b_branch := apex_json.get_varchar2('[%d].BranchName', i);

        --Get user ID numbers
        CCCD_Id := apex_json.get_varchar2('[%d].CCCD', i);
        CCCD_Issue_Place := apex_json.get_varchar2('[%d].CCCD_IssuePlace', i);
        CCCD_Issue_Date := TO_DATE(apex_json.get_varchar2('[%d].CCCD_IssueDate', i), 'YYYY-MM-DD"T"HH24:MI:SS');
        CCCD_Expiration_Date := TO_DATE(apex_json.get_varchar2('[%d].CCCDExpirationDate', i), 'YYYY-MM-DD"T"HH24:MI:SS');
        CMND_Id := apex_json.get_varchar2('[%d].CMND', i);
        CMND_Issue_Place := apex_json.get_varchar2('[%d].CMND_IssuePlace', i);
        CMND_Issue_Date := TO_DATE(apex_json.get_varchar2('[%d].CMND_IssueDate', i), 'YYYY-MM-DD"T"HH24:MI:SS');
        CMND_Expiration_Date := TO_DATE(apex_json.get_varchar2('[%d].CMNDExpirationDate', i), 'YYYY-MM-DD"T"HH24:MI:SS');
        Passport_Id := apex_json.get_varchar2('[%d].Passport', i);
        Passport_Issue_Place := apex_json.get_varchar2('[%d].Passport_IssuePlace', i);
        Passport_Issue_Date := TO_DATE(apex_json.get_varchar2('[%d].Passport_IssueDate', i), 'YYYY-MM-DD"T"HH24:MI:SS');
        Passport_Expiration_Date := TO_DATE(apex_json.get_varchar2('[%d].PassportExpirationDate', i), 'YYYY-MM-DD"T"HH24:MI:SS');
        Visa_Id := apex_json.get_varchar2('[%d].Visa', i);
        Visa_Issue_Place := apex_json.get_varchar2('[%d].Visa_IssuePlace', i);
        Visa_Issue_Date := TO_DATE(apex_json.get_varchar2('[%d].Visa_IssueDate', i), 'YYYY-MM-DD"T"HH24:MI:SS');
        Visa_Expiration_Date := TO_DATE(apex_json.get_varchar2('[%d].VisaExpirationDate', i), 'YYYY-MM-DD"T"HH24:MI:SS');
        PIT_Id := apex_json.get_varchar2('[%d].PIT', i);
        PIT_Issue_Place := apex_json.get_varchar2('[%d].PIT_IssuePlace', i);
        PIT_Issue_Date := TO_DATE(apex_json.get_varchar2('[%d].PIT_IssueDate', i), 'YYYY-MM-DD"T"HH24:MI:SS');
        PIT_Expiration_Date := TO_DATE(apex_json.get_varchar2('[%d].PITExpirationDate', i), 'YYYY-MM-DD"T"HH24:MI:SS');
        EmpWorkPermit_Id := apex_json.get_varchar2('[%d].EmpWorkPermit', i);
        EmpWorkPermit_Issue_Place := apex_json.get_varchar2('[%d].EmpWorkPermit_IssuePlace', i);
        EmpWorkPermit_Issue_Date := TO_DATE(apex_json.get_varchar2('[%d].EmpWorkPermit_IssueDate', i), 'YYYY-MM-DD"T"HH24:MI:SS');
        WorkPermit_Expiration_Date := TO_DATE(apex_json.get_varchar2('[%d].WorkPermitExpirationDate', i), 'YYYY-MM-DD"T"HH24:MI:SS');
        
        SELECT COUNT(ID) INTO l_count_idemp FROM EMPLOYEES WHERE ID = i ;
        If l_count_idemp > 0 Then
            UPDATE EMPLOYEES SET EMPLOYEE_ID = i, FIRST_NAME = n_firstname, LAST_NAME = n_lastname,
                                FULL_NAME = n_name, PHONE_NUMBER = n_phone,  PERSONAL_EMAIL = n_email,
                                EMPLOYEE_CODE = n_code, USER_NAME = n_email, MANAGER_ID = n_managernumber ,POSITION_ID = n_positionId,MANAGER_POSITION_ID= n_managerPosition,
                                DOB = n_birth_date, START_DATE = n_start_date, GENDER = n_gender, COUNTRY = n_country, TITLE = n_title    
            WHERE ID = i ;

        Else
            INSERT INTO EMPLOYEES(ID, EMPLOYEE_ID, FIRST_NAME, LAST_NAME, FULL_NAME, PHONE_NUMBER, PERSONAL_EMAIL, EMPLOYEE_CODE, USER_NAME, 
                MANAGER_ID,POSITION_ID,MANAGER_POSITION_ID, DOB, START_DATE, GENDER, COUNTRY, TITLE)
            VALUES(i, i, n_firstname, n_lastname, n_name, n_phone, n_email, n_code, n_email, n_managernumber,n_positionId,n_managerPosition,
                n_birth_date, n_start_date, n_gender, n_country, n_title);

        End If;

        SELECT COUNT(ID) INTO l_count_iduser FROM USERS WHERE PERSON_ID = i AND PERSON_TYPE = 'STAFF';
        If l_count_iduser > 0 Then
            UPDATE USERS SET MANAGERPOSITION = n_managerPosition,USER_NAME = n_email
            WHERE PERSON_ID = i AND PERSON_TYPE = 'STAFF';
        Else
            INSERT INTO USERS(PERSON_ID, PERSON_TYPE, MANAGERPOSITION, USER_NAME)
            VALUES(i, 'STAFF', n_managerPosition, n_email);
        End If;
        
        --Get bank accounts
        SELECT COUNT(ID) INTO l_count_idemp FROM EMP_BANK WHERE ID = i ;
        If l_count_idemp > 0 Then
            -- Update bank accounts
            UPDATE EMP_BANK SET EMPLOYEE_ID = i, EMPLOYEE_CODE = n_code, BANK_ACC_NUM = b_acc_num,
                    BANK_NAME = b_name, BANK_BRANCH = b_branch
            WHERE ID = i ;

        Else
            -- Insert bank accounts
            INSERT INTO EMP_BANK(ID, EMPLOYEE_ID, EMPLOYEE_CODE, BANK_ACC_NUM, BANK_NAME, BANK_BRANCH)
            VALUES(i, i, n_code, b_acc_num, b_name, b_branch);

        End If;

        --Get Id Numbers
        -- FOR j in 0 .. total_id_types - 1
        -- LOOP
        --     id_index := (i-1)*total_id_types+j;

        --     -- get ID data
        --     Temp_Id := CASE 
        --         WHEN j = 0 THEN CCCD_Id
        --         WHEN j = 1 THEN Passport_Id
        --         WHEN j = 2 THEN EmpWorkPermit_Id
        --         WHEN j = 3 THEN PIT_Id
        --     END;   
        --     Temp_Issue_Place := CASE 
        --         WHEN j = 0 THEN CCCD_Issue_Place
        --         WHEN j = 1 THEN Passport_Issue_Place
        --         WHEN j = 2 THEN EmpWorkPermit_Issue_Place
        --         WHEN j = 3 THEN PIT_Issue_Place
        --     END;   
        --     Temp_Issue_Date := CASE 
        --         WHEN j = 0 THEN CCCD_Issue_Date
        --         WHEN j = 1 THEN Passport_Issue_Date
        --         WHEN j = 2 THEN EmpWorkPermit_Issue_Date
        --         WHEN j = 3 THEN PIT_Issue_Date
        --     END;   
        --     Temp_Expiration_Date := CASE 
        --         WHEN j = 0 THEN CCCD_Expiration_Date
        --         WHEN j = 1 THEN Passport_Expiration_Date
        --         WHEN j = 2 THEN WorkPermit_Expiration_Date
        --         WHEN j = 3 THEN PIT_Expiration_Date
        --     END;   

        --     SELECT COUNT(ID) INTO l_count_idemp FROM EMP_ID_NUMBER WHERE ID = id_index;
        --     If l_count_idemp > 0 Then
        --         -- Update id numbers
        --         UPDATE EMP_ID_NUMBER SET ID_NUMBER = Temp_Id, ISSUE_DATE = Temp_Issue_Date, EXPIRATION_DATE = Temp_Expiration_Date, 
        --             ISSUE_PLACE = Temp_Issue_Place, EMPLOYEE_ID = i, ID_TYPE = j
        --         WHERE ID = id_index ;

        --     Else
        --         -- Insert id numbers
        --         INSERT INTO EMP_ID_NUMBER(ID, ID_NUMBER, ISSUE_DATE, EXPIRATION_DATE, ISSUE_PLACE, EMPLOYEE_ID, EMPLOYEE_CODE, ID_TYPE)
        --         VALUES(id_index, Temp_Id, Temp_Issue_Date, Temp_Expiration_Date, Temp_Issue_Place, i, n_code, j);

        --     End If;
        -- END LOOP;
       
        -- n_checked_date := TO_CHAR(TO_DATE(n_checked_date, 'YYYY-MM-DD'), 'DD/MM/YYYY');
        COMMIT;
         
    END LOOP;
    --DBMS_OUTPUT.put_line(TO_CHAR(n_id)||n_name||TO_CHAR(n_managerPosition));
    
END;
/