// [Update 5.1.1] The following example is updated to show using the view rowActionMenu$ property and the new viewchange created flag.

// do this after the page loads but before the IG is initialized to catch the initial events
$(function() {
    // listen for view change events to find out when grid views are created 
    $("#iGrid_workflow_conditions").on("interactivegridviewchange", function(event, data) {
        if ( data.view === "grid" && data.created ) {
            var view = apex.region("iGrid_workflow_conditions").widget().interactiveGrid("getViews", "grid"),
                menu$ = view.rowActionMenu$;

            menu$.menu("option").items.push({
                type:"action",
                label:"Hi",
                action: function(menu, element) {
                    var record = view.getContextRecord( element )[0];
                    alert("Hi " + view.model.getValue(record, "ENAME") );
                }
            });
        }
    });
});

// [Update 5.1.1] The following example is updated to show using the view selActionMenu$ property and the new viewchange created flag.

// Adding to the Selection Actions Menu is very similar. The following is an example that does just that. Replace the addGridMenu in the previous example with this one. Add the following code to the page attribute JavaScript: Function and Global Variable Declaration. An additional requirement is that the IG has a numeric column called SAL.


// do this after the page loads but before the IG is initialized to catch the initial events
$(function() {
    // listen for view change events to find out when grid views are created 
    $("#iGrid_workflow_conditions").on("interactivegridviewchange", function(event, data) {
        if ( data.view === "grid" && data.created ) {
            var view = apex.region("iGrid_workflow_conditions").widget().interactiveGrid("getViews", "grid"),
                menu$ = view.selActionMenu$;

            menu$.menu("option").items.push({
                type:"action",
                label:"Total Salary",
                action: function(menu, element) {
                    var i, records = view.getSelectedRecords(),
                        total = 0;
                    for ( i = 0; i < records.length; i++) {
                        total += parseInt(view.model.getValue(records[i], "SAL"), 10);
                    }
                    alert("Total Salary is " + total);
                }
            });
        }
    });
});

// all item.action in Menu
// single-row-view undefined undefined action
// undefined undefined undefined 'separator'
// row-add-row undefined undefined action
// row-duplicate undefined undefined action
// undefined undefined undefined 'separator'
// row-delete undefined undefined action
// undefined undefined undefined 'separator'
// row-refresh undefined undefined action
// row-revert undefined undefined action

// remove all action except delete row
$(function() {
    // Listen for view change events to modify the grid when it's created
    $("#iGrid_workflow_conditions").on("interactivegridviewchange", function(event, data) {
        if (data.view === "grid" && data.created) {
            var view = apex.region("iGrid_workflow_conditions").widget().interactiveGrid("getViews", "grid"),
                menu$ = view.rowActionMenu$;

            // Check each menu item and remove if not the 'Delete' action
            menu$.menu("option", "items").forEach(function(item, index, object) {
                // print action info
                // console.log(item.action, item.label, item.icon, item.type); 
                // console.log(item.action); 
                
                if (item.action && item.action !== 'row-delete') {
                    console.log(item.action); 
                    // add class to hide menu item
                    menu$.find('.a-Menu-item:eq(' + index + ')').addClass('display-none');
                }
            });     
        }
    });
});


$(function() {
    $("#iGrid_workflow_conditions").on("interactivegridviewchange", function(event, data) {
        if (data.view === "grid" && data.created) {
            var view = apex.region("iGrid_workflow_conditions").widget().interactiveGrid("getViews", "grid"),
                menu$ = view.rowActionMenu$;

            // Rebuild the items array with only the desired actions
            var newItems = menu$.menu("option", "items").filter(function(item) {
                return item.action === 'row-delete';
            });

            // Set the new items array
            menu$.menu("option", "items", newItems);
        }
    });
});

