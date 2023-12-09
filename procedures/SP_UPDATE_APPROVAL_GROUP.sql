-- TABLE: EMPLOYEES
-- ID	NUMBER(10,0)
-- USER_NAME	NVARCHAR2(100 CHAR)
-- LEVEL_ID	NVARCHAR2(20 CHAR)
-- APPROVAL_GROUP	NVARCHAR2(50 CHAR)
-- MANAGER_ID	NVARCHAR2(100 CHAR) : This is employee code of manager

-- Update Approval_group for all employees based on level_id; have params to exclude certain USER_NAME
create or replace procedure "SP_UPDATE_APPROVAL_GROUP"
(
    p_exclude_user_name_list in varchar2 default null
)
as
begin
    -- p_exclude_user_name_list = 'user1,user2,user3'
    -- user_name will exclude USER_NAME is not like 'user1@%' and not like 'user2@%' and not like 'user3@%'

    -- OLD

    -- UPDATE EMPLOYEES
    -- SET APPROVAL_GROUP = 'head_of_' || lower(substr(DEPARTMENT_ID, instr(DEPARTMENT_ID, '_')+1)) 
    -- WHERE trim(lower(LEVEL_ID)) = 'd' -- Director
    -- AND DEPARTMENT_ID IS NOT NULL
    -- AND LOWER(SUBSTR(USER_NAME, 1, INSTR(USER_NAME, '@') - 1)) NOT IN ( -- exclude user_name
    --         SELECT TRIM(REGEXP_SUBSTR('hrtest04,hrtest01,t 06', '[^,]+', 1, LEVEL)) FROM DUAL
    --         CONNECT BY REGEXP_SUBSTR('hrtest04,hrtest01,t06', '[^,]+', 1, LEVEL) IS NOT NULL
    --     );

    -- .OLD

    -- NEW

    -- 1. Loop through all employees, find recursive manager to the root for each employee
    -- ex: 
    -- current_user_name := 'hrtest04';
    -- manager recursive list: hrtest04 <- hrtest01 <- t06 <- null 
    

    -- .NEW

end;
