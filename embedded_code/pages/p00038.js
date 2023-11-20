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
// Page: 38 - New Scholarship > JavaScript > Function and Global Variable Declaration

$('.delete-condition').click(function(){
    $('.reg_condition.condition_id_'+$(this).attr("condition_id")).remove();
})

// ----------------------------------------
// Page: 38 - New Scholarship > Dynamic Action: New > Action: Execute JavaScript Code > Settings > Code

var popLovValue = apex.item("SD_PROGRAM").getValue();
apex.item("P38_SD_PROGRAM").setValue(popLovValue);


// ----------------------------------------
// Page: 38 - New Scholarship > Dynamic Action: Add new row > Action: Execute JavaScript Code > Settings > Code

apex.region( "ontoor" ).widget().interactiveGrid( "getActions" ).invoke( "selection-add-row" );

// ----------------------------------------
// Page: 38 - New Scholarship > Dynamic Action: DA_DELETEROW > Action: Set Value > Settings > JavaScript Expression

$(this.triggeringElement).parent().data('id')

