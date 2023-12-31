create or replace procedure "COPY_SCHOLARSHIP_REQUEST"
(
SCHOLARSHIP_REQUEST_ID_COPY number,
P20003_FEATURE NVARCHAR2,
EMP_CODE NVARCHAR2,
OUT_SCHOLARSHIP_ID out NUMBER
) 
is
SCHOLARSHIP_REQUEST_ID_NEW number;
EMP_REQUEST_ID_NEW number;

EMP_REQUESTS_ID number(10);
SCHOLARSHIP_RECIPIENT varchar2(1);
LINE_MANAGER varchar2(100);
NOTE varchar2(2000);
REASON_REQUEST varchar2(1000);

-- variables for Insert into SCHOLARSHIP_REQUEST values ()
RECIPIENT_TYPE varchar2(10);
PROGRAM varchar2(50);
REQUESTER_CODE varchar2(50);
REQUESTER_DEPARTMENT varchar2(50);
REQUESTER_DEPARTMENT_CODE varchar2(50);
REQUESTER_LEVEL varchar2(20);
PARTNER_NAME varchar2(50);
PARTNER_PHONE varchar2(20);
PARTNER_TITLE varchar2(50);
PARTNER_DEPARTMENT varchar2(50);
PARTNER_FIELD varchar2(50);
PARTNER_WORKPLACE varchar2(50);
RECIPIENT_NAME varchar2(50);
RECIPIENT_DOB date;
RECIPIENT_PHONE varchar2(20);
RECIPIENT_RELATIONSHIP varchar2(50);
RECIPIENT_CAMPUS varchar2(50);
RECIPIENT_REASON_REQUEST varchar2(1000);
ATTACH_NAME varchar2(2000);
ATTACH_FILE varchar2(2000);
RECIPIENT_REPLACEMENT varchar2(100);
RECIPIENT_VOUCHER_CODE_REPLACEMENT varchar2(50);
RECIPIENT_EXPIRATION_DATE_REPLACEMENT date;
RECIPIENT_NOTE varchar2(1000);
DISCOUNT_RATE number(3);
VOUCHER_CODE varchar2(50);
NUMBER_OF_COURSES number(5);
EFFECTIVE_DATE date;
EXPIRATION_DATE date;
APPROVED_DATE date;
CREATED_DATE date;
STATUS number(2);
DETAIL_ID number(10);
PROMOTION_CODE varchar2(50);


begin
    -- Get data from SCHOLARSHIP_REQUEST table where ID = SCHOLARSHIP_REQUEST_ID_COPY
    select
        RECIPIENT_TYPE,
        PROGRAM,
        REQUESTER_CODE,
        REQUESTER_DEPARTMENT,
        REQUESTER_DEPARTMENT_CODE,
        REQUESTER_LEVEL,
        PARTNER_NAME,
        PARTNER_PHONE,
        PARTNER_TITLE,
        PARTNER_DEPARTMENT,
        PARTNER_FIELD,
        PARTNER_WORKPLACE,
        RECIPIENT_NAME,
        RECIPIENT_DOB,
        RECIPIENT_PHONE,
        RECIPIENT_RELATIONSHIP,
        RECIPIENT_CAMPUS,
        ATTACH_NAME,
        ATTACH_FILE,
        RECIPIENT_REPLACEMENT,
        RECIPIENT_VOUCHER_CODE_REPLACEMENT,
        RECIPIENT_EXPIRATION_DATE_REPLACEMENT,
        RECIPIENT_NOTE,
        RECIPIENT_REASON_REQUEST,
        DISCOUNT_RATE,
        VOUCHER_CODE,
        NUMBER_OF_COURSES,
        EFFECTIVE_DATE,
        EXPIRATION_DATE,
        APPROVED_DATE,
        CREATED_DATE,
        STATUS,
        DETAIL_ID,
        PROMOTION_CODE
    into
        RECIPIENT_TYPE,
        PROGRAM,
        REQUESTER_CODE,
        REQUESTER_DEPARTMENT,
        REQUESTER_DEPARTMENT_CODE,
        REQUESTER_LEVEL,
        PARTNER_NAME,
        PARTNER_PHONE,
        PARTNER_TITLE,
        PARTNER_DEPARTMENT,
        PARTNER_FIELD,
        PARTNER_WORKPLACE,
        RECIPIENT_NAME,
        RECIPIENT_DOB,
        RECIPIENT_PHONE,
        RECIPIENT_RELATIONSHIP,
        RECIPIENT_CAMPUS,
        ATTACH_NAME,
        ATTACH_FILE,
        RECIPIENT_REPLACEMENT,
        RECIPIENT_VOUCHER_CODE_REPLACEMENT,
        RECIPIENT_EXPIRATION_DATE_REPLACEMENT,
        RECIPIENT_NOTE,
        RECIPIENT_REASON_REQUEST,
        DISCOUNT_RATE,
        VOUCHER_CODE,
        NUMBER_OF_COURSES,
        EFFECTIVE_DATE,
        EXPIRATION_DATE,
        APPROVED_DATE,
        CREATED_DATE,
        STATUS,
        DETAIL_ID,
        PROMOTION_CODE
    from
        SCHOLARSHIP_REQUEST
    where
        ID = SCHOLARSHIP_REQUEST_ID_COPY;


    -- Copy data from SCHOLARSHIP_REQUEST where ID = SCHOLARSHIP_REQUEST_ID_COPY, then return the ID of the new record as SCHOLARSHIP_REQUEST_ID_NEW
    
    -- Insert data into SCHOLARSHIP_REQUEST table with the new ID using Insert into values () returning ID into SCHOLARSHIP_REQUEST_ID_NEW;
    insert into
        SCHOLARSHIP_REQUEST(
            RECIPIENT_TYPE,
            PROGRAM,
            REQUESTER_CODE,
            REQUESTER_DEPARTMENT,
            REQUESTER_DEPARTMENT_CODE,
            REQUESTER_LEVEL,
            PARTNER_NAME,
            PARTNER_PHONE,
            PARTNER_TITLE,
            PARTNER_DEPARTMENT,
            PARTNER_FIELD,
            PARTNER_WORKPLACE,
            RECIPIENT_NAME,
            RECIPIENT_DOB,
            RECIPIENT_PHONE,
            RECIPIENT_RELATIONSHIP,
            RECIPIENT_CAMPUS,
            -- ATTACH_NAME,
            -- ATTACH_FILE,
            RECIPIENT_NOTE,
            RECIPIENT_REASON_REQUEST,
            DISCOUNT_RATE,
            NUMBER_OF_COURSES,
            EFFECTIVE_DATE,
            -- EXPIRATION_DATE,
            APPROVED_DATE,
            CREATED_DATE,
            STATUS,
            PROMOTION_CODE
        )
    values
    (
            RECIPIENT_TYPE,
            PROGRAM,
            REQUESTER_CODE,
            REQUESTER_DEPARTMENT,
            REQUESTER_DEPARTMENT_CODE,
            REQUESTER_LEVEL,
            PARTNER_NAME,
            PARTNER_PHONE,
            PARTNER_TITLE,
            PARTNER_DEPARTMENT,
            PARTNER_FIELD,
            PARTNER_WORKPLACE,
            RECIPIENT_NAME,
            RECIPIENT_DOB,
            RECIPIENT_PHONE,
            RECIPIENT_RELATIONSHIP,
            RECIPIENT_CAMPUS,
            -- ATTACH_NAME,
            -- ATTACH_FILE,
            RECIPIENT_NOTE,
            RECIPIENT_REASON_REQUEST,
            DISCOUNT_RATE,
            NUMBER_OF_COURSES,
            sysdate,
            -- EXPIRATION_DATE,
            APPROVED_DATE,
            sysdate,
            1, -- Draft
            PROMOTION_CODE
        )
    returning ID into SCHOLARSHIP_REQUEST_ID_NEW;

     -- retunr ID, NOTE, REASON_REQUEST, LINE_MANAGER into EMP_REQUESTS_ID, NOTE, REASON_REQUEST, LINE_MANAGER;

    -- get LINE_MANAGER
    select MANAGER_ID into LINE_MANAGER from EMPLOYEES where EMPLOYEE_CODE = EMP_CODE;
    DBMS_OUTPUT.PUT_LINE('LINE_MANAGER: ' || LINE_MANAGER);

    -- Insert data into EMP_REQUESTS table with the new ID
    for rec in (
        select
            WF_FEATURE_APPLY,
            WF_PROCESS_ID
        from
            WORKFLOW
        where
            -- lower(WF_FEATURE_APPLY) = 'scholarship' 
            lower(WF_FEATURE_APPLY) = lower(P20003_FEATURE)
            and WF_EXPIRATION_DATE >= sysdate
    ) loop
    insert into
        EMP_REQUESTS(
            REQUEST_TYPE,
            SUBMIT_DATE,
            EMPLOYEE_CODE,
            STATUS,
            NOTE,
            CREATE_DATE,
            REQUEST_DETAIL_ID,
            WF_PROCESS_ID,
            LINE_MANAGER
        )
    values
    (
            rec.WF_FEATURE_APPLY,
            sysdate,
            EMP_CODE,
            1,
            -- NOTE,
            CASE
                WHEN SCHOLARSHIP_RECIPIENT = 'A'
                OR SCHOLARSHIP_RECIPIENT = 'B' THEN NOTE
                ELSE REASON_REQUEST
            END,
            sysdate,
            SCHOLARSHIP_REQUEST_ID_NEW,
            rec.WF_PROCESS_ID,
            LINE_MANAGER
    ) returning ID into EMP_REQUEST_ID_NEW;

    end loop;

    dbms_output.put_line('EMP_REQUEST_ID_NEW: ' || EMP_REQUEST_ID_NEW);

    OUT_SCHOLARSHIP_ID := SCHOLARSHIP_REQUEST_ID_NEW;
        
end;

-- APEX ORACLE 23.1
-- -- TABLE: EMP_REQUESTS
-- ID	NUMBER(10,0)
-- REQUEST_TYPE	NVARCHAR2(100 CHAR)
-- SUBMIT_DATE	DATE
-- EMPLOYEE_CODE	NVARCHAR2(200 CHAR)
-- STATUS	NUMBER(2,0)
-- NOTE	NVARCHAR2(2000 CHAR)
-- MODIFIED_BY_CODE	NVARCHAR2(500 CHAR)
-- MODIFIED_DATE	DATE
-- REQUEST_DETAIL_ID	NUMBER(10,0)
-- WF_PROCESS_ID	NVARCHAR2(500 CHAR)
-- LINE_MANAGER	NVARCHAR2(100 CHAR)
-- CURRENT_STEP	NUMBER(5,0)
-- CREATE_DATE	DATE
-- NEXT_STEP	NUMBER(5,0)
-- IS_DEL	NUMBER(2,0)
-- CONVERT_VALUE	NUMBER(5,0)
-- CONVERT_TYPE	VARCHAR2(50 BYTE)

-- -- TABLE: SCHOLARSHIP_REQUEST
-- ID	NUMBER(10,0)
-- RECIPIENT_TYPE	VARCHAR2(10 CHAR)
-- PROGRAM	NVARCHAR2(50 CHAR)
-- REQUESTER_CODE	NVARCHAR2(50 CHAR)
-- REQUESTER_DEPARTMENT	NVARCHAR2(50 CHAR)
-- REQUESTER_DEPARTMENT_CODE	NVARCHAR2(50 CHAR)
-- REQUESTER_LEVEL	NVARCHAR2(20 CHAR)
-- PARTNER_NAME	NVARCHAR2(50 CHAR)
-- PARTNER_PHONE	NVARCHAR2(20 CHAR)
-- PARTNER_TITLE	NVARCHAR2(50 CHAR)
-- PARTNER_DEPARTMENT	NVARCHAR2(50 CHAR)
-- PARTNER_FIELD	NVARCHAR2(50 CHAR)
-- PARTNER_WORKPLACE	NVARCHAR2(50 CHAR)
-- RECIPIENT_NAME	NVARCHAR2(50 CHAR)
-- RECIPIENT_DOB	DATE
-- RECIPIENT_PHONE	NVARCHAR2(20 CHAR)
-- RECIPIENT_RELATIONSHIP	NVARCHAR2(50 CHAR)
-- RECIPIENT_CAMPUS	NVARCHAR2(50 CHAR)
-- ATTACH_NAME	VARCHAR2(2000 CHAR)
-- ATTACH_FILE	VARCHAR2(2000 CHAR)
-- RECIPIENT_REPLACEMENT	NVARCHAR2(100 CHAR)
-- RECIPIENT_VOUCHER_CODE_REPLACEMENT	NVARCHAR2(50 CHAR)
-- RECIPIENT_EXPIRATION_DATE_REPLACEMENT	DATE
-- RECIPIENT_NOTE	NVARCHAR2(1000 CHAR)
-- RECIPIENT_REASON_REQUEST	NVARCHAR2(1000 CHAR)
-- DISCOUNT_RATE	NUMBER(3,0)
-- VOUCHER_CODE	NVARCHAR2(50 CHAR)
-- NUMBER_OF_COURSES	NUMBER(5,0)
-- EFFECTIVE_DATE	DATE
-- EXPIRATION_DATE	DATE
-- APPROVED_DATE	DATE
-- CREATED_DATE	DATE
-- STATUS	NUMBER(2,0)
-- DETAIL_ID	NUMBER(10,0)
-- PROMOTION_CODE	NVARCHAR2(50 CHAR);
/