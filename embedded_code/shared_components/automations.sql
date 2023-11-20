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
-- Automation: Reject leaves on calculation time > Action: New Action > Source > PL/SQL Code

begin
    null;
end;

-- ----------------------------------------
-- Automation: Set user role > Action: Set user role > Source > PL/SQL Code

declare
begin
for rec in (select emp.id,emp.WORKER_TITLE_ID from employees emp 
join (select MANAGER_POSITION_ID from employees 
where MANAGER_POSITION_ID is not null AND LOWER(USER_NAME) NOT LIKE '%hrtest%' group by MANAGER_POSITION_ID) mt on emp.POSITION_ID = mt.MANAGER_POSITION_ID)loop
    if rec.WORKER_TITLE_ID is null then
        update employees set WORKER_TITLE_ID = 'MANAGER' where rec.id = id;
    end if;
end loop;
end;


-- ----------------------------------------
-- Automation: send email HPBD > Action: Call API send email > Source > PL/SQL Code

declare
l_body clob;
l_response_clob clob;
begin
    for rec in (select ID, GENDER, FULL_NAME, USER_NAME as USER_EMAIL, DOB from EMPLOYEES 
    where DOB is not NULL and to_char(DOB, 'dd/mm') = to_char(sysdate, 'dd/mm')) loop
        l_body := '{"email":"'||rec.USER_EMAIL||'","name":"'||rec.FULL_NAME||'"}';
                                apex_web_service.g_request_headers(1).name := 'Content-Type';
                                apex_web_service.g_request_headers(1).value := 'application/json';
                        l_response_clob :=  apex_web_service.make_rest_request(
                                p_url => 'https://prod-63.southeastasia.logic.azure.com:443/workflows/131c9ca26eb24beab0dd440ef6193ea2/triggers/manual/paths/invoke?api-version=2016-06-01&sp=%2Ftriggers%2Fmanual%2Frun&sv=1.0&sig=P38KXMniHVHw-L_DRqj1X-iP2na3lPLBc59nz6fp9eE',
                                p_http_method => 'POST',
                                p_body => l_body,
                                p_transfer_timeout => 3600
                                );
                            dbms_output.put_line (  l_response_clob );
    end loop;
end;

