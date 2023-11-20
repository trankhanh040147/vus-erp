-- --------------------------------------------------------------------------------
-- 
-- Oracle APEX source export file
-- 
-- The contents of this file are intended for review and analysis purposes only.
-- Developers must use the Application Builder to make modifications to an
-- application. Changes to this file will not be reflected in the application.
-- 
-- --------------------------------------------------------------------------------

-- ----------------------------------------
-- Page: 29 - Overtime Request for Employee > Region: Report > Source > SQL Query

with temp as (
    select 
    case when CONVERT_TYPE = 'Money'
    then 0 else
    CONVERT_VALUE end CONVERT_VALUE,
    CONVERT_TYPE from EMP_REQUESTS where id = :P29_REQUEST_ID
)

select 
    eor.ID,
    eor.EMPLOYEE_CODE,
    eor.CREATED_DATE,
    eor.profile_time,
    eor.start_time,
    eor.end_time,
    eor.TOTAL_HOUR_WK,
    eor.TOTAL_HOUR_REST_WK,
    eor.TOTAL_HOUR_PUBLIC,
    eor.REASON,
    eor.NOTE,
    eor.WORKING_PLACE,
    eor.status,
    eor.DETAIL_ID,
    (select CONVERT_TYPE from temp) as CONVERT_TYPE,
    (select CONVERT_VALUE from temp) as CONVERT_VALUE
from EMP_OVERTIME_REQUESTS eor
where eor.EMPLOYEE_CODE = :P29_EMPLOYEE_CODE and :P29_DETAIL_ID = eor.DETAIL_ID;

-- ----------------------------------------
-- Page: 29 - Overtime Request for Employee > Region: Report > Column: PROFILE_TIME > Default > SQL Query

select PROFILE_ID as ID from WORKING_SCHEDULE where EMPLOYEE_CODE = :APP_EMP_CODE and WS_DATE = :CREATED_DATE
UNION all

-- -- Second query, executed only if the first one returns no results
SELECT e.PROFILE_ID as ID
FROM EMPLOYEES e
WHERE e.EMPLOYEE_CODE = :APP_EMP_CODE 
AND NOT EXISTS (
    SELECT 1 
    FROM WORKING_SCHEDULE 
    WHERE EMPLOYEE_CODE = :APP_EMP_CODE AND WS_DATE = :CREATED_DATE
);

-- ----------------------------------------
-- Page: 29 - Overtime Request for Employee > Region: Report > Column: PROFILE_TIME > List of Values > SQL Query

select PROFILE_ID,PROFILE_ID as ID from WORKING_SCHEDULE where EMPLOYEE_CODE = :APP_EMP_CODE and WS_DATE = :CREATED_DATE
UNION all
SELECT e.PROFILE_ID, e.PROFILE_ID AS ID 
FROM EMPLOYEES e
WHERE e.EMPLOYEE_CODE = :APP_EMP_CODE 
AND NOT EXISTS (
    SELECT 1 
    FROM WORKING_SCHEDULE 
    WHERE EMPLOYEE_CODE = :APP_EMP_CODE AND WS_DATE = :CREATED_DATE
);

-- ----------------------------------------
-- Page: 29 - Overtime Request for Employee > Region: Report > Column: APEX$ROW_SELECTOR > Server-side Condition (Function Body) > PL/SQL Function Body

declare
n_check number;
begin
    select count(id) into n_check from EMP_REQUESTS where (:P29_REQUEST_ID is not null and id = :P29_REQUEST_ID and employee_code = :APP_EMP_CODE) or :P29_REQUEST_ID is null;
    if n_check > 0 then
        return true;
        else
        return false;
    end if;
end;

-- ----------------------------------------
-- Page: 29 - Overtime Request for Employee > Region: Report > Column: APEX$ROW_ACTION > Server-side Condition (Function Body) > PL/SQL Function Body

declare
n_check number;
begin
    select count(id) into n_check from EMP_REQUESTS where (:P29_REQUEST_ID is not null and id = :P29_REQUEST_ID and employee_code = :APP_EMP_CODE) or :P29_REQUEST_ID is null;
    if n_check > 0 then
        return true;
        else
        return false;
    end if;
end;

-- ----------------------------------------
-- Page: 29 - Overtime Request for Employee > Process: Send email > Source > PL/SQL Code

declare
    link_url nvarchar2(2000);
    manager_email nvarchar2(100);
manager_name nvarchar2(100);
begin
-- Send mail

SELECT USER_NAME, FULL_NAME INTO manager_email, manager_name FROM EMPLOYEES WHERE (SELECT MANAGER_ID FROM EMPLOYEES WHERE EMPLOYEE_CODE = :APP_EMP_CODE) = EMPLOYEE_CODE;

    --For employee
SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', :APP_USER, 'Overtime Request Submitted Successfully', '<p> Hello '|| :APP_USER_NAME ||', </p>' ||
'<p>We have successfully received your overtime request for the date(s). Here are the details of your request:</p>' ||
'<p>- Total OT hours on weekdays:</p>' ||
'<p>- Total OT hours on day-off: </p>' ||
'<p>- Total OT hours on public holidays: </p>' ||
'<p>- Note: </p>' ||
'<p>Your request is currently waiting for approve. Once it''s approved by your manager, you will be notified.</p>' ||
'<br>' || 
'<p> Best regards,</p>' ||
'<p> VUS </p>');


---For manager

SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', manager_email, 'New Overtime Request from', '<p>Hello '|| manager_name ||',</p>' || 
    '<p>'||:APP_USER_NAME||'has submitted a new overtime request. Below are the details:</p>' ||
    '<p>- Date(s) of Overtime:</p>' ||
    '<p>- Total OT hours on weekdays:</p>' ||
'<p>- Total OT hours on day-off: </p>' ||
'<p>- Total OT hours on public holidays: </p>' ||
'<p>- Note: </p>' ||
'<p>To review and take action on this request, please click on the link below: <a href=\"https://erp-uat.vus.edu.vn/ords/r/erp/erp/approve-request-overtime\">Link to the Overtime Request.</a></p>' ||
    '<br>' || 
    '<p>Please ensure that you review the request in a timely manner.</p>' ||
    '<br>' || 
    '<p>Thank you,</p>' ||
    '<p> Best regards,</p>' ||
    '<p>VUS</p>');
end;

-- ----------------------------------------
-- Page: 29 - Overtime Request for Employee > Process: UPDATE - EMP_Request > Source > PL/SQL Code

BEGIN
    UPDATE EMP_REQUESTS 
    SET NOTE = :P29_NOTE
    WHERE ID = :P29_REQUEST_ID;
END;

-- ----------------------------------------
-- Page: 29 - Overtime Request for Employee > Process: Update status draft > Source > PL/SQL Code

declare
    n_check number;
BEGIN
select count(id) into n_check from EMP_REQUESTS WHERE ID = :P29_REQUEST_ID and status = 1;
if n_check > 0 then
    UPDATE EMP_REQUESTS 
    SET status = 2
    WHERE ID = :P29_REQUEST_ID;
end if;

END;

-- ----------------------------------------
-- Page: 29 - Overtime Request for Employee > Process: Insert row new draft > Source > PL/SQL Code

begin
for rec in (select WF_FEATURE_APPLY,WF_PROCESS_ID from WORKFLOW where WF_FEATURE_APPLY = :P29_FEATURE and WF_EXPIRATION_DATE >= sysdate)loop
    insert into EMP_REQUESTS(REQUEST_TYPE,SUBMIT_DATE,EMPLOYEE_CODE,STATUS,NOTE,CREATE_DATE,REQUEST_DETAIL_ID,WF_PROCESS_ID,LINE_MANAGER,CONVERT_TYPE,CONVERT_VALUE)
    values(rec.WF_FEATURE_APPLY,sysdate,:APP_EMP_CODE,1,:P29_NOTE, sysdate,:P29_DETAIL_ID,rec.WF_PROCESS_ID,:P29_LINE_MANAGER,:P29_COVERTED,:P29_TOTAL_DAY_OFF);
end loop;

end;

-- ----------------------------------------
-- Page: 29 - Overtime Request for Employee > Process: Reject request > Source > PL/SQL Code

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
        join WORKFLOW_APPROVAL tmp on tmp.WA_GROUP = wa.WA_GROUP
        where er.ID = :P29_REQUEST_ID and er.STATUS <> 3 group by er.CURRENT_STEP,er.NEXT_STEP)loop
            if rec.NEXT_STEP < rec.SEQ then
                --select wa.WA_SEQUENCE_NUMBER into n_step from EMPLOYEES emp join WORKFLOW_APPROVAL wa on wa.WA_GROUP = emp.APPROVAL_GROUP and employee_code = :APP_EMP_CODE;
                update EMP_REQUESTS set MODIFIED_DATE = sysdate,CURRENT_STEP=rec.NEXT_STEP,MODIFIED_BY_CODE = :APP_EMP_CODE,STATUS=4 where id = :P29_REQUEST_ID;
                            insert into WORKFLOW_DETAIL(WD_MODIFIED_DATE,WD_MODIFIED_CODE,STATUS,REQUEST_ID,SEQUENCE) 
            values(sysdate,:APP_EMP_CODE,4,:P29_REQUEST_ID,rec.NEXT_STEP);
                --else
                --update EMP_REQUESTS set MODIFIED_DATE = sysdate,CURRENT_STEP=rec.NEXT_STEP,MODIFIED_BY_CODE = :APP_EMP_CODE,STATUS=3 where id = :P29_REQUEST_ID;
            end if;
        end loop;


SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'dieptran@vus-etsc.edu.vn', 'OT Request Submitted Successfully', '<p> Dear '|| :APP_USER_NAME ||', </p>' ||
'<p> Your OT request has been submitted successfully. Here are the details: </p>' ||

'<p> If you have any questions or need further assistance, please feel free to reach out to the HR department. </p>' ||
'<br>' || 
'<p> Thank you, </p>' ||
'<p> VUS </p>');
end;

-- ----------------------------------------
-- Page: 29 - Overtime Request for Employee > Process: Approve request > Source > PL/SQL Code

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
        join WORKFLOW_APPROVAL tmp on tmp.WA_GROUP = wa.WA_GROUP
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

-- ----------------------------------------
-- Page: 29 - Overtime Request for Employee > Process: Insert row new > Source > PL/SQL Code

begin
for rec in (select WF_FEATURE_APPLY,WF_PROCESS_ID from WORKFLOW where WF_FEATURE_APPLY = :P29_FEATURE and WF_EXPIRATION_DATE >= sysdate)loop
    insert into EMP_REQUESTS(REQUEST_TYPE,SUBMIT_DATE,EMPLOYEE_CODE,STATUS,NOTE,CREATE_DATE,REQUEST_DETAIL_ID,WF_PROCESS_ID,LINE_MANAGER,CONVERT_TYPE,CONVERT_VALUE)
    values(rec.WF_FEATURE_APPLY,sysdate,:APP_EMP_CODE,2,:P29_NOTE, sysdate,:P29_DETAIL_ID,rec.WF_PROCESS_ID,:P29_LINE_MANAGER,:P29_COVERTED,:P29_TOTAL_DAY_OFF) returning ID into :P29_REQUEST_ID;
end loop;

end;

-- ----------------------------------------
-- Page: 29 - Overtime Request for Employee > Dynamic Action: Set value > Action: Execute Server-side Code > Settings > PL/SQL Code

begin
for rec in (select * from employees where employee_code = :P29_EMPLOYEE_CODE)loop
    :P29_EMPLOYEE_NAME := rec.FULL_NAME;
    :P29_TITLE := rec.TITLE;
    :P29_DEPARTMENT := rec.DEPARTMENT_ID;
    :P29_LEVEL := 'SE';
end loop;
    
end;

-- ----------------------------------------
-- Page: 29 - Overtime Request for Employee > Dynamic Action: StartTime_EndTime_change > Action: Calculating Totals > Settings > PL/SQL Code

declare 
    start_time_1 DATE;
    end_time_1 DATE;
    loop_flex_time_start DATE;
    loop_flex_time_end DATE;
    total_flex_time NUMBER(5,2) := 0;
    total_public NUMBER(5,2) := 0;
    l_count_public_holidays NUMBER;
    l_count_day_off NUMBER;
    cursor c_flex_times is
        SELECT TO_DATE(START_TIME, 'HH24:MI') as flex_start, 
               TO_DATE(END_TIME, 'HH24:MI') as flex_end
        FROM WORKING_PROFILE_LINES wpd
        JOIN PROFILE_TYPES pt ON custom_trim_v2(pt.PROFILE_TYPE_ID) = wpd.PROFILE_TYPE_ID
        WHERE wpd.PROFILE_ID = :PROFILE_TIME
        AND pt.PROFILE_TYPE_GROUP = 'ot';
        -- AND wpd.PROFILE_TYPE_ID LIKE '%ot%'
begin
    -- Convert the time strings to DATE data type
    start_time_1 := TO_DATE(:START_TIME, 'HH24:MI');
    end_time_1 := TO_DATE(:END_TIME, 'HH24:MI');

    :TOTAL_HOUR_PUBLIC := 0;
    :TOTAL_HOUR_REST_WK := 0;
    :TOTAL_HOUR_WK := 0;

    SELECT COUNT(*) INTO l_count_public_holidays FROM PUBLIC_HOLIDAYS ph WHERE TO_CHAR(ph.PH_DATE, 'DD-MM')  = TO_CHAR(TO_DATE(:CREATED_DATE, 'MM-DD-YYYY'), 'DD-MM');
    select COUNT(*) INTO l_count_day_off from WORKING_PROFILE wp where wp.PROFILE_ID =  CUSTOM_TRIM_V3(:PROFILE_TIME) and IS_DAY_OFF_PROFILE = 1;

    -- Case: PUBLIC_HOLIDAYS
    IF l_count_public_holidays > 0 THEN
        total_public := custom_round((end_time_1 - start_time_1) * 24);
        -- DBMS_OUTPUT.PUT_LINE('Total Public:' || total_public);
        -- :TOTAL_HOUR_PUBLIC := total_public;
        IF total_public > 0 THEN :TOTAL_HOUR_PUBLIC := total_public; ELSE :TOTAL_HOUR_PUBLIC := 0; END IF;

        RETURN;
    END IF;

    -- Case: WEEKDAYS && DAY_OFF
    
    -- Loop through each flex time and calculate the overlap
    for flex_record in c_flex_times loop
        loop_flex_time_start := flex_record.flex_start;
        loop_flex_time_end := flex_record.flex_end;

        IF loop_flex_time_start <= end_time_1 AND loop_flex_time_end >= start_time_1 THEN
            total_flex_time := total_flex_time + (LEAST(end_time_1, loop_flex_time_end) - GREATEST(start_time_1, loop_flex_time_start)) * 24;
        END IF;

    end loop;

    total_flex_time := custom_round(total_flex_time);

    -- Check day_off 
    IF l_count_day_off > 0 THEN
        :TOTAL_HOUR_REST_WK := total_flex_time;
        IF total_flex_time > 0 THEN :TOTAL_HOUR_REST_WK := total_flex_time; ELSE :TOTAL_HOUR_REST_WK := 0; END IF;

        -- DBMS_OUTPUT.PUT_LINE('Total day-off hours:' || custom_round(total_flex_time));
    ELSE
        :TOTAL_HOUR_WK := total_flex_time;
        IF total_flex_time > 0 THEN :TOTAL_HOUR_WK := total_flex_time; ELSE :TOTAL_HOUR_WK := 0; END IF;
        -- DBMS_OUTPUT.PUT_LINE('Total weekdays hours:' || custom_round(total_flex_time));
    END IF;

end;


-- ----------------------------------------
-- Page: 29 - Overtime Request for Employee > Button: Deleterow > Server-side Condition (Function Body) > PL/SQL Function Body

declare
    n_check number;
begin
    if :P29_REQUEST_ID is not null then
        select count(id) into n_check from EMP_REQUESTS 
        where ID = :P29_REQUEST_ID and (STATUS = 1 or STATUS = 2) and employee_code = :APP_EMP_CODE;
            if n_check > 0 then
                return true;
                else
                return false;
            end if;
        else
            return true;
    end if;
end;

-- ----------------------------------------
-- Page: 29 - Overtime Request for Employee > Button: Addrow > Server-side Condition (Function Body) > PL/SQL Function Body

declare
    n_check number;
begin
    if :P29_REQUEST_ID is not null then
        select count(id) into n_check from EMP_REQUESTS 
        where ID = :P29_REQUEST_ID and (STATUS = 1 or STATUS = 2) and employee_code = :APP_EMP_CODE;
            if n_check > 0 then
                return true;
                else
                return false;
            end if;
            else
            return true;
    end if;
end;

-- ----------------------------------------
-- Page: 29 - Overtime Request for Employee > Button: Reject > Server-side Condition (Function Body) > PL/SQL Function Body

declare
    n_check number;
    n_check_seq number;
    n_check_line_man number;
begin
select count(id) into n_check_seq from EMP_REQUESTS er where next_step = 1 and er.ID = :P29_REQUEST_ID;
if n_check_seq > 0 then
    select count(id) into n_check_line_man from EMP_REQUESTS er where next_step = 1 and er.ID = :P29_REQUEST_ID and er.line_manager = :APP_EMP_CODE ;
    if n_check_line_man > 0 then
        return true;
        else
        return false;
    end if;
else
    select count(er.id) into n_check from EMP_REQUESTS er
        join WORKFLOW_APPROVAL wa on wa.WF_PROCESS_ID = er.WF_PROCESS_ID
        join employees emp on emp.APPROVAL_GROUP = wa.WA_GROUP
        where er.ID = :P29_REQUEST_ID and er.NEXT_STEP = wa.WA_SEQUENCE_NUMBER
        and emp.EMPLOYEE_CODE = :APP_EMP_CODE and er.STATUS not in (3,4) and er.next_step > 1 and :APP_EMP_CODE <>(select line_manager from EMP_REQUESTS where ID = :P29_REQUEST_ID);

        if n_check > 0 then
            return true;
            else
            return false;
        end if;
end if;

end;

-- ----------------------------------------
-- Page: 29 - Overtime Request for Employee > Button: Approve > Server-side Condition (Function Body) > PL/SQL Function Body

declare
    n_check number;
    n_check_seq number;
    n_check_line_man number;
begin
select count(id) into n_check_seq from EMP_REQUESTS er where next_step = 1 and er.ID = :P29_REQUEST_ID;
if n_check_seq > 0 then
    select count(id) into n_check_line_man from EMP_REQUESTS er where next_step = 1 and er.ID = :P29_REQUEST_ID and er.line_manager = :APP_EMP_CODE ;
    if n_check_line_man > 0 then
        return true;
        else
        return false;
    end if;
else
    select count(er.id) into n_check from EMP_REQUESTS er
        join WORKFLOW_APPROVAL wa on wa.WF_PROCESS_ID = er.WF_PROCESS_ID
        join employees emp on emp.APPROVAL_GROUP = wa.WA_GROUP
        where er.ID = :P29_REQUEST_ID and er.NEXT_STEP = wa.WA_SEQUENCE_NUMBER
        and emp.EMPLOYEE_CODE = :APP_EMP_CODE and er.STATUS not in (3,4) and er.next_step > 1 and :APP_EMP_CODE <>(select line_manager from EMP_REQUESTS where ID = :P29_REQUEST_ID);

        if n_check > 0 then
            return true;
            else
            return false;
        end if;
end if;

end;

-- ----------------------------------------
-- Page: 29 - Overtime Request for Employee > Button: Submit_Draft > Server-side Condition (Function Body) > PL/SQL Function Body

declare
n_check number;
begin
if :P29_REQUEST_ID is not null then
select count(id) into n_check from EMP_REQUESTS WHERE ID = :P29_REQUEST_ID and status = 1;
    if n_check > 0 then
        return true;
        else
        return false;
    end if;
else
    return false;
end if;
end;

-- ----------------------------------------
-- Page: 29 - Overtime Request for Employee > Button: Update > Server-side Condition (Function Body) > PL/SQL Function Body

declare
    n_check number;
begin
    if :P29_REQUEST_ID is not null then
    select count(id) into n_check from EMP_REQUESTS 
    where ID = :P29_REQUEST_ID and (STATUS = 1 or STATUS = 2) and employee_code = :APP_EMP_CODE;
        if n_check > 0 then
            return true;
            else
            return false;
        end if;
    end if;
end;

-- ----------------------------------------
-- Page: 29 - Overtime Request for Employee > Page Item: P29_LINE_MANAGER > Default > SQL Query

SELECT MANAGER_ID FROM EMPLOYEES WHERE EMPLOYEE_CODE = :APP_EMP_CODE;

-- ----------------------------------------
-- Page: 29 - Overtime Request for Employee > Page Item: P29_DETAIL_ID > Default > SQL Query

select OT_DETAIL_ID.nextval from dual;

-- ----------------------------------------
-- Page: 29 - Overtime Request for Employee > Region: Content > Source > SQL Query

select --ID,
       to_char(wd.WD_MODIFIED_DATE,'DD/MM/YYYY HH24:MI') as MODIFIED_DATE,
       emp.FULL_NAME,
       --WD_MODIFIED_CODE,
       WD_COMMENT,
       --WD_INFORMATION,
       --WF_PROCESS_ID,
       --STATUS,
       s.status as status,
       --wd.NOTE,
       --REQUEST_ID,
       SEQUENCE
from WORKFLOW_DETAIL wd
join EMPLOYEES emp on wd.WD_MODIFIED_CODE = emp.EMPLOYEE_CODE
join status s on s.id = wd.status
where REQUEST_ID = :P29_REQUEST_ID
order by SEQUENCE;

-- ----------------------------------------
-- Page: 29 - Overtime Request for Employee > Region: Group > Server-side Condition (Function Body) > PL/SQL Function Body

declare
    n_check number;
begin
    if :P29_REQUEST_ID is not null then
        select count(id) into n_check from EMP_REQUESTS 
        where ID = :P29_REQUEST_ID and (STATUS = 1 or STATUS = 2) and LINE_MANAGER = :APP_EMP_CODE;
            if n_check > 0 then
                return true;
                else
                return false;
            end if;
        else
            return false;
    end if;
end;

