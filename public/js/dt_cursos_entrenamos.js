var anOpen = [];
var sImageUrl = "http://qa.kleer.la/wp-content/uploads/2011/03/";
//sImageUrl = "./DataTables-1.9.1/media/images/";

var oTable;
$(document).ready(function() {
	oTable = $('#cursos').dataTable( {
		"bLengthChange": false,
		/*"bProcessing": true, lo anule porque ocupa mucho lugar encima de la tabla*/
		"sAjaxSource": '/entrenamos/eventos/country/all',
		"aoColumns": [
			{ "sWidth": "5%" },
			{ "sWidth": "75%" },
			{ "sClass": "right", "sWidth": "20%" }
		],
		"aaSorting": [],
		"bPaginate": false,
		"oLanguage": {
			"sProcessing":   "Procesando...",
			"sLengthMenu":   "Mostrar _MENU_ registros",
			"sZeroRecords":  "<div class=\"alert alert-error\"><strong>Uhgh!</strong> No se encontraron cursos que cumplan con ese criterio...</div>",
			"sInfo":         "<div class=\"alert alert-info\">Mostrando desde _START_ hasta _END_ de _TOTAL_ registros</div>",
			"sInfoEmpty":    "",
			"sInfoFiltered": "<div class=\"alert alert-info\">(filtrado de _MAX_ registros en total)</div>",
			"sInfoPostFix":  "",
			"sSearch":       "Buscar:",
			"sUrl":          "",
			"oPaginate": {
				"sFirst":    "Primero",
				"sPrevious": "Anterior",
				"sNext":     "Siguiente",
				"sLast":     "Último"
			}
		}
	});

	// Cuelgo los handlers de los clicks
	$("ul#course-country-filter > li > a").on("click", function(event) {
		event.preventDefault();

		var newSource = $(this).attr("href");
		oTable.fnReloadAjax(newSource);

		var containerUl = $(this).parent().parent();
		containerUl.children("li").removeClass("active");

		var clickedLi = $(this).parent();
		clickedLi.addClass("active");
	});
});

$.fn.dataTableExt.oApi.fnReloadAjax = function ( oSettings, sNewSource, fnCallback, bStandingRedraw )
{
    if ( typeof sNewSource != 'undefined' && sNewSource != null ) {
        oSettings.sAjaxSource = sNewSource;
    }
 
    // Server-side processing should just call fnDraw
    if ( oSettings.oFeatures.bServerSide ) {
        this.fnDraw();
        return;
    }
 
    this.oApi._fnProcessingDisplay( oSettings, true );
    var that = this;
    var iStart = oSettings._iDisplayStart;
    var aData = [];
  
    this.oApi._fnServerParams( oSettings, aData );
      
    oSettings.fnServerData.call( oSettings.oInstance, oSettings.sAjaxSource, aData, function(json) {
        /* Clear the old information from the table */
        that.oApi._fnClearTable( oSettings );
          
        /* Got the data - add it to the table */
        var aData =  (oSettings.sAjaxDataProp !== "") ?
            that.oApi._fnGetObjectDataFn( oSettings.sAjaxDataProp )( json ) : json;
          
        for ( var i=0 ; i<aData.length ; i++ )
        {
            that.oApi._fnAddData( oSettings, aData[i] );
        }
          
        oSettings.aiDisplay = oSettings.aiDisplayMaster.slice();
          
        if ( typeof bStandingRedraw != 'undefined' && bStandingRedraw === true ) {
            oSettings._iDisplayStart = iStart;
            that.fnDraw( false );
        }
        else {
            that.fnDraw();
        }
          
        that.oApi._fnProcessingDisplay( oSettings, false );
          
        /* Callback user function - for event handlers etc */
        if ( typeof fnCallback == 'function' && fnCallback != null ) {
            fnCallback( oSettings );
        }
    }, oSettings );
};
