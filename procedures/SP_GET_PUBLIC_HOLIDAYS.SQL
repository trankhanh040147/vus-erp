create or replace PROCEDURE "SP_GET_PUBLIC_HOLIDAYS"
(
    p_legal_entity NVARCHAR2
)
is
l_token_type NVARCHAR2(2000);
l_access_token NVARCHAR2(2000);
l_body NVARCHAR2(2000);
l_response_clob clob;
l_authorization NVARCHAR2(2000);
l_response clob;
n_LegalEntityID NVARCHAR2(50);
n_Date DATE;
n_SpecialDayId NVARCHAR2(50);
n_CalendarType NUMBER;
l_numrow number;
l_count_idemp number;
l_count_iduser number;
l_body_json clob;


p_token NVARCHAR2(10000);
BEGIN
    SP_GET_TOKEN(p_token);

    apex_web_service.g_request_headers.delete();
    apex_web_service.g_request_headers(1).name := 'Content-Type';
    apex_web_service.g_request_headers(1).value := 'application/json';
    apex_web_service.g_request_headers(2).name := 'Content-Length';
    apex_web_service.g_request_headers(2).value := 0;
    apex_web_service.g_request_headers(3).name := 'Authorization';
    apex_web_service.g_request_headers(3).value := 'Bearer '|| p_token;
    --apex_web_service.g_request_headers(4).name := 'Content-Type';
    --apex_web_service.g_request_headers(4).value := 'application/json';

    l_body := '{"_jsonRequest":{"LegalEntityID":"'||p_legal_entity||'"} }';
    
    APEX_JSON.parse(

    apex_web_service.make_rest_request(
            p_url => global_vars.get_resource_url || '/api/services/VUSTC_TimSheetServiceGroup/TimeSheetService/GetPublicHoliday',
            p_http_method => 'POST',
            p_body => l_body,
            p_transfer_timeout => 3600
            ) --;
    );

    l_numrow := APEX_JSON.get_count (p_path =>'.'); --Đếm tổng số chuỗi trả về
    
    FOR i IN 1 .. l_numrow
    LOOP
        n_LegalEntityID := apex_json.get_varchar2('[%d].LegalEntityID', i);
        n_Date := TO_DATE(apex_json.get_varchar2('[%d].Date',i),'YYYY-MM-DD');
        n_SpecialDayId := apex_json.get_varchar2('[%d].SpecialDayId', i);
        n_CalendarType := apex_json.get_number('[%d].CalendarType', i);

        SELECT COUNT(*) INTO l_count_idemp FROM PUBLIC_HOLIDAYS 
        WHERE  PH_DATE = n_Date Facility;
        
        If l_count_idemp > 0 Then
            UPDATE
                PUBLIC_HOLIDAYS
            SET
                PH_LEGAL_ENTITY = n_LegalEntityID,
                PH_DESCRIPTION = n_SpecialDayId,
                PH_CALENDAR_TYPE = n_CalendarType   
            WHERE
                PH_DATE = n_Date Facility;
        Else
            INSERT INTO PUBLIC_HOLIDAYS
            (
                PH_LEGAL_ENTITY,
                PH_DATE,
                PH_DESCRIPTION,
                PH_CALENDAR_TYPE
            )
            VALUES
            (
                n_LegalEntityID,
                n_Date,
                n_SpecialDayId,
                n_CalendarType
            );
        End If;

        COMMIT; 
         
    END LOOP;

    -- FOR i IN 1 .. l_numrow
    -- LOOP
    --     n_LegalEntityID := apex_json.get_varchar2('[%d].LegalEntityID', i);
    --     n_Date := TO_DATE(apex_json.get_varchar2('[%d].Date',i),'YYYY-MM-DD');
    --     n_SpecialDayId := apex_json.get_varchar2('[%d].SpecialDayId', i);
    --     n_CalendarType := apex_json.get_number('[%d].CalendarType', i);

    --     MERGE INTO PUBLIC_HOLIDAYS ph
    --     USING (SELECT n_Date AS PH_DATE, n_LegalEntityID AS PH_LEGAL_ENTITY, n_SpecialDayId AS PH_DESCRIPTION, n_CalendarType AS PH_CALENDAR_TYPE FROM dual) new_data
    --     ON (ph.PH_DATE = new_data.PH_DATE)
    --     WHEN MATCHED THEN
    --         UPDATE SET 
    --             PH_LEGAL_ENTITY = new_data.PH_LEGAL_ENTITY,
    --             PH_DESCRIPTION = new_data.PH_DESCRIPTION,
    --             PH_CALENDAR_TYPE = new_data.PH_CALENDAR_TYPE
    --     WHEN NOT MATCHED THEN
    --         INSERT 
    --         (
    --             PH_LEGAL_ENTITY,
    --             PH_DATE,
    --             PH_DESCRIPTION,
    --             PH_CALENDAR_TYPE
    --         )
    --         VALUES
    --         (
    --             new_data.PH_LEGAL_ENTITY,
    --             new_data.PH_DATE,
    --             new_data.PH_DESCRIPTION,
    --             new_data.PH_CALENDAR_TYPE
    --         );

    --     COMMIT;
    -- END LOOP;


    DBMS_OUTPUT.put_line(l_response_clob);
    
END;
/