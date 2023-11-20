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
-- Authorization: Admin & Manager Rights > Settings > PL/SQL Function Body

declare
n_count number;

Begin
select count(*) into n_count from employees p
where p.employee_ID = :APP_USER_ID and :APP_USER_ROLE_ID in(0,1,2);

IF n_count >0 then
return TRUE;
else 
return FALSE;
END IF;

End;

-- ----------------------------------------
-- Authorization: Admin ONLY > Settings > PL/SQL Function Body

declare
n_count number;

Begin
select count(*) into n_count from employees p
where p.employee_ID = :APP_USER_ID and :APP_USER_ROLE_ID in(0);

IF n_count >0 then
return TRUE;
else 
return FALSE;
END IF;

End;

-- ----------------------------------------
-- Authorization: Admin Rights > Settings > PL/SQL Function Body

declare
n_count number;

Begin
select count(*) into n_count from USERS U
join USER_ROLES UR on U.Id = UR.User_Id
join ROLES R on UR.Role_Id = R.Id
where U.ID = :APP_USER_ACCESS_ID and R.CODE ='ADMIN';

IF n_count >0 then
return TRUE;
else 
return FALSE;
END IF;

End;

-- ----------------------------------------
-- Authorization: Reader Rights > Settings > PL/SQL Function Body

if nvl(apex_app_setting.get_value(
   p_name => 'ACCESS_CONTROL_SCOPE'),'x') = 'ALL_USERS' then
    -- allow user not in the ACL to access the application
    return true;
else
    -- require user to have at least one role
    return apex_acl.has_user_any_roles (
        p_application_id => :APP_ID, 
        p_user_name      => :APP_USER);
end if;

