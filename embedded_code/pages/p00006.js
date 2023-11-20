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
// Page: 6 - My Payslips History > Dynamic Action: auto_close_noti > Action: Execute JavaScript Code > Settings > Code

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
// Page: 6 - My Payslips History > Dynamic Action: auto_close_noti > Action: Execute JavaScript Code > Settings > Code

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


