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
// Page: 29 - Overtime Request for Employee > JavaScript > Execute when Page Loads

$('#P29_TOTAL_DAY_OFF_CONTAINER').hide();


// ----------------------------------------
// Page: 29 - Overtime Request for Employee > Dynamic Action: Set value day off > Action: Execute JavaScript Code > Settings > Code

apex.item('P29_TOTAL_DAY_OFF').setValue(apex.item('P29_TOTAL_HOURS').getValue()*1.5);

// ----------------------------------------
// Page: 29 - Overtime Request for Employee > Dynamic Action: Set convert > Action: Execute JavaScript Code > Settings > Code

if(apex.item('P29_COVERTED').getValue() == 'Money'){
    $('#P29_TOTAL_DAY_OFF_CONTAINER').hide();
}else
    $('#P29_TOTAL_DAY_OFF_CONTAINER').show();


// ----------------------------------------
// Page: 29 - Overtime Request for Employee > Dynamic Action: Add row > Action: Execute JavaScript Code > Settings > Code

apex.region( "ontoor" ).widget().interactiveGrid( "getActions" ).invoke( "selection-add-row" );

// ----------------------------------------
// Page: 29 - Overtime Request for Employee > Dynamic Action: Delete row > Action: Execute JavaScript Code > Settings > Code

apex.region( "ontoor" ).widget().interactiveGrid( "getActions" ).invoke( "selection-delete" );

