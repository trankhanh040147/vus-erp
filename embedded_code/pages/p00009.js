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
// Page: 9 - Approve Leave > JavaScript > Function and Global Variable Declaration




// ----------------------------------------
// Page: 9 - Approve Leave > Dynamic Action: on change message > Action: Display message > Settings > Code

var messageValue = $v("P9_MESSAGE");
if (messageValue === 'SUCCESS') {
    apex.message.showPageSuccess("Request approved successfully.");
} else if (messageValue === 'FAILED') {
    apex.message.showPageError("Cannot approve the request. Please check the benefit accruals for the employee.");
}


// ----------------------------------------
// Page: 9 - Approve Leave > Dynamic Action: onload > Action: Display message > Settings > Code

var messageValue = $v("P9_MESSAGE");
if (messageValue === 'SUCCESS') {
    apex.message.showPageSuccess("Request approved successfully.");
} else if (messageValue === 'FAILED') {
    apex.message.showPageError("Cannot approve the request. Please check the benefit accruals for the employee.");
}


// ----------------------------------------
// Page: 9 - Approve Leave > Dynamic Action: onload > Action: Assign request_id > Affected Elements > JavaScript Expression

// // Get the URL parameters
// const urlParams = new URLSearchParams(window.location.search);

// // Get the value of the 'request_id' parameter
// const requestId = urlParams.get('request_id');

// // Assign the value to the hidden item
// apex.item('REQUEST_ID').setValue(requestId);

apex.jQuery(function($) {
    const urlParams = new URLSearchParams(window.location.search);
    const requestId = urlParams.get('request_id');
    apex.item('REQUEST_ID').setValue(requestId);
});



// ----------------------------------------
// Page: 9 - Approve Leave > Dynamic Action: New > Action: Execute JavaScript Code > Settings > Code

location.reload();

// ----------------------------------------
// Page: 9 - Approve Leave > Dynamic Action: New > When > JavaScript Expression

window

// ----------------------------------------
// Page: 9 - Approve Leave > JavaScript > Execute when Page Loads

const setDefaultReport = function(){

    $('.interactive-grid').each(element => {
        
        let igActions = apex.region($('.approve-list-grid')[element].id).call("getActions");

        let choices =  igActions.lookup("change-report").choices;


        if(choices.length > 0){
            
            let primary = choices.filter(obj => {

                return obj.group === "Default";

            })[0].value;
             
            let publicStandard = choices.filter(obj => {
                return obj.label.indexOf('[STD>= 0 && obj.group === "Public"');

            })[1];
          
            if(publicStandard){
               
                publicStandard = publicStandard.value;

            }

            let current = igActions.get("change-report");

            if ( publicStandard && current !== publicStandard && current === primary ) {

                igActions.set("change-report", publicStandard);
             
            }

        }

    });

}

$( document ).ready(function() {
    setDefaultReport();
});

