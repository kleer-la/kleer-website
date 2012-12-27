var anOpen = [];
var sImageUrl = "http://qa.kleer.la/wp-content/uploads/2011/03/";
//sImageUrl = "./DataTables-1.9.1/media/images/";

var oTable;
$(document).ready(function() {
    oTable = $('#cursos').dataTable( {
	         "aaData": aCursos,
			 "bLengthChange": false,
			  "aoColumns": [
				  { "sTitle": "Comienzo", "sWidth": "6%" },
				  { "sTitle": "Descripcion", "sWidth": "82%" },
				  { "sTitle": "Registro", "sClass": "right", "sWidth": "12%" }
			  ],
			"aaSorting": [],
			"bPaginate": false,
			"oLanguage": 	{
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
} );
