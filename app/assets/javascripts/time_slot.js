$(document).on('turbolinks:load', function() {
    Turbolinks.clearCache();
    $("#datatable_horario").dataTable({
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

$(document).on('turbolinks:load', function() {
    var today = new Date();
    $('#time_slot_time_slot_date').click(function () {
        $(".drp-calendar.left").remove();
    });
    $('input[id="time_slot_time_slot_date"]').daterangepicker({
        startDate: new Date(),
        minDate: new Date(),
        maxDate: new Date(today.getFullYear(), today.getMonth()+1, 0),
        showWeekNumbers: false,
        isInvalidDate: function(date) {
            return (date.day() == 0 || date.day() == 6);
        },
        locale: {
            firstDay:1,
            format: 'DD/MM/YYYY',
            "separator": " - ",
            "applyLabel": "Aplicar",
            "cancelLabel": "Cancelar",
            "fromLabel": "DE",
            "toLabel": "HASTA",
            "customRangeLabel": "Custom",
            "daysOfWeek": [
                "Dom",
                "Lun",
                "Mar",
                "Mie",
                "Jue",
                "Vie",
                "Sáb"
            ],
            "monthNames": [
                "Enero",
                "Febrero",
                "Marzo",
                "Abril",
                "Mayo",
                "Junio",
                "Julio",
                "Agosto",
                "Septiembre",
                "Octubre",
                "Noviembre",
                "Diciembre"
            ],
        }
    });

    $("#time_slot_start_time").change(function () {
        var start_time = $(this).children(":selected").attr("value");
        clearTarget();
        var horas = ["09:00", "10:00", "11:00", "12:00", "13:00", "14:00", "15:00", "16:00", "17:00", "18:00", "19:00"];
        for (var i = 0; i < horas.length; i++) {
            if (start_time < horas[i]) {
                // console.log(horas[i]);
                $('#time_slot_end_time').append("<option value=" + horas[i] + ">" + horas[i]+ " horas"+  "</option>");

            }
        }
        function clearTarget() {
            return this.$("#time_slot_end_time").html('<option>--:--</option>');
        }
        $("#time_slot_end_time").change(function () {
            var end_time = $(this).children(":selected").attr("value");
            clearTarget();
            horas.forEach(function (data) {
                if(start_time < data && end_time > data){
                    console.log(data);
                    $('#time_slot_lunch_hour').append("<option value=" + data + ">" + data + " horas"+ "</option>");
                }
            });
            function clearTarget() {
                return this.$("#time_slot_lunch_hour").html('<option>--:--</option>');
            }
        });
    });


});



