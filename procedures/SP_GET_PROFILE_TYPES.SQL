create or replace PROCEDURE "SP_GET_PROFILE_TYPES"
IS
l_token_type NVARCHAR2(2000);
l_access_token NVARCHAR2(2000);
l_body NVARCHAR2(2000);
l_response_clob clob;
l_authorization NVARCHAR2(2000);
l_response clob;

n_ProfileType NVARCHAR2(50);
n_Description NVARCHAR2(300);
n_ProfileSpecificationType NVARCHAR2(50);
n_Type NVARCHAR2(50);
n_DataAreaId NVARCHAR2(50);

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
    apex_web_service.g_request_headers(2).name := 'Authorization';
    apex_web_service.g_request_headers(2).value := 'Bearer '|| p_token;
    apex_web_service.g_request_headers(3).name := 'Content-Length';
    apex_web_service.g_request_headers(3).value := 0;
    --apex_web_service.g_request_headers(4).name := 'Content-Type';
    --apex_web_service.g_request_headers(4).value := 'application/json';

    -- l_body := '{"_jsonRequest":{"LegalEntityID":"'||p_legal_entity||'"} }';
    
    APEX_JSON.parse(

    apex_web_service.make_rest_request(
            p_url => global_vars.get_resource_url || '/api/services/VUSTC_TimSheetServiceGroup/TimeSheetService/GetProfileType',
            p_http_method => 'POST',
            p_transfer_timeout => 3600
            ) --;
    );

    l_numrow := APEX_JSON.get_count (p_path =>'.'); --Đếm tổng số chuỗi trả về
    
    FOR i IN 1 .. l_numrow
    LOOP

        n_ProfileType := apex_json.get_varchar2('[%d].ProfileType', i);
        n_Description := apex_json.get_varchar2('[%d].Description', i);
        n_ProfileSpecificationType := apex_json.get_varchar2('[%d].ProfileSpecificationType', i);
        n_DataAreaId := apex_json.get_varchar2('[%d].DataAreaId', i);
        n_Type := apex_json.get_varchar2('[%d].Type', i);
        n_Type := custom_trim_v1(n_Type);
        n_Type := NVL(n_Type, CASE 
            WHEN custom_trim_v1(n_ProfileType) = 'clock-in' THEN 'clock_in'
            WHEN custom_trim_v1(n_ProfileType) = 'clock-out' THEN 'clock_out'
            WHEN custom_trim_v1(n_ProfileType) like 'break%' THEN 'break_time'
            WHEN custom_trim_v1(n_ProfileType) = 'night shift' THEN 'night_shift'
            WHEN custom_trim_v1(n_ProfileType) = 'standard time' THEN 'standard_time'
        END);

        -- PROFILE_TYPES
        -- ID	NUMBER(3,0)
        -- PROFILE_TYPE_GROUP	NVARCHAR2(30 CHAR)
        -- PROFILE_TYPE_ID	NVARCHAR2(30 CHAR)
        -- PROFILE_DESCRIPTION	NVARCHAR2(50 CHAR)
        -- PROFILE_SPEC_TYPE	NVARCHAR2(50 CHAR)
        -- DATA_AREA	NVARCHAR2(20 CHAR)

        SELECT COUNT(*) INTO l_count_idemp FROM PROFILE_TYPES 
        WHERE  PROFILE_TYPE_ID = n_ProfileType;
        
        If l_count_idemp > 0 Then
            UPDATE
                PROFILE_TYPES
            SET
                PROFILE_TYPE_GROUP = n_Type,
                PROFILE_DESCRIPTION = n_Description,
                PROFILE_SPEC_TYPE = n_ProfileSpecificationType,
                DATA_AREA = n_DataAreaId
            WHERE
                PROFILE_TYPE_ID = n_ProfileType; 
        Else
            INSERT INTO PROFILE_TYPES
            (
                PROFILE_TYPE_GROUP,
                PROFILE_TYPE_ID,
                PROFILE_DESCRIPTION,
                PROFILE_SPEC_TYPE,
                DATA_AREA
            )
            VALUES
            (
                n_Type,
                n_ProfileType,
                n_Description,
                n_ProfileSpecificationType,
                n_DataAreaId
            );
        End If;

        COMMIT; 
         
    END LOOP;

    -- DBMS_OUTPUT.put_line(l_response_clob);
    
END;
/