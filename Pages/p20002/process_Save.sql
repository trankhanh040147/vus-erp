declare
c_date date := to_char(sysdate,'MM/DD/YYYY');
scholarship_request_id number;
pro_code nvarchar2(50);
emp_requests_id number;
v_start_time NUMBER;
v_end_time NUMBER;

discount_rate number;

begin

    -- --if :P20002_REQUEST_ID is null then
    -- select PROMOTION_CODE into pro_code
    -- from COREEDU_PROMOTION
    -- where PROGRAM = :P20002_PROGRAM and DISCOUNT_RATE = nvl(:P20002_DISCOUNT_RATE, 50);

 -- lấy giá trị của discount_rate bằng id
    SELECT DISCOUNT_RATE INTO discount_rate
    FROM COREEDU_PROMOTION
    WHERE :P20002_DISCOUNT_RATE = ID;
    
-- thêm vào bảng SCHOLARSHIP_REQUEST
    INSERT INTO
        SCHOLARSHIP_REQUEST(
            STATUS,
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
            DETAIL_ID,
            ID_COREEDU_PROMOTION
        )
    VALUES
    (
            1,
            :P20002_SCHOLARSHIP_RECIPIENT,
            :P20002_PROGRAM,
            case
                when :P20002_IS_HR_ADMIN = 1 and :P20002_SCHOLARSHIP_RECIPIENT = 'C' then :P20002_REQUEST_NAME
                when :P20002_IS_HR_ADMIN = 1 and :P20002_SCHOLARSHIP_RECIPIENT = 'D' then :P20002_REQUEST_NAME
                when lower(:P20002_LEVEL_ID) = 'c' and :P20002_SCHOLARSHIP_RECIPIENT = 'D' then :P20002_REQUEST_NAME    -- trường hợp CEO tạo đơn
            else
                :P20002_EMPLOYEE_CODE
            end,
            :P20002_DEPARTMENT,
            :P20002_DEPARTMENT_CODE,
            :P20002_LEVEL,
            :P20002_PARTNER_NAME,
            :P20002_PARTNER_PHONE,
            :P20002_TITLE,
            :P20002_PARTNER_DEPARTMENT,
            :P20002_FIELD,
            :P20002_WORKPLACE,
            :P20002_RECIPIENT_NAME,
            :P20002_RECIPIENT_DOB,
            :P20002_RECIPIENT_PHONE,
            :P20002_RELATIONSHIP,
            :P20002_CAMPUS,
            :P20002_NAME_FILES,
            :P20002_URL_FILES,
            :P20002_REPLACEMENT,
            :P20002_VOUCHER_CODE_REPLACEMENT,
            :P20002_EXPIRATION_DATE_REPLACEMENT,
            :P20002_NOTE,
            :P20002_REASON_REQUEST,
            discount_rate,
            :P20002_VOUCHER_CODE,
            :P20002_NUMBER_OF_COURSES,
            :P20002_EFFECTIVE_DATE,
            :P20002_EXPIRATION_DATE,
            :P20002_APPROVED_DATE,
            c_date,
            :P20002_SCHOLARSHIP_DETAIL,
            :P20002_DISCOUNT_RATE
        ) returning ID into scholarship_request_id;

    for rec in (
        select 
            WF_FEATURE_APPLY,
            WF_PROCESS_ID 
        from 
            WORKFLOW 
        where 
            -- lower(WF_FEATURE_APPLY) = 'scholarship' 
            lower(WF_FEATURE_APPLY) = lower(:P20002_FEATURE) 
            and WF_EXPIRATION_DATE >= sysdate
            AND ROWNUM = 1      -- do hiện tại đang có 2 workflow áp dụng mà ko phân biệt được (nếu đúng là phải phân biệt bằng 'condition' nhưng chưa làm đc)
        ORDER BY ID
    )loop
        insert into EMP_REQUESTS(
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
        values(
            rec.WF_FEATURE_APPLY,
            sysdate,
            :APP_EMP_CODE,
            1,
            -- :P20002_NOTE,
            CASE 
                WHEN :P20002_SCHOLARSHIP_RECIPIENT = 'A' OR :P20002_SCHOLARSHIP_RECIPIENT = 'B' THEN :P20002_NOTE
                ELSE :P20002_REASON_REQUEST
            END,
            sysdate,
            scholarship_request_id,
            rec.WF_PROCESS_ID,
            :P20002_LINE_MANAGER
            );
    end loop;

    -- trường hợp đơn dành cho đối tác giám đốc
    if :P20002_SCHOLARSHIP_RECIPIENT = 'D' then
        UPDATE EMP_REQUESTS
        SET WF_PROCESS_ID = 'WORKFLOW2023-010'
        WHERE REQUEST_DETAIL_ID = scholarship_request_id and lower(REQUEST_TYPE) = lower(:P20002_FEATURE);
    end if;

    -- Get emp_requests_id
    select ID
    into emp_requests_id
    from EMP_REQUESTS er where scholarship_request_id = er.REQUEST_DETAIL_ID and lower(REQUEST_TYPE) = lower(:P20002_FEATURE);
    
    -- emp_requests_id := 999;

    -- thêm trạng thái Draft vào workflow_detail
    insert into WORKFLOW_DETAIL(
        WD_MODIFIED_DATE,
        WD_MODIFIED_CODE,
        STATUS,
        REQUEST_ID,
        WD_COMMENT
    ) 
    values(
        sysdate,
        :APP_EMP_CODE,
        1,
        emp_requests_id,
        CASE 
            WHEN :P20002_SCHOLARSHIP_RECIPIENT = 'A' OR :P20002_SCHOLARSHIP_RECIPIENT = 'B' THEN :P20002_NOTE
            ELSE :P20002_REASON_REQUEST
        END
        );
    
    
   -- Insert ATTACHMENT_HISTORY
    IF(remove_first_semicolon(:P20002_DEFAULT_IMAGES_URL) != :P20002_URL_FILES or
       ( :P20002_REQUEST_ID is null and :P20002_URL_FILES is not null )) 
    THEN
        INSERT INTO ATTACHMENT_HISTORY (ATTACHMENT_DATE, EMPLOYEE_CODE, ATTACHMENT_URL, ATTACHMENT_NAME, REQUEST_ID)
        VALUES(sysdate, :APP_EMP_CODE, :P20002_URL_FILES, :P20002_NAME_FILES, emp_requests_id);
    END IF;

    -- Write log attachments
    -- INSERT INTO OUTPUT_LOGS(NUMBER1, STR1, STR2, STR3)
    -- VALUES ((select ID from EMP_REQUESTS er where scholarship_request_id = er.REQUEST_DETAIL_ID), 'savedraft_scho', :P20002_DEFAULT_IMAGES_URL, :P20002_URL_FILES);
end;