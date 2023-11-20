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
// Page: 20002 - new_scholarship_request > Dynamic Action: Change P20002_DISCOUNT_RATE > Client-side Condition > JavaScript Expression

($v("P20002_REQUEST_ID") === null || $v("P20002_REQUEST_ID") === "")
&& ($v("P20002_SCHOLARSHIP_RECIPIENT") === 'A' || $v("P20002_SCHOLARSHIP_RECIPIENT") === 'B')

// ----------------------------------------
// Page: 20002 - new_scholarship_request > Dynamic Action: New > Action: Execute JavaScript Code > Settings > Code

$('#submit_button').hide();
$('#update_button').hide();


// ----------------------------------------
// Page: 20002 - new_scholarship_request > Dynamic Action: Hide/Show Button > Action: Execute JavaScript Code > Settings > Code

$('#submit_button').hide();

// ----------------------------------------
// Page: 20002 - new_scholarship_request > Dynamic Action: Hide/Show Button > Action: Execute JavaScript Code > Settings > Code

$('#submit_button').show();
$('#update_button').show();
$('#save_submit_button').hide();
$('#save_button').hide();


// ----------------------------------------
// Page: 20002 - new_scholarship_request > Dynamic Action: Change_D > Action: show_hide_D > Settings > Code

// show
$('#P20002_REQUEST_NAME_CONTAINER').show();
$('#P20002_DEPARTMENT_CODE_CONTAINER').show();
$('.region_partner').show();
$('#P20002_UPLOAD_FILE_CONTAINER').show();
$('#P20002_REASON_REQUEST_CONTAINER').show();

// hide
$('#P20002_REQUEST_NAME_AB_CONTAINER').hide();
$('#P20002_EMPLOYEE_CODE_CONTAINER').hide();
$('#P20002_LEVEL_CONTAINER').hide();
$('#P20002_START_DATE_CONTAINER').hide();
$('#P20002_TERMINATION_DATE_CONTAINER').hide();
$('#P20002_REPLACEMENT_CONTAINER').hide();
$('#P20002_VOUCHER_CODE_REPLACEMENT_CONTAINER').hide();
$('#P20002_EXPIRATION_DATE_REPLACEMENT_CONTAINER').hide();
$('#P20002_NOTE_CONTAINER').hide();


// ----------------------------------------
// Page: 20002 - new_scholarship_request > Dynamic Action: Change_D > Action: Set Read Only  > Client-side Condition > JavaScript Expression

($v("P20002_REQUEST_ID") === null || $v("P20002_REQUEST_ID") === "")

// ----------------------------------------
// Page: 20002 - new_scholarship_request > Dynamic Action: Change_D > Action: Set Read Only  > Settings > Code

// add
$('#P20002_DEPARTMENT_CODE').addClass('apex_disabled');
$('.P20002_DEPARTMENT').addClass('apex_disabled');
$('#P20002_VOUCHER_CODE').addClass('apex_disabled');
$('#P20002_NUMBER_OF_COURSES').addClass('apex_disabled');
$('#P20002_APPROVED_DATE').addClass('apex_disabled');

// remove
$('.P20002_REQUEST_NAME').removeClass('apex_disabled');
$('#P20002_REQUEST_NAME_AB').removeClass('apex_disabled');
$('#P20002_EMPLOYEE_CODE').removeClass('apex_disabled');
$('#P20002_LEVEL').removeClass('apex_disabled');
$('#P20002_START_DATE').removeClass('apex_disabled');
$('#P20002_TERMINATION_DATE').removeClass('apex_disabled');
$('#P20002_RECIPIENT_NAME').removeClass('apex_disabled');
$('#P20002_RECIPIENT_DOB').removeClass('apex_disabled');
$('.P20002_RELATIONSHIP').removeClass('apex_disabled');
$('#P20002_VOUCHER_CODE_REPLACEMENT').removeClass('apex_disabled');
$('#P20002_EXPIRATION_DATE_REPLACEMENT').removeClass('apex_disabled');
$('.P20002_DISCOUNT_RATE').removeClass('apex_disabled');
$('#P20002_EFFECTIVE_DATE').removeClass('apex_disabled');

// ----------------------------------------
// Page: 20002 - new_scholarship_request > Dynamic Action: Change_C > Action: Set Read Only  > Client-side Condition > JavaScript Expression

($v("P20002_REQUEST_ID") === null || $v("P20002_REQUEST_ID") === "")

// ----------------------------------------
// Page: 20002 - new_scholarship_request > Dynamic Action: Change_C > Action: Set Read Only  > Settings > Code

// add
$('.P20002_REQUEST_NAME').addClass('apex_disabled');
$('#P20002_REQUEST_NAME_AB').addClass('apex_disabled');
$('#P20002_DEPARTMENT_CODE').addClass('apex_disabled');
$('.P20002_EMPLOYEE_CODE').addClass('apex_disabled');      // cả 3 item (employee code, requester code, department code) cùng column class
$('.P20002_DEPARTMENT').addClass('apex_disabled');
$('#P20002_VOUCHER_CODE').addClass('apex_disabled');
$('#P20002_NUMBER_OF_COURSES').addClass('apex_disabled');
$('#P20002_APPROVED_DATE').addClass('apex_disabled');

// remove
$('#P20002_EMPLOYEE_CODE').removeClass('apex_disabled');
$('#P20002_LEVEL').removeClass('apex_disabled');
$('#P20002_START_DATE').removeClass('apex_disabled');
$('#P20002_TERMINATION_DATE').removeClass('apex_disabled');
$('#P20002_RECIPIENT_NAME').removeClass('apex_disabled');
$('#P20002_RECIPIENT_DOB').removeClass('apex_disabled');
$('.P20002_RELATIONSHIP').removeClass('apex_disabled');
$('#P20002_VOUCHER_CODE_REPLACEMENT').removeClass('apex_disabled');
$('#P20002_EXPIRATION_DATE_REPLACEMENT').removeClass('apex_disabled');
$('.P20002_DISCOUNT_RATE').removeClass('apex_disabled');
$('#P20002_EFFECTIVE_DATE').removeClass('apex_disabled');


// ----------------------------------------
// Page: 20002 - new_scholarship_request > Dynamic Action: Change_C > Action: show_hide_C > Settings > Code

// show
$('#P20002_REQUEST_NAME_CONTAINER').show();
$('#P20002_DEPARTMENT_CODE_CONTAINER').show();
$('.region_partner').show();
$('#P20002_UPLOAD_FILE_CONTAINER').show();
$('#P20002_REASON_REQUEST_CONTAINER').show();

// hide
$('#P20002_REQUEST_NAME_AB_CONTAINER').hide();
$('#P20002_EMPLOYEE_CODE_CONTAINER').hide();
$('#P20002_LEVEL_CONTAINER').hide();
$('#P20002_START_DATE_CONTAINER').hide();
//$('#P20002_START_DATE_CONTAINER').show();
$('#P20002_TERMINATION_DATE_CONTAINER').hide();
$('#P20002_REPLACEMENT_CONTAINER').hide();
$('#P20002_VOUCHER_CODE_REPLACEMENT_CONTAINER').hide();
$('#P20002_EXPIRATION_DATE_REPLACEMENT_CONTAINER').hide();
$('#P20002_NOTE_CONTAINER').hide();


// ----------------------------------------
// Page: 20002 - new_scholarship_request > Dynamic Action: Change_B > Action: Set Read Only  > Client-side Condition > JavaScript Expression

($v("P20002_REQUEST_ID") === null || $v("P20002_REQUEST_ID") === "")

// ----------------------------------------
// Page: 20002 - new_scholarship_request > Dynamic Action: Change_B > Action: Set Read Only  > Settings > Code

// add
$('.P20002_REQUEST_NAME').addClass('apex_disabled');
$('#P20002_REQUEST_NAME_AB').addClass('apex_disabled');
$('.P20002_EMPLOYEE_CODE').addClass('apex_disabled');      // cả 3 item (employee code, requester code, department code) cùng column class
$('.P20002_DEPARTMENT').addClass('apex_disabled');
$('#P20002_LEVEL').addClass('apex_disabled');
$('#P20002_START_DATE').addClass('apex_disabled');
$('#P20002_TERMINATION_DATE').addClass('apex_disabled');
$('#P20002_VOUCHER_CODE_REPLACEMENT').addClass('apex_disabled');
$('#P20002_EXPIRATION_DATE_REPLACEMENT').addClass('apex_disabled');
$('.P20002_DISCOUNT_RATE').addClass('apex_disabled');
$('#P20002_VOUCHER_CODE').addClass('apex_disabled');
$('#P20002_NUMBER_OF_COURSES').addClass('apex_disabled');
$('#P20002_APPROVED_DATE').addClass('apex_disabled');

// remove
$('#P20002_DEPARTMENT_CODE').removeClass('apex_disabled');
$('#P20002_RECIPIENT_NAME').removeClass('apex_disabled');
$('#P20002_RECIPIENT_DOB').removeClass('apex_disabled');
$('.P20002_RELATIONSHIP').removeClass('apex_disabled');
$('#P20002_EFFECTIVE_DATE').removeClass('apex_disabled');

// ----------------------------------------
// Page: 20002 - new_scholarship_request > Dynamic Action: Change_B > Action: show_hide_B > Settings > Code

// show
$('#P20002_REQUEST_NAME_AB_CONTAINER').show();
//$('#P20002_REQUESTER_CODE_CONTAINER').show();
$('#P20002_EMPLOYEE_CODE_CONTAINER').show();
$('#P20002_LEVEL_CONTAINER').show();
$('#P20002_START_DATE_CONTAINER').show();
$('#P20002_TERMINATION_DATE_CONTAINER').show();
$('#P20002_UPLOAD_FILE_CONTAINER').show();
$('#P20002_REPLACEMENT_CONTAINER').show();
$('#P20002_VOUCHER_CODE_REPLACEMENT_CONTAINER').show();
$('#P20002_EXPIRATION_DATE_REPLACEMENT_CONTAINER').show();
$('#P20002_NOTE_CONTAINER').show();

// hide
$('#P20002_REQUEST_NAME_CONTAINER').hide();
$('#P20002_DEPARTMENT_CODE_CONTAINER').hide();
$('.region_partner').hide();
$('#P20002_REASON_REQUEST_CONTAINER').hide();

// ----------------------------------------
// Page: 20002 - new_scholarship_request > Dynamic Action: Change_A > Action: Set Read Only  > Client-side Condition > JavaScript Expression

//$v("P20002_REQUEST_ID") === ""
($v("P20002_REQUEST_ID") === null || $v("P20002_REQUEST_ID") === "")

// ----------------------------------------
// Page: 20002 - new_scholarship_request > Dynamic Action: Change_A > Action: Set Read Only  > Settings > Code

// add
$('.P20002_REQUEST_NAME').addClass('apex_disabled');
$('#P20002_REQUEST_NAME_AB').addClass('apex_disabled');
// $('.P20002_EMPLOYEE_CODE').addClass('apex_disabled');      // cả 3 item (employee code, requester code, department code) cùng column class
$('#P20002_EMPLOYEE_CODE').addClass('apex_disabled');
$('.P20002_DEPARTMENT').addClass('apex_disabled');
$('#P20002_LEVEL').addClass('apex_disabled');
$('#P20002_START_DATE').addClass('apex_disabled');
$('#P20002_TERMINATION_DATE').addClass('apex_disabled');
$('#P20002_RECIPIENT_NAME').addClass('apex_disabled');
$('#P20002_RECIPIENT_DOB').addClass('apex_disabled');
$('.P20002_RELATIONSHIP').addClass('apex_disabled');
$('.P20002_DISCOUNT_RATE').addClass('apex_disabled');
$('#P20002_VOUCHER_CODE').addClass('apex_disabled');
$('#P20002_NUMBER_OF_COURSES').addClass('apex_disabled');
$('#P20002_EFFECTIVE_DATE').addClass('apex_disabled');
$('#P20002_APPROVED_DATE').addClass('apex_disabled');

// remove
$('#P20002_DEPARTMENT_CODE').removeClass('apex_disabled');
$('#P20002_VOUCHER_CODE_REPLACEMENT').removeClass('apex_disabled');
$('#P20002_EXPIRATION_DATE_REPLACEMENT').removeClass('apex_disabled');

// ----------------------------------------
// Page: 20002 - new_scholarship_request > Dynamic Action: Change_A > Action: show_hide_A > Settings > Code

// show
$('#P20002_REQUEST_NAME_AB_CONTAINER').show();
$('#P20002_EMPLOYEE_CODE_CONTAINER').show();
$('#P20002_LEVEL_CONTAINER').show();
$('#P20002_START_DATE_CONTAINER').show();
$('#P20002_TERMINATION_DATE_CONTAINER').show();
$('#P20002_NOTE_CONTAINER').show();

// hide
$('#P20002_REQUEST_NAME_CONTAINER').hide();
$('#P20002_DEPARTMENT_CODE_CONTAINER').hide();
$('.region_partner').hide();
$('#P20002_UPLOAD_FILE_CONTAINER').hide();
$('#P20002_REPLACEMENT_CONTAINER').hide();
$('#P20002_VOUCHER_CODE_REPLACEMENT_CONTAINER').hide();
$('#P20002_EXPIRATION_DATE_REPLACEMENT_CONTAINER').hide();
$('#P20002_REASON_REQUEST_CONTAINER').hide();

// ----------------------------------------
// Page: 20002 - new_scholarship_request > Dynamic Action: Change_0 > Action: Set Read Only  > Client-side Condition > JavaScript Expression

($v("P20002_REQUEST_ID") === null || $v("P20002_REQUEST_ID") === "")

// ----------------------------------------
// Page: 20002 - new_scholarship_request > Dynamic Action: Change_0 > Action: Set Read Only  > Settings > Code

// add
$('.P20002_REQUEST_NAME').addClass('apex_disabled');
$('#P20002_REQUEST_NAME_AB').addClass('apex_disabled');
//$('.P20002_EMPLOYEE_CODE').addClass('apex_disabled');      // cả 3 item employee code, requester code, department code cùng column class
$('#P20002_EMPLOYEE_CODE').addClass('apex_disabled');
// câu lệnh dưới, sau khi disable, item vẫn có thể select
$('.P20002_DEPARTMENT').addClass('apex_disabled');
// câu lệnh dưới, sau khi disable, item KHÔNG select
//apex.item('P20002_DEPARTMENT').disable();
$('#P20002_LEVEL').addClass('apex_disabled');
$('#P20002_START_DATE').addClass('apex_disabled');
$('#P20002_TERMINATION_DATE').addClass('apex_disabled');
$('.P20002_DISCOUNT_RATE').addClass('apex_disabled');
$('#P20002_VOUCHER_CODE').addClass('apex_disabled');
$('#P20002_APPROVED_DATE').addClass('apex_disabled');
$('#P20002_NUMBER_OF_COURSES').addClass('apex_disabled');
$('#P20002_EFFECTIVE_DATE').addClass('apex_disabled');

// remove
$('#P20002_DEPARTMENT_CODE').removeClass('apex_disabled');
$('#P20002_RECIPIENT_NAME').removeClass('apex_disabled');
$('#P20002_RECIPIENT_DOB').removeClass('apex_disabled');
$('.P20002_RELATIONSHIP').removeClass('apex_disabled');
$('#P20002_VOUCHER_CODE_REPLACEMENT').removeClass('apex_disabled');
$('#P20002_EXPIRATION_DATE_REPLACEMENT').removeClass('apex_disabled');
//$('.P20002_DISCOUNT_RATE').removeClass('apex_disabled');

// ----------------------------------------
// Page: 20002 - new_scholarship_request > Dynamic Action: Change_0 > Action: show_hide_0 > Settings > Code

// show
$('#P20002_REQUEST_NAME_AB_CONTAINER').show();
$('#P20002_EMPLOYEE_CODE_CONTAINER').show();
$('#P20002_LEVEL_CONTAINER').show();
$('#P20002_START_DATE_CONTAINER').show();
$('#P20002_TERMINATION_DATE_CONTAINER').show();
$('#P20002_NOTE_CONTAINER').show();

// hide
$('#P20002_REQUEST_NAME_CONTAINER').hide();
$('#P20002_DEPARTMENT_CODE_CONTAINER').hide();
$('.region_partner').hide();
$('#P20002_UPLOAD_FILE_CONTAINER').hide();
$('#P20002_REPLACEMENT_CONTAINER').hide();
$('#P20002_VOUCHER_CODE_REPLACEMENT_CONTAINER').hide();
$('#P20002_EXPIRATION_DATE_REPLACEMENT_CONTAINER').hide();
$('#P20002_REASON_REQUEST_CONTAINER').hide();

// ----------------------------------------
// Page: 20002 - new_scholarship_request > Dynamic Action: Set Read Only > Action: Set Read Only > Client-side Condition > JavaScript Expression

$v("P20002_SCHOLARSHIP_RECIPIENT") === "D" 
// && ($v("P20002_REQUEST_ID") !== null || $v("P20002_REQUEST_ID") !== "")

// ----------------------------------------
// Page: 20002 - new_scholarship_request > Dynamic Action: Set Read Only > Action: Set Read Only > Settings > Code

$('.P20002_SCHOLARSHIP_RECIPIENT').addClass('apex_disabled');      
$('.P20002_PROGRAM').addClass('apex_disabled');                    

$('.P20002_REQUEST_NAME').addClass('apex_disabled');            
$('#P20002_REQUEST_NAME_AB').addClass('apex_disabled');
$('#P20002_EMPLOYEE_CODE').addClass('apex_disabled');
$('#P20002_DEPARTMENT_CODE').addClass('apex_disabled');
$('.P20002_DEPARTMENT').addClass('apex_disabled');              
$('#P20002_LEVEL').addClass('apex_disabled');
$('#P20002_START_DATE').addClass('apex_disabled');
$('#P20002_TERMINATION_DATE').addClass('apex_disabled');


$('#P20002_RECIPIENT_NAME').removeClass('apex_disabled');
$('#P20002_RECIPIENT_DOB').removeClass('apex_disabled');
$('#P20002_RECIPIENT_PHONE').removeClass('apex_disabled');
$('.P20002_RELATIONSHIP').removeClass('apex_disabled');            
$('.P20002_CAMPUS').removeClass('apex_disabled');                     
$('#P20002_UPLOAD_FILE').removeClass('apex_disabled');
$('#P20002_URL_FILES').removeClass('apex_disabled');
$('#P20002_NAME_FILES').removeClass('apex_disabled');


$('.P20002_REPLACEMENT').removeClass('apex_disabled');                
$('#P20002_VOUCHER_CODE_REPLACEMENT').removeClass('apex_disabled');
$('#P20002_EXPIRATION_DATE_REPLACEMENT').removeClass('apex_disabled');
$('#P20002_NOTE').removeClass('apex_disabled');  
$('#P20002_REASON_REQUEST').removeClass('apex_disabled');             


$('.P20002_DISCOUNT_RATE').addClass('apex_disabled');           
$('#P20002_VOUCHER_CODE').addClass('apex_disabled');
$('#P20002_NUMBER_OF_COURSES').addClass('apex_disabled');
$('#P20002_EFFECTIVE_DATE').addClass('apex_disabled');
$('#P20002_APPROVED_DATE').addClass('apex_disabled');
$('#P20002_EXPIRATION_DATE').addClass('apex_disabled');


$('#P20002_PARTNER_NAME').removeClass('apex_disabled');
$('#P20002_PARTNER_PHONE').removeClass('apex_disabled');
$('#P20002_TITLE').removeClass('apex_disabled');
$('.P20002_PARTNER_DEPARTMENT').removeClass('apex_disabled');
$('.P20002_FIELD').removeClass('apex_disabled');
$('#P20002_WORKPLACE').removeClass('apex_disabled');



// ----------------------------------------
// Page: 20002 - new_scholarship_request > Dynamic Action: Set Read Only > Action: Set Read Only > Client-side Condition > JavaScript Expression

$v("P20002_SCHOLARSHIP_RECIPIENT") === "C" 
// && ($v("P20002_REQUEST_ID") !== null || $v("P20002_REQUEST_ID") !== "")

// ----------------------------------------
// Page: 20002 - new_scholarship_request > Dynamic Action: Set Read Only > Action: Set Read Only > Settings > Code

$('.P20002_SCHOLARSHIP_RECIPIENT').addClass('apex_disabled');      
$('.P20002_PROGRAM').addClass('apex_disabled');                    

$('.P20002_REQUEST_NAME').addClass('apex_disabled');            
$('#P20002_REQUEST_NAME_AB').addClass('apex_disabled');
$('#P20002_EMPLOYEE_CODE').addClass('apex_disabled');
$('#P20002_DEPARTMENT_CODE').addClass('apex_disabled');
$('.P20002_DEPARTMENT').addClass('apex_disabled');              
$('#P20002_LEVEL').addClass('apex_disabled');
$('#P20002_START_DATE').addClass('apex_disabled');
$('#P20002_TERMINATION_DATE').addClass('apex_disabled');


$('#P20002_RECIPIENT_NAME').removeClass('apex_disabled');
$('#P20002_RECIPIENT_DOB').removeClass('apex_disabled');
$('#P20002_RECIPIENT_PHONE').removeClass('apex_disabled');
$('.P20002_RELATIONSHIP').removeClass('apex_disabled');            
$('.P20002_CAMPUS').removeClass('apex_disabled');                     
$('#P20002_UPLOAD_FILE').removeClass('apex_disabled');
$('#P20002_URL_FILES').removeClass('apex_disabled');
$('#P20002_NAME_FILES').removeClass('apex_disabled');


$('.P20002_REPLACEMENT').removeClass('apex_disabled');                
$('#P20002_VOUCHER_CODE_REPLACEMENT').removeClass('apex_disabled');
$('#P20002_EXPIRATION_DATE_REPLACEMENT').removeClass('apex_disabled');
$('#P20002_NOTE').removeClass('apex_disabled');  
$('#P20002_REASON_REQUEST').removeClass('apex_disabled');             


$('.P20002_DISCOUNT_RATE').addClass('apex_disabled');           
$('#P20002_VOUCHER_CODE').addClass('apex_disabled');
$('#P20002_NUMBER_OF_COURSES').addClass('apex_disabled');
$('#P20002_EFFECTIVE_DATE').addClass('apex_disabled');
$('#P20002_APPROVED_DATE').addClass('apex_disabled');
$('#P20002_EXPIRATION_DATE').addClass('apex_disabled');


$('#P20002_PARTNER_NAME').removeClass('apex_disabled');
$('#P20002_PARTNER_PHONE').removeClass('apex_disabled');
$('#P20002_TITLE').removeClass('apex_disabled');
$('.P20002_PARTNER_DEPARTMENT').removeClass('apex_disabled');
$('.P20002_FIELD').removeClass('apex_disabled');
$('#P20002_WORKPLACE').removeClass('apex_disabled');

// ----------------------------------------
// Page: 20002 - new_scholarship_request > Dynamic Action: Set Read Only > Action: Set Read Only > Client-side Condition > JavaScript Expression

$v("P20002_SCHOLARSHIP_RECIPIENT") === "B" 
// && ($v("P20002_REQUEST_ID") !== null || $v("P20002_REQUEST_ID") !== "")

// ----------------------------------------
// Page: 20002 - new_scholarship_request > Dynamic Action: Set Read Only > Action: Set Read Only > Settings > Code

// add
$('.P20002_SCHOLARSHIP_RECIPIENT').addClass('apex_disabled');      
$('.P20002_PROGRAM').addClass('apex_disabled');                    

$('.P20002_REQUEST_NAME').addClass('apex_disabled');            
$('#P20002_REQUEST_NAME_AB').addClass('apex_disabled');
$('#P20002_EMPLOYEE_CODE').addClass('apex_disabled');
$('#P20002_DEPARTMENT_CODE').addClass('apex_disabled');
$('.P20002_DEPARTMENT').addClass('apex_disabled');              
$('#P20002_LEVEL').addClass('apex_disabled');
$('#P20002_START_DATE').addClass('apex_disabled');
$('#P20002_TERMINATION_DATE').addClass('apex_disabled');


$('#P20002_RECIPIENT_NAME').removeClass('apex_disabled');
$('#P20002_RECIPIENT_DOB').removeClass('apex_disabled');
$('#P20002_RECIPIENT_PHONE').removeClass('apex_disabled');      
$('.P20002_RELATIONSHIP').removeClass('apex_disabled');
$('.P20002_CAMPUS').removeClass('apex_disabled');                     
$('#P20002_UPLOAD_FILE').removeClass('apex_disabled');
$('#P20002_URL_FILES').removeClass('apex_disabled');
$('#P20002_NAME_FILES').removeClass('apex_disabled');


$('.P20002_REPLACEMENT').removeClass('apex_disabled');                
$('#P20002_VOUCHER_CODE_REPLACEMENT').addClass('apex_disabled');
$('#P20002_EXPIRATION_DATE_REPLACEMENT').addClass('apex_disabled');
$('#P20002_NOTE').removeClass('apex_disabled');  
$('#P20002_REASON_REQUEST').removeClass('apex_disabled');             


$('.P20002_DISCOUNT_RATE').addClass('apex_disabled');           
$('#P20002_VOUCHER_CODE').addClass('apex_disabled');
$('#P20002_NUMBER_OF_COURSES').addClass('apex_disabled');
$('#P20002_EFFECTIVE_DATE').addClass('apex_disabled');
$('#P20002_APPROVED_DATE').addClass('apex_disabled');
$('#P20002_EXPIRATION_DATE').addClass('apex_disabled');


$('#P20002_PARTNER_NAME').removeClass('apex_disabled');
$('#P20002_PARTNER_PHONE').removeClass('apex_disabled');
$('#P20002_TITLE').removeClass('apex_disabled');
$('.P20002_PARTNER_DEPARTMENT').removeClass('apex_disabled');
$('.P20002_FIELD').removeClass('apex_disabled');
$('#P20002_WORKPLACE').removeClass('apex_disabled');

// ----------------------------------------
// Page: 20002 - new_scholarship_request > Dynamic Action: Set Read Only > Action: Set Read Only > Client-side Condition > JavaScript Expression

$v("P20002_SCHOLARSHIP_RECIPIENT") === "A" 
// && ($v("P20002_REQUEST_ID") !== null || $v("P20002_REQUEST_ID") !== "")

// ----------------------------------------
// Page: 20002 - new_scholarship_request > Dynamic Action: Set Read Only > Action: Set Read Only > Settings > Code

// add

$('.P20002_SCHOLARSHIP_RECIPIENT').addClass('apex_disabled');      
$('.P20002_PROGRAM').addClass('apex_disabled');                    

$('.P20002_REQUEST_NAME').addClass('apex_disabled');            
$('#P20002_REQUEST_NAME_AB').addClass('apex_disabled');
$('#P20002_EMPLOYEE_CODE').addClass('apex_disabled');
$('#P20002_DEPARTMENT_CODE').addClass('apex_disabled');
$('.P20002_DEPARTMENT').addClass('apex_disabled');              
$('#P20002_LEVEL').addClass('apex_disabled');
$('#P20002_START_DATE').addClass('apex_disabled');
$('#P20002_TERMINATION_DATE').addClass('apex_disabled');

$('#P20002_RECIPIENT_NAME').addClass('apex_disabled');
$('#P20002_RECIPIENT_DOB').addClass('apex_disabled');
$('.P20002_RELATIONSHIP').addClass('apex_disabled');

$('.P20002_DISCOUNT_RATE').addClass('apex_disabled');           
$('#P20002_VOUCHER_CODE').addClass('apex_disabled');
$('#P20002_NUMBER_OF_COURSES').addClass('apex_disabled');
$('#P20002_EFFECTIVE_DATE').addClass('apex_disabled');
$('#P20002_APPROVED_DATE').addClass('apex_disabled');
$('#P20002_EXPIRATION_DATE').addClass('apex_disabled');

// remove
$('#P20002_PARTNER_NAME').removeClass('apex_disabled');
$('#P20002_PARTNER_PHONE').removeClass('apex_disabled');
$('#P20002_TITLE').removeClass('apex_disabled');
$('.P20002_PARTNER_DEPARTMENT').removeClass('apex_disabled');
$('.P20002_FIELD').removeClass('apex_disabled');
$('#P20002_WORKPLACE').removeClass('apex_disabled');

$('#P20002_RECIPIENT_PHONE').removeClass('apex_disabled');      
$('.P20002_CAMPUS').removeClass('apex_disabled');                     
$('#P20002_UPLOAD_FILE').removeClass('apex_disabled');
$('#P20002_URL_FILES').removeClass('apex_disabled');
$('#P20002_NAME_FILES').removeClass('apex_disabled');
$('.P20002_REPLACEMENT').removeClass('apex_disabled');                
$('#P20002_VOUCHER_CODE_REPLACEMENT').removeClass('apex_disabled');
$('#P20002_EXPIRATION_DATE_REPLACEMENT').removeClass('apex_disabled');

$('#P20002_REASON_REQUEST').removeClass('apex_disabled');             
$('#P20002_NOTE').removeClass('apex_disabled');                






// ----------------------------------------
// Page: 20002 - new_scholarship_request > Dynamic Action: set_value_of_voucher_code > Client-side Condition > JavaScript Expression

$v("P20002_REQUEST_ID") === null || $v("P20002_REQUEST_ID") === ""

// ----------------------------------------
// Page: 20002 - new_scholarship_request > Dynamic Action: change_value_of_replacement > Client-side Condition > JavaScript Expression

$v("P20002_REPLACEMENT") !== null

// ----------------------------------------
// Page: 20002 - new_scholarship_request > Dynamic Action: change_value_of_request_name > Client-side Condition > JavaScript Expression

//($v("P20002_REQUEST_ID") === null || $v("P20002_REQUEST_ID") === "")

($v("P20002_SCHOLARSHIP_RECIPIENT") === "C" || $v("P20002_SCHOLARSHIP_RECIPIENT") === "D")  && 
($v("P20002_REQUEST_ID") === "" || $v("P20002_REQUEST_ID") === null) && 
$v("P20002_REQUEST_NAME") !== null

// ----------------------------------------
// Page: 20002 - new_scholarship_request > Dynamic Action: Change P20002_WORKPLACE > Client-side Condition > JavaScript Expression

($v("P20002_REQUEST_ID") === null || $v("P20002_REQUEST_ID") === "")

// ----------------------------------------
// Page: 20002 - new_scholarship_request > Dynamic Action: Change P20002_FIELD > Client-side Condition > JavaScript Expression

($v("P20002_REQUEST_ID") === null || $v("P20002_REQUEST_ID") === "")

// ----------------------------------------
// Page: 20002 - new_scholarship_request > Dynamic Action: Change P20002_PARTNER_DEPARTMENT > Client-side Condition > JavaScript Expression

($v("P20002_REQUEST_ID") === null || $v("P20002_REQUEST_ID") === "")

// ----------------------------------------
// Page: 20002 - new_scholarship_request > Dynamic Action: Change P20002_TITLE > Client-side Condition > JavaScript Expression

($v("P20002_REQUEST_ID") === null || $v("P20002_REQUEST_ID") === "")

// ----------------------------------------
// Page: 20002 - new_scholarship_request > Dynamic Action: Change P20002_PARTNER_PHONE > Client-side Condition > JavaScript Expression

($v("P20002_REQUEST_ID") === null || $v("P20002_REQUEST_ID") === "")

// ----------------------------------------
// Page: 20002 - new_scholarship_request > Dynamic Action: Change P20002_PARTNER_NAME > Client-side Condition > JavaScript Expression

($v("P20002_REQUEST_ID") === null || $v("P20002_REQUEST_ID") === "")

// ----------------------------------------
// Page: 20002 - new_scholarship_request > Dynamic Action: Change P20002_EXPIRATION_DATE > Client-side Condition > JavaScript Expression

($v("P20002_REQUEST_ID") === null || $v("P20002_REQUEST_ID") === "")

// ----------------------------------------
// Page: 20002 - new_scholarship_request > Dynamic Action: Change P20002_EFFECTIVE_DATE > Client-side Condition > JavaScript Expression

($v("P20002_REQUEST_ID") === null || $v("P20002_REQUEST_ID") === "")

// ----------------------------------------
// Page: 20002 - new_scholarship_request > Dynamic Action: Change P20002_REASON_REQUEST > Client-side Condition > JavaScript Expression

($v("P20002_REQUEST_ID") === null || $v("P20002_REQUEST_ID") === "")

// ----------------------------------------
// Page: 20002 - new_scholarship_request > Dynamic Action: Change P20002_REPLACEMENT > Client-side Condition > JavaScript Expression

($v("P20002_REQUEST_ID") === null || $v("P20002_REQUEST_ID") === "")

// ----------------------------------------
// Page: 20002 - new_scholarship_request > Dynamic Action: Change P20002_CAMPUS > Client-side Condition > JavaScript Expression

($v("P20002_REQUEST_ID") === null || $v("P20002_REQUEST_ID") === "")

// ----------------------------------------
// Page: 20002 - new_scholarship_request > Dynamic Action: Change P20002_RELATIONSHIP > Client-side Condition > JavaScript Expression

($v("P20002_REQUEST_ID") === null || $v("P20002_REQUEST_ID") === "")

// ----------------------------------------
// Page: 20002 - new_scholarship_request > Dynamic Action: Change P20002_RECIPIENT_PHONE > Client-side Condition > JavaScript Expression

($v("P20002_REQUEST_ID") === null || $v("P20002_REQUEST_ID") === "")

// ----------------------------------------
// Page: 20002 - new_scholarship_request > Dynamic Action: Change P20002_RECIPIENT_DOB > Client-side Condition > JavaScript Expression

($v("P20002_REQUEST_ID") === null || $v("P20002_REQUEST_ID") === "")

// ----------------------------------------
// Page: 20002 - new_scholarship_request > Dynamic Action: Change P20002_RECIPIENT_NAME > Client-side Condition > JavaScript Expression

($v("P20002_REQUEST_ID") === null || $v("P20002_REQUEST_ID") === "")

// ----------------------------------------
// Page: 20002 - new_scholarship_request > Dynamic Action: Change P20002_TERMINATION_DATE > Client-side Condition > JavaScript Expression

($v("P20002_REQUEST_ID") === null || $v("P20002_REQUEST_ID") === "")

// ----------------------------------------
// Page: 20002 - new_scholarship_request > Dynamic Action: Change P20002_START_DATE > Client-side Condition > JavaScript Expression

($v("P20002_REQUEST_ID") === null || $v("P20002_REQUEST_ID") === "")

// ----------------------------------------
// Page: 20002 - new_scholarship_request > Dynamic Action: Change P20002_LEVEL > Client-side Condition > JavaScript Expression

($v("P20002_REQUEST_ID") === null || $v("P20002_REQUEST_ID") === "")

// ----------------------------------------
// Page: 20002 - new_scholarship_request > Dynamic Action: Change P20002_DEPARTMENT > Client-side Condition > JavaScript Expression

($v("P20002_REQUEST_ID") === null || $v("P20002_REQUEST_ID") === "")

// ----------------------------------------
// Page: 20002 - new_scholarship_request > Dynamic Action: Change P20002_DEPARTMENT_CODE > Client-side Condition > JavaScript Expression

($v("P20002_REQUEST_ID") === null || $v("P20002_REQUEST_ID") === "")

// ----------------------------------------
// Page: 20002 - new_scholarship_request > Dynamic Action: Change P20002_EMPLOYEE_CODE > Client-side Condition > JavaScript Expression

($v("P20002_REQUEST_ID") === null || $v("P20002_REQUEST_ID") === "")

// ----------------------------------------
// Page: 20002 - new_scholarship_request > Dynamic Action: Change P20002_REQUEST_NAME > Client-side Condition > JavaScript Expression

($v("P20002_REQUEST_ID") === null || $v("P20002_REQUEST_ID") === "")

// ----------------------------------------
// Page: 20002 - new_scholarship_request > Dynamic Action: Change P20002_REQUEST_NAME_AB > Client-side Condition > JavaScript Expression

($v("P20002_REQUEST_ID") === null || $v("P20002_REQUEST_ID") === "")

// ----------------------------------------
// Page: 20002 - new_scholarship_request > Dynamic Action: Change P20002_PROGRAM > Client-side Condition > JavaScript Expression

($v("P20002_REQUEST_ID") === null || $v("P20002_REQUEST_ID") === "")

// ----------------------------------------
// Page: 20002 - new_scholarship_request > Dynamic Action: Change P20002_NOTE > Client-side Condition > JavaScript Expression

($v("P20002_REQUEST_ID") === null || $v("P20002_REQUEST_ID") === "")

