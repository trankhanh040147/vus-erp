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
// Page: 35 - List Request overtime for Employee > JavaScript > Execute when Page Loads

$('.req-status').each(function(){
    if ($(this).text() == 'In Review'||$(this).text() == 'Approved'||$(this).text() == 'Rejected'){
        console.log($(this).parent());
        $(this).parent().addClass('disabled');
    }
})

$('.a-GV-pageSelector-item').click(function(){
    console.log('Clicked on pagination.')
    $('.req-status').each(function(){
        if ($(this).text() == 'In Review'||$(this).text() == 'Approved'||$(this).text() == 'Rejected'){
            console.log($(this).parent());
            $(this).parent().addClass('disabled');
        }
    })
})

// ----------------------------------------
// Page: 35 - List Request overtime for Employee > Dynamic Action: Delete > Action: Execute JavaScript Code > Settings > Code

apex.region( "ontoor" ).widget().interactiveGrid( "getActions" ).invoke( "selection-delete" );

// ----------------------------------------
// Page: 35 - List Request overtime for Employee > Dynamic Action: Reload > Action: Execute JavaScript Code > Settings > Code

location.reload()

// ----------------------------------------
// Page: 35 - List Request overtime for Employee > Dynamic Action: Reload > When > JavaScript Expression

window

