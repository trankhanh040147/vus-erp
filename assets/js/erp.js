function onLoadFunction() {
    var treeNav = document.getElementById("t_TreeNav");
    if (
        (treeNav && treeNav.getAttribute("aria-hidden") === "true") ||
        treeNav.getAttribute("aria-expanded") === "false"
    ) {
        // The element with ID "t_TreeNav" has aria-hidden="false", so click it
        treeNav.click();
    } else {
        // The element doesn't have aria-hidden="false", so don't click it
        console.log("t_TreeNav is hidden or not found.");
    }

    // jQuery('.a-GV-w-scroll').jScrollPane();
}

window.onload = onLoadFunction;