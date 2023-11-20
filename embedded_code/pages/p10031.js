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
// Page: 10031 - Top Users > Region: Top Users Chart > Attributes:  > Advanced > Initialization JavaScript Function

function( options ){ 

    this.pieSliceLabel = function(dataContext) {
        var series_name,
            percent = Math.round(dataContext.value/dataContext.totalValue*100);
        
        if ( dataContext.seriesData ) {
            series_name = dataContext.seriesData.name;
        } else {
            series_name = 'Other';
        }
        return series_name + " " + percent + "% ( " + dataContext.value + " )";
    }
    
    // Set chart initialization options 
    options.dataLabel = pieSliceLabel; 
    return options; 
}

