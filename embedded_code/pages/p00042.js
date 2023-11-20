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
// Page: 42 - Confirm Scholarship Request PK > Dynamic Action: set_value_for_voucher_code_X > Client-side Condition > JavaScript Expression

($v("P42_SCHOLARSHIP_RECIPIENT") !== null && ($v("P42_REQUEST_ID") === null || $v("P42_REQUEST_ID") === ""))

// ----------------------------------------
// Page: 42 - Confirm Scholarship Request PK > Dynamic Action: New > Action: Execute JavaScript Code > Settings > Code

// add
$('.P42_SCHOLARSHIP_RECIPIENT').addClass('apex_disabled');
$('.P42_PROGRAM').addClass('apex_disabled');
$('.P42_REQUEST_NAME').addClass('apex_disabled');
$('#P42_REQUEST_NAME_AB').addClass('apex_disabled');
$('#P42_EMPLOYEE_CODE').addClass('apex_disabled');
$('#P42_DEPARTMENT_CODE').addClass('apex_disabled');
$('.P42_DEPARTMENT').addClass('apex_disabled');
$('#P42_LEVEL').addClass('apex_disabled');
$('#P42_START_DATE').addClass('apex_disabled');
$('#P42_TERMINATION_DATE').addClass('apex_disabled');

$('.P42_DISCOUNT_RATE').addClass('apex_disabled');
$('#P42_VOUCHER_CODE').addClass('apex_disabled');
$('#P42_NUMBER_OF_COURSES').addClass('apex_disabled');
$('#P42_EFFECTIVE_DATE').addClass('apex_disabled');
$('#P42_APPROVED_DATE').addClass('apex_disabled');

// $('#P42_RECIPIENT_NAME').addClass('apex_disabled');
// $('#P42_RECIPIENT_DOB').addClass('apex_disabled');
// $('.P42_RELATIONSHIP').addClass('apex_disabled');

// // remove

// $('#P42_VOUCHER_CODE_REPLACEMENT').removeClass('apex_disabled');
// $('#P42_EXPIRATION_DATE_REPLACEMENT').removeClass('apex_disabled');

// ----------------------------------------
// Page: 42 - Confirm Scholarship Request PK > Dynamic Action: Change_0 > Action: Set Read Only  > Client-side Condition > JavaScript Expression

($v("P42_REQUEST_ID") === null || $v("P42_REQUEST_ID") === "")

// ----------------------------------------
// Page: 42 - Confirm Scholarship Request PK > Dynamic Action: Change_0 > Action: Set Read Only  > Settings > Code

// add
$('.P42_REQUEST_NAME').addClass('apex_disabled');
$('#P42_REQUEST_NAME_AB').addClass('apex_disabled');
//$('.P42_EMPLOYEE_CODE').addClass('apex_disabled');      // cả 3 item employee code, requester code, department code cùng column class
$('#P42_EMPLOYEE_CODE').addClass('apex_disabled');
// câu lệnh dưới, sau khi disable, item vẫn có thể select
$('.P42_DEPARTMENT').addClass('apex_disabled');
// câu lệnh dưới, sau khi disable, item KHÔNG select
//apex.item('P42_DEPARTMENT').disable();
$('#P42_LEVEL').addClass('apex_disabled');
$('#P42_START_DATE').addClass('apex_disabled');
$('#P42_TERMINATION_DATE').addClass('apex_disabled');
$('.P42_DISCOUNT_RATE').addClass('apex_disabled');
$('#P42_VOUCHER_CODE').addClass('apex_disabled');
$('#P42_APPROVED_DATE').addClass('apex_disabled');
$('#P42_NUMBER_OF_COURSES').addClass('apex_disabled');
$('#P42_EFFECTIVE_DATE').addClass('apex_disabled');

// remove
$('#P42_DEPARTMENT_CODE').removeClass('apex_disabled');
$('#P42_RECIPIENT_NAME').removeClass('apex_disabled');
$('#P42_RECIPIENT_DOB').removeClass('apex_disabled');
$('.P42_RELATIONSHIP').removeClass('apex_disabled');
$('#P42_VOUCHER_CODE_REPLACEMENT').removeClass('apex_disabled');
$('#P42_EXPIRATION_DATE_REPLACEMENT').removeClass('apex_disabled');
//$('.P42_DISCOUNT_RATE').removeClass('apex_disabled');

// ----------------------------------------
// Page: 42 - Confirm Scholarship Request PK > Dynamic Action: Change_0 > Action: show_hide_0 > Settings > Code

// show
$('#P42_REQUEST_NAME_AB_CONTAINER').show();
$('#P42_EMPLOYEE_CODE_CONTAINER').show();
$('#P42_LEVEL_CONTAINER').show();
$('#P42_START_DATE_CONTAINER').show();
$('#P42_TERMINATION_DATE_CONTAINER').show();
$('#P42_NOTE_CONTAINER').show();

// hide
$('#P42_REQUEST_NAME_CONTAINER').hide();
$('#P42_DEPARTMENT_CODE_CONTAINER').hide();
$('.region_partner').hide();
$('#P42_UPLOAD_FILE_CONTAINER').hide();
$('#P42_REPLACEMENT_CONTAINER').hide();
$('#P42_VOUCHER_CODE_REPLACEMENT_CONTAINER').hide();
$('#P42_EXPIRATION_DATE_REPLACEMENT_CONTAINER').hide();
$('#P42_REASON_REQUEST_CONTAINER').hide();

// ----------------------------------------
// Page: 42 - Confirm Scholarship Request PK > Dynamic Action: Change_B > Action: set_value_effective_day > Client-side Condition > JavaScript Expression

//$v("P42_REQUEST_ID") === ""
($v("P42_REQUEST_ID") === null || $v("P42_REQUEST_ID") === "")

// ----------------------------------------
// Page: 42 - Confirm Scholarship Request PK > Dynamic Action: Change_B > Action: set_value_discount_rate > Client-side Condition > JavaScript Expression

//$v("P42_REQUEST_ID") === ""
($v("P42_REQUEST_ID") === null || $v("P42_REQUEST_ID") === "")

// ----------------------------------------
// Page: 42 - Confirm Scholarship Request PK > Dynamic Action: Change_B > Action: set_value_termination_date > Client-side Condition > JavaScript Expression

//$v("P42_REQUEST_ID") === ""
($v("P42_REQUEST_ID") === null || $v("P42_REQUEST_ID") === "")

// ----------------------------------------
// Page: 42 - Confirm Scholarship Request PK > Dynamic Action: Change_B > Action: set_value_start_date > Client-side Condition > JavaScript Expression

//$v("P42_REQUEST_ID") === ""
($v("P42_REQUEST_ID") === null || $v("P42_REQUEST_ID") === "")

// ----------------------------------------
// Page: 42 - Confirm Scholarship Request PK > Dynamic Action: Change_B > Action: set_value_level > Client-side Condition > JavaScript Expression

//$v("P42_REQUEST_ID") === ""
($v("P42_REQUEST_ID") === null || $v("P42_REQUEST_ID") === "")

// ----------------------------------------
// Page: 42 - Confirm Scholarship Request PK > Dynamic Action: Change_B > Action: set_value_department > Client-side Condition > JavaScript Expression

//$v("P42_REQUEST_ID") === ""
($v("P42_REQUEST_ID") === null || $v("P42_REQUEST_ID") === "")

// ----------------------------------------
// Page: 42 - Confirm Scholarship Request PK > Dynamic Action: Change_B > Action: set_value_requester_code > Client-side Condition > JavaScript Expression

//$v("P42_REQUEST_ID") === ""
($v("P42_REQUEST_ID") === null || $v("P42_REQUEST_ID") === "")

// ----------------------------------------
// Page: 42 - Confirm Scholarship Request PK > Dynamic Action: Change_B > Action: set_value_requester_name_ab > Client-side Condition > JavaScript Expression

//$v("P42_REQUEST_ID") === ""
($v("P42_REQUEST_ID") === null || $v("P42_REQUEST_ID") === "")

// ----------------------------------------
// Page: 42 - Confirm Scholarship Request PK > Dynamic Action: Change_B > Action: Set Read Only  > Client-side Condition > JavaScript Expression

//$v("P42_REQUEST_ID") === ""
($v("P42_REQUEST_ID") === null || $v("P42_REQUEST_ID") === "")

// ----------------------------------------
// Page: 42 - Confirm Scholarship Request PK > Dynamic Action: Change_B > Action: Set Read Only  > Settings > Code

// add
$('.P42_REQUEST_NAME').addClass('apex_disabled');
$('#P42_REQUEST_NAME_AB').addClass('apex_disabled');
$('.P42_EMPLOYEE_CODE').addClass('apex_disabled');      // cả 3 item (employee code, requester code, department code) cùng column class
$('.P42_DEPARTMENT').addClass('apex_disabled');
$('#P42_LEVEL').addClass('apex_disabled');
$('#P42_START_DATE').addClass('apex_disabled');
$('#P42_TERMINATION_DATE').addClass('apex_disabled');
$('#P42_VOUCHER_CODE_REPLACEMENT').addClass('apex_disabled');
$('#P42_EXPIRATION_DATE_REPLACEMENT').addClass('apex_disabled');
$('.P42_DISCOUNT_RATE').addClass('apex_disabled');
$('#P42_VOUCHER_CODE').addClass('apex_disabled');
$('#P42_NUMBER_OF_COURSES').addClass('apex_disabled');
$('#P42_APPROVED_DATE').addClass('apex_disabled');

// remove
$('#P42_DEPARTMENT_CODE').removeClass('apex_disabled');
$('#P42_RECIPIENT_NAME').removeClass('apex_disabled');
$('#P42_RECIPIENT_DOB').removeClass('apex_disabled');
$('.P42_RELATIONSHIP').removeClass('apex_disabled');
$('#P42_EFFECTIVE_DATE').removeClass('apex_disabled');

// ----------------------------------------
// Page: 42 - Confirm Scholarship Request PK > Dynamic Action: Change_B > Action: show_hide_B > Settings > Code

// show
$('#P42_REQUEST_NAME_AB_CONTAINER').show();
//$('#P42_REQUESTER_CODE_CONTAINER').show();
$('#P42_EMPLOYEE_CODE_CONTAINER').show();
$('#P42_LEVEL_CONTAINER').show();
$('#P42_START_DATE_CONTAINER').show();
$('#P42_TERMINATION_DATE_CONTAINER').show();
$('#P42_UPLOAD_FILE_CONTAINER').show();
$('#P42_REPLACEMENT_CONTAINER').show();
$('#P42_VOUCHER_CODE_REPLACEMENT_CONTAINER').show();
$('#P42_EXPIRATION_DATE_REPLACEMENT_CONTAINER').show();
$('#P42_NOTE_CONTAINER').show();

// hide
$('#P42_REQUEST_NAME_CONTAINER').hide();
$('#P42_DEPARTMENT_CODE_CONTAINER').hide();
$('.region_partner').hide();
$('#P42_REASON_REQUEST_CONTAINER').hide();

// ----------------------------------------
// Page: 42 - Confirm Scholarship Request PK > Dynamic Action: Change_D > Action: set_value_requester_name > Client-side Condition > JavaScript Expression

($v("P42_REQUEST_ID") === null || $v("P42_REQUEST_ID") === "")

// ----------------------------------------
// Page: 42 - Confirm Scholarship Request PK > Dynamic Action: Change_D > Action: set_value_ relationship > Client-side Condition > JavaScript Expression

($v("P42_REQUEST_ID") === null || $v("P42_REQUEST_ID") === "")

// ----------------------------------------
// Page: 42 - Confirm Scholarship Request PK > Dynamic Action: Change_D > Action: set_value_ effective_day > Client-side Condition > JavaScript Expression

($v("P42_REQUEST_ID") === null || $v("P42_REQUEST_ID") === "")

// ----------------------------------------
// Page: 42 - Confirm Scholarship Request PK > Dynamic Action: Change_D > Action: Set Read Only  > Client-side Condition > JavaScript Expression

($v("P42_REQUEST_ID") === null || $v("P42_REQUEST_ID") === "")

// ----------------------------------------
// Page: 42 - Confirm Scholarship Request PK > Dynamic Action: Change_D > Action: Set Read Only  > Settings > Code

// add
$('#P42_DEPARTMENT_CODE').addClass('apex_disabled');
$('.P42_DEPARTMENT').addClass('apex_disabled');
$('#P42_VOUCHER_CODE').addClass('apex_disabled');
$('#P42_NUMBER_OF_COURSES').addClass('apex_disabled');
$('#P42_APPROVED_DATE').addClass('apex_disabled');

// remove
$('.P42_REQUEST_NAME').removeClass('apex_disabled');
$('#P42_REQUEST_NAME_AB').removeClass('apex_disabled');
$('#P42_EMPLOYEE_CODE').removeClass('apex_disabled');
$('#P42_LEVEL').removeClass('apex_disabled');
$('#P42_START_DATE').removeClass('apex_disabled');
$('#P42_TERMINATION_DATE').removeClass('apex_disabled');
$('#P42_RECIPIENT_NAME').removeClass('apex_disabled');
$('#P42_RECIPIENT_DOB').removeClass('apex_disabled');
$('.P42_RELATIONSHIP').removeClass('apex_disabled');
$('#P42_VOUCHER_CODE_REPLACEMENT').removeClass('apex_disabled');
$('#P42_EXPIRATION_DATE_REPLACEMENT').removeClass('apex_disabled');
$('.P42_DISCOUNT_RATE').removeClass('apex_disabled');
$('#P42_EFFECTIVE_DATE').removeClass('apex_disabled');

// ----------------------------------------
// Page: 42 - Confirm Scholarship Request PK > Dynamic Action: Change_D > Action: show_hide_D > Settings > Code

// show
$('#P42_REQUEST_NAME_CONTAINER').show();
$('#P42_DEPARTMENT_CODE_CONTAINER').show();
$('.region_partner').show();
$('#P42_UPLOAD_FILE_CONTAINER').show();
$('#P42_REASON_REQUEST_CONTAINER').show();

// hide
$('#P42_REQUEST_NAME_AB_CONTAINER').hide();
$('#P42_EMPLOYEE_CODE_CONTAINER').hide();
$('#P42_LEVEL_CONTAINER').hide();
$('#P42_START_DATE_CONTAINER').hide();
$('#P42_TERMINATION_DATE_CONTAINER').hide();
$('#P42_REPLACEMENT_CONTAINER').hide();
$('#P42_VOUCHER_CODE_REPLACEMENT_CONTAINER').hide();
$('#P42_EXPIRATION_DATE_REPLACEMENT_CONTAINER').hide();
$('#P42_NOTE_CONTAINER').hide();


// ----------------------------------------
// Page: 42 - Confirm Scholarship Request PK > Dynamic Action: Change_C > Action: set_value_requester_name > Client-side Condition > JavaScript Expression

($v("P42_REQUEST_ID") === null || $v("P42_REQUEST_ID") === "")

// ----------------------------------------
// Page: 42 - Confirm Scholarship Request PK > Dynamic Action: Change_C > Action: set_value_ effective_day > Client-side Condition > JavaScript Expression

($v("P42_REQUEST_ID") === null || $v("P42_REQUEST_ID") === "")

// ----------------------------------------
// Page: 42 - Confirm Scholarship Request PK > Dynamic Action: Change_C > Action: set_value_ relationship > Client-side Condition > JavaScript Expression

($v("P42_REQUEST_ID") === null || $v("P42_REQUEST_ID") === "")

// ----------------------------------------
// Page: 42 - Confirm Scholarship Request PK > Dynamic Action: Change_C > Action: Set Read Only  > Client-side Condition > JavaScript Expression

($v("P42_REQUEST_ID") === null || $v("P42_REQUEST_ID") === "")

// ----------------------------------------
// Page: 42 - Confirm Scholarship Request PK > Dynamic Action: Change_C > Action: Set Read Only  > Settings > Code

// add
$('.P42_REQUEST_NAME').addClass('apex_disabled');
$('#P42_REQUEST_NAME_AB').addClass('apex_disabled');
$('#P42_DEPARTMENT_CODE').addClass('apex_disabled');
$('.P42_EMPLOYEE_CODE').addClass('apex_disabled');      // cả 3 item (employee code, requester code, department code) cùng column class
$('.P42_DEPARTMENT').addClass('apex_disabled');
$('#P42_VOUCHER_CODE').addClass('apex_disabled');
$('#P42_NUMBER_OF_COURSES').addClass('apex_disabled');
$('#P42_APPROVED_DATE').addClass('apex_disabled');

// remove
$('#P42_EMPLOYEE_CODE').removeClass('apex_disabled');
$('#P42_LEVEL').removeClass('apex_disabled');
$('#P42_START_DATE').removeClass('apex_disabled');
$('#P42_TERMINATION_DATE').removeClass('apex_disabled');
$('#P42_RECIPIENT_NAME').removeClass('apex_disabled');
$('#P42_RECIPIENT_DOB').removeClass('apex_disabled');
$('.P42_RELATIONSHIP').removeClass('apex_disabled');
$('#P42_VOUCHER_CODE_REPLACEMENT').removeClass('apex_disabled');
$('#P42_EXPIRATION_DATE_REPLACEMENT').removeClass('apex_disabled');
$('.P42_DISCOUNT_RATE').removeClass('apex_disabled');
$('#P42_EFFECTIVE_DATE').removeClass('apex_disabled');


// ----------------------------------------
// Page: 42 - Confirm Scholarship Request PK > Dynamic Action: Change_C > Action: show_hide_C > Settings > Code

// show
$('#P42_REQUEST_NAME_CONTAINER').show();
$('#P42_DEPARTMENT_CODE_CONTAINER').show();
$('.region_partner').show();
$('#P42_UPLOAD_FILE_CONTAINER').show();
$('#P42_REASON_REQUEST_CONTAINER').show();

// hide
$('#P42_REQUEST_NAME_AB_CONTAINER').hide();
$('#P42_EMPLOYEE_CODE_CONTAINER').hide();
$('#P42_LEVEL_CONTAINER').hide();
$('#P42_START_DATE_CONTAINER').hide();
$('#P42_TERMINATION_DATE_CONTAINER').hide();
$('#P42_REPLACEMENT_CONTAINER').hide();
$('#P42_VOUCHER_CODE_REPLACEMENT_CONTAINER').hide();
$('#P42_EXPIRATION_DATE_REPLACEMENT_CONTAINER').hide();
$('#P42_NOTE_CONTAINER').hide();


// ----------------------------------------
// Page: 42 - Confirm Scholarship Request PK > Dynamic Action: Change_A > Action: set_value_effective_day > Client-side Condition > JavaScript Expression

//$v("P42_REQUEST_ID") === ""
($v("P42_REQUEST_ID") === null || $v("P42_REQUEST_ID") === "")

// ----------------------------------------
// Page: 42 - Confirm Scholarship Request PK > Dynamic Action: Change_A > Action: set_value_discount_rate > Client-side Condition > JavaScript Expression

//$v("P42_REQUEST_ID") === ""
($v("P42_REQUEST_ID") === null || $v("P42_REQUEST_ID") === "")

// ----------------------------------------
// Page: 42 - Confirm Scholarship Request PK > Dynamic Action: Change_A > Action: set_value_recipient_relationship > Client-side Condition > JavaScript Expression

//$v("P42_REQUEST_ID") === ""
($v("P42_REQUEST_ID") === null || $v("P42_REQUEST_ID") === "")

// ----------------------------------------
// Page: 42 - Confirm Scholarship Request PK > Dynamic Action: Change_A > Action: set_value_recipient_dob > Client-side Condition > JavaScript Expression

//$v("P42_REQUEST_ID") === ""
($v("P42_REQUEST_ID") === null || $v("P42_REQUEST_ID") === "")

// ----------------------------------------
// Page: 42 - Confirm Scholarship Request PK > Dynamic Action: Change_A > Action: set_value_recipient_name > Client-side Condition > JavaScript Expression

//$v("P42_REQUEST_ID") === ""
($v("P42_REQUEST_ID") === null || $v("P42_REQUEST_ID") === "")

// ----------------------------------------
// Page: 42 - Confirm Scholarship Request PK > Dynamic Action: Change_A > Action: set_value_termination_date > Client-side Condition > JavaScript Expression

//$v("P42_REQUEST_ID") === ""
($v("P42_REQUEST_ID") === null || $v("P42_REQUEST_ID") === "")

// ----------------------------------------
// Page: 42 - Confirm Scholarship Request PK > Dynamic Action: Change_A > Action: set_value_start_date > Client-side Condition > JavaScript Expression

//$v("P42_REQUEST_ID") === ""
($v("P42_REQUEST_ID") === null || $v("P42_REQUEST_ID") === "")

// ----------------------------------------
// Page: 42 - Confirm Scholarship Request PK > Dynamic Action: Change_A > Action: set_value_level > Client-side Condition > JavaScript Expression

//$v("P42_REQUEST_ID") === ""
($v("P42_REQUEST_ID") === null || $v("P42_REQUEST_ID") === "")

// ----------------------------------------
// Page: 42 - Confirm Scholarship Request PK > Dynamic Action: Change_A > Action: set_value_department > Client-side Condition > JavaScript Expression

//$v("P42_REQUEST_ID") === ""
($v("P42_REQUEST_ID") === null || $v("P42_REQUEST_ID") === "")

// ----------------------------------------
// Page: 42 - Confirm Scholarship Request PK > Dynamic Action: Change_A > Action: set_value_requester_code > Client-side Condition > JavaScript Expression

//$v("P42_REQUEST_ID") === ""
($v("P42_REQUEST_ID") === null || $v("P42_REQUEST_ID") === "")

// ----------------------------------------
// Page: 42 - Confirm Scholarship Request PK > Dynamic Action: Change_A > Action: set_value_requester_name_ab > Client-side Condition > JavaScript Expression

//$v("P42_REQUEST_ID") === ""
($v("P42_REQUEST_ID") === null || $v("P42_REQUEST_ID") === "")

// ----------------------------------------
// Page: 42 - Confirm Scholarship Request PK > Dynamic Action: Change_A > Action: Set Read Only  > Client-side Condition > JavaScript Expression

//$v("P42_REQUEST_ID") === ""
($v("P42_REQUEST_ID") === null || $v("P42_REQUEST_ID") === "")

// ----------------------------------------
// Page: 42 - Confirm Scholarship Request PK > Dynamic Action: Change_A > Action: Set Read Only  > Settings > Code

// add
$('.P42_REQUEST_NAME').addClass('apex_disabled');
$('#P42_REQUEST_NAME_AB').addClass('apex_disabled');
// $('.P42_EMPLOYEE_CODE').addClass('apex_disabled');      // cả 3 item (employee code, requester code, department code) cùng column class
$('#P42_EMPLOYEE_CODE').addClass('apex_disabled');
$('.P42_DEPARTMENT').addClass('apex_disabled');
$('#P42_LEVEL').addClass('apex_disabled');
$('#P42_START_DATE').addClass('apex_disabled');
$('#P42_TERMINATION_DATE').addClass('apex_disabled');
$('#P42_RECIPIENT_NAME').addClass('apex_disabled');
$('#P42_RECIPIENT_DOB').addClass('apex_disabled');
$('.P42_RELATIONSHIP').addClass('apex_disabled');
$('.P42_DISCOUNT_RATE').addClass('apex_disabled');
$('#P42_VOUCHER_CODE').addClass('apex_disabled');
$('#P42_NUMBER_OF_COURSES').addClass('apex_disabled');
$('#P42_EFFECTIVE_DATE').addClass('apex_disabled');
$('#P42_APPROVED_DATE').addClass('apex_disabled');

// remove
$('#P42_DEPARTMENT_CODE').removeClass('apex_disabled');
$('#P42_VOUCHER_CODE_REPLACEMENT').removeClass('apex_disabled');
$('#P42_EXPIRATION_DATE_REPLACEMENT').removeClass('apex_disabled');

// ----------------------------------------
// Page: 42 - Confirm Scholarship Request PK > Dynamic Action: Change_A > Action: show_hide_A > Settings > Code

// show
$('#P42_REQUEST_NAME_AB_CONTAINER').show();
$('#P42_EMPLOYEE_CODE_CONTAINER').show();
$('#P42_LEVEL_CONTAINER').show();
$('#P42_START_DATE_CONTAINER').show();
$('#P42_TERMINATION_DATE_CONTAINER').show();
$('#P42_NOTE_CONTAINER').show();

// hide
$('#P42_REQUEST_NAME_CONTAINER').hide();
$('#P42_DEPARTMENT_CODE_CONTAINER').hide();
$('.region_partner').hide();
$('#P42_UPLOAD_FILE_CONTAINER').hide();
$('#P42_REPLACEMENT_CONTAINER').hide();
$('#P42_VOUCHER_CODE_REPLACEMENT_CONTAINER').hide();
$('#P42_EXPIRATION_DATE_REPLACEMENT_CONTAINER').hide();
$('#P42_REASON_REQUEST_CONTAINER').hide();

// ----------------------------------------
// Page: 42 - Confirm Scholarship Request PK > Dynamic Action: Change P42_PROGRAM > Client-side Condition > JavaScript Expression

($v("P42_REQUEST_ID") === null || $v("P42_REQUEST_ID") === "")

// ----------------------------------------
// Page: 42 - Confirm Scholarship Request PK > Dynamic Action: change_value_of_replacement > Client-side Condition > JavaScript Expression

($v("P42_REPLACEMENT") !== null && ($v("P42_REQUEST_ID") === null || $v("P42_REQUEST_ID") === ""))

// ----------------------------------------
// Page: 42 - Confirm Scholarship Request PK > Dynamic Action: set_value_for_voucher_code_3 > Client-side Condition > JavaScript Expression

($v("P42_VOUCHER_CODE_3") !== null && ($v("P42_REQUEST_ID") === null || $v("P42_REQUEST_ID") === ""))

// ----------------------------------------
// Page: 42 - Confirm Scholarship Request PK > Dynamic Action: set_value_for_voucher_code_2 > Client-side Condition > JavaScript Expression

($v("P42_VOUCHER_CODE_2") !== null && ($v("P42_REQUEST_ID") === null || $v("P42_REQUEST_ID") === ""))

// ----------------------------------------
// Page: 42 - Confirm Scholarship Request PK > Dynamic Action: set_value_for_voucher_code_ccc_department > Client-side Condition > JavaScript Expression

($v("P42_DEPARTMENT_CODE") !== null && ($v("P42_REQUEST_ID") === null || $v("P42_REQUEST_ID") === ""))

// ----------------------------------------
// Page: 42 - Confirm Scholarship Request PK > Dynamic Action: change_value_of_request_name > Client-side Condition > JavaScript Expression

//($v("P42_REQUEST_ID") === null || $v("P42_REQUEST_ID") === "")

($v("P42_SCHOLARSHIP_RECIPIENT") === "D" && 
($v("P42_REQUEST_ID") === "" || $v("P42_REQUEST_ID") === null) && 
$v("P42_REQUEST_NAME") !== null)


// ----------------------------------------
// Page: 42 - Confirm Scholarship Request PK > Dynamic Action: set_value_for_voucher_code_EP/ELT > Client-side Condition > JavaScript Expression

($v("P42_PROGRAM") !== null && ($v("P42_REQUEST_ID") === null || $v("P42_REQUEST_ID") === ""))

// ----------------------------------------
// Page: 42 - Confirm Scholarship Request PK > Dynamic Action: set_value_for_voucher_code_aaa > Client-side Condition > JavaScript Expression

($v("P42_DISCOUNT_RATE") !== null && ($v("P42_REQUEST_ID") === null || $v("P42_REQUEST_ID") === ""))

// ----------------------------------------
// Page: 42 - Confirm Scholarship Request PK > Dynamic Action: set_value_for_voucher_code > Client-side Condition > JavaScript Expression

($v("P42_VOUCHER_CODE_1") !== null && ($v("P42_REQUEST_ID") === null || $v("P42_REQUEST_ID") === ""))

