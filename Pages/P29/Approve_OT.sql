declare
    n_check number;
    n_step number;
begin
for rec in (
    with temp as (
    select wa.WA_GROUP from EMP_REQUESTS er
        join WORKFLOW_APPROVAL wa on wa.WF_PROCESS_ID = er.WF_PROCESS_ID
        join employees emp on emp.APPROVAL_GROUP = wa.WA_GROUP
        where emp.EMPLOYEE_CODE = :APP_EMP_CODE
        group by wa.WA_GROUP
)
    select er.CURRENT_STEP,er.NEXT_STEP,count(wa.WA_SEQUENCE_NUMBER) as SEQ from EMP_REQUESTS er
        join WORKFLOW_APPROVAL wa on wa.WF_PROCESS_ID = er.WF_PROCESS_ID
        -- join WORKFLOW_APPROVAL tmp on tmp.WA_GROUP = wa.WA_GROUP
        where er.ID = :P29_REQUEST_ID and er.STATUS <> 3 group by er.CURRENT_STEP,er.NEXT_STEP)loop
            if rec.NEXT_STEP < rec.SEQ then
                --select wa.WA_SEQUENCE_NUMBER into n_step from EMPLOYEES emp join WORKFLOW_APPROVAL wa on wa.WA_GROUP = emp.APPROVAL_GROUP and employee_code = :APP_EMP_CODE;
                update EMP_REQUESTS set MODIFIED_DATE = sysdate,CURRENT_STEP=rec.NEXT_STEP,MODIFIED_BY_CODE = :APP_EMP_CODE,NEXT_STEP = rec.NEXT_STEP+1,STATUS=6 where id = :P29_REQUEST_ID;
                else
                update EMP_REQUESTS set MODIFIED_DATE = sysdate,CURRENT_STEP=rec.NEXT_STEP,MODIFIED_BY_CODE = :APP_EMP_CODE,STATUS=3 where id = :P29_REQUEST_ID;
            end if;
            insert into WORKFLOW_DETAIL(WD_MODIFIED_DATE,WD_MODIFIED_CODE,STATUS,REQUEST_ID,SEQUENCE,WD_COMMENT) 
            values(sysdate,:APP_EMP_CODE,3,:P29_REQUEST_ID,rec.NEXT_STEP,:P29_NOTE);
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