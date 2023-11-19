// Get the model and record data from the Interactive Grid
var model = this.data.model,
    rec = this.data.record,
    meta = model.getRecordMetadata(this.data.recordId);

// Check if the record has been newly inserted
if (meta.inserted) {
    apex.server.process('GET_NEXT_SEQUENCE_VALUE', {
        // x01 could be used to pass any additional data if needed
    }, {
        success: function(data) {
            // Assuming the server returns the next sequence value in the 'nextSeqValue' attribute
            var seqValue = data.nextSeqValue;

            // Set the TEMP_ID column value using the sequence value obtained from the server
            model.setValue(rec, "TEMP_ID", seqValue);

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
     
        },
        error: function(jqXHR, textStatus, errorThrown) {
            // Handle any errors
            apex.debug.error('Error fetching next sequence value:', errorThrown);
        }
    });
}