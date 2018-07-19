$(document).on('turbolinks:load', function() {
    Turbolinks.clearCache();
    $("#datatable_description").dataTable({
        "lengthMenu": [[5,10, 25, 50, -1], [5, 10, 25, 50, "All"]],
        "iDisplayLength": 5,
        "aaSorting": [],
        "language": {
            "search": "Buscar _INPUT_ ",
            "lengthMenu": "Mostrando _MENU_ resultados por página",
            "zeroRecords": "No se encontraron resultados",
            "info": "Mostrando página _PAGE_ de _PAGES_",
            "infoEmpty": "Sin resultados",
            "infoFiltered": "(filtrado de un total de _MAX_ registros)",
            "paginate": {
                "previous": "<i class=\"fa fa-backward\"></i>",
                "next": "<i class=\"fa fa-forward\"></i>",
                "first": "<i class=\"fa fa-step-backward\"></i>",
                "last": "<i class=\"fa fa-step-forward\"></i>"
            }
        }
    });
});