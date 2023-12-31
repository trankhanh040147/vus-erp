create or replace PROCEDURE SP_UPDATE_TIME_SHEET_TESTING(
    p_ts_header_id NUMBER,
    o_status OUT NUMBER -- API request status    
) IS
    l_token_type NVARCHAR2(2000);
    l_body NVARCHAR2(4000); -- increased size
    l_response CLOB;
    l_body_mail NVARCHAR2(2000);

    n_id NUMBER;
    n_legal_entity NVARCHAR2(10) := 'V01'; -- Assuming a default value for now
    n_profile_date DATE;
    n_worker NUMBER;
    n_profile NVARCHAR2(100);
    p_token NVARCHAR2(5000);

BEGIN
    SP_GET_TOKEN(p_token);

    apex_web_service.g_request_headers.delete();    
    apex_web_service.g_request_headers(1).name := 'Authorization';
    apex_web_service.g_request_headers(1).value := 'Bearer ' || p_token;
    
    apex_web_service.g_request_headers(2).name := 'Content-Type';
    apex_web_service.g_request_headers(2).value := 'application/json; charset=utf-8';


    -- Sync Time_sheet 
    SP_SYNC_TIME_SHEET(p_ts_header_id);

    -- Fetch header details
    SELECT PROFILE_DATE, PROFILE_ID, WORKER INTO n_profile_date, n_profile, n_worker 
    FROM EMP_TIME_SHEET WHERE TS_HEADER_REC_ID = p_ts_header_id;

    -- set l_body for testing

    -- l_body - case: Update fail (total rows = 0)

    -- l_body := '{
    --     "_jsonRequest":{
    --         "LegalEntityID": "V01",
    --         "TimeSheetHeader":[
    --             {
    --                 "ProfileDate": "9-12-2023", //MM-dd-YYYY
    --                 "Profile": "thu test",
    --                 "Worker": 5637182862,
    --                 "TimeSheetLine":[
    --                 {
    --                     "TimeSheetLineRecId": 5637188826,
    --                     "RegType": "Clock in",
    --                     "JobRef": "System",
    --                     "JobId": "",
    --                     "StartTime": "7:00:00 AM",
    --                     "EndTime": "7:00:00 AM"
    --                 },
    --                 {
    --                     "TimeSheetLineRecId": 5637187327,
    --                     "RegType": "Clock out",
    --                     "JobRef": "System",
    --                     "JobId": "",
    --                     "StartTime": "6:00:00 pm",
    --                     "EndTime": "6:00:00 pm"
    --                 }
    --             ]
    --             },
    --             {
    --                 "ProfileDate": "08-26-2023",
    --                 "Profile": "Office 2",
    --                 "Worker":5637182862,
    --                 "TimeSheetLine":[]
    --             }
    --         ]
    --     }
    -- }'

    -- l_body - case: Update success (total rows > 0)

    l_body := '{
        "_jsonRequest":{
            "LegalEntityID": "V01",
            "TimeSheetHeader":[
                {
                    "ProfileDate": "11-24-2023", //MM-dd-YYYY
                    "Profile": "Office 1",
                    "Worker": 5637182863,
                    "TimeSheetLine":[
                    {
                        "TimeSheetLineRecId": 5637218136,
                        "RegType": "Clock in",
                        "JobRef": "System",
                        "JobId": "V01-001181",
                        "StartTime": "02:00:00 am",
                        "EndTime": "02:00:00 am",
                        "Description": "Clock in",
                        "TransId": "1",
                        "Time": "00.00"
                    },
                    {
                        "TimeSheetLineRecId": 5637218176,
                        "RegType": "Indirect activity",
                        "JobRef": "System",
                        "JobId": "V01-001187",
                        "StartTime": "02:00:00 am",
                        "EndTime": "04:00:00 pm",
                        "Description": "Waiting job",
                        "TransId": "4",
                        "Time": "00.00"
                    },
                    {
                        "TimeSheetLineRecId": 5637218137,
                        "RegType": "Clock out",
                        "JobRef": "System",
                        "JobId": "V01-001182",
                        "StartTime": "04:00:00 pm",
                        "EndTime": "04:00:00 pm",
                        "Description": "Clock out",
                        "TransId": "3",
                        "Time": "00.00"
                    },
                    {
                        "TimeSheetLineRecId": 5637218828,
                        "RegType": "Absence",
                        "JobRef": "Flex",
                        "JobId": "V01-001249",
                        "StartTime": "04:00:00 pm",
                        "EndTime": "06:00:00 pm",
                        "Description": "Flex time",
                        "TransId": "5",
                        "Time": "00.00"
                    }
                ]
                }
            ]
        }
    }
    ';


    -- Removing last comma and closing the JSON structure
    -- l_body := RTRIM(l_body, ',') || ']
    --             }
    --         ]
    --     }
    -- }';

    DBMS_OUTPUT.put_line('body: ');
    DBMS_OUTPUT.put_line(l_body);

    
    -- set o_status to 1 if the API call is successful
    o_status := 0;

    -- Make the API call 
    l_response := apex_web_service.make_rest_request(
        p_url => global_vars.get_resource_url || '/api/services/VUSTC_TimSheetServiceGroup/TimeSheetService/UpdateTimeSheet',
        p_http_method => 'POST',
        p_body => l_body,
        p_transfer_timeout => 3600
    );

    -- print the response 
    DBMS_OUTPUT.put_line('response: ');
    DBMS_OUTPUT.put_line(l_response);

    -- parse the response
    APEX_JSON.parse(l_response);

    -- check if the response is successful
    -- response rule: if TotalRows > 0 then success, otherwise failure check <RESPONSE> sample down below
    IF APEX_JSON.get_varchar2(p_path => 'TotalRows') > 0 THEN
        o_status := 1;
    END IF;
    
    DBMS_OUTPUT.put_line(''); -- empty line
    DBMS_OUTPUT.put_line('o_status: ');
    DBMS_OUTPUT.put_line(o_status);

    -- write API response log into OUTPUT_LOGS table
    INSERT INTO LOGS_API_RESPONSE (
        API_ENDPOINT,
        REQUEST_HEADERS,
        REQUEST_BODY,
        RESPONSE_CODE,
        RESPONSE_BODY,
        CALL_TIMESTAMP,
        NOTE
    ) VALUES (
        'UpdateTimeSheet', -- Endpoint you just called
        apex_web_service.g_request_headers(1).value, -- This is a simplification, you may need to concatenate all headers
        l_body, -- The request body you sent
        apex_web_service.g_status_code, -- Response status code
        l_response, -- The response body you received
        SYSDATE, -- The current timestamp
        'header_id=' || p_ts_header_id || 'worker=' || n_worker || ' profile=' || n_profile || ' profile_date=' || TO_CHAR(n_profile_date, 'MM-DD-YYYY') || ' status=' || o_status -- Any additional notes
    );

END;

    -- <RESPONSE> sample:
    -- {
    --     "LegalEntityID": "V01",
    --     "StatusDescription": "",
    --     "TotalRows": 0,
    --     "FromDate": "1900-01-01T12:00:00",
    --     "ToDate": "1900-01-01T12:00:00",
    --     "TimeSheetHeader": [
    --         {
    --             "ProfileDate": "",
    --             "Profile": "",
    --             "Worker": 0,
    --             "TimeSheetHeaderRecId": 0,
    --             "StatusUpdated": 0,
    --             "Description Update": "",
    --             "TimeSheetLine": null
    --         }
    --     ]
    -- }


-- call the procedure to test
-- DECLARE
--     o_status NUMBER;
-- BEGIN
--     SP_UPDATE_TIME_SHEET_TESTING(1, o_status);
-- END;