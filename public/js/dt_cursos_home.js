var anOpen = [];
var sImageUrl = "http://qa.kleer.la/wp-content/uploads/2011/03/";
//sImageUrl = "./DataTables-1.9.1/media/images/";

var oTable;
$(document).ready(function() {
	oTable = $('#cursos').dataTable( {
		"bLengthChange": false,
		"sAjaxSource": '/entrenamos/eventos/proximos',
		"aoColumns": [
			{ "sWidth": "5%" },
			{ "sWidth": "75%" },
			{ "sClass": "right", "sWidth": "20%" }
		],
		"aaSorting": [],
		"bSort": false,
		"bPaginate": false,
		"bFilter": false,
		"sScrollY": "220px",
		"oLanguage": {
			"sLengthMenu":   "Mostrar _MENU_ registros",
			"sZeroRecords":  "<div class=\"alert alert-warning center\">Cargando...</div>",
			"sInfo":         "",
			"sInfoEmpty":    "",
			"sInfoFiltered": "",
			"sInfoPostFix":  "",
			"sUrl":          ""
		},
		"fnInitComplete": function(oSettings, json) {
			oSettings.oLanguage.sZeroRecords = "<div class=\"alert alert-warning\">No tenemos cursos en los próximos dos meses pero nos gustaría que nos contactes a <a href=\"mailto:hola@kleer.la\">hola@kleer.la</a> con tu inquietud.</div>";
		}
	});
});
