var anOpen = [];
var sImageUrl = "http://qa.kleer.la/wp-content/uploads/2011/03/";
//sImageUrl = "./DataTables-1.9.1/media/images/";

var oTable;
$(document).ready(function() {
    oTable = $('#cursos').dataTable( {
	         "aaData": aCursos,
			 "bLengthChange": false,
			  "aoColumns": [
				  { "sWidth": "5%" },
				  { "sWidth": "70%" },
				  { "sClass": "right", "sWidth": "25%" }
			  ],
			"aaSorting": [],
			"bPaginate": false,
			"bFilter": false,
			"sScrollY": "220px",
			"oLanguage": 	{
				"sProcessing":   "Procesando...",
				"sLengthMenu":   "Mostrar _MENU_ registros",
				"sZeroRecords":  "<div class=\"alert alert-error\"><strong>Uhgh!</strong> No se encontraron cursos que cumplan con ese criterio...</div>",
				"sInfo":         "",
				"sInfoEmpty":    "",
				"sInfoFiltered": "",
				"sInfoPostFix":  "",
				"sUrl":          "",
				"oPaginate": {
					"sFirst":    "Primero",
					"sPrevious": "Anterior",
					"sNext":     "Siguiente",
					"sLast":     "Último"
				}
			}
	});
} );
