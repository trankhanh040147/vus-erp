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
// Page: 10 - Leave Request for Manager > Dynamic Action: Set display time > Action: Execute JavaScript Code > Settings > Code

$('#P10_START_TIME_CONTAINER').hide();
$('#P10_START_TIME_HO_CONTAINER').hide();
$('#P10_END_TIME_CONTAINER').hide();

// ----------------------------------------
// Page: 10 - Leave Request for Manager > Dynamic Action: auto_close_noti > Action: Execute JavaScript Code > Settings > Code

// Chờ cho đến khi document hoàn tất việc tải
apex.jQuery(document).ready(function(){
  // Kiểm tra sau mỗi 500ms xem thông báo đã sẵn sàng chưa
  var checkExist = setInterval(function() {
     if (apex.jQuery('.t-Alert--success').length) {
        // console.log("Success message exists");
        // Khi thông báo xuất hiện, đặt timeout để ẩn nó sau 3-5 giây
        setTimeout(function(){
            apex.jQuery('.t-Alert--success').fadeOut('slow');
        }, 5000); // Đổi 3000 (3 giây) thành 5000 để làm 5 giây nếu cần
        clearInterval(checkExist); // Xóa interval sau khi đã tìm thấy và xử lý thông báo
     }
  }, 500); // Kiểm tra mỗi nửa giây
});


// ----------------------------------------
// Page: 10 - Leave Request for Manager > Dynamic Action: auto_close_noti > Action: Execute JavaScript Code > Settings > Code

// Chờ cho đến khi document hoàn tất việc tải
apex.jQuery(document).ready(function(){
  // Kiểm tra sau mỗi 500ms xem thông báo đã sẵn sàng chưa
  var checkExist = setInterval(function() {
     if (apex.jQuery('.t-Alert--warning').length) {
        // console.log("Success message exists");
        // Khi thông báo xuất hiện, đặt timeout để ẩn nó sau 3-5 giây
        setTimeout(function(){
            apex.jQuery('.t-Alert--warning').fadeOut('slow');
        }, 5000); // Đổi 3000 (3 giây) thành 5000 để làm 5 giây nếu cần
        clearInterval(checkExist); // Xóa interval sau khi đã tìm thấy và xử lý thông báo
     }
  }, 500); // Kiểm tra mỗi nửa giây
});


// ----------------------------------------
// Page: 10 - Leave Request for Manager > Dynamic Action: Change Start_Time > Action: Set END_TIME for HO > Settings > Code

// Parse the hour and minute from START_TIME
let [hour, minute] = $v("P10_START_TIME").split(":").map(Number);

// Add 4 hours
hour += 4;

// Handle situations where the hour is 24 or more
if (hour >= 24) {
  hour -= 24;
}

// Update END_TIME
$s("P10_END_TIME", ("0" + hour).slice(-2) + ":" + ("0" + minute).slice(-2));

// ----------------------------------------
// Page: 10 - Leave Request for Manager > Dynamic Action: Change Type > Action: Unblock submit onload > Affected Elements > JavaScript Expression

$('#btnSubmitLeave').attr('disabled',false);

// ----------------------------------------
// Page: 10 - Leave Request for Manager > Dynamic Action: Change Type > Action: Block submit onload > Affected Elements > JavaScript Expression

$('#btnSubmitLeave').attr('disabled',true);

// ----------------------------------------
// Page: 10 - Leave Request for Manager > Dynamic Action: Change Type > Action: Execute JavaScript Code > Settings > Code

$('#P10_ANNUAL_LEAVE_BALANCE_CONTAINER').show();


// ----------------------------------------
// Page: 10 - Leave Request for Manager > Dynamic Action: Change Type > Action: Execute JavaScript Code > Settings > Code

$('#P10_ANNUAL_LEAVE_BALANCE_CONTAINER').hide();


// ----------------------------------------
// Page: 10 - Leave Request for Manager > Dynamic Action: Change Type > Action: Hide Leave_Detail > Settings > Code

$('#P10_LEAVE_DETAIL_CONTAINER').hide();
$('#P10_UPLOAD_FILE_inline_help').hide();


// ----------------------------------------
// Page: 10 - Leave Request for Manager > Dynamic Action: Change Type > Action: Show Leave_Detail > Settings > Code

$('#P10_LEAVE_DETAIL_CONTAINER').show();
$('#P10_UPLOAD_FILE_inline_help').show();


// ----------------------------------------
// Page: 10 - Leave Request for Manager > Dynamic Action: Change from date > Action: Change End_Date when it disabled > Client-side Condition > JavaScript Expression

$('#P10_END_DATE').attr('disabled') === 'disabled';

// ----------------------------------------
// Page: 10 - Leave Request for Manager > Dynamic Action: Change from date > Action: Change End_Date when it disabled > Client-side Condition > JavaScript Expression

$('#P10_END_DATE').attr('disabled') === 'disabled';

// ----------------------------------------
// Page: 10 - Leave Request for Manager > Dynamic Action: Change from date > Action: Change End_Date when it disabled > Settings > Code

$('#P10_END_DATE').attr('value',$('#P10_FROM_DATE').val());


// ----------------------------------------
// Page: 10 - Leave Request for Manager > Dynamic Action: Set display time > Action: Enable_end_date > Settings > Code

$('#P10_END_DATE').attr('disabled',false);

// ----------------------------------------
// Page: 10 - Leave Request for Manager > Dynamic Action: Set display time > Action: Disable_end_date > Settings > Code

$('#P10_END_DATE').attr('disabled',true);

// ----------------------------------------
// Page: 10 - Leave Request for Manager > Dynamic Action: Set display time > Action: Execute JavaScript Code > Settings > Code

$('#P10_START_TIME_CONTAINER').show();
$('#P10_START_TIME_HO_CONTAINER').show();
$('#P10_END_TIME_CONTAINER').show();

