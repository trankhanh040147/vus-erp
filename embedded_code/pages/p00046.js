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
// Page: 46 - Scholarship Config Detail  > JavaScript > Function and Global Variable Declaration

$('.delete-condition').click(function(){
    $('.reg_condition.condition_id_'+$(this).attr("condition_id")).remove();
})

// ----------------------------------------
// Page: 46 - Scholarship Config Detail  > Dynamic Action: DA_DELETEROW > Action: Set Value > Settings > JavaScript Expression

$(this.triggeringElement).parent().data('id')

