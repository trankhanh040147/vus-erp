-- Ajax Callback
-- date: 2017-02-16

-- Ajax call these function
-- DECLARE
--     SCHOLARSHIP_ID_NEW NUMBER;
-- BEGIN
--     COPY_SCHOLARSHIP_REQUEST(391, 'Scholarship', '626', SCHOLARSHIP_ID_NEW);
--     DBMS_OUTPUT.put_line(SCHOLARSHIP_ID_NEW);
-- END;


        -- // Make the AJAX call
        -- apex.server.process("COPY_REQUEST", {
        --     x01: id_request_copy
        -- }, {
        --     success: function (pData) {
        --         // Refresh the region
        --         apex.region("request").refresh();
        --     },
        --     error: function (request, status, error) {
        --         console.log("AJAX error: " + status + " - " + error);
        --     }
        -- });

-- apex_jsson
-- declare
--     result varchar2(32767);
-- begin
--     result := apex_util.prepare_url(apex_application.g_x01);
--     apex_json.open_object;
--     apex_json.write('success', true);
--     apex_json.write('url', result);
--     apex_json.close_object;
-- exception
--     when others then
--         apex_json.open_object;
--         apex_json.write('success', false);
--         apex_json.write('message', sqlerrm);
--         apex_json.close_object;
-- end;


DECLARE
    l_id_request_copy NUMBER;
    l_id_new_request NUMBER;
BEGIN
    -- use apex_application.g_x01
    l_id_request_copy := apex_application.g_x01;
    apex_json.open_object;
    apex_json.write('success', true);
    COPY_SCHOLARSHIP_REQUEST(l_id_request_copy, :P20003_FEATURE, :APP_EMP_CODE, l_id_new_request);
    apex_json.write('id_new_request', l_id_new_request);
    :SCHOLARSHIP_ID_NEW := l_id_new_request;
    apex_json.close_object;
EXCEPTION
    WHEN OTHERS THEN
        apex_json.open_object;
        apex_json.write('success', false);
        apex_json.write('message', sqlerrm);
        apex_json.close_object;
END;