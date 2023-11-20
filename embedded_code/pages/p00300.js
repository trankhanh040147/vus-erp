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
// Page: 300 - Leave Request for Employee - clone > Dynamic Action: Set display time > Action: Execute JavaScript Code > Settings > Code

$('#P300_START_TIME_CONTAINER').hide();
$('#P300_END_TIME_CONTAINER').hide();

// ----------------------------------------
// Page: 300 - Leave Request for Employee - clone > Dynamic Action: On_click Pre_submit > Action: Turn on loading > Settings > Code

//$("#loader-container").css("display", "block");
console.log('Loading');


// ----------------------------------------
// Page: 300 - Leave Request for Employee - clone > Dynamic Action: New_1 > Action: Set End_Time > Settings > Code

// Parse the hour and minute from START_TIME
let [hour, minute] = $v("P300_START_TIME").split(":").map(Number);

// Add 4 hours
hour += 4;

// Handle situations where the hour is 24 or more
if (hour >= 24) {
  hour -= 24;
}

// Update END_TIME
$s("P300_END_TIME", ("0" + hour).slice(-2) + ":" + ("0" + minute).slice(-2));

// ----------------------------------------
// Page: 300 - Leave Request for Employee - clone > Dynamic Action: Change Type_1 > Action: Unblock submit onload > Affected Elements > JavaScript Expression

$('#btnSubmitLeave').attr('disabled',false);

// ----------------------------------------
// Page: 300 - Leave Request for Employee - clone > Dynamic Action: Change Type_1 > Action: Block submit onload > Affected Elements > JavaScript Expression

$('#btnSubmitLeave').attr('disabled',true);

// ----------------------------------------
// Page: 300 - Leave Request for Employee - clone > Dynamic Action: Change Type_1 > Action: Execute JavaScript Code > Settings > Code

$('#P300_ANNUAL_LEAVE_BALANCE_CONTAINER').hide();


// ----------------------------------------
// Page: 300 - Leave Request for Employee - clone > Dynamic Action: Change Type_1 > Action: Execute JavaScript Code > Settings > Code

$('#P300_ANNUAL_LEAVE_BALANCE_CONTAINER').show();


// ----------------------------------------
// Page: 300 - Leave Request for Employee - clone > Dynamic Action: Change Type_1 > Action: Hide Leave_Detail > Settings > Code

$('#P300_LEAVE_DETAIL_CONTAINER').hide();
$('#P300_UPLOAD_FILE_inline_help').hide();


// ----------------------------------------
// Page: 300 - Leave Request for Employee - clone > Dynamic Action: Change Type_1 > Action: Show Leave_Detail > Settings > Code

$('#P300_LEAVE_DETAIL_CONTAINER').show();
$('#P300_UPLOAD_FILE_inline_help').show();


// ----------------------------------------
// Page: 300 - Leave Request for Employee - clone > Dynamic Action: Change from date > Action: Change End_Date when it disabled > Client-side Condition > JavaScript Expression

$('#P300_END_DATE').attr('disabled') === 'disabled';

// ----------------------------------------
// Page: 300 - Leave Request for Employee - clone > Dynamic Action: Change from date > Action: Change End_Date when it disabled > Client-side Condition > JavaScript Expression

$('#P300_END_DATE').attr('disabled') === 'disabled';

// ----------------------------------------
// Page: 300 - Leave Request for Employee - clone > Dynamic Action: Change from date > Action: Change End_Date when it disabled > Settings > Code

$('#P300_END_DATE').attr('value',$('#P300_FROM_DATE').val());


// ----------------------------------------
// Page: 300 - Leave Request for Employee - clone > Dynamic Action: Set display time > Action: Enable_end_date > Settings > Code

$('#P300_END_DATE').attr('disabled',false);

// ----------------------------------------
// Page: 300 - Leave Request for Employee - clone > Dynamic Action: Set display time > Action: Disable_end_date > Settings > Code

$('#P300_END_DATE').attr('disabled',true);

// ----------------------------------------
// Page: 300 - Leave Request for Employee - clone > Dynamic Action: Set display time > Action: Execute JavaScript Code > Settings > Code

$('#P300_START_TIME_CONTAINER').show();
$('#P300_END_TIME_CONTAINER').show();

