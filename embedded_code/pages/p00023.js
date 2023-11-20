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
// Page: 23 - Time Sheet for Employee > JavaScript > Execute when Page Loads

styling_grid();
filterCheckboxes();


// Click on pagination
$(document).on('click', '.a-GV-pageButton', function () {
    console.log('Clicked on pagination.');

    setTimeout(function () {
        styling_grid();
        filterCheckboxes();
    }, 300);
});

// Style interative grid
function styling_grid() {
    const tdElements = document.querySelectorAll('.page-23 .a-GV-table--checkbox tbody td:nth-child(29)');

    tdElements.forEach(td => {
        const text = td.textContent.toLowerCase();
        console.log(text);
        if (text === 'check') {
            td.style.color = '#ff67ff';
        }
    });
}

// Hide checkbox base on status
function filterCheckboxes() {
    $('.req-status').each(function () {
        if ($(this).text() != 'Need to confirm') {
            console.log($(this).parent());
            $(this).parent().addClass('disabled');
        }
    });
}







// ----------------------------------------
// Page: 23 - Time Sheet for Employee > Dynamic Action: Set selected > Action: Execute JavaScript Code > Settings > Code

var i, selectedIds="",

    model = this.data.model;

for ( i = 0; i < this.data.selectedRecords.length; i++ ) {

//here you fetch the records of the column you want to pass to the ITEM

    selectedIds += ":"+ model.getValue( this.data.selectedRecords[i], "ID") ;

}

//your item to be set on click in the IG
selectedIds = selectedIds.substring(1);
$s("P23_SELECTED",selectedIds);

