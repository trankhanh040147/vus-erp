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
-- Page: 300 - Leave Request for Employee - clone > Page Item: P300_APPROVED_MANAGER > List of Values > SQL Query

SELECT FULL_NAME,EMPLOYEE_ID as ID FROM EMPLOYEES WHERE POSITION_ID = (
select MANAGER_POSITION_ID FROM EMPLOYEES WHERE EMPLOYEE_CODE = :APP_EMP_CODE );

-- ----------------------------------------
-- Page: 300 - Leave Request for Employee - clone > Process: Calculate request > Source > PL/SQL Code

declare
v_request_id number;
v_action nvarchar2(100);
v_day_temp number:=0;

begin

for rec in (select * from ABSENCE_GROUP_EMPLOYEE eal 
join (
    select * from EMPLOYEE_REQUESTS where EMPLOYEE_CODE_REQ = :APP_EMP_CODE 
    order by submit_date desc
    FETCH FIRST 1 ROWS ONLY
) er on er.EMPLOYEE_CODE_REQ = eal.employee_code 
where eal.EMPLOYEE_CODE = :APP_EMP_CODE and EXPIRATION_DATE >= to_char(sysdate,'MM/DD/YYYY')
and eal.HRM_ABSENCE_CODE_GROUP_ID = :P300_ANNUAL_LEAVE 
)loop
if rec.HRM_ABSENCE_CODE_GROUP_ID = 'APL' then
update ABSENCE_GROUP_EMPLOYEE 
                set CARRY_FORWARD_USED = rec.CARRY_FORWARD_USED + rec.CRF_DAY_TEMP,
                DAY_APPROVE = sysdate,
                CARRY_FORWARD_AVALABLE = rec.CARRY_FORWARD_AVALABLE - rec.CRF_DAY_TEMP,
                AVAILABLE = rec.AVAILABLE - rec.ANNUAL_DAY_TEMP,
                PLAN_YEAR_USED = rec.PLAN_YEAR_USED + rec.ANNUAL_DAY_TEMP
                where EMPLOYEE_CODE = rec.EMPLOYEE_CODE and EXPIRATION_DATE >= to_char(sysdate,'MM/DD/YYYY') ;

end if;
end loop;
end;

-- ----------------------------------------
-- Page: 300 - Leave Request for Employee - clone > Process: Calculate request > Server-side Condition (Function Body) > PL/SQL Function Body

declare
    v_count number:=0;
begin
select count(id) into v_count from ABSENCE_GROUP_EMPLOYEE where EMPLOYEE_CODE = :APP_EMP_CODE and EXPIRATION_DATE >= to_char(sysdate,'MM/DD/YYYY');
if v_count > 0 then
    return true;
else
    return false;
end if;
end;

-- ----------------------------------------
-- Page: 300 - Leave Request for Employee - clone > Process: Save when submit > Source > PL/SQL Code

declare
v_request_id_temp number:=1;
v_id NUMBER:=1;
v_name_type nvarchar2(100);
v_benefit_code nvarchar2(100):='';
v_annual_temp float:=0;
v_crf_temp float:=0;
manager_email nvarchar2(100);
manager_name nvarchar2(100);
begin

-- Waiting for the end to come
-- dbms_session.sleep(1);

-- INSERT INTO DEMO_ATTACHMENT(URL) VALUES(:P300_URL_FILES);

if :P300_ANNUAL_LEAVE = 'APL' then
    for rec in ( select * from ABSENCE_GROUP_EMPLOYEE where employee_code = :APP_EMP_CODE and EXPIRATION_DATE >= to_char(sysdate,'MM/DD/YYYY'))loop
        if rec.CARRY_FORWORD_EXP_DATE >= to_char(sysdate,'MM/DD/YYYY') then
            -- CF not expired
            if  :P300_TOTAL_DAYS <= rec.CARRY_FORWARD_AVALABLE and rec.CARRY_FORWARD_AVALABLE > 0 then
                -- CF enough
                v_benefit_code := rec.CARRY_FORWARD_CODE;
                v_crf_temp := :P300_TOTAL_DAYS;
            elsif rec.CARRY_FORWARD_AVALABLE > 0 and :P300_TOTAL_DAYS > rec.CARRY_FORWARD_AVALABLE then
                -- CF not enough
                v_benefit_code := rec.BENEFIT_ACCRUAL_PLAN||','||rec.CARRY_FORWARD_CODE;
                v_crf_temp := rec.CARRY_FORWARD_AVALABLE;
                v_annual_temp := :P300_TOTAL_DAYS - rec.CARRY_FORWARD_AVALABLE;
            elsif rec.CARRY_FORWARD_AVALABLE <= 0 THEN
                -- CF not expired, CF = 0
                v_benefit_code := rec.BENEFIT_ACCRUAL_PLAN;
                v_annual_temp := :P300_TOTAL_DAYS;
            end if;
        else
            v_benefit_code := rec.BENEFIT_ACCRUAL_PLAN;
            v_annual_temp := :P300_TOTAL_DAYS;
        end if;
    end loop;
else 
    v_annual_temp := :P300_TOTAL_DAYS;
    v_benefit_code := :P300_LEAVE_DETAIL;
end if;

select "REQUEST_ID".nextval into v_request_id_temp from sys.dual; 

-- Insert leave request
-- insert into EMPLOYEE_REQUESTS (
--     REQUESTOR_ID,REQUEST_ID,EMPLOYEE_CODE_REQ,EMPLOYEE_NAME,FROM_DATE,
--     END_DATE,ALL_DAY,NOTE,TOTAL_DAYS,EMP_REQ_STATUS,LEAVE_TYPE,RESPONSER_ID,TARGET_CODE,
--     START_TIME,END_TIME,SUBMIT_DATE,BENEFIT_CODE,CRF_DAY_TEMP,ANNUAL_DAY_TEMP,ATTACH_NAME,ATTATCH_FILE
--     ) values (
--         :APP_USER_ID,v_request_id_temp,:P300_EMPLOYEE_CODE,:P300_EMPLOYEE,:P300_FROM_DATE,
--         :P300_END_DATE,to_char(:P300_ALL_DAY),:P300_NOTE,:P300_TOTAL_DAYS,2,:P300_ANNUAL_LEAVE,:P300_APPROVED_MANAGER,:P300_MANAGER_CODE,
--         :P300_START_TIME,:P300_END_TIME,sysdate,v_benefit_code,v_crf_temp,v_annual_temp,nvl(:P300_NAME_FILES,''),nvl(:P300_URL_FILES,'#')
--         ); 
--     returning ID into v_id;

    -- Insert a leave request and retrieve the ID into v_id
    insert into EMPLOYEE_REQUESTS (
        REQUESTOR_ID,REQUEST_ID,EMPLOYEE_CODE_REQ,EMPLOYEE_NAME,FROM_DATE,
        END_DATE,ALL_DAY,NOTE,TOTAL_DAYS,EMP_REQ_STATUS,LEAVE_TYPE,RESPONSER_ID,TARGET_CODE,
        START_TIME,END_TIME,SUBMIT_DATE,BENEFIT_CODE,CRF_DAY_TEMP,ANNUAL_DAY_TEMP,ATTACH_NAME,ATTATCH_FILE
    ) values (
        :APP_USER_ID,v_request_id_temp,:P300_EMPLOYEE_CODE,:P300_EMPLOYEE,to_date(:P300_FROM_DATE, 'DD/MM/YYYY'),
        CASE WHEN :P300_END_DATE IS NULL OR :P300_END_DATE = '' THEN to_date(:P300_FROM_DATE, 'DD/MM/YYYY') ELSE to_date(:P300_END_DATE, 'DD/MM/YYYY') END,to_char(:P300_ALL_DAY),:P300_NOTE,:P300_TOTAL_DAYS,2,:P300_ANNUAL_LEAVE,:P300_APPROVED_MANAGER,:P300_MANAGER_CODE,
        :P300_START_TIME,:P300_END_TIME,sysdate,v_benefit_code,v_crf_temp,v_annual_temp,nvl(:P300_NAME_FILES,''),:P300_URL_FILES
    ) returning ID into v_id;

-- Send mail

SELECT USER_NAME, FULL_NAME INTO manager_email, manager_name FROM EMPLOYEES WHERE (SELECT MANAGER_ID FROM EMPLOYEES WHERE EMPLOYEE_CODE = :P300_EMPLOYEE_CODE) = EMPLOYEE_CODE;
    
    --For employee
-- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', :APP_USER_NAME, 'Leave Request Submitted Successfully', '<p> Dear '|| :P300_EMPLOYEE ||', </p>' ||
SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'khanhnguyendev@vus-etsc.edu.vn', 'Leave Request Submitted Successfully', '<p> Dear '|| :P300_EMPLOYEE ||', </p>' ||
'<p> Successfully submitted. Kindly return <b>My leave history page</b> to follow your leave request. Here are the details: </p>' ||
'<p> Employee Code: '|| :P300_EMPLOYEE_CODE ||' </p>' ||
'<p> Total Days: '|| :P300_TOTAL_DAYS ||' </p>' ||
'<p> From Date: '|| :P300_FROM_DATE ||' </p>' ||
'<p> To Date: '|| :P300_END_DATE ||' </p>' ||
'<br>' || 
'<p> If you have any questions or need further assistance, please feel free to reach out to the HR department. </p>' ||
'<br>' || 
'<p> Thank you, </p>' ||
'<p> VUS </p>');


    --For manager
-- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', manager_email, 'Leave Request Approval Required', '<p>Dear '|| manager_name ||',</p>' ||
SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'khanhnguyendev@vus-etsc.edu.vn', 'Leave Request Approval Required', '<p>Dear '|| manager_name ||',</p>' ||
    '<p>A leave request from '|| :P300_EMPLOYEE ||' requires your approval. Here are the details:</p>' ||
    '<p>Employee Code: '|| :P300_EMPLOYEE_CODE ||'</p>' ||
    '<p>Total Days: '|| :P300_TOTAL_DAYS ||'</p>' ||
    '<p>From Date: '|| :P300_FROM_DATE ||'</p>' ||
    '<p>To Date: '|| :P300_END_DATE ||'</p>' ||
    '<br>' || 
    '<p>Please log in to the leave management system to review and approve the request. You can approve the leave by clicking on the following link: <a href=\"https://erp-uat.vus.edu.vn/ords/r/erp/erp/approve-leave?request_id=' || to_char(v_id) || '\"> link to approve the leave ↗.</a></p>' ||
    '<br>' || 
    '<p>If you have any questions or need further information, please contact the HR department.</p>' ||
    '<br>' || 
    '<p>Thank you,</p>' ||'<p>VUS</p>');

end;

-- ----------------------------------------
-- Page: 300 - Leave Request for Employee - clone > Validation: Check overlapping leaves > Validation > PL/SQL Function Body

DECLARE
    TOTAL_OVERLAP_DAYS NUMBER := 0;
    V_TOTAL_DAYS       NUMBER;
    V_EMP_REQ_STATUS   NUMBER;
BEGIN
    FOR REC IN (
        SELECT
            TOTAL_DAYS,
            EMP_REQ_STATUS,
            FROM_DATE,
            END_DATE
        FROM
            EMPLOYEE_REQUESTS
        WHERE
            EMPLOYEE_CODE_REQ = :APP_EMP_CODE
            AND (TO_DATE(:P300_END_DATE, 'DD/MM/YYYY')  <= TO_DATE(END_DATE, 'MM/DD/YYYY')
            AND TO_DATE(:P300_FROM_DATE, 'DD/MM/YYYY') >= TO_DATE(FROM_DATE, 'MM/DD/YYYY')) -- Overlapping
    ) LOOP
        IF REC.EMP_REQ_STATUS = 5 THEN
            V_TOTAL_DAYS := -REC.TOTAL_DAYS;
        ELSIF REC.EMP_REQ_STATUS = 2 OR REC.EMP_REQ_STATUS = 3 THEN
            V_TOTAL_DAYS := REC.TOTAL_DAYS;
        ELSE
            V_TOTAL_DAYS := 0;
        END IF;
        TOTAL_OVERLAP_DAYS := TOTAL_OVERLAP_DAYS + V_TOTAL_DAYS;
    END LOOP;
    IF TOTAL_OVERLAP_DAYS >= 1 THEN
        RETURN FALSE;
    ELSE
        RETURN TRUE;
    END IF;
END;

-- ----------------------------------------
-- Page: 300 - Leave Request for Employee - clone > Validation: Check total > Validation > PL/SQL Function Body

DECLARE
    v_maximum_days NUMBER;
BEGIN
    -- FOR REC IN (
    --     SELECT
    --         AVAILABLE+CARRY_FORWARD_AVALABLE AS AVAILABLE
    --     FROM
    --         ABSENCE_GROUP_EMPLOYEE
    --     WHERE
    --         EMPLOYEE_CODE = :APP_EMP_CODE
    --         AND EXPIRATION_DATE >= TO_CHAR(SYSDATE, 'MM/DD/YYYY', 'NLS_DATE_LANGUAGE=AMERICAN')
    -- )LOOP
    --     IF :P300_TOTAL_DAYS <= REC.AVAILABLE THEN
    --         RETURN TRUE;
    --     ELSE
    --         RETURN FALSE;
    --     END IF;
    -- END LOOP;
    IF trim(:P300_ANNUAL_LEAVE) = 'APL' THEN
        SELECT TO_NUMBER(:P300_ANNUAL_LEAVE_BALANCE)
        INTO v_maximum_days
        FROM DUAL;
    ELSE
        SELECT MAXIMUM_LIMIT_PER_TIME
        INTO v_maximum_days
        FROM ABSENCE_CODE_LIST
        WHERE TRIM(LOWER(ACL_ABSENCECODE_ID)) = TRIM(LOWER(:P300_LEAVE_DETAIL));
    END IF;

        -- IF :P300_TOTAL_DAYS <= TO_NUMBER(:P300_ANNUAL_LEAVE_BALANCE) THEN
        --     RETURN TRUE;
        -- ELSE
        --     RETURN FALSE;
        -- END IF;

    IF :P300_TOTAL_DAYS <= v_maximum_days THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
    
END;

-- ----------------------------------------
-- Page: 300 - Leave Request for Employee - clone > Dynamic Action: New_1 > Action: Set End Time > Settings > PL/SQL Code

BEGIN
    :P300_END_TIME:= :P300_START_TIME;
END;


-- ----------------------------------------
-- Page: 300 - Leave Request for Employee - clone > Dynamic Action: Change end date > Action: Execute Server-side Code > Settings > PL/SQL Code

begin
if :P300_ALL_DAY = 'Y' then
select ROUND(TO_DATE(:P300_END_DATE,'DD/MM/YYYY')-TO_DATE(:P300_FROM_DATE,'DD/MM/YYYY'))+1 into :P300_TOTAL_DAYS FROM DUAL;
end if;
if :P300_ALL_DAY = 'N' then
select (TO_DATE(:P300_END_DATE,'DD/MM/YYYY')-TO_DATE(:P300_FROM_DATE,'DD/MM/YYYY'))+0.5 into :P300_TOTAL_DAYS FROM DUAL;
end if;
end;

-- ----------------------------------------
-- Page: 300 - Leave Request for Employee - clone > Dynamic Action: Change Type_1 > Action: Calc Balance > Settings > PL/SQL Code

declare
v_check number:=0;
begin
for rec in (select * from ABSENCE_GROUP_EMPLOYEE 
emp_al
right JOIN EMPLOYEES e ON emp_al.EMPLOYEE_CODE = e.EMPLOYEE_CODE
where USER_NAME = :APP_USER_NAME and EXPIRATION_DATE >= to_char(sysdate,'MM/DD/YYYY') 
 and HRM_ABSENCE_CODE_GROUP_ID = :P300_ANNUAL_LEAVE)loop
    if rec.CARRY_FORWORD_EXP_DATE >= to_char(sysdate,'MM/DD/YYYY')  then
        :P300_ANNUAL_LEAVE_BALANCE := rec.AVAILABLE + rec.CARRY_FORWARD_AVALABLE;
    else
        :P300_ANNUAL_LEAVE_BALANCE := rec.AVAILABLE;
    end if;
end loop;
/*
select nvl(AVAILABLE+CARRY_FORWARD_AVALABLE,0) into :P300_ANNUAL_LEAVE_BALANCE
from ABSENCE_GROUP_EMPLOYEE emp_al
right JOIN EMPLOYEES e ON emp_al.EMPLOYEE_CODE = e.EMPLOYEE_CODE
where e.USER_NAME = :APP_USER_NAME and HRM_ABSENCE_CODE_GROUP_ID = :P300_ANNUAL_LEAVE and EXPIRATION_DATE >= to_char(sysdate,'MM/DD/YYYY');
*/
end;

-- ----------------------------------------
-- Page: 300 - Leave Request for Employee - clone > Dynamic Action: Change Type_1 > Action: Update Leave Detail list > Settings > SQL Statement

select ACL_DESCRIPTION, ACL_ABSENCECODE_ID as ID 
FROM ABSENCE_CODE_LIST
WHERE ABSENCE_GROUP = :P300_ANNUAL_LEAVE
ORDER BY ACL_DESCRIPTION;

-- ----------------------------------------
-- Page: 300 - Leave Request for Employee - clone > Dynamic Action: Change from date > Action: Execute Server-side Code > Settings > PL/SQL Code

begin
if :P300_ALL_DAY = 'Y' then
select ROUND(TO_DATE(:P300_END_DATE, 'DD/MM/YYYY')-TO_DATE(:P300_FROM_DATE, 'DD/MM/YYYY'))+1 into :P300_TOTAL_DAYS FROM DUAL;
end if;
if :P300_ALL_DAY = 'N' then
select (TO_DATE(:P300_END_DATE, 'DD/MM/YYYY')-TO_DATE(:P300_FROM_DATE, 'DD/MM/YYYY'))+0.5 into :P300_TOTAL_DAYS FROM DUAL;
end if;
end;

-- ----------------------------------------
-- Page: 300 - Leave Request for Employee - clone > Dynamic Action: Change from date > Action: Change End_Date when it disabled > Settings > PL/SQL Code

BEGIN
    :P300_END_DATE := :P300_START_DATE;
END;


-- ----------------------------------------
-- Page: 300 - Leave Request for Employee - clone > Dynamic Action: Set display time > Action: Calculate Total Days > Settings > PL/SQL Code

-- begin
-- if :P300_ALL_DAY = 'Y' then
-- select ROUND(TO_DATE(:P300_END_DATE)-TO_DATE(:P300_FROM_DATE))+1 into :P300_TOTAL_DAYS FROM DUAL;
-- end if;
-- if :P300_ALL_DAY = 'N' then
-- select (TO_DATE(:P300_END_DATE)-TO_DATE(:P300_FROM_DATE))+0.5 into :P300_TOTAL_DAYS FROM DUAL;
-- end if;
-- end;

begin
if :P300_ALL_DAY = 'Y' then
select ROUND(TO_DATE(:P300_END_DATE,'DD/MM/YYYY')-TO_DATE(:P300_FROM_DATE,'DD/MM/YYYY'))+1 into :P300_TOTAL_DAYS FROM DUAL;
end if;
if :P300_ALL_DAY = 'N' then
select (TO_DATE(:P300_END_DATE,'DD/MM/YYYY')-TO_DATE(:P300_FROM_DATE,'DD/MM/YYYY'))+0.5 into :P300_TOTAL_DAYS FROM DUAL;
end if;
end;

-- ----------------------------------------
-- Page: 300 - Leave Request for Employee - clone > Page Item: P300_TOTAL_DAYS > Default > SQL Query

SELECT 
--case :P300_ALL_DAY
--when 'Y' then
--TO_DATE(:P300_END_DATE) - TO_DATE(:P300_FROM_DATE)
--else
--TO_DATE(:P300_END_DATE,'MM/DD/YYY')-TO_DATE(:P300_FROM_DATE,'MM/DD/YYY')+0.5
--null
--end 
--as total_days
0
FROM DUAL;

-- ----------------------------------------
-- Page: 300 - Leave Request for Employee - clone > Page Item: P300_END_DATE > Default > SQL Query

select sysdate from dual;

-- ----------------------------------------
-- Page: 300 - Leave Request for Employee - clone > Page Item: P300_FROM_DATE > Default > SQL Query

select sysdate from dual;

-- ----------------------------------------
-- Page: 300 - Leave Request for Employee - clone > Page Item: P300_MANAGER_CODE > Default > SQL Query

select MANAGER_POSITION_ID FROM EMPLOYEES e WHERE e.USER_NAME = :APP_USER_NAME;

-- ----------------------------------------
-- Page: 300 - Leave Request for Employee - clone > Page Item: P300_LEAVE_TYPE_DEPT > Default > SQL Query

SELECT SCHEDULE FROM EMPLOYEES WHERE EMPLOYEE_CODE = :APP_EMP_CODE;

-- ----------------------------------------
-- Page: 300 - Leave Request for Employee - clone > Page Item: P300_CURRENT_TIME_PROFILE > Default > SQL Query

SELECT PROFILE_ID FROM EMPLOYEES WHERE EMPLOYEE_CODE = :APP_EMP_CODE;

-- ----------------------------------------
-- Page: 300 - Leave Request for Employee - clone > Page Item: P300_ANNUAL_LEAVE > List of Values > SQL Query

select ACGL_DESCRIPTION,ACGL_ABSENCE_GROUP_ID as ID FROM ABSENCE_CODE_GROUP_LIST order by ACGL_DESCRIPTION;

-- ----------------------------------------
-- Page: 300 - Leave Request for Employee - clone > Page Item: P300_LEAVE_DETAIL > List of Values > SQL Query

select ACL_DESCRIPTION, ACL_ABSENCECODE_ID as ID 
FROM ABSENCE_CODE_LIST
WHERE ABSENCE_GROUP = :P300_ANNUAL_LEAVE
ORDER BY ACL_DESCRIPTION;

-- ----------------------------------------
-- Page: 300 - Leave Request for Employee - clone > Page Item: P300_EMPLOYEE > Default > SQL Query

select full_name from employees where EMPLOYEE_CODE = :APP_EMP_CODE;

-- ----------------------------------------
-- Page: 300 - Leave Request for Employee - clone > Page Item: P300_APPROVED_MANAGER > Default > SQL Query

SELECT EMPLOYEE_ID as ID FROM EMPLOYEES WHERE POSITION_ID = (
select MANAGER_POSITION_ID FROM EMPLOYEES WHERE EMPLOYEE_CODE = :APP_EMP_CODE );

