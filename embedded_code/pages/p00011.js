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
// Page: 11 - Confirm Request for Manager > JavaScript > Function and Global Variable Declaration

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
// Page: 11 - Confirm Request for Manager > Dynamic Action: Call approve > Action: Execute JavaScript Code > Settings > Code

approve_request('&P11_REQUEST_ID.');

// ----------------------------------------
// Page: 11 - Confirm Request for Manager > JavaScript > Execute when Page Loads

/*const swalWithBootstrapButtons = Swal.mixin({
  customClass: {
    confirmButton: 'btn btn-success',
    cancelButton: 'btn btn-danger'
  },
  buttonsStyling: false
})

var ntext = "";
if(&P11_TYPE. == 3){
    ntext = "You want to approve this?";
}else{
    ntext = "You want to reject this?";
}
swalWithBootstrapButtons.fire({
  //title: 'Confirm Approve Leave Request',
  //text: "You want to approve this?",
  //text:ntext,
  icon: 'warning',
  showCancelButton: true,
  //confirmButtonText: 'Yes',
  //cancelButtonText: 'Cancel',
  reverseButtons: true
}).then((result) => {
  if (result.isConfirmed) {
      if (&P11_TYPE. == 3){
approve_request('&P11_REQUEST_ID.');
swalWithBootstrapButtons.fire(
      'Approved'
    ).then((result) =>{
        apex.navigation.dialog.close(true);
    }
    )
      }
      if (&P11_TYPE. == 4){
reject_request('&P11_REQUEST_ID.','&P11_HRM_ABSCODE.');
swalWithBootstrapButtons.fire(
      'Rejected'
    ).then((result) =>{
        apex.navigation.dialog.close(true);
    }
    )
      }
      
    /*swalWithBootstrapButtons.fire(
      'Success'
    ).then((result) =>{
        apex.navigation.dialog.close(true);
    }
    )
  } else if (
    /* Read more about handling dismissals below 
    result.dismiss === Swal.DismissReason.cancel
  ) {
    swalWithBootstrapButtons.fire(
      'Cancelled'
    ).then((result) =>{
        apex.navigation.dialog.close(true);
    }
    )
  }
})
*/

