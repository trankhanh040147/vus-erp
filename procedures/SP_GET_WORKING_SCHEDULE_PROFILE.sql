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
-- END_TIME	NVARCHAR2(10 CHAR)a
-- START_DAY	NUMBER
-- END_DAY	NUMBER
-- DAY_OF_WEEK	NUMBER

create or replace procedure "SP_GET_WORKING_SCHEDULE_PROFILE"
    (
       p_legal_entity VARCHAR2
    )
    is
      l_method_url VARCHAR2(255);
      l_num_row number;
      l_body NVARCHAR2(2000);
      l_response clob;
      l_count_idemp number;
      n_profile_id VARCHAR2(30);
      n_color VARCHAR2(50);
      n_description VARCHAR2(100);
      n_legal_entity_id VARCHAR2(20);
      p_token nvarchar2(10000);
    begin
      l_method_url := 'https://hra.sandbox.operations.dynamics.com/api/services/VUSTC_TimSheetServiceGroup/TimeSheetService/GetWorkingSchedule';

      SP_GET_TOKEN(p_token);

      apex_web_service.g_request_headers.delete();
      apex_web_service.g_request_headers(1).name := 'Authorization';
      apex_web_service.g_request_headers(1).value := 'Bearer '|| p_token;
      
      apex_web_service.g_request_headers(2).name := 'Content-Type';
      apex_web_service.g_request_headers(2).value := 'application/json';

    --   l_body := '{"_jsonRequest":{"LegalEntityID":"' || p_legal_entity || '"} }';
      l_body := '{"_jsonRequest":{"LegalEntityID": "V01"}}';

      DBMS_OUTPUT.put_line(l_body);

      l_response := apex_web_service.make_rest_request(
          p_url => 'https://hra.sandbox.operations.dynamics.com/api/services/VUSTC_TimSheetServiceGroup/TimeSheetService/GetWorkingSchedule',
          p_http_method => 'POST',
          p_body => l_body,
          p_transfer_timeout => 3600
      );

      APEX_JSON.parse(l_response); 
    --   DBMS_OUTPUT.put_line(l_response);


    --       APEX_JSON.parse(
    --     apex_web_service.make_rest_request(
    --       p_url => l_method_url,
    --       p_http_method => 'POST',
    --     --   p_body => l_body,
    --       p_transfer_timeout => 3600
    --     )
    --   );

    --   DBMS_OUTPUT.put_line(APEX_JSON.get_clob_output);

      l_num_row := APEX_JSON.get_count (p_path => '.');

      FOR i IN 1 .. l_num_row
      LOOP
        n_legal_entity_id := APEX_JSON.get_varchar2('[%d].LegalEntityID', i);
        n_profile_id := APEX_JSON.get_varchar2('[%d].ProfileId', i);
        n_description := APEX_JSON.get_varchar2('[%d].Description', i);
        n_color := TO_CHAR(APEX_JSON.get_number('[%d].ProfileColor', i));

        SELECT COUNT(ID) INTO l_count_idemp FROM WORKING_PROFILE WHERE PROFILE_ID = n_profile_id AND LEGAL_ENTITY_ID = n_legal_entity_id;
        
        -- Insert/Update into WORKING_PROFILE
        if l_count_idemp = 0 then
            -- Insert into WORKING_PROFILE
            INSERT INTO WORKING_PROFILE (PROFILE_ID, COLOR, DESCRIPTION, LEGAL_ENTITY_ID)
            VALUES (n_profile_id, n_color, n_description, n_legal_entity_id);
        else
            UPDATE WORKING_PROFILE
            SET COLOR = n_color,
                DESCRIPTION = n_description
            WHERE PROFILE_ID = n_profile_id AND LEGAL_ENTITY_ID = n_legal_entity_id;
        end if;

      END LOOP;


END;
/