declare
    l_numrows number;
    id_rec number;
begin
    APEX_JSON.PARSE(:P43_IMPORT_DATA); 
    l_numrows := APEX_JSON.get_count(p_path => '.');
    
    if l_numrows > 0 then
        FOR i IN 1 .. l_numrows
        LOOP
            id_rec := to_number(APEX_JSON.get_varchar2(p_path => '[%d].EVENT_ID', p0 => i));
            
            IF id_rec is not null and id_rec > 0 THEN
                UPDATE WORKING_SCHEDULE_EVENTS
                SET 
                    WS_ID = TO_NUMBER(APEX_JSON.get_varchar2(p_path => '[%d].WS_ID', p0 => i)),
                    DESCRIPTION = APEX_JSON.get_varchar2(p_path => '[%d].EVENT_DESCRIPTION', p0 => i)
                WHERE ID = id_rec;
            ELSE
                insert into WORKING_SCHEDULE_EVENTS (
                    WS_ID,
                    DESCRIPTION
                )
                values (
                    TO_NUMBER(APEX_JSON.get_varchar2(p_path => '[%d].WS_ID', p0 => i)),
                    APEX_JSON.get_varchar2(p_path => '[%d].EVENT_DESCRIPTION', p0 => i)
                );
            end if;
        end loop;
    end if;
end;
