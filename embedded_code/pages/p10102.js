// --------------------------------------------------------------------------------
// 
// Oracle APEX source export file
// 
// The contents of this file are intended for review and analysis purposes only.
// Developers must use the Application Builder to make modifications to an
// application. Changes to this file will not be reflected in the application.
// 
// --------------------------------------------------------------------------------

// ----------------------------------------
// Page: 10102 - EMP_CERTIFICATE_UPLOAD_FILE > JavaScript > Function and Global Variable Declaration

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

