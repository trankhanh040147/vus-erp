// // Get the model and record data from the Interactive Grid
// var model = this.data.model,
//     rec = this.data.record,
//     meta = model.getRecordMetadata(this.data.recordId);

// // Check if the record has been newly inserted
// if (meta.inserted) {
//     // Call the AJAX Callback process to get the next sequence value
//     apex.server.process('GET_NEXT_SEQUENCE_VALUE', {
//         // x01 could be used to pass any additional data if needed
//     }, {
//         success: function(data) {
//             // Assuming the server returns the next sequence value in the 'nextSeqValue' attribute
//             var seqValue = data.nextSeqValue;

//             console.log('seqValue: ' +  seqValue);      

//             // Set the TEMP_KEY column value using the sequence value obtained from the server
//             // The 'd' property is used for display and 'v' property for the actual value
//             // model.setValue(rec, "TEMP_KEY", {d: seqValue.toString(), v: seqValue});
//             // TEMP_KEY is number
//             var uploadIconHtml = '<span class="fa fa-upload"></span>';
//             model.setValue(rec, "TEMP_ID", {d: seqValue, v: seqValue});
//             // model.setValue(rec, 'UPLOAD', uploadIconHtml);

//             // model.setValue(rec, "TEMP_KEY", {d: 1, v: 2});
//         },
//         error: function(jqXHR, textStatus, errorThrown) {
//             // Handle any errors
//             apex.debug.error('Error fetching next sequence value:', errorThrown);
//         }
//     });
// }


// ------------------------------------------------------------


// Get the model and record data from the Interactive Grid
var model = this.data.model,
    rec = this.data.record,
    meta = model.getRecordMetadata(this.data.recordId);

// Check if the record has been newly inserted
if (meta.inserted) {
    // Call the AJAX Callback process to get the next sequence value
    apex.server.process('GET_NEXT_SEQUENCE_VALUE', {
        // x01 could be used to pass any additional data if needed
    }, {
        success: function(data) {
            // Assuming the server returns the next sequence value in the 'nextSeqValue' attribute
            var seqValue = data.nextSeqValue;

            // Set the TEMP_ID column value using the sequence value obtained from the server
            model.setValue(rec, "TEMP_ID", seqValue);

            // Now set the UPLOAD column with the HTML for the upload icon
            // Construct the upload link using the sequence value
            // var uploadLink = apex.util.makeApplicationUrl({
            //     pageId: 10101, // Your page number for the upload dialog
            //     items: 'P10101_EMPLOYEE_CODE,P10101_TEMP_ID',
            //     values: rec[model.getFieldKey('EMPLOYEE_ID')] + ',' + seqValue
            // });


            // var uploadIconHtml = '<a href="javascript:openModal(\'' + uploadLink + '\');"><span class="fa fa-upload"></span></a>';
            
            // uploadIconHtml expected: <a href="javascript:apex.theme42.dialog('\u002Fords\u002Fr\u002Ferp\u002Ferp\u002Fdemo-upload-file-education?p10101_employee_code=626\u0026p10101_temp_id=5\u0026p10101_emp_education_id=3723\u0026clear=10101\u0026session=515872932492670\u0026dialogCs=d6JOtqQGzr8wV_H0KV3jpnjpX55378KhHWaCyWDxIYbPYz9uUj7ztPwiCg48gabhGiUZldGp-wXURoC1iRYvqg',{title:'Attachments',h:'auto',w:'720',mxw:'960',modal:true,dialog:null,dlgCls:'t-Dialog-page--standard '+''},'','#education-box')" tabindex="-1"><span><i class="fa fa-upload"></i></span></a>

            var employee_code = rec[model.getFieldKey('EMPLOYEE_CODE')];
            var emp_education_id = rec[model.getFieldKey('EMP_EDUCATION_ID')];
            var TEMP_ID = rec[model.getFieldKey('TEMP_ID')];

            uploadIconHtml = '<a href="javascript:apex.theme42.dialog(\'/ords/r/erp/erp/demo-upload-file-education?p10101_employee_code=' + employee_code + '&p10101_temp_id=' + TEMP_ID + '&clear=10101&session=515872932492670&dialogCs=d6JOtqQGzr8wV_H0KV3jpnjpX55378KhHWaCyWDxIYbPYz9uUj7ztPwiCg48gabhGiUZldGp-wXURoC1iRYvqg\',{title:\'Attachments\',h:\'auto\',w:\'720\',mxw:\'960\',modal:true,dialog:null,dlgCls:\'t-Dialog-page--standard \'+\'\'},\'\',\'#education-box\')" tabindex="-1"><span><i class="fa fa-upload"></i></span></a>';

            console.log(uploadIconHtml);
            console.log('employee_code: ' + employee_code);
            console.log('emp_education_id: ' + emp_education_id);
            console.log('TEMP_ID: ' + TEMP_ID);

            // model.setValue(rec, 'UPLOAD', uploadIconHtml);


        },
        error: function(jqXHR, textStatus, errorThrown) {
            // Handle any errors
            apex.debug.error('Error fetching next sequence value:', errorThrown);
        }
    });
}

// Helper function to open the modal dialog
function openModal(link) {
    apex.theme42.util.modalDialog(link, {
        title: 'Attachments',
        height: 'auto',
        width: '720',
        maxWidth: '960',
        modal: true
    });
}
