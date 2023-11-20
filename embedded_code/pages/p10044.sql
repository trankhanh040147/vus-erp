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
-- Page: 10044 - Add Multiple Users - Step 2 > Region: Exceptions > Server-side Condition (Rows returned) > SQL Query

select 1
  from apex_collections
 where collection_name = 'ACL_BULK_USER_INVALID';

-- ----------------------------------------
-- Page: 10044 - Add Multiple Users - Step 2 > Process: Add Users to Access Control List > Source > PL/SQL Code

declare
    l_user_role_ids apex_application_global.vc_arr2;
begin
    for c in (  select distinct c001 as username, c003 as user_roles
                from   apex_collections
                where  collection_name = 'ACL_BULK_USER_VALID' )
    loop
         l_user_role_ids := apex_util.string_to_table(c.user_roles);
         for i in 1..l_user_role_ids.count loop
             apex_acl.add_user_role(p_application_id => :APP_ID, p_user_name => c.username, p_role_id => l_user_role_ids(i));
         end loop;
    end loop;

    apex_collection.delete_collection('ACL_BULK_USER_INVALID');
    apex_collection.delete_collection('ACL_BULK_USER_VALID');
    :P10043_PRELIM_USERS := null;
end;

-- ----------------------------------------
-- Page: 10044 - Add Multiple Users - Step 2 > Button: SUBMIT > Server-side Condition (Rows returned) > SQL Query

select 1
  from apex_collections
 where collection_name = 'ACL_BULK_USER_VALID';

-- ----------------------------------------
-- Page: 10044 - Add Multiple Users - Step 2 > Page Item: P10044_INVALID_COUNT > Source > SQL Query

select count(*)
  from apex_collections
 where collection_name = 'ACL_BULK_USER_VALID';

-- ----------------------------------------
-- Page: 10044 - Add Multiple Users - Step 2 > Page Item: P10044_VALID_COUNT > Source > SQL Query

select count(*)
  from apex_collections
 where collection_name = 'ACL_BULK_USER_VALID';

-- ----------------------------------------
-- Page: 10044 - Add Multiple Users - Step 2 > Page Item: P10044_ROLE > Source > SQL Query

select LISTAGG( role_name, ', ')
         WITHIN GROUP (ORDER BY role_name) role_name
from APEX_APPL_ACL_ROLES
where application_id = :APP_ID
and instr(:P10043_ROLE, role_id, 1) > 0;

-- ----------------------------------------
-- Page: 10044 - Add Multiple Users - Step 2 > Region: No Valid Users Exist - Page Info > Server-side Condition (No Rows returned) > SQL Query

select 1
  from apex_collections
 where collection_name = 'ACL_BULK_USER_VALID';

-- ----------------------------------------
-- Page: 10044 - Add Multiple Users - Step 2 > Region: Valid Users Exist - Page Info > Server-side Condition (Rows returned) > SQL Query

select 1
  from apex_collections
 where collection_name = 'ACL_BULK_USER_VALID';

-- ----------------------------------------
-- Page: 10044 - Add Multiple Users - Step 2 > Region: &P10044_VALID_COUNT. Users to Add > Source > SQL Query

select distinct c001 username
  from apex_collections
 where collection_name = 'ACL_BULK_USER_VALID'
order by 1;

-- ----------------------------------------
-- Page: 10044 - Add Multiple Users - Step 2 > Region: &P10044_VALID_COUNT. Users to Add > Server-side Condition (Rows returned) > SQL Query

select 1
  from apex_collections
 where collection_name = 'ACL_BULK_USER_VALID';

-- ----------------------------------------
-- Page: 10044 - Add Multiple Users - Step 2 > Region: Exceptions > Source > SQL Query

select c001 username, c002 reason
  from apex_collections
 where collection_name = 'ACL_BULK_USER_INVALID'
order by 1;

