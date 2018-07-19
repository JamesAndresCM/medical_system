$(document).on('turbolinks:load', function() {

    function parse_slot(slot_date){
        var slot_date = slot_date.split("/");
        var parse_date_slot = slot_date[2] + "-" + slot_date[1] + "-" + slot_date[0];
        return parse_date_slot
    }

    function clearTarget(class_selector,message) {
        return this.$(class_selector).html('<option>'+message+'</option>');
    }

    function dataRangePicker(identificador){
        var today = new Date();

        var data_table_element = $('input[id='+identificador+']').daterangepicker({
            startDate: new Date(),
            minDate: new Date(),
            maxDate: new Date(today.getFullYear(), today.getMonth()+1, 0),
            showWeekNumbers: false,
            singleDatePicker: true,
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
        return data_table_element;
    }

    function getHoras(){
        var date_slot = $("#appointment_appointment_date").val();
        var id_doctor = parseInt($("#appointment_doctor_id").val());

        console.log(date_slot + " " + id_doctor);
        var parse_date_slot = parse_slot(date_slot);
        // 2018-07-09 09/07/2018
        clearTarget("#appointment_time_slot_id","Seleccione horario");
        if (!isNaN(id_doctor)) {
            $.ajax({
                type: "GET",
                url: "/appointments/availability_slot/" + id_doctor + "/" + parse_date_slot,
                contentType: 'application/json',
                dataType: "json",

                success: function (data) {
                    for (var i = 0; i < data.length; i++) {
                        var start_time = (new Date(data[i].start_time).toString().split(" ")[4]).slice(0, -3);
                        var end_time = (new Date(data[i].end_time).toString().split(" ")[4]).slice(0, -3);

                        if (data.length > 0) {
                            $('#appointment_time_slot_id').append("<option value=" + data[i].id + ">" + start_time + " " + end_time + "</option>");
                        }
                    }
                },

            });
        }
    }

    dataRangePicker("appointment_appointment_date");

    $("#appointment_appointment_date").prop('disabled', true);
    $("#send_appointment").prop('disabled', true);

       $("#appointment_appointment_date").change(function () {
            getHoras();
        });

        // disable input calendar
    $('#appointment_doctor_id').change(function(){
        if($(this).val().length !=0){
            $("#appointment_appointment_date").attr('disabled', false);
            getHoras();
        }
        else
        {
            $("#appointment_appointment_date").prop('disabled', true);

        }
    });

    $('#appointment_user_id').change(function(){
        if($(this).val() != "Seleccione horario"){
            $("#appointment_appointment_date").attr('disabled', false);
            getHoras();
        }
        else
        {
            $("#appointment_appointment_date").prop('disabled', true);

        }
    });

     // disable/enable btn
    $('#appointment_time_slot_id').change(function(){
        if ($(this).val() != "Seleccione horario"){
            $("#send_appointment").attr('disabled', false);
        }
        else
        {
            $("#send_appointment").prop('disabled', true);

        }
    });

    $("#appointment_specialty_id").change(function () {
        var doctor_id = parseInt($(this).children(":selected").attr("value"));
        clearTarget("#appointment_doctor_id","Seleccione Médico");

        if (!isNaN(doctor_id)) {
            $.ajax({
                type: "GET",
                url: "/appointments/doctor_specialty/" + doctor_id,
                contentType: 'application/json',
                dataType: "json",

                success: function (data) {
                    for (var i = 0; i < data.length; i++) {
                        //console.log(data);
                        if (data.length > 0) {
                            $('#appointment_doctor_id').append("<option value=" + data[i].id + ">" + data[i].username + " " + data[i].last_name + " " + data[i].last_name_mother +  "</option>");
                        }
                    }
                },

            });
        }
    });


    Turbolinks.clearCache();
    $("#datatable_citas").dataTable({
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


    dataRangePicker("appointment_date");

    $("#date_month").change(function () {
        var date_slot = $("#date_month").val();
        var current_year = new Date().getFullYear();
        var date_parse = (current_year+"-"+date_slot);


        if (date_parse.length > 0) {
            $.ajax({
                type: "GET",
                url: "/appointments/get_date_range/" + date_parse,
                contentType: 'application/json',
                dataType: "json",

                success: function (data) {
                    var json = JSON.parse(JSON.stringify(data));
                    if (json.length === 0){
                        $("#datatable_citas").DataTable().clear().draw();
                    }else {
                        $("#datatable_citas").DataTable().clear().draw();
                        for (var i = 0; i < json.length; i++) {
                            console.log(json[i].appointment_date);
                            var fecha = (json[i].appointment_date);
                            var start_time = (new Date(json[i].start_time).toString().split(" ")[4]).slice(0, -3);
                            var end_time = (new Date(json[i].end_time).toString().split(" ")[4]).slice(0, -3);
                            var doctor_name = (json[i].username);
                            var doctor_apellido_paterno = (json[i].last_name);
                            var doctor_apellido_materno = (json[i].last_name_mother);
                            var doctor_telefono = (json[i].phone_number);
                            var doctor_especialidad = (json[i].name);
                            var doctor_rut = (json[i].rut);

                            var tr = [];
                            tr.push(doctor_rut);
                            tr.push(doctor_name);
                            tr.push(doctor_apellido_paterno);
                            tr.push(doctor_apellido_materno);
                            tr.push(doctor_telefono);
                            tr.push(doctor_especialidad);
                            tr.push(fecha);
                            tr.push(start_time + "-" + end_time );
                            $("#datatable_citas").DataTable().row.add(tr).draw();

                        }
                    }
                },

            });
        }
    });

    dataRangePicker("appointment_date_doctor");

    $("#appointment_date_doctor").change(function () {
        var date_slot = $("#appointment_date_doctor").val();
        var date_parse = parse_slot(date_slot);

        if (date_parse.length > 0) {
            $.ajax({
                type: "GET",
                url: "/appointments/get_date_range/" + date_parse,
                contentType: 'application/json',
                dataType: "json",

                success: function (data) {
                    var json = JSON.parse(JSON.stringify(data));

                    if (json.length === 0){
                        $("#datatable_citas").DataTable().clear().draw();
                    }else {
                        $("#datatable_citas").DataTable().clear().draw();
                        for (var i = 0; i < json.length; i++) {

                            // pregunto si viene incluido id de medical_card, true ? muestro botones : opcion de crear ficha medica
                            if (json[i].id) {
                                var medical_card_user = "<a style=\"color: gray\" href=\"/appointments/medical_card/"+json[i].id+"\"><i style=\"margin: 5px\" class=\"fa fa-address-book\"></i></a>\n" +
                                    "<a data-remote=\"true\" href=\"/appointments/medical_card/"+json[i].id+"/edit\"><i style=\"margin: 5px\" class=\"fa fa-pencil-square-o\"></i></a>";

                            }else {
                                var medical_card_user = "<a class=\"btn btn-sm btn-secondary\" data-remote=\"true\" href=\"/appointments/medical_card/new?user_id="+json[i].user_id+"\">Crear Ficha Paciente</a>";
                            }

                            // asigno variables
                            var fecha = (json[i].appointment_date);
                            var start_time = (new Date(json[i].start_time).toString().split(" ")[4]).slice(0, -3);
                            var end_time = (new Date(json[i].end_time).toString().split(" ")[4]).slice(0, -3);
                            var user_name = (json[i].username);
                            var user_apellido_paterno = (json[i].last_name);
                            var user_apellido_materno = (json[i].last_name_mother);
                            var user_telefono = (json[i].phone_number);
                            var user_rut = (json[i].rut);


                            // agrego variables a array tr
                            var tr = [];
                            tr.push(user_rut);
                            tr.push(user_name);
                            tr.push(user_apellido_paterno);
                            tr.push(user_apellido_materno);
                            tr.push(user_telefono);
                            tr.push(fecha);
                            tr.push(start_time + "-" + end_time);
                            tr.push(medical_card_user);

                            // dibujo tabla con datos filtrados
                            $("#datatable_citas").DataTable().row.add(tr).draw();

                            // centro columna 7 "Ficha Medica"
                            $("#datatable_citas > tbody > tr").each(function() {
                                $( this ).find( "td:eq(7)" ).css( "text-align", "center" );
                            });
                        }
                    }

                },

            });
        }
    });

});










