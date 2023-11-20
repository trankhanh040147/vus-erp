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
-- Page: 43 - Working Schedule > Page Item: P43_PROFILE_TIME > List of Values > SQL Query

SELECT PROFILE_ID, PROFILE_ID as ID
FROM WORKING_PROFILE WP
WHERE lower(WP.PROFILE_ID) NOT LIKE '%test%'
AND lower(WP.PROFILE_ID) NOT LIKE '%nam%';

-- ----------------------------------------
-- Page: 43 - Working Schedule > Process: Save data > Source > PL/SQL Code

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
end;



-- ----------------------------------------
-- Page: 43 - Working Schedule > Process: GET_PROFILE_LINES > Source > PL/SQL Code

DECLARE
   l_cursor SYS_REFCURSOR;
BEGIN
   -- Initialize the JSON output
   APEX_JSON.initialize_clob_output;
   
   -- Open the cursor
   OPEN l_cursor FOR
      SELECT ID, START_TIME, END_TIME 
      FROM WORKING_PROFILE_LINES 
      WHERE PROFILE_ID = APEX_APPLICATION.G_X01;

   -- Convert cursor data to JSON format
   APEX_JSON.open_object; -- Open the main JSON object
   APEX_JSON.write('data', l_cursor); -- Write cursor data as 'data' array in JSON
   APEX_JSON.close_object; -- Close the main JSON object

   -- Fetch the JSON output
   HTP.p(APEX_JSON.get_clob_output);

   -- Close JSON output and free memory
   APEX_JSON.free_output;
END;


-- ----------------------------------------
-- Page: 43 - Working Schedule > Process: Reset  > Source > PL/SQL Code

BEGIN
    :P43_EMPLOYEE_NAME := '';
    :P43_PROFILE_TIME := '';
END;

-- ----------------------------------------
-- Page: 43 - Working Schedule > Dynamic Action: Typing > Action: Reload list > Settings > SQL Statement

-- SELECT JSON_ARRAYAGG(
--   JSON_OBJECT(
--     'WP_ID' VALUE WP.ID,
--     'WPL_ID' VALUE WPL.ID,
--     'COLOR' VALUE WP.COLOR,
--     'PROFILE_ID' VALUE WPL.PROFILE_ID,
--     'START_TIME' VALUE WPL.START_TIME,
--     'END_TIME' VALUE WPL.END_TIME
--   )
-- ) AS json_data
-- FROM WORKING_PROFILE_LINES WPL
-- JOIN WORKING_PROFILE WP ON WPL.PROFILE_ID = WP.PROFILE_ID
-- WHERE lower(WP.PROFILE_ID) NOT LIKE '%test%'
-- AND lower(WP.PROFILE_ID) NOT LIKE '%nam%'
-- AND lower(WP.PROFILE_ID) LIKE '%' || LOWER(TRIM(:P43_SEARCH_PROFILE)) || '%';

SELECT JSON_ARRAYAGG(
  JSON_OBJECT(
    'WPL_ID' VALUE WPL.LINE_REC_ID,
    'COLOR' VALUE WP.COLOR,
    'PROFILE_ID' VALUE WPL.PROFILE_ID,
    'START_TIME' VALUE WPL.START_TIME,
    'END_TIME' VALUE WPL.END_TIME
  )
) AS json_data
FROM WORKING_PROFILE_LINES WPL
JOIN WORKING_PROFILE WP ON WPL.PROFILE_ID = WP.PROFILE_ID
WHERE lower(WP.PROFILE_ID) NOT LIKE '%test%'
AND lower(WP.PROFILE_ID) NOT LIKE '%nam%'
AND (WPL.START_DAY = 2 AND WPL.END_DAY = 2 AND WPL.DAY_OF_WEEK = 2)
AND lower(WP.PROFILE_ID) LIKE '%' || LOWER(TRIM(:P43_SEARCH_PROFILE)) || '%'
AND wpl.PROFILE_TYPE_ID = 'standardtime';

-- ----------------------------------------
-- Page: 43 - Working Schedule > Page Item: P43_PROFILE_LINES_FILTER > Source > SQL Query

-- SELECT JSON_ARRAYAGG(
--   JSON_OBJECT(
--     'WPL_ID' VALUE WPL.LINE_REC_ID,
--     'COLOR' VALUE WP.COLOR,
--     'PROFILE_ID' VALUE WPL.PROFILE_ID,
--     'START_TIME' VALUE WPL.START_TIME,
--     'END_TIME' VALUE WPL.END_TIME
--   )
-- ) AS json_data
-- FROM WORKING_PROFILE_LINES WPL
-- JOIN WORKING_PROFILE WP ON WPL.PROFILE_ID = WP.PROFILE_ID
-- -- WHERE lower(WP.PROFILE_ID) NOT LIKE '%test%'
-- -- AND lower(WP.PROFILE_ID) NOT LIKE '%nam%'
-- AND (WPL.START_DAY = 2 AND WPL.END_DAY = 2 AND WPL.DAY_OF_WEEK = 2)
-- AND wpl.PROFILE_TYPE_ID = 'standardtime';

SELECT JSON_ARRAYAGG(
  JSON_OBJECT(
    'WPL_ID' VALUE STV.LINE_REC_IDS,
    'COLOR' VALUE WP.COLOR,
    'PROFILE_ID' VALUE STV.PROFILE_ID,
    'TIMELINE' VALUE STV.TIMELINE
    -- 'START_TIME' VALUE WPL.START_TIME,
    -- 'END_TIME' VALUE WPL.END_TIME
  )
) AS json_data
FROM STANDARDTIME_VIEW STV
JOIN WORKING_PROFILE WP ON STV.PROFILE_ID = WP.PROFILE_ID
-- WHERE lower(WP.PROFILE_ID) NOT LIKE '%test%'
-- AND lower(WP.PROFILE_ID) NOT LIKE '%nam%'
AND (STV.START_DAY = 2 AND STV.END_DAY = 2 AND STV.DAY_OF_WEEK = 2)
AND STV.PROFILE_TYPE_ID = 'standardtime';

-- ----------------------------------------
-- Page: 43 - Working Schedule > Page Item: P43_WORKING_SCHEDULE_EVENT > Source > SQL Query

SELECT JSON_ARRAYAGG(
  JSON_OBJECT(
    'EVENT_ID' VALUE WSE.ID,
    'WS_ID' VALUE WSE.WS_ID,
    'EVENT_DESCRIPTION' VALUE WSE.DESCRIPTION
  )
) AS json_data
FROM WORKING_SCHEDULE_EVENTS WSE;

-- ----------------------------------------
-- Page: 43 - Working Schedule > Page Item: P43_CALENDAR_ITEMS > Default > SQL Query

SELECT JSON_ARRAYAGG(
  JSON_OBJECT(
    'ID' VALUE ws.ID,
    'EMPLOYEE_CODE' VALUE ws.EMPLOYEE_CODE,
    'DATE' VALUE TO_CHAR(ws."WS_DATE", 'YYYY-MM-DD'),
    'PROFILE_ID' VALUE ws.PROFILE_ID,
    'LINE_REC_ID' VALUE ws.LINE_REC_ID,
    'EMPLOYEE_FULLNAME' VALUE e.FULL_NAME,
    'COLOR' VALUE ws.COLOR,
    'TIMELINE' VALUE ws.TIMELINE,
    'EVENT_DESCRIPTION' VALUE ws.EVENT_DESCRIPTION
    -- 'START_TIME' VALUE ws.START_TIME,
    -- 'END_TIME' VALUE ws.END_TIME
  )
) AS json_data
FROM WORKING_SCHEDULE ws
JOIN EMPLOYEES e ON e.EMPLOYEE_CODE = ws.EMPLOYEE_CODE
LEFT JOIN PROFILE_TIME_LIST ptl ON ptl.PROFILE_ID = ws.PROFILE_ID
WHERE lower(E.FULL_NAME) like '%' || TRIM(lower(:P43_EMPLOYEE_NAME)) ||'%'
    and lower(ws.PROFILE_ID) like '%' || lower(case when :P43_PROFILE_TIME = 'na' then '' else :P43_PROFILE_TIME end) || '%'
    and ws.PROFILE_ID not like '%-x-%';

-- ----------------------------------------
-- Page: 43 - Working Schedule > Page Item: P43_PROFILE_LINES > Source > SQL Query

-- SELECT JSON_ARRAYAGG(
--   JSON_OBJECT(
--     'WPL_ID' VALUE WPL.LINE_REC_ID,
--     'COLOR' VALUE WP.COLOR,
--     'PROFILE_ID' VALUE WPL.PROFILE_ID,
--     'START_TIME' VALUE WPL.START_TIME,
--     'END_TIME' VALUE WPL.END_TIME
--   )
-- ) AS json_data
-- FROM WORKING_PROFILE_LINES WPL
-- JOIN WORKING_PROFILE WP ON WPL.PROFILE_ID = WP.PROFILE_ID
-- -- WHERE lower(WP.PROFILE_ID) NOT LIKE '%test%'
-- -- AND lower(WP.PROFILE_ID) NOT LIKE '%nam%'
-- AND (WPL.START_DAY = 2 AND WPL.END_DAY = 2 AND WPL.DAY_OF_WEEK = 2)
-- AND wpl.PROFILE_TYPE_ID = 'standardtime';

SELECT JSON_ARRAYAGG(
  JSON_OBJECT(
    'WPL_ID' VALUE STV.LINE_REC_IDS,
    'COLOR' VALUE WP.COLOR,
    'PROFILE_ID' VALUE STV.PROFILE_ID,
    'TIMELINE' VALUE STV.TIMELINE
    -- 'START_TIME' VALUE WPL.START_TIME,
    -- 'END_TIME' VALUE WPL.END_TIME
  )
) AS json_data
FROM STANDARDTIME_VIEW STV
JOIN WORKING_PROFILE WP ON STV.PROFILE_ID = WP.PROFILE_ID
-- WHERE lower(WP.PROFILE_ID) NOT LIKE '%test%'
-- AND lower(WP.PROFILE_ID) NOT LIKE '%nam%'
AND (STV.START_DAY = 2 AND STV.END_DAY = 2 AND STV.DAY_OF_WEEK = 2)
AND STV.PROFILE_TYPE_ID = 'standardtime';

