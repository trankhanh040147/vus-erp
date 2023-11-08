
--APEX ORACLE 23.1.5
-- This code block is a process on page to submit

-- DECLARE
-- BEGIN    
--     UPDATE EMP_CERTIFICATE 
--     SET ATTACHMENT_URL = :P10102_ATTACHMENT_URL, 
--         ATTACHMENT_NAME = :P10102_ATTACHMENT_NAME 
--     WHERE ID = :P10102_EMP_CERTIFICATE_ID;

-- END;

-- 

-- Create a application process replace the block above
--  UPDATE_EMP_CERTIFICATE_ATTACHMENT('&P10102_EMP_CERTIFICATE_ID.', '&P10102_ATTACHMENT_URL.', '&P10102_ATTACHMENT_NAME.');
-- Name: UPDATE_EMP_CERTIFICATE_ATTACHMENT


-- Application Process UPDATE_EMP_CERTIFICATE_ATTACHMENT

DECLARE
    v_emp_certificate_id NUMBER := :P10102_EMP_CERTIFICATE_ID;
    v_attachment_url VARCHAR2(4000) := :P10102_ATTACHMENT_URL;
    v_attachment_name VARCHAR2(500) := :P10102_ATTACHMENT_NAME;
begin
    v_emp_certificate_id := apex_application.g_x01;
    v_attachment_url := apex_application.g_x02;
    v_attachment_name := apex_application.g_x03;

    UPDATE EMP_CERTIFICATE
    SET ATTACHMENT_URL = v_attachment_url,
        ATTACHMENT_NAME = v_attachment_name
    WHERE ID = v_emp_certificate_id;
end;


-- Define on page 5 to call this ajax process
-- Template
function delete_request(item_id)
{
         apex.server.process( 'Delete_request',
            {
                x01: item_id
            },  // Parameter to be passed to the server
            {
                success: function (pData) {             // Success
                    console.log(pData);
                },
                error: function(e){
                    console.log("Error: ", e);
                },
                dataType: "json"                        // Response type
            }
        );
}

function UPDATE_EMP_CERTIFICATE_ATTACHMENT(item_id, attachment_url, attachment_name)
{
         apex.server.process( 'UPDATE_EMP_CERTIFICATE_ATTACHMENT',
            {
                x01: item_id,
                x02: attachment_url,
                x03: attachment_name
            },  // Parameter to be passed to the server
            {
                success: function (pData) {             // Success
                    console.log(pData);
                },
                error: function(e){
                    console.log("Error: ", e);
                },
                dataType: "json"                        // Response type
            }
        );
}