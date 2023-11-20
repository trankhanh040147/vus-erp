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
// Page: 25 - Scholarship Request pk > JavaScript > Function and Global Variable Declaration

const setDefaultReport = function(){

    $('.igrid_p25_1').each(element => {
        
        let igActions = apex.region($('.igrid_p25_1')[element].id).call("getActions");

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

