create or replace procedure "SP_GET_WORKING_SCHEDULE_PROFILE_DETAIL"
(
    p_legal_entity_id NVARCHAR2
)
is
l_method_url NVARCHAR2(500);
l_body NVARCHAR2(10000);
l_num_row number;
l_count_unit_i number;
l_count_unit_j number;

n_legal_entity_id NVARCHAR2(50);
n_profile_id NVARCHAR2(50);
n_des NVARCHAR2(1000);
n_color NVARCHAR2(50);

n_profile_type_id NVARCHAR2(50);
n_des_detail NVARCHAR2(1000);
n_start_time NVARCHAR2(50);
n_end_time NVARCHAR2(50);
n_start_day NVARCHAR2(50);
n_end_day NVARCHAR2(50);
n_day NVARCHAR2(50);

num_start_day NUMBER;
num_end_day NUMBER;
num_day NUMBER;

p_token nvarchar2(10000);

BEGIN
    l_method_url := 'https://hra.sandbox.operations.dynamics.com/api/services/VUSTC_TimSheetServiceGroup/TimeSheetService/GetWorkingSchedule';

    SP_GET_TOKEN(p_token);

    apex_web_service.g_request_headers.delete();
    apex_web_service.g_request_headers(1).name := 'Content-Type';
    apex_web_service.g_request_headers(1).value := 'application/json';
    -- apex_web_service.g_request_headers(2).name := 'Content-Length';
    -- apex_web_service.g_request_headers(2).value := 0;
    apex_web_service.g_request_headers(2).name := 'Authorization';
    apex_web_service.g_request_headers(2).value := 'Bearer ' || p_token;

    l_body := '{"_jsonRequest":{"LegalEntityId":"' || p_legal_entity_id || '"}}';

    -- l_body := '{"_jsonRequest":{"LegalEntityID": "V01"}}';

    --DBMS_OUTPUT.put_line(l_body);
    
    apex_json.parse(
        apex_web_service.make_rest_request(
            p_url => l_method_url,
            p_http_method => 'POST',
            p_body => l_body,
            p_transfer_timeout => 3600
        )
    );

    l_num_row := apex_json.get_count (p_path => '.');

    --DBMS_OUTPUT.put_line(l_num_row);
    
    FOR i IN 1..l_num_row
    LOOP
        n_legal_entity_id := apex_json.get_varchar2('[%d].LegalEntityID', i);
        n_profile_id :=  apex_json.get_varchar2('[%d].ProfileId', i);
        n_profile_id :=  REPLACE(TRIM(n_profile_id), ' ', '');
        n_color := apex_json.get_varchar2('[%d].ProfileColor', i);
        n_des := apex_json.get_varchar2('[%d].Description', i);
        
        -- DBMS_OUTPUT.put_line(n_legal_entity_id);
        -- DBMS_OUTPUT.put_line(n_profile_id);
        -- DBMS_OUTPUT.put_line(n_color);
        -- DBMS_OUTPUT.put_line(n_des);

        SELECT COUNT(PROFILE_ID) INTO l_count_unit_i 
        FROM WORKING_PROFILE 
        WHERE PROFILE_ID = n_profile_id AND LEGAL_ENTITY_ID = n_legal_entity_id;

        if l_count_unit_i > 0 then
            UPDATE WORKING_PROFILE
            SET PROFILE_ID = n_profile_id, COLOR = n_color, DESCRIPTION = n_des, LEGAL_ENTITY_ID = n_legal_entity_id
            WHERE PROFILE_ID = n_profile_id AND LEGAL_ENTITY_ID = n_legal_entity_id;
        
        else
            INSERT INTO WORKING_PROFILE(PROFILE_ID, COLOR, DESCRIPTION, LEGAL_ENTITY_ID)
            VALUES(n_profile_id, n_color, n_des, n_legal_entity_id);

        end if;

        FOR j IN 1..apex_json.get_count('[%d].Profile', i)
        LOOP
            n_profile_type_id := apex_json.get_varchar2('[%d].Profile[%d].ProfileTypeId',i, j);
            n_profile_type_id :=  REPLACE(TRIM(n_profile_type_id), ' ', '');
            n_des_detail := apex_json.get_varchar2('[%d].Profile[%d].Description', i, j);
            n_start_time := apex_json.get_varchar2('[%d].Profile[%d].StartTime', i, j);
            n_end_time := apex_json.get_varchar2('[%d].Profile[%d].EndTime', i, j);
            n_start_day := apex_json.get_varchar2('[%d].Profile[%d].StartDay', i, j);
            n_end_day := apex_json.get_varchar2('[%d].Profile[%d].EndDay', i, j);
            n_day := apex_json.get_varchar2('[%d].Profile[%d].Day', i, j);
            --DBMS_OUTPUT.put_line(n_day);
            -- if (n_profile_type_id like 'Standard time') then
            --     DBMS_OUTPUT.put_line('ProfileId: ' || n_profile_id);
            --     DBMS_OUTPUT.put_line('ProfileTypeId: ' || n_profile_type_id);
            --     DBMS_OUTPUT.put_line('StartTime: ' || n_start_time);
            --     DBMS_OUTPUT.put_line('EndTime: ' || n_end_time);
            --     DBMS_OUTPUT.put_line('StartDay: ' || n_start_day);
            --     DBMS_OUTPUT.put_line('EndDay: ' || n_end_day);
            --     DBMS_OUTPUT.put_line('Day: ' || n_day);
            -- end if;

            CONVERT_DAY_TO_NUMBER(n_start_day, num_start_day);
            CONVERT_DAY_TO_NUMBER(n_end_day, num_end_day);
            CONVERT_DAY_TO_NUMBER(n_day, num_day);

            -- SELECT COUNT(*)
            -- INTO l_count_unit
            -- FROM WORKING_DETAIL_DEMO
            -- WHERE PROFILE_ID = n_profile_id
            --       AND LEGAL_ENTITY_ID = n_legal_entity_id
            --       AND PROFILE_TYPE_ID = n_profile_type_id
            --       AND START_TIME = n_start_time
            --       AND END_TIME = n_end_time
            --       AND START_DAY = n_start_day
            --       AND END_DAY = n_end_day
            --       AND DAY = n_day;

            SELECT COUNT(*)
            INTO l_count_unit_j
            FROM WORKING_PROFILE_DETAIL
            WHERE ID = j;

            IF l_count_unit_j > 0 THEN
           
                UPDATE WORKING_PROFILE_DETAIL
                SET
                    PROFILE_ID = n_profile_id,
                    PROFILE_TYPE_ID = n_profile_type_id,
                    DESCRIPTION = n_des_detail,
                    START_TIME = n_start_time,
                    END_TIME = n_end_time,
                    START_DAY = num_start_day,
                    END_DAY = num_end_day,
                    DAY_OF_WEEK = num_day
                WHERE ID = j;
            ELSE
          
                INSERT INTO WORKING_PROFILE_DETAIL (
                    PROFILE_ID,
                    PROFILE_TYPE_ID,
                    DESCRIPTION,
                    START_TIME,
                    END_TIME,
                    START_DAY,
                    END_DAY,
                    DAY_OF_WEEK
                )
                VALUES (
                    n_profile_id,
                    n_profile_type_id,
                    n_des_detail,
                    n_start_time,
                    n_end_time,
                    num_start_day,
                    num_end_day,
                    num_day
                );
            END IF;

        END LOOP;

        COMMIT;
        
    END LOOP;

END "SP_GET_WORKING_SCHEDULE_PROFILE_DETAIL";
/