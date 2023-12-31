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