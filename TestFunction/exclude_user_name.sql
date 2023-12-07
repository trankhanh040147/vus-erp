declare
    p_exclude_user_name_list in varchar2
begin
    -- p_exclude_user_name_list = 'user1,user2,user3'
    -- user_name will exclude USER_NAME is not like '%user1%' and not like '%user2%' and not like '%user3%'
    SELECT USER_NAME FROM EMPLOYEES
    WHERE LOWER(SUBSTR(USER_NAME, 1, INSTR(USER_NAME, '@') - 1)) LIKE '%est%' 
        AND LOWER(SUBSTR(USER_NAME, 1, INSTR(USER_NAME, '@') - 1)) NOT IN (
            SELECT TRIM(REGEXP_SUBSTR('hrtest04,hrtest01,t06', '[^,]+', 1, LEVEL)) FROM DUAL
            CONNECT BY REGEXP_SUBSTR('hrtest04,hrtest01,t06', '[^,]+', 1, LEVEL) IS NOT NULL
        );

end;