-- declare
-- l_numrows number;
-- begin
-- APEX_JSON.PARSE(:P43_IMPORT_DATA); 
--     l_numrows := APEX_JSON.get_count (p_path => '.');
--     if l_numrows > 0 then
--         FOR i IN 1 .. l_numrows   
--         LOOP
--             insert into WORKING_SCHEDULE (EMPLOYEE_CODE,WS_DATE,TIME_OF_DAY,PROFILE_ID,DAY_OF_WEEK) values (
--                 APEX_JSON.get_varchar2('[%d].empl_id',i),to_date(APEX_JSON.get_varchar2('[%d].ws_date',i),'DD/MM/YYYY'),
--                 APEX_JSON.get_varchar2('[%d].timeOfDay',i),APEX_JSON.get_varchar2('[%d].profileId',i),to_char(to_date(APEX_JSON.get_varchar2('[%d].ws_date',i),'DD/MM/YYYY'),'D')
--             );
--         end loop;
--     end if;
-- end;

declare
l_numrows number;
begin
APEX_JSON.PARSE(:P43_IMPORT_DATA); 
    l_numrows := APEX_JSON.get_count (p_path => '.');
    if l_numrows > 0 then
        FOR i IN 1 .. l_numrows   
        LOOP
            insert into
                WORKING_SCHEDULE (
                    EMPLOYEE_CODE,
                    WS_DATE,
                    PROFILE_ID,
                    LINE_REC_ID,
                    START_TIME,
                    END_TIME
                )
            values
                (
                    APEX_JSON.get_varchar2('[%d].EMPLOYEE_CODE', i),
                    to_date(APEX_JSON.get_varchar2('[%d].DATE', i),'YYYY-MM-DD'),
                    APEX_JSON.get_varchar2('[%d].PROFILE_ID', i),
                    APEX_JSON.get_varchar2('[%d].LINE_REC_ID', i),
                    APEX_JSON.get_varchar2('[%d].START_TIME', i),
                    APEX_JSON.get_varchar2('[%d].END_TIME', i)
                );
        end loop;
    end if;
end;
