declare
    pro_code nvarchar2(100);
    id_replace number;      -- id của voucher code bị replace
    emp_manager nvarchar2(200);
    emp_email nvarchar2(200);

begin

    -- lấy promotion_code mới
    select cp.PROMOTION_CODE
    into pro_code
    from COREEDU_PROMOTION cp
    where cp.PROGRAM = :P20004_PROGRAM and cp.DISCOUNT_RATE = :P20004_DISCOUNT_RATE;

    for rec in (
    --     with temp as (
    --     select wa.WA_GROUP from EMP_REQUESTS er
    --         join WORKFLOW_APPROVAL wa on wa.WF_PROCESS_ID = er.WF_PROCESS_ID
    --         join employees emp on emp.APPROVAL_GROUP = wa.WA_GROUP
    --         where emp.EMPLOYEE_CODE = :APP_EMP_CODE
    --         group by wa.WA_GROUP
    -- )
        select er.CURRENT_STEP,er.NEXT_STEP,
            count(wa.WA_SEQUENCE_NUMBER) as SEQ 
        from EMP_REQUESTS er
        join WORKFLOW_APPROVAL wa on wa.WF_PROCESS_ID = er.WF_PROCESS_ID
            -- join WORKFLOW_APPROVAL tmp on tmp.WA_GROUP = wa.WA_GROUP
        where er.REQUEST_DETAIL_ID = :P20004_REQUEST_ID 
            and er.STATUS <> 3 
        group by er.CURRENT_STEP,er.NEXT_STEP
    )
        loop
            if rec.NEXT_STEP < rec.SEQ then
                --select wa.WA_SEQUENCE_NUMBER into n_step from EMPLOYEES emp join WORKFLOW_APPROVAL wa on wa.WA_GROUP = emp.APPROVAL_GROUP and employee_code = :APP_EMP_CODE;
                
                -- cập nhật bảng EMP_REQUESTS về trạng thái 'in-review'
                update EMP_REQUESTS 
                set MODIFIED_DATE = sysdate,
                    CURRENT_STEP = rec.NEXT_STEP,
                    MODIFIED_BY_CODE = :APP_EMP_CODE,
                    NEXT_STEP = rec.NEXT_STEP + 1,
                    STATUS = 6 
                where REQUEST_DETAIL_ID = :P20004_REQUEST_ID;

                -- cập nhật bảng SCHOLARSHIP_REQUEST về trạng thái 'in-review'
                update SCHOLARSHIP_REQUEST 
                set STATUS = 6,
                    RECIPIENT_CAMPUS = :P20004_CAMPUS,
                    RECIPIENT_REPLACEMENT = :P20004_REPLACEMENT,
                    RECIPIENT_VOUCHER_CODE_REPLACEMENT = :P20004_VOUCHER_CODE_REPLACEMENT,
                    RECIPIENT_EXPIRATION_DATE_REPLACEMENT = :P20004_EXPIRATION_DATE_REPLACEMENT,
                    RECIPIENT_NOTE = :P20004_NOTE,
                    RECIPIENT_REASON_REQUEST = :P20004_REASON_REQUEST,
                    DISCOUNT_RATE = :P20004_DISCOUNT_RATE,
                    VOUCHER_CODE = :P20004_VOUCHER_CODE,
                    NUMBER_OF_COURSES = :P20004_NUMBER_OF_COURSES,
                    EFFECTIVE_DATE = :P20004_EFFECTIVE_DATE,
                    EXPIRATION_DATE = :P20004_EXPIRATION_DATE,
                    PROMOTION_CODE = pro_code
                where id = :P20004_REQUEST_ID;

                -- thêm dòng mới vào bảng 'WORKFLOW_DETAIL' khi có thao tác 'approve'
                insert into WORKFLOW_DETAIL(
                    WD_MODIFIED_DATE,
                    WD_MODIFIED_CODE,
                    STATUS,
                    REQUEST_ID,
                    SEQUENCE,
                    WD_COMMENT
                ) 
                values(
                    sysdate,
                    :APP_EMP_CODE,
                    6,
                    :P20004_REQUEST_ID,
                    rec.NEXT_STEP,
                    :P20004_NOTE
                    );
            else
                -- cập nhật bảng EMP_REQUESTS về trạng thái 'active'                
                update EMP_REQUESTS 
                set MODIFIED_DATE = sysdate,
                    CURRENT_STEP = rec.NEXT_STEP,
                    MODIFIED_BY_CODE = :APP_EMP_CODE,
                    STATUS = 3 
                where REQUEST_DETAIL_ID = :P20004_REQUEST_ID;

                -- cập nhật bảng SCHOLARSHIP_REQUEST về trạng thái 'active'
                update SCHOLARSHIP_REQUEST 
                set STATUS = 3,
                    RECIPIENT_CAMPUS = :P20004_CAMPUS,
                    RECIPIENT_REPLACEMENT = :P20004_REPLACEMENT,
                    RECIPIENT_VOUCHER_CODE_REPLACEMENT = :P20004_VOUCHER_CODE_REPLACEMENT,
                    RECIPIENT_EXPIRATION_DATE_REPLACEMENT = :P20004_EXPIRATION_DATE_REPLACEMENT,
                    RECIPIENT_NOTE = :P20004_NOTE,
                    RECIPIENT_REASON_REQUEST = :P20004_REASON_REQUEST,
                    DISCOUNT_RATE = :P20004_DISCOUNT_RATE,
                    VOUCHER_CODE = :P20004_VOUCHER_CODE,
                    NUMBER_OF_COURSES = :P20004_NUMBER_OF_COURSES,
                    EFFECTIVE_DATE = :P20004_EFFECTIVE_DATE,
                    EXPIRATION_DATE = :P20004_EXPIRATION_DATE,
                    PROMOTION_CODE = pro_code
                where id = :P20004_REQUEST_ID;

                -- thêm dòng mới vào bảng 'WORKFLOW_DETAIL' khi 'active'
                insert into WORKFLOW_DETAIL(
                    WD_MODIFIED_DATE,
                    WD_MODIFIED_CODE,
                    STATUS,
                    REQUEST_ID,
                    SEQUENCE,
                    WD_COMMENT
                ) 
                values(
                    sysdate,
                    :APP_EMP_CODE,
                    3,
                    :P20004_REQUEST_ID,
                    rec.NEXT_STEP,
                    :P20004_NOTE
                    );

                -- trường hợp replacement được chấp nhận, đổi status của voucher bị replace thành in-active (7)
                if :P20004_REPLACEMENT is not null then
                    select id into id_replace from SCHOLARSHIP_REQUEST where VOUCHER_CODE = :P20004_REPLACEMENT;
                    
                    update SCHOLARSHIP_REQUEST
                    set STATUS = 7
                    where id = id_replace;

                    update EMP_REQUESTS 
                    set STATUS = 7 
                    where REQUEST_DETAIL_ID = id_replace;
                    
                    -- thêm trạng thái in-active vào workflow_detail
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
                        7,
                        id_replace,
                        :P20004_NOTE
                        );
                end if;
            end if;
            
            -- insert into WORKFLOW_DETAIL(
            --     WD_MODIFIED_DATE,
            --     WD_MODIFIED_CODE,
            --     STATUS,
            --     REQUEST_ID,
            --     SEQUENCE,
            --     WD_COMMENT
            --     ) 
            -- values(
            --     sysdate,
            --     :APP_EMP_CODE,
            --     3,
            --     :P20004_REQUEST_ID,
            --     rec.NEXT_STEP,
            --     :P20004_NOTE
            --     );
        end loop;


-- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'thviet613@gmail.com', 'Scholarship Request Submitted Successfully', '<p> Dear '|| :APP_USER_NAME ||', </p>' ||
-- '<p> Your Scholarship Request has been submitted successfully. Here are the details: </p>' ||

-- '<p> If you have any questions or need further assistance, please feel free to reach out to the HR department. </p>' ||
-- '<br>' || 
-- '<p> Thank you, </p>' ||
-- '<p> VUS </p>');

end;