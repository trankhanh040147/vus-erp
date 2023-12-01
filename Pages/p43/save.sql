-- declare
--     l_numrows number;
--     id_rec number;
-- begin
--     APEX_JSON.PARSE(:P43_IMPORT_DATA); 
--     l_numrows := APEX_JSON.get_count(p_path => '.');
    
--     if l_numrows > 0 then
--         FOR i IN 1 .. l_numrows
--         LOOP
--             id_rec := to_number(APEX_JSON.get_varchar2(p_path => '[%d].ID', p0 => i));
            
--             IF id_rec is not null and id_rec > 0 THEN
--                 UPDATE WORKING_SCHEDULE
--                 SET 
--                     EMPLOYEE_CODE = APEX_JSON.get_varchar2(p_path => '[%d].EMPLOYEE_CODE', p0 => i),
--                     WS_DATE = to_date(APEX_JSON.get_varchar2(p_path => '[%d].DATE', p0 => i), 'YYYY-MM-DD'),
--                     PROFILE_ID = APEX_JSON.get_varchar2(p_path => '[%d].PROFILE_ID', p0 => i),
--                     LINE_REC_ID = APEX_JSON.get_varchar2(p_path => '[%d].LINE_REC_ID', p0 => i),
--                     -- START_TIME =  SUBSTR(APEX_JSON.get_varchar2(p_path => '[%d].START_TIME', p0 => i), 1, 5),
--                     -- END_TIME = SUBSTR(APEX_JSON.get_varchar2(p_path => '[%d].END_TIME', p0 => i), 1, 5),
--                     TIMELINE = APEX_JSON.get_varchar2(p_path => '[%d].TIMELINE', p0 => i),
--                     COLOR = APEX_JSON.get_varchar2(p_path => '[%d].COLOR', p0 => i)
--                 WHERE ID = id_rec;
--             ELSE
--                 insert into WORKING_SCHEDULE (
--                     EMPLOYEE_CODE,
--                     WS_DATE,
--                     PROFILE_ID,
--                     LINE_REC_ID,
--                     TIMELINE,
--                     COLOR
--                 )
--                 values (
--                     APEX_JSON.get_varchar2(p_path => '[%d].EMPLOYEE_CODE', p0 => i),
--                     to_date(APEX_JSON.get_varchar2(p_path => '[%d].DATE', p0 => i), 'YYYY-MM-DD'),
--                     APEX_JSON.get_varchar2(p_path => '[%d].PROFILE_ID', p0 => i),
--                     APEX_JSON.get_varchar2(p_path => '[%d].LINE_REC_ID', p0 => i),
--                     APEX_JSON.get_varchar2(p_path => '[%d].TIMELINE', p0 => i),
--                     APEX_JSON.get_varchar2(p_path => '[%d].COLOR', p0 => i)
--                 );
--             end if;
--         end loop;
--     end if;
-- end;

-- declare
-- l_numrows number;
-- begin
-- APEX_JSON.PARSE(:P43_IMPORT_DATA); 
--     l_numrows := APEX_JSON.get_count (p_path => '.');
--     if l_numrows > 0 then
--         FOR i IN 1 .. l_numrows   
--         LOOP
--             insert into
--                 WORKING_SCHEDULE (
--                     EMPLOYEE_CODE,
--                     WS_DATE,
--                     PROFILE_ID,
--                     LINE_REC_ID,
--                     START_TIME,
--                     END_TIME
--                 )
--             values
--                 (
--                     APEX_JSON.get_varchar2('[%d].EMPLOYEE_CODE', i),
--                     to_date(APEX_JSON.get_varchar2('[%d].DATE', i),'YYYY-MM-DD'),
--                     APEX_JSON.get_varchar2('[%d].PROFILE_ID', i),
--                     APEX_JSON.get_varchar2('[%d].LINE_REC_ID', i),
--                     APEX_JSON.get_varchar2('[%d].START_TIME', i),
--                     APEX_JSON.get_varchar2('[%d].END_TIME', i)
--                 );
--         end loop;
--     end if;
-- end;

declare
    l_numrows number;
    id_rec number;
    id_event number;
begin
    APEX_JSON.PARSE(:P43_IMPORT_DATA); 
    l_numrows := APEX_JSON.get_count(p_path => '.');
    
    if l_numrows > 0 then
        FOR i IN 1 .. l_numrows
        LOOP
            id_rec := to_number(APEX_JSON.get_varchar2(p_path => '[%d].ID', p0 => i));

            id_event := to_number(APEX_JSON.get_varchar2(p_path => '[%d].WS_ID', p0 => i));
            
            IF id_rec is not null and id_rec > 0 THEN
                UPDATE WORKING_SCHEDULE
                SET 
                    EMPLOYEE_CODE = APEX_JSON.get_varchar2(p_path => '[%d].EMPLOYEE_CODE', p0 => i),
                    WS_DATE = to_date(APEX_JSON.get_varchar2(p_path => '[%d].DATE', p0 => i), 'YYYY-MM-DD'),
                    PROFILE_ID = APEX_JSON.get_varchar2(p_path => '[%d].PROFILE_ID', p0 => i),
                    LINE_REC_ID = APEX_JSON.get_varchar2(p_path => '[%d].LINE_REC_ID', p0 => i),
                    -- START_TIME =  SUBSTR(APEX_JSON.get_varchar2(p_path => '[%d].START_TIME', p0 => i), 1, 5),
                    -- END_TIME = SUBSTR(APEX_JSON.get_varchar2(p_path => '[%d].END_TIME', p0 => i), 1, 5),
                    TIMELINE = APEX_JSON.get_varchar2(p_path => '[%d].TIMELINE', p0 => i),
                    COLOR = APEX_JSON.get_varchar2(p_path => '[%d].COLOR', p0 => i),
                    EVENT_DESCRIPTION = APEX_JSON.get_varchar2(p_path => '[%d].EVENT_DESCRIPTION', p0 => i)
                WHERE ID = id_rec;
            ELSE
                insert into WORKING_SCHEDULE (
                    EMPLOYEE_CODE,
                    WS_DATE,
                    PROFILE_ID,
                    LINE_REC_ID,
                    TIMELINE,
                    COLOR,
                    EVENT_DESCRIPTION
                )
                values (
                    APEX_JSON.get_varchar2(p_path => '[%d].EMPLOYEE_CODE', p0 => i),
                    to_date(APEX_JSON.get_varchar2(p_path => '[%d].DATE', p0 => i), 'YYYY-MM-DD'),
                    APEX_JSON.get_varchar2(p_path => '[%d].PROFILE_ID', p0 => i),
                    APEX_JSON.get_varchar2(p_path => '[%d].LINE_REC_ID', p0 => i),
                    APEX_JSON.get_varchar2(p_path => '[%d].TIMELINE', p0 => i),
                    APEX_JSON.get_varchar2(p_path => '[%d].COLOR', p0 => i),
                    APEX_JSON.get_varchar2(p_path => '[%d].EVENT_DESCRIPTION', p0 => i)
                );
            end if;

            -- IF id_event is not null and id_event > 0 THEN
            --     UPDATE WORKING_SCHEDULE_EVENTS
            --     SET 
            --         WS_ID = TO_NUMBER(APEX_JSON.get_varchar2(p_path => '[%d].WS_ID', p0 => i)),
            --         DESCRIPTION = APEX_JSON.get_varchar2(p_path => '[%d].EVENT_DESCRIPTION', p0 => i)
            --     WHERE ID = id_event;
            -- ELSE
            --     insert into WORKING_SCHEDULE_EVENTS (
            --         WS_ID,
            --         DESCRIPTION
            --     )
            --     values (
            --         TO_NUMBER(APEX_JSON.get_varchar2(p_path => '[%d].WS_ID', p0 => i)),
            --         APEX_JSON.get_varchar2(p_path => '[%d].EVENT_DESCRIPTION', p0 => i)
            --     );
            -- end if;

        end loop;
    end if;


    -- $('#P43_REMOVE_DATA').val()
    -- '["332","331"]'
    -- delete from WORKING_SCHEDULE where ID in p43_remove_data;

    APEX_JSON.PARSE(:P43_REMOVE_DATA);
    l_numrows := APEX_JSON.get_count(p_path => '.');
    if l_numrows > 0 then
        FOR i IN 1 .. l_numrows
        LOOP
            id_rec := to_number(APEX_JSON.get_varchar2(p_path => '[%d]', p0 => i));
            delete from WORKING_SCHEDULE where ID = id_rec;
        end loop;
    end if;
    
end;

