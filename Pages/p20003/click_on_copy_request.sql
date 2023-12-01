
declare
SCHOLARSHIP_REQUEST_ID_COPY number(10); 
SCHOLARSHIP_REQUEST_ID_NEW number(10); 
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
ATTACH_NAME varchar2(2000);
ATTACH_FILE varchar2(2000);
RECIPIENT_REPLACEMENT varchar2(100);
RECIPIENT_VOUCHER_CODE_REPLACEMENT varchar2(50);
RECIPIENT_EXPIRATION_DATE_REPLACEMENT date;
RECIPIENT_NOTE varchar2(1000);

begin
    SCHOLARSHIP_REQUEST_ID_COPY := :ID;

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
        )
    returning ID into SCHOLARSHIP_REQUEST_ID_NEW;

     -- retunr ID, NOTE, REASON_REQUEST, LINE_MANAGER into EMP_REQUESTS_ID, NOTE, REASON_REQUEST, LINE_MANAGER;

    -- Insert data into EMP_REQUESTS table with the new ID
    for rec in (
        select
            WF_FEATURE_APPLY,
            WF_PROCESS_ID
        from
            WORKFLOW
        where
            -- lower(WF_FEATURE_APPLY) = 'scholarship' 
            lower(WF_FEATURE_APPLY) = lower(:P20003_FEATURE)
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
            :APP_EMP_CODE,
            1,
            -- NOTE,
            CASE
                WHEN SCHOLARSHIP_RECIPIENT = 'A'
                OR SCHOLARSHIP_RECIPIENT = 'B' THEN NOTE
                ELSE REASON_REQUEST
            END,
            sysdate,
            scholarship_request_id,
            rec.WF_PROCESS_ID,
            LINE_MANAGER
        );

    end loop;
        
end;

