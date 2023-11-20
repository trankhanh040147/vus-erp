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
-- Page: 24 - CALENDAR_WORKING_SCHEDULE > Page Item: P24_PROFILE_LINES_FILTER > Source > SQL Query

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
AND lower(WP.PROFILE_ID) LIKE '%' || LOWER(TRIM(:P24_SEARCH_PROFILE)) || '%'
AND wpl.PROFILE_TYPE_ID = 'standardtime';

-- ----------------------------------------
-- Page: 24 - CALENDAR_WORKING_SCHEDULE > Dynamic Action: Typing > Action: Reload list > Settings > SQL Statement

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
-- AND lower(WP.PROFILE_ID) LIKE '%' || LOWER(TRIM(:P24_SEARCH_PROFILE)) || '%';

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
AND lower(WP.PROFILE_ID) LIKE '%' || LOWER(TRIM(:P24_SEARCH_PROFILE)) || '%'
AND wpl.PROFILE_TYPE_ID = 'standardtime';

