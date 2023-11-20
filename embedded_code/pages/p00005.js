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
// Page: 5 - Personal Information > JavaScript > Function and Global Variable Declaration

function generateTempKey(ig$, column, record, value, rowIndex, modelInstance) {
  var tempKey = 'temp_' + new Date().getTime() + '_' + Math.random().toString(36).substr(2, 9);
  return tempKey;
}


// ----------------------------------------
// Page: 5 - Personal Information > Dynamic Action: auto_close_noti > Action: Execute JavaScript Code > Settings > Code

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
// Page: 5 - Personal Information > Dynamic Action: Reload > Action: Refresh > Affected Elements > JavaScript Expression

location.reload();

// ----------------------------------------
// Page: 5 - Personal Information > Dynamic Action: auto_close_noti > Action: Execute JavaScript Code > Settings > Code

// Chờ cho đến khi document hoàn tất việc tải
apex.jQuery(document).ready(function(){
  // Kiểm tra sau mỗi 500ms xem thông báo đã sẵn sàng chưa
  var checkExist = setInterval(function() {
     if (apex.jQuery('.t-Alert--warning').length) {
        // console.log("Success message exists");
        // Khi thông báo xuất hiện, đặt timeout để ẩn nó sau 3-5 giây
        setTimeout(function(){
            apex.jQuery('.t-Alert--warning').fadeOut('slow');
        }, 3000); // Đổi 3000 (3 giây) thành 5000 để làm 5 giây nếu cần
        clearInterval(checkExist); // Xóa interval sau khi đã tìm thấy và xử lý thông báo
     }
  }, 500); // Kiểm tra mỗi nửa giây
});


// ----------------------------------------
// Page: 5 - Personal Information > Dynamic Action: Row Init > Action: Set edu_temp_id > Settings > Code

// Get the model and record data from the Interactive Grid
var model = this.data.model,
    rec = this.data.record,
    meta = model.getRecordMetadata(this.data.recordId);

// Check if the record has been newly inserted
if (meta.inserted) {
    apex.server.process('GET_NEXT_EDU_TEMP_ID_SEQ', {
        // x01 could be used to pass any additional data if needed
    }, {
        success: function(data) {
            // Assuming the server returns the next sequence value in the 'nextSeqValue' attribute
            var seqValue = data.nextSeqValue;

            // Set the TEMP_ID column value using the sequence value obtained from the server
            model.setValue(rec, "TEMP_ID", seqValue.toString());

            var employee_code = rec[model.getFieldKey('EMPLOYEE_CODE')];
            var emp_education_id = rec[model.getFieldKey('EMP_EDUCATION_ID')];
            var TEMP_ID = rec[model.getFieldKey('TEMP_ID')];

            console.log('employee_code: ' + employee_code);
            console.log('emp_education_id: ' + emp_education_id);
            console.log('TEMP_ID: ' + TEMP_ID);

            // After setting TEMP_ID, find the link in the current row and update it
            var linkSelector = 'a.edu-upload-link';
            var currentRowSelector = '#education-box .a-GV-row.is-selected.is-inserted ' + linkSelector;
            var $linkInCurrentRow = jQuery(currentRowSelector);
            $linkInCurrentRow.attr('data-tempid', seqValue);

            // Refresh the grid to reflect the changes
            model.refresh();

            // Issue: When set value of the TEMP_ID column using model.setValue, the record do not save value of the TEMP_ID column when inserted (new record)
            // Workaround: Set value of the TEMP_ID column using jQuery
            // jQuery('#education-box .a-GV-row.is-selected.is-inserted .a-GV-cell[data-header="TEMP_ID"]').text(seqValue);
            
        },
        error: function(jqXHR, textStatus, errorThrown) {
            // Handle any errors
            apex.debug.error('Error fetching next sequence value:', errorThrown);
        }
    });
}

// ----------------------------------------
// Page: 5 - Personal Information > Dynamic Action: IG Certificate - Row init > Action: Set Certiciate's TEMP_ID > Settings > Code

// Get the model and record data from the Interactive Grid
var model = this.data.model,
    rec = this.data.record,
    meta = model.getRecordMetadata(this.data.recordId);

// Check if the record has been newly inserted
if (meta.inserted) {
    apex.server.process('GET_NEXT_CERT_TEMP_ID_SEQ', {
        // x01 could be used to pass any additional data if needed
    }, {
        success: function(data) {
            // Assuming the server returns the next sequence value in the 'nextSeqValue' attribute
            var seqValue = data.nextSeqValue;

            // Set the TEMP_ID column value using the sequence value obtained from the server
            model.setValue(rec, "TEMP_ID", seqValue.toString());

            // After setting TEMP_ID, find the link in the current row and update it
            var linkSelector = 'a.cert-upload-link';
            var currentRowSelector = '#certificate-box .a-GV-row.is-selected.is-inserted ' + linkSelector;
            var $linkInCurrentRow = jQuery(currentRowSelector);
            $linkInCurrentRow.attr('data-tempid', seqValue);

            // Refresh the grid to reflect the changes
            model.refresh();

            // Issue: When set value of the TEMP_ID column using model.setValue, the record do not save value of the TEMP_ID column when inserted (new record)
            // Workaround: Set value of the TEMP_ID column using jQuery
            // jQuery('#education-box .a-GV-row.is-selected.is-inserted .a-GV-cell[data-header="TEMP_ID"]').text(seqValue);
            
        },
        error: function(jqXHR, textStatus, errorThrown) {
            // Handle any errors
            apex.debug.error('Error fetching next sequence value:', errorThrown);
        }
    });
}

// ----------------------------------------
// Page: 5 - Personal Information > Dynamic Action: Reload > When > JavaScript Expression

window

// ----------------------------------------
// Page: 5 - Personal Information > JavaScript > Execute when Page Loads

// $('#education-box').before('<h3 style="font-weight: 700;">Degree</h3>');
// $('#certificate-box #certificate-box_ig').before('<h3 style="font-weight: 700;">Other certificates</h3>');

$('#education-box').before('<h3 style="font-weight: 700;" id="mess_degree"></h3>');
$('#certificate-box #certificate-box_ig').before('<h3 style="font-weight: 700;" id="mess_certificates"></h3>');

// document.addEventListener('DOMContentLoaded', function() {
document.getElementById('mess_degree').textContent = apex.lang.getMessage('DEGREE');
//document.getElementById('mess_degree').textContent = 'TEXT';
document.getElementById('mess_certificates').textContent = apex.lang.getMessage('CERTIFICATES');
// });

apex.jQuery(function($) {
  // Wait for the Interactive Grid to be initialized
  $('body').on('interactivegridviewmodelcreate', function(event, viewmodel) {
    var grid = viewmodel.grid;

    // Bind an event to the 'Add Row' button click
    grid.widget().on('gridpageaddrow', function(e, ui) {
      // Get model from the grid
      var model = grid.model;

      // Get the newly added record
      var record = model.getRecord(ui.recordId);

      // Generate and set the temporary key
      var tempKey = generateTempKey();
      model.setValue(record, 'TEMP_KEY', tempKey);
    });
  });
});


// -------------------------------------------------------

jQuery(document).on('click', '.edu-upload-link', function (e) {
    e.preventDefault();
    var $this = jQuery(this);
    var tempId = $this.data('tempid');
    var empCode = $this.data('empcode');
    var eduId = $this.data('edu-id');

    // Construct the base URL
    var url = "f?p=#APP_ID#:10101:#SESSION#::NO::P10101_TEMP_ID,P10101_EMPLOYEE_CODE,P10101_EMP_EDUCATION_ID:" + tempId + "," + empCode + "," + eduId;
    url = url.replace("#APP_ID#", $v("pFlowId"));
    url = url.replace("#SESSION#", $v("pInstance"));

    // Make the AJAX call
    apex.server.process("PREPARE_URL", {
        x01: url
    }, {
        success: function(pData) {
            if (pData.success === true) {
                apex.navigation.redirect(pData.url);
            } else {
                console.log("Error: URL preparation failed");
            }
        },
        error: function(request, status, error) {
            console.log("AJAX error: " + status + " - " + error);
        }
    });
});


// Upload attachment IG Certificate

jQuery(document).on('click', '.cert-upload-link', function (e) {
    e.preventDefault();
    var $this = jQuery(this);
    var tempId = $this.data('tempid');
    var empCode = $this.data('empcode');
    var certId = $this.data('cert-id');

    // Construct the base URL
    var url = "f?p=#APP_ID#:10102:#SESSION#::NO::P10102_TEMP_ID,P10102_EMPLOYEE_CODE,P10102_EMP_CERTIFICATE_ID:" + tempId + "," + empCode + "," + certId;
    url = url.replace("#APP_ID#", $v("pFlowId"));
    url = url.replace("#SESSION#", $v("pInstance"));

    // Make the AJAX call
    apex.server.process("PREPARE_URL", {
        x01: url
    }, {
        success: function(pData) {
            if (pData.success === true) {
                apex.navigation.redirect(pData.url);
            } else {
                console.log("Error: URL preparation failed");
            }
        },
        error: function(request, status, error) {
            console.log("AJAX error: " + status + " - " + error);
        }
    });
});

