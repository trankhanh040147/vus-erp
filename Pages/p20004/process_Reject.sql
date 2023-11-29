declare
    n_check number;
    n_step number;
    emp_requests_id number;
begin
    -- Get emp_requests_id
    select ID
    into emp_requests_id
    from EMP_REQUESTS er where :P20004_REQUEST_ID = er.REQUEST_DETAIL_ID and  REQUEST_TYPE = :P20004_FEATURE;

    for rec in (
    --     with temp as (
    --     select wa.WA_GROUP from EMP_REQUESTS er
    --         join WORKFLOW_APPROVAL wa on wa.WF_PROCESS_ID = er.WF_PROCESS_ID
    --         join employees emp on emp.APPROVAL_GROUP = wa.WA_GROUP
    --         where emp.EMPLOYEE_CODE = :APP_EMP_CODE
    --         group by wa.WA_GROUP
    -- )
        select er.CURRENT_STEP,er.NEXT_STEP,count(wa.WA_SEQUENCE_NUMBER) as SEQ from EMP_REQUESTS er
            join WORKFLOW_APPROVAL wa on wa.WF_PROCESS_ID = er.WF_PROCESS_ID
            -- join WORKFLOW_APPROVAL tmp on tmp.WA_GROUP = wa.WA_GROUP
            where er.REQUEST_DETAIL_ID = :P20004_REQUEST_ID and REQUEST_TYPE = :P20004_FEATURE and er.STATUS <> 3 group by er.CURRENT_STEP,er.NEXT_STEP) 
            loop
                if rec.NEXT_STEP < rec.SEQ then
                    --select wa.WA_SEQUENCE_NUMBER into n_step from EMPLOYEES emp join WORKFLOW_APPROVAL wa on wa.WA_GROUP = emp.APPROVAL_GROUP and employee_code = :APP_EMP_CODE;
                    update EMP_REQUESTS 
                    set MODIFIED_DATE = sysdate,
                        CURRENT_STEP = rec.NEXT_STEP,
                        MODIFIED_BY_CODE = :APP_EMP_CODE,
                        STATUS = 4
                    where REQUEST_DETAIL_ID = :P20004_REQUEST_ID and REQUEST_TYPE = :P20004_FEATURE;
                                
                    insert into WORKFLOW_DETAIL(
                        WD_MODIFIED_DATE,
                        WD_MODIFIED_CODE,
                        STATUS,
                        REQUEST_ID,
                        SEQUENCE
                        ) 
                    values(
                        sysdate,
                        :APP_EMP_CODE,
                        4,
                        emp_requests_id,
                        rec.NEXT_STEP
                        );
                
                update SCHOLARSHIP_REQUEST 
                set STATUS = 4 
                where id = :P20004_REQUEST_ID;
                    --else
                    --update EMP_REQUESTS set MODIFIED_DATE = sysdate,CURRENT_STEP=rec.NEXT_STEP,MODIFIED_BY_CODE = :APP_EMP_CODE,STATUS=3 where id = :P20004_REQUEST_ID and REQUEST_TYPE = :P20004_FEATURE;
                end if;
            end loop;

    /*
    SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'dieptran@vus-etsc.edu.vn', 'OT Request Submitted Successfully', '<p> Dear '|| :APP_USER_NAME ||', </p>' ||
    '<p> Your OT request has been submitted successfully. Here are the details: </p>' ||

    '<p> If you have any questions or need further assistance, please feel free to reach out to the HR department. </p>' ||
    '<br>' || 
    '<p> Thank you, </p>' ||
    '<p> VUS </p>');
    */
end;