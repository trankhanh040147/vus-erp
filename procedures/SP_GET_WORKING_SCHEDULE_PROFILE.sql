-- GET From API GetWorkingSchedule


-- Response of the API:
-- [
--     {
--         "LegalEntityID": "v01",
--         "ProfileId": "ASA",
--         "Description": "ASA ca thường",
--         "ProfileColor": 15098425,
--         "Profile": [
--             {
--                 "ProfileId": "ASA",
--                 "ProfileTypeId": "Flex+",
--                 "Description": "Flex+",
--                 "StartTime": "07:00:00 am",
--                 "EndTime": "08:00:00 am",
--                 "StartDay": "Monday",
--                 "EndDay": "Monday",
--                 "Day": "Monday"
--             },
--             {
--                 "ProfileId": "ASA",
--                 "ProfileTypeId": "Clock-in",
--                 "Description": "Clock-in",
--                 "StartTime": "08:00:00 am",
--                 "EndTime": "08:00:00 am",
--                 "StartDay": "Monday",
--                 "EndDay": "Monday",
--                 "Day": "Monday"
--             },
--             {
--                 "ProfileId": "ASA",
--                 "ProfileTypeId": "Standard time",
--                 "Description": "Standard time",
--                 "StartTime": "08:00:00 am",
--                 "EndTime": "02:00:00 pm",
--                 "StartDay": "Monday",
--                 "EndDay": "Monday",
--                 "Day": "Monday"
--             },
--         ]
--     },
-- ]

-- Table: WORKING_PROFILE
-- ID	NUMBER(5,0)
-- PROFILE_ID	NVARCHAR2(30 CHAR)
-- COLOR	NVARCHAR2(50 CHAR)
-- DESCRIPTION	NVARCHAR2(100 CHAR)
-- LEGAL_ENTITY_ID	NVARCHAR2(20 CHAR)

-- Table: WORKING_PROFILE_DETAIL
-- ID	NUMBER(7,0)
-- PROFILE_ID	NVARCHAR2(25 CHAR)
-- PROFILE_TYPE_ID	NVARCHAR2(25 CHAR)
-- DESCRIPTION	NVARCHAR2(100 CHAR)
-- START_TIME	NVARCHAR2(10 CHAR)
-- END_TIME	NVARCHAR2(10 CHAR)
-- START_DAY	NUMBER
-- END_DAY	NUMBER
-- DAY_OF_WEEK	NUMBER

create or replace procedure "SP_GET_WORKING_SCHEDULE_PROFILE"
is
  l_method_url VARCHAR2(255);
  l_num_row number;
  n_profile_id VARCHAR2(30);
  n_color VARCHAR2(50);
  n_description VARCHAR2(100);
  n_legal_entity_id VARCHAR2(20);
  p_token nvarchar2(10000);
begin
  l_method_url := 'https://hra.sandbox.operations.dynamics.com/api/services/VUSTC_TimSheetServiceGroup/TimeSheetService/GetWorkingSchedule';

  SP_GET_TOKEN(p_token);

  apex_web_service.g_request_headers.delete();
  apex_web_service.g_request_headers(1).name := 'Content-Type';
  apex_web_service.g_request_headers(1).value := 'application/json';
  apex_web_service.g_request_headers(2).name := 'Content-Length';
  apex_web_service.g_request_headers(2).value := 0;
  apex_web_service.g_request_headers(3).name := 'Authorization';
  apex_web_service.g_request_headers(3).value := 'Bearer ' || p_token;

  APEX_JSON.parse(
    apex_web_service.make_rest_request(
      p_url => l_method_url,
      p_http_method => 'POST',
      p_body => l_body,
      p_transfer_timeout => 3600
    )
  );

  DBMS_OUTPUT.put_line(APEX_JSON.get_clob_output);

  l_num_row := APEX_JSON.get_count (p_path => '.');

--   FOR i IN 1 .. l_num_row
--   LOOP
--     n_legal_entity_id := APEX_JSON.get_varchar2('[%d].LegalEntityID', i);
--     n_profile_id := APEX_JSON.get_varchar2('[%d].ProfileId', i);
--     n_description := APEX_JSON.get_varchar2('[%d].Description', i);
--     n_color := TO_CHAR(APEX_JSON.get_number('[%d].ProfileColor', i));

--     -- Insert into WORKING_PROFILE
--     INSERT INTO WORKING_PROFILE (PROFILE_ID, COLOR, DESCRIPTION, LEGAL_ENTITY_ID)
--     VALUES (NVL(n_profile_id,'null'), n_color, n_description, n_legal_entity_id);
--   END LOOP;

  COMMIT;

end "SP_GET_WORKING_SCHEDULE_PROFILE";
/
