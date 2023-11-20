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
-- Page: 10043 - Add Multiple Users - Step 1 > Process: Create Collections > Source > PL/SQL Code

declare
    l_line      varchar2(32767);
    l_emails    apex_t_varchar2;
    l_username  varchar2(4000);
    l_at        number;
    l_dot       number;
    l_valid     boolean := true;
    l_domain    varchar2(4000);
begin
    -- create collections
    apex_collection.create_or_truncate_collection('ACL_BULK_USER_INVALID');
    apex_collection.create_or_truncate_collection('ACL_BULK_USER_VALID');

    -- replace delimiting characters with commas
    l_line := :P10043_PRELIM_USERS;
    l_line := replace(l_line, chr(10), ' ');
    l_line := replace(l_line, chr(13), ' ');
    l_line := replace(l_line, chr(9),  ' ');
    l_line := replace(l_line, '<', ' ');
    l_line := replace(l_line, '>', ' ');
    l_line := replace(l_line, ';', ' ');
    l_line := replace(l_line, ':', ' ');
    l_line := replace(l_line, '(', ' ');
    l_line := replace(l_line, ')', ' ');
    l_line := replace(l_line, ' ', ',');

    -- get one comma separated line of emails
    for j in 1 .. 1000 loop
        if instr(l_line, ',,') > 0 then
            l_line := replace(l_line, ',,', ',');
        else
            exit;
        end if;
    end loop;

    -- get an array of emails
    l_emails := apex_string.split(l_line, ',');

    -- add emails to a collection
    l_username := null;
    l_domain   := null;
    l_at       := 0;
    l_dot      := 0;
    for j in 1..l_emails.count loop
        l_valid    := true;
        l_username := upper(trim(l_emails(j)));
        l_username := trim(both '.' from l_username);
        l_username := replace(l_username, ' ', null);
        l_username := replace(l_username, chr(10), null);
        l_username := replace(l_username, chr(9), null);
        l_username := replace(l_username, chr(13), null);
        l_username := replace(l_username, chr(49824), null);

        if l_username is not null then
            if nvl(:P10043_USERNAME_FORMAT,'x') = 'EMAIL' then
              -- Validate
              l_at     := instr(nvl(l_username, 'x'), '@');
              l_domain := substr(l_username, l_at+1);
              l_dot    := instr(l_domain, '.');
              if l_at < 2 then
                  -- invalid email
                  apex_collection.add_member(
                      p_collection_name => 'ACL_BULK_USER_INVALID',
                      p_c001            => l_username,
                      p_c002            => apex_lang.message('APEX.FEATURE.ACL.BULK_USER.MISSING_AT_SIGN'));
                  commit;
                  l_valid := false;
              end if;

              if l_dot = 0 and l_valid then
                  apex_collection.add_member(
                      p_collection_name => 'ACL_BULK_USER_INVALID',
                      p_c001            => l_username,
                      p_c002            => apex_lang.message('APEX.FEATURE.ACL.BULK_USER.MISSING_DOT'));
                  commit;
                  l_valid := false;
              end if;
            end if;

            if l_valid and length(l_username) > 255 then
                apex_collection.add_member(
                    p_collection_name => 'ACL_BULK_USER_INVALID',
                    p_c001            => l_username,
                    p_c002            => apex_lang.message('APEX.FEATURE.ACL.BULK_USER.USERNAME_TOO_LONG'));
                commit;
                l_valid := false;
            end if;

            if l_valid then
                for c1 in (select user_name username
                             from APEX_APPL_ACL_USERS
                            where user_name = l_username and application_id = :APP_ID)
                loop
                    apex_collection.add_member(
                        p_collection_name => 'ACL_BULK_USER_INVALID',
                        p_c001            => l_username,
                        p_c002            => apex_lang.message('APEX.FEATURE.ACL.BULK_USER.ALREADY_IN_ACL'));
                    commit;
                    l_valid := false;
                    exit;
                end loop;
            end if;

            if l_valid then
                for c1 in (select c001
                             from apex_collections
                            where collection_name = 'ACL_BULK_USER_VALID'
                              and c001            = l_username)
                loop
                    apex_collection.add_member(
                        p_collection_name => 'ACL_BULK_USER_INVALID',
                        p_c001            => l_username,
                        p_c002            => apex_lang.message('APEX.FEATURE.ACL.BULK_USER.DUPLICATE_USER'));
                        commit;
                    l_valid := false;
                    exit;
                end loop;
            end if;

            if l_valid then
                apex_collection.add_member(
                    p_collection_name => 'ACL_BULK_USER_VALID',
                    p_c001            => l_username,
                    p_c002            => null,
                    p_c003            => :P10043_ROLE);
                    commit;
            end if;

        end if;
        l_username := null;
    end loop;
end;

