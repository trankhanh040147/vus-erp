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
// Page: 13 - Request Detail > JavaScript > Function and Global Variable Declaration

function reject_request(req_id,hrm_code){
 apex.server.process( 'Reject_request',
            {
                x01: req_id,
                x02: hrm_code
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
function cancel_request(req_id,hrm_code){
 apex.server.process( 'Cancel_request',
            {
                x01: req_id,
                x02: hrm_code
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
function approve_request(req_id) {
apex.server.process('Update_request',
{
x01: req_id,
//x02: v_action
},
{
success: function(pData) {
console.log(pData);
},
error: function(e) {
    //alert('Số ngày phép không hợp lệ')
console.log("Error: ",e);
},
dataType: "json" // Response type
}
);
}

// ----------------------------------------
// Page: 13 - Request Detail > Dynamic Action: Call reject > Action: Delay for processing > Settings > Code

setTimeout(function(){
    console.log('Processing done!')
}, 2000); // 2000ms delay = 2 seconds


// ----------------------------------------
// Page: 13 - Request Detail > Dynamic Action: Call reject > Action: reject_request > Settings > Code

reject_request('&P13_REQUEST_ID.','&P13_HRM_CODE.');


// ----------------------------------------
// Page: 13 - Request Detail > Dynamic Action: Call approve > Action: Delay for processing > Settings > Code

setTimeout(function(){
    console.log('Processing done!')
}, 3000); // 2000ms delay = 2 seconds


// ----------------------------------------
// Page: 13 - Request Detail > Dynamic Action: Call approve > Action: approve_request > Settings > Code

approve_request('&P13_REQUEST_ID.');


