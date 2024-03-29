create or replace PROCEDURE "SP_GET_ALL_EMPLOYEES"
(
    p_from_num NUMBER,
    p_to_num NUMBER
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
l_count_id_emer number;
l_count_iduser number;
l_count_id_social number;
l_body_json clob;

n_id number;
n_name NVARCHAR2(2000);
n_code NVARCHAR2(100);
n_firstname NVARCHAR2(2000);
n_lastname NVARCHAR2(2000);
n_middleName NVARCHAR2(2000);
n_phone  NVARCHAR2(100);
n_email NVARCHAR2(200);
n_company_email NVARCHAR2(200);
n_manager VARCHAR2(2000);
n_managernumber NVARCHAR2(100);
n_managerPosition NVARCHAR2(100);
n_positionId NVARCHAR2(100);
n_temp_address NVARCHAR2(100);
n_prim_address NVARCHAR2(100);
n_social NVARCHAR2(100);
--
n_birth_date DATE;
n_start_date DATE;
n_terminate_date DATE;
n_gender_str NVARCHAR2(100);
n_gender number;
n_country NVARCHAR2(100);
n_title NVARCHAR2(100);
n_data_area NVARCHAR2(100 CHAR);


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
-- Emergency contact
n_FullNameEmergencyContact NVARCHAR2(200); 
n_RelationshipEmergencyContact NVARCHAR2(100);
n_PhoneEmergencyContact NVARCHAR2(100);
n_ProfileId NVARCHAR2(100);
n_Schedule  NVARCHAR2(100);
-- Social Insurance
n_SocialInsuranceNumber NVARCHAR2(100);
n_HealthInsuranceCard NVARCHAR2(100);
n_HospitalOrClinicCode NVARCHAR2(100);
n_HouseholderFullName NVARCHAR2(100);
n_HouseholderIDNumber NVARCHAR2(100);
n_HouseholderRelationship NVARCHAR2(100);
n_Householder_DOB NVARCHAR2(100);


p_token nvarchar2(10000);


BEGIN

    -- (1): Call API 

    SP_GET_TOKEN(p_token);
    apex_web_service.g_request_headers.delete();
    apex_web_service.g_request_headers(1).name := 'Content-Type';
    apex_web_service.g_request_headers(1).value := 'application/json';
    apex_web_service.g_request_headers(2).name := 'Authorization';
    apex_web_service.g_request_headers(2).value := 'Bearer '|| p_token;

    l_body := '{"_jsonRequest":{"FromWorkerNum":"' || p_from_num || '","ToWorkerNum":"' || p_to_num || '"} }';


    APEX_JSON.parse(

    apex_web_service.make_rest_request(
            p_url => 'https://hra.sandbox.operations.dynamics.com/api/services/HRPortalServices/EmployeeProfileService/getAllEmployeeNew',
            p_http_method => 'POST',
            p_body => l_body,
            p_transfer_timeout => 3600
            )
    );

    -- {API Response}
        --     {
        --     "$id": "1",
        --     "Name": "Trần D",
        --     "Code": "000000078",
        --     "FirstName": "",
        --     "LastName": "",
        --     "MiddleName": "",
            -- "Title": "HR Admin Officer",
        --     "Phone": "",
        --     "Email": "",
        --     "BirthDate": "1900-01-01T12:00:00",
        --     "Gender": "",
        --     "Country": "",
        --     "CCCD": "",
        --     "CCCD_IssueDate": "1900-01-01T12:00:00",
        --     "CCCD_IssuePlace": "",
        --     "CCCDExpirationDate": "1900-01-01T12:00:00",
        --     "CMND": "",
        --     "CMND_IssueDate": "1900-01-01T12:00:00",
        --     "CMND_IssuePlace": "",
        --     "CMNDExpirationDate": "1900-01-01T12:00:00",
        --     "Passport": "",
        --     "Passport_IssueDate": "1900-01-01T12:00:00",
        --     "Passport_IssuePlace": "",
        --     "PassportExpirationDate": "1900-01-01T12:00:00",
        --     "Visa": "",
        --     "Visa_IssueDate": "1900-01-01T12:00:00",
        --     "Visa_IssuePlace": "",
        --     "VisaExpirationDate": "1900-01-01T12:00:00",
        --     "EmpWorkPermit": "",
        --     "EmpWorkPermitIssueDate": "1900-01-01T12:00:00",
        --     "EmpWorkPermitIssuePlace": "",
        --     "WorkPermitExpirationDate": "1900-01-01T12:00:00",
        --     "EmpPIT": "",
        --     "EmpPITIssueDate": "1900-01-01T12:00:00",
        --     "EmpPITIssuePlace": "",
        --     "PITExpirationDate": "1900-01-01T12:00:00",
        --     "PositionId": "000485",
        --     "PositionName": "HR Admin Officer",
        --     "Manager": "",
        --     "ManagerNumber": "",
        --     "ManagerPosition": "",
        --     "OfficeLocation": "HCM_VPTT",
        --     "OfficeAddress": "",
        --     "DepartmentName": "HR & Admin Department",
        --     "DataArea": "V01",
        --     "StartDate": "2022-01-30T17:00:00Z",
        --     "TerminateDate": "2154-12-31T23:59:59Z",
        --     "CompanyEmail": "trang.th@vus-etsc.edu.vn",
        --     "BankAccount": "",
        --     "BankName": "",
        --     "BranchName": "",
        --     "SocialInsuranceNumber": "",
        --     "ProfileId": "",
        --     "Schedule": "HO",
        --     "UserEmail": "",
        --     "EmployeeStartDate": "1900-01-01T00:00:00Z",
        --     "HealthInsuranceCard": "",
        --     "HospitalOrClinicCode": "",
        --     "HouseholderFullName": "",
        --     "HouseholderIDNumber": "",
        --     "HouseholderRelationship": "",
        --     "Householder_DOB": "1900-01-01T00:00:00Z",
        --     "PrimaryAddressing": "",
        --     "TempAddressing": "",
        --     "FullNameEmergencyContact": "",
        --     "RelationshipEmergencyContact": "",
        --     "PhoneEmergencyContact": "",
        --     "Worker": 5637197826
        -- }

    l_numrow := APEX_JSON.get_count (p_path =>'.'); --Đếm tổng số chuỗi trả về

    -- Delete old data
    FOR i IN 1 .. l_numrow
    loop
      
        Delete from EMP_ID_NUMBER_NEW where EMPLOYEE_ID = i + p_from_num - 1;

    end loop;
    
    FOR i IN 1 .. l_numrow
    LOOP
        n_code := apex_json.get_clob('[%d].Code', i);
        -- n_id := TO_NUMBER(apex_json.get_varchar2('[%d].$id', i)) + p_from_num - 1;
        n_id := i + p_from_num - 1;
        n_firstname := apex_json.get_clob('[%d].FirstName', i);
        n_lastname := apex_json.get_clob('[%d].LastName', i);
        n_name := apex_json.get_clob('[%d].Name', i);
        n_phone := apex_json.get_clob('[%d].Phone', i);
        -- n_email := NVL(apex_json.get_clob('[%d].UserEmail', i), i||'vus.account.null@vus-etsc.edu.vn');
        n_email := apex_json.get_clob('[%d].Email', i);
        n_company_email := NVL(apex_json.get_clob('[%d].CompanyEmail', n_id), n_id||'vus.account.null@vus-etsc.edu.vn');
        -- n_company_email := apex_json.get_clob('[%d].CompanyEmail', i);
        n_managernumber := apex_json.get_clob('[%d].ManagerNumber', i);
        n_positionId := apex_json.get_varchar2('[%d].PositionId', i);
        n_managerPosition := apex_json.get_varchar2('[%d].ManagerPosition', i);

        -- n_birth_date := TO_DATE(apex_json.get_varchar2('[%d].BirthDate', i), 'YYYY-MM-DD"T"HH24:MI:SS');
        -- n_start_date := TO_DATE(apex_json.get_varchar2('[%d].StartDate', i), 'YYYY-MM-DD"T"HH24:MI:SS"Z"');
        -- n_terminate_date := TO_DATE(apex_json.get_varchar2('[%d].StartDate', i), 'YYYY-MM-DD"T"HH24:MI:SS"Z"');
        n_birth_date := CASE WHEN apex_json.get_varchar2('[%d].BirthDate', i) LIKE '%1900-01-01%' THEN NULL ELSE TO_CHAR(TO_DATE(apex_json.get_varchar2('[%d].BirthDate', i), 'YYYY-MM-DD"T"HH24:MI:SS'), 'MM/DD/YYYY') END;
        n_start_date := CASE WHEN apex_json.get_varchar2('[%d].StartDate', i) LIKE '%1900-01-01%' THEN NULL ELSE TO_CHAR(TO_DATE(apex_json.get_varchar2('[%d].StartDate', i), 'YYYY-MM-DD"T"HH24:MI:SS"Z"'), 'MM/DD/YYYY') END;
        n_terminate_date := CASE WHEN apex_json.get_varchar2('[%d].TerminateDate', i) LIKE '%1900-01-01%' THEN NULL ELSE TO_CHAR(TO_DATE(apex_json.get_varchar2('[%d].TerminateDate', i), 'YYYY-MM-DD"T"HH24:MI:SS"Z"'), 'MM/DD/YYYY') END;

        n_temp_address := apex_json.get_varchar2('[%d].TempAddressing', i);
        n_prim_address := apex_json.get_varchar2('[%d].PrimaryAddressing', i);
        n_gender_str := apex_json.get_varchar2('[%d].Gender', i);
        n_gender := CASE 
            WHEN n_gender_str LIKE 'Mr.%' THEN 1
            WHEN n_gender_str LIKE 'Ms.%' OR n_gender_str LIKE 'Mrs.%' THEN 2
            ELSE 0
        END;        
        n_country := apex_json.get_varchar2('[%d].Country', i);
        n_title := apex_json.get_varchar2('[%d].Title', i);
        n_data_area := apex_json.get_varchar2('[%d].DataArea', i);
        n_FullNameEmergencyContact := apex_json.get_varchar2('[%d].FullNameEmergencyContact', i);
        n_RelationshipEmergencyContact := apex_json.get_varchar2('[%d].RelationshipEmergencyContact', i);
        n_PhoneEmergencyContact := apex_json.get_varchar2('[%d].PhoneEmergencyContact', i);
        n_ProfileId := apex_json.get_varchar2('[%d].ProfileId', i);
        n_Schedule := apex_json.get_varchar2('[%d].Schedule', i);
        

        --Get user bank accounts
        b_acc_num := apex_json.get_varchar2('[%d].BankAccount', i);
        b_name := apex_json.get_varchar2('[%d].BankName', i);
        b_branch := apex_json.get_varchar2('[%d].BranchName', i);

        --Get user ID numbers
        n_social := apex_json.get_varchar2('[%d].SocialInsuranceNumber', i);
        CCCD_Id := apex_json.get_varchar2('[%d].CCCD', i);
        CCCD_Issue_Place := apex_json.get_varchar2('[%d].CCCD_IssuePlace', i);
        CCCD_Issue_Date := CASE WHEN apex_json.get_varchar2('[%d].CCCD_IssueDate', i) LIKE '%1900-01-01%' THEN NULL ELSE TO_CHAR(TO_DATE(apex_json.get_varchar2('[%d].CCCD_IssueDate', i), 'YYYY-MM-DD"T"HH24:MI:SS'), 'MM/DD/YYYY') END;
        CCCD_Expiration_Date := CASE WHEN apex_json.get_varchar2('[%d].CCCDExpirationDate', i) LIKE '%1900-01-01%' THEN NULL ELSE TO_CHAR(TO_DATE(apex_json.get_varchar2('[%d].CCCDExpirationDate', i), 'YYYY-MM-DD"T"HH24:MI:SS'), 'MM/DD/YYYY') END;

        CMND_Id := apex_json.get_varchar2('[%d].CMND', i);
        CMND_Issue_Place := apex_json.get_varchar2('[%d].CMND_IssuePlace', i);
        CMND_Issue_Date := CASE WHEN apex_json.get_varchar2('[%d].CMND_IssueDate', i) LIKE '%1900-01-01%' THEN NULL ELSE TO_CHAR(TO_DATE(apex_json.get_varchar2('[%d].CMND_IssueDate', i), 'YYYY-MM-DD"T"HH24:MI:SS'), 'MM/DD/YYYY') END;
        CMND_Expiration_Date := CASE WHEN apex_json.get_varchar2('[%d].CMNDExpirationDate', i) LIKE '%1900-01-01%' THEN NULL ELSE TO_CHAR(TO_DATE(apex_json.get_varchar2('[%d].CMNDExpirationDate', i), 'YYYY-MM-DD"T"HH24:MI:SS'), 'MM/DD/YYYY') END;

        Passport_Id := apex_json.get_varchar2('[%d].Passport', i);
        Passport_Issue_Place := apex_json.get_varchar2('[%d].Passport_IssuePlace', i);
        -- Passport_Issue_Date := TO_DATE(apex_json.get_varchar2('[%d].Passport_IssueDate', i), 'YYYY-MM-DD"T"HH24:MI:SS');
        Passport_Issue_Date := CASE WHEN apex_json.get_varchar2('[%d].Passport_IssueDate', i) LIKE '%1900-01-01%' THEN NULL ELSE TO_CHAR(TO_DATE(apex_json.get_varchar2('[%d].Passport_IssueDate', i), 'YYYY-MM-DD"T"HH24:MI:SS'), 'MM/DD/YYYY') END;
        Passport_Expiration_Date := CASE WHEN apex_json.get_varchar2('[%d].PassportExpirationDate', i) LIKE '%1900-01-01%' THEN NULL ELSE TO_CHAR(TO_DATE(apex_json.get_varchar2('[%d].PassportExpirationDate', i), 'YYYY-MM-DD"T"HH24:MI:SS'), 'MM/DD/YYYY') END;
        Visa_Id := apex_json.get_varchar2('[%d].Visa', i);
        Visa_Issue_Place := apex_json.get_varchar2('[%d].Visa_IssuePlace', i);
        Visa_Issue_Date := CASE WHEN apex_json.get_varchar2('[%d].Visa_IssueDate', i) LIKE '%1900-01-01%' THEN NULL ELSE TO_CHAR(TO_DATE(apex_json.get_varchar2('[%d].Visa_IssueDate', i), 'YYYY-MM-DD"T"HH24:MI:SS'), 'MM/DD/YYYY') END;
        Visa_Expiration_Date := CASE WHEN apex_json.get_varchar2('[%d].VisaExpirationDate', i) LIKE '%1900-01-01%' THEN NULL ELSE TO_CHAR(TO_DATE(apex_json.get_varchar2('[%d].VisaExpirationDate', i), 'YYYY-MM-DD"T"HH24:MI:SS'), 'MM/DD/YYYY') END;

        PIT_Id := apex_json.get_varchar2('[%d].PIT', i);
        PIT_Issue_Place := apex_json.get_varchar2('[%d].PIT_IssuePlace', i);
        PIT_Issue_Date := CASE WHEN apex_json.get_varchar2('[%d].PIT_IssueDate', i) LIKE '%1900-01-01%' THEN NULL ELSE TO_CHAR(TO_DATE(apex_json.get_varchar2('[%d].PIT_IssueDate', i), 'YYYY-MM-DD"T"HH24:MI:SS'), 'MM/DD/YYYY') END;
        PIT_Expiration_Date := CASE WHEN apex_json.get_varchar2('[%d].PITExpirationDate', i) LIKE '%1900-01-01%' THEN NULL ELSE TO_CHAR(TO_DATE(apex_json.get_varchar2('[%d].PITExpirationDate', i), 'YYYY-MM-DD"T"HH24:MI:SS'), 'MM/DD/YYYY') END;
        EmpWorkPermit_Id := apex_json.get_varchar2('[%d].EmpWorkPermit', i);
        EmpWorkPermit_Issue_Place := apex_json.get_varchar2('[%d].EmpWorkPermit_IssuePlace', i);
        EmpWorkPermit_Issue_Date := CASE WHEN apex_json.get_varchar2('[%d].EmpWorkPermit_IssueDate', i) LIKE '%1900-01-01%' THEN NULL ELSE TO_CHAR(TO_DATE(apex_json.get_varchar2('[%d].EmpWorkPermit_IssueDate', i), 'YYYY-MM-DD"T"HH24:MI:SS'), 'MM/DD/YYYY') END;
        WorkPermit_Expiration_Date := CASE WHEN apex_json.get_varchar2('[%d].WorkPermitExpirationDate', i) LIKE '%1900-01-01%' THEN NULL ELSE TO_CHAR(TO_DATE(apex_json.get_varchar2('[%d].WorkPermitExpirationDate', i), 'YYYY-MM-DD"T"HH24:MI:SS'), 'MM/DD/YYYY') END;

        
        -- Social Insurance
        n_SocialInsuranceNumber := apex_json.get_varchar2('[%d].SocialInsuranceNumber', i);
        n_HealthInsuranceCard := apex_json.get_varchar2('[%d].HealthInsuranceCard', i);
        n_HospitalOrClinicCode := apex_json.get_varchar2('[%d].HospitalOrClinicCode', i);
        n_HouseholderFullName := apex_json.get_varchar2('[%d].HouseholderFullName', i);
        n_HouseholderIDNumber := apex_json.get_varchar2('[%d].HouseholderIDNumber', i);
        n_HouseholderRelationship := apex_json.get_varchar2('[%d].HouseholderRelationship', i);
        n_Householder_DOB := CASE WHEN apex_json.get_varchar2('[%d].Householder_DOB', i) LIKE '%1900-01-01%' THEN NULL ELSE TO_CHAR(TO_DATE(apex_json.get_varchar2('[%d].Householder_DOB', i), 'YYYY-MM-DD"T"HH24:MI:SS"Z"'), 'MM/DD/YYYY') END;

        -- Update EMPLOYEES_NEW table
        SELECT COUNT(ID) INTO l_count_idemp FROM EMPLOYEES_NEW WHERE EMPLOYEE_CODE = n_code ;
        If l_count_idemp > 0 Then
            UPDATE EMPLOYEES_NEW SET EMPLOYEE_ID = n_id, FIRST_NAME = n_firstname, LAST_NAME = n_lastname,
                                FULL_NAME = n_name, PHONE_NUMBER = n_phone,  PERSONAL_EMAIL = n_email,
                                EMPLOYEE_CODE = n_code, USER_NAME = n_company_email, MANAGER_ID = n_managernumber ,POSITION_ID = n_positionId,MANAGER_POSITION_ID= n_managerPosition,
                                DOB = n_birth_date, START_DATE = n_start_date, GENDER = n_gender, COUNTRY = n_country, TITLE = n_title, DATAAREA = n_data_area, 
                                TEMPORARY_ADDRESS = n_temp_address, PERMANENT_ADDRESS = n_prim_address, SOCIAL = n_social,
                                PROFILE_ID = n_ProfileId, SCHEDULE = n_Schedule
                                
            WHERE EMPLOYEE_CODE = n_code ;

        Else
            INSERT INTO EMPLOYEES_NEW(ID, EMPLOYEE_ID, FIRST_NAME, LAST_NAME, FULL_NAME, PHONE_NUMBER, PERSONAL_EMAIL, EMPLOYEE_CODE, USER_NAME, 
                MANAGER_ID,POSITION_ID,MANAGER_POSITION_ID, DOB, START_DATE, GENDER, COUNTRY, TITLE, DATAAREA, TEMPORARY_ADDRESS, PERMANENT_ADDRESS, 
                SOCIAL, PROFILE_ID, SCHEDULE)
            VALUES(n_id, n_id, n_firstname, n_lastname, n_name, n_phone, n_email, n_code, n_company_email, n_managernumber,n_positionId,n_managerPosition,
                n_birth_date, n_start_date, n_gender, n_country, n_title, n_data_area,n_temp_address, n_prim_address, n_social, n_ProfileId, n_Schedule);

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

        -- Get Id Numbers
        FOR j in 0 .. total_id_types - 1
        LOOP
            id_index := (i-1)*total_id_types+j;

            -- get ID data
            Temp_Id := CASE 
                WHEN j = 0 THEN CCCD_Id
                WHEN j = 1 THEN Passport_Id
                WHEN j = 2 THEN EmpWorkPermit_Id
                WHEN j = 3 THEN PIT_Id
            END;   
            Temp_Issue_Place := CASE 
                WHEN j = 0 THEN CCCD_Issue_Place
                WHEN j = 1 THEN Passport_Issue_Place
                WHEN j = 2 THEN EmpWorkPermit_Issue_Place
                WHEN j = 3 THEN PIT_Issue_Place
            END;   
            Temp_Issue_Date := CASE 
                WHEN j = 0 THEN CCCD_Issue_Date
                WHEN j = 1 THEN Passport_Issue_Date
                WHEN j = 2 THEN EmpWorkPermit_Issue_Date
                WHEN j = 3 THEN PIT_Issue_Date
            END;   
            Temp_Expiration_Date := CASE 
                WHEN j = 0 THEN CCCD_Expiration_Date
                WHEN j = 1 THEN Passport_Expiration_Date
                WHEN j = 2 THEN WorkPermit_Expiration_Date
                WHEN j = 3 THEN PIT_Expiration_Date
            END;   

            SELECT COUNT(ID) INTO l_count_idemp FROM EMP_ID_NUMBER_NEW WHERE ID = id_index;
            If l_count_idemp > 0 Then
                -- Update id numbers
                UPDATE EMP_ID_NUMBER_NEW SET ID_NUMBER = Temp_Id, ISSUE_DATE = Temp_Issue_Date, EXPIRATION_DATE = Temp_Expiration_Date, 
                    ISSUE_PLACE = Temp_Issue_Place, EMPLOYEE_ID = i, ID_TYPE = j
                WHERE ID = id_index ;

            Else
                -- Insert id numbers
                INSERT INTO EMP_ID_NUMBER_NEW(ID, ID_NUMBER, ISSUE_DATE, EXPIRATION_DATE, ISSUE_PLACE, EMPLOYEE_ID, EMPLOYEE_CODE, ID_TYPE)
                VALUES(id_index, Temp_Id, Temp_Issue_Date, Temp_Expiration_Date, Temp_Issue_Place, i, n_code, j);

            End If;

            -- Update/Insert Emergency Contact
            SELECT COUNT(ID) INTO l_count_id_emer FROM EMP_EMERGENCY_CONTACT WHERE ID = i;
            If l_count_id_emer > 0 Then
                -- Update Emergency Contact
                UPDATE EMP_EMERGENCY_CONTACT EEC 
                    SET EEC.EMPLOYEE_ID = i, EEC.EMPLOYEE_CODE = n_code,
                    EME_FULL_NAME = n_FullNameEmergencyContact, RELATION_SHIP = n_RelationshipEmergencyContact, EME_PHONE_NUMBER = n_PhoneEmergencyContact 
                    WHERE ID = i ;
            Else
                -- Insert Emergency Contact
                INSERT INTO EMP_EMERGENCY_CONTACT(ID, EMPLOYEE_ID, EMPLOYEE_CODE, EME_FULL_NAME, RELATION_SHIP, EME_PHONE_NUMBER)
                VALUES(i, i, n_code, n_FullNameEmergencyContact, n_RelationshipEmergencyContact, n_PhoneEmergencyContact);

            End If;

            -- Update [Social_Insurance]
            SELECT COUNT(ID) INTO l_count_id_social FROM EMP_SOCICAL_INSURANCE WHERE ID = i;
            If l_count_id_social > 0 Then
                -- Update Emergency Contact
                UPDATE EMP_SOCICAL_INSURANCE EEC 
                    SET SOC_INS_NUMBER = n_SocialInsuranceNumber, PRI_HEAL_SERVICE = n_HealthInsuranceCard,
                        SOC_HOSPITAL_CODE = n_HospitalOrClinicCode, SOC_HOU_NAME = n_HouseholderFullName, 
                        SOC_HOU_DOB = n_Householder_DOB, SOC_HOU_ID = n_HouseholderIDNumber,
                        SOC_RELATIONSHIP = n_HouseholderRelationship, EMPLOYEE_ID = i, EMPLOYEE_CODE = n_code
                    WHERE ID = i ;
            Else
                -- Insert Emergency Contact
                INSERT INTO EMP_SOCICAL_INSURANCE(ID, EMPLOYEE_ID, EMPLOYEE_CODE, SOC_INS_NUMBER, PRI_HEAL_SERVICE, SOC_HOSPITAL_CODE, SOC_HOU_NAME, SOC_HOU_DOB, SOC_HOU_ID, SOC_RELATIONSHIP)
                VALUES(i, i, n_code, n_SocialInsuranceNumber, n_HealthInsuranceCard, n_HospitalOrClinicCode, n_HouseholderFullName, n_Householder_DOB, n_HouseholderIDNumber, n_HouseholderRelationship);

            End If;

        END LOOP;

        -- n_checked_date := TO_CHAR(TO_DATE(n_checked_date, 'YYYY-MM-DD'), 'DD/MM/YYYY');
        COMMIT;
         
    END LOOP;
    --DBMS_OUTPUT.put_line(TO_CHAR(n_id)||n_name||TO_CHAR(n_managerPosition));
    
END;
/