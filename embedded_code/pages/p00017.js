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
// Page: 17 - Confirm Delete Education Detail > JavaScript > Function and Global Variable Declaration

function delete_edu(item_id,type)
{
         apex.server.process( 'Delete_education',
            {
                x01: item_id,
                x02: type
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

// ----------------------------------------
// Page: 17 - Confirm Delete Education Detail > JavaScript > Execute when Page Loads

const swalWithBootstrapButtons = Swal.mixin({
  customClass: {
    confirmButton: 'btn btn-success',
    cancelButton: 'btn btn-danger'
  },
  buttonsStyling: false
})

swalWithBootstrapButtons.fire({
  title: 'Are you sure?',
  text: "You won't be able to revert this!",
  icon: 'warning',
  showCancelButton: true,
  confirmButtonText: 'Yes, delete it!',
  cancelButtonText: 'No, cancel!',
  reverseButtons: true
}).then((result) => {
  if (result.isConfirmed) {
      delete_edu('&P17_ID.','&P17_TYPE.');
      
    swalWithBootstrapButtons.fire(
      'Deleted!',
      'Your file has been deleted.',
      'success'
    ).then((result) =>{
        apex.navigation.dialog.close(true);
    }
    )
  } else if (
    /* Read more about handling dismissals below */
    result.dismiss === Swal.DismissReason.cancel
  ) {
    swalWithBootstrapButtons.fire(
      'Cancelled',
      'Your imaginary file is safe :)',
      'error'
    ).then((result) =>{
        apex.navigation.dialog.close(true);
    }
    )
  }
})

