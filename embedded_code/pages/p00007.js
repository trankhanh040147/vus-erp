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
// Page: 7 - My Leave History > JavaScript > Execute when Page Loads

/*        jQuery(document).ready(function($) {
            // Delay execution by 5 seconds
            setTimeout(function() {
                $('button.js-desc:first').click();
            }, 2000); // 5000 milliseconds = 5 seconds
        });
        */

const setDefaultReport = function(){

    $('.interactive-grid').each(element => {
        
        let igActions = apex.region($('.interactive-grid')[element].id).call("getActions");

        let choices =  igActions.lookup("change-report").choices;


        if(choices.length > 0){
            
            let primary = choices.filter(obj => {

                return obj.group === "Default_History";

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

// ----------------------------------------
// Page: 7 - My Leave History > Dynamic Action: New > Action: Execute JavaScript Code > Settings > Code

location.reload();

// ----------------------------------------
// Page: 7 - My Leave History > Dynamic Action: New > When > JavaScript Expression

window

