create or replace procedure "SP_UPDATE_PROFILE_COLOR"
as
begin
    UPDATE WORKING_PROFILE
    SET COLOR = (CASE 
        WHEN lower(PROFILE_ID) LIKE 'asa' OR 'asa-1' THEN '32a852' 
        WHEN (COLOR = '0' OR COLOR is NULL) AND lower(PROFILE_ID) LIKE 'asa%' THEN 'f15b29' 
        WHEN (COLOR = '0' OR COLOR is NULL) AND lower(PROFILE_ID) LIKE 'office%' THEN 'f69222' 
        WHEN (COLOR = '0' OR COLOR is NULL) AND lower(PROFILE_ID) LIKE 'ssc%' THEN 'f9af40' 
        WHEN (COLOR = '0' OR COLOR is NULL) AND lower(PROFILE_ID) LIKE '%test%' THEN 'ffc1a5' 
        WHEN (COLOR = '0' OR COLOR is NULL) AND lower(PROFILE_ID) LIKE 'vus%' THEN '8a0202' 
        WHEN (COLOR = '0' OR COLOR is NULL) AND lower(PROFILE_ID) LIKE 'standard%' THEN 'c3121a' 
        WHEN (COLOR = '0' OR COLOR is NULL) AND lower(PROFILE_ID) LIKE '%nam%' THEN 'fc5e03' 
        ELSE to_char(COLOR)
    END);
end "SP_UPDATE_PROFILE_COLOR";
/