jQuery.fn.correo = function(){
    if(/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/.test($(this).val())){
        return true;
    } else {
        $(this).focus();
        return false;
    }
}

// function loadListadoAutoresFunctions(){
    // $('#resultado_busqueda a').click(function(){
        // var valor = $(this).attr('id');
           // console.log(valor);
        // $.ajax({
           // url: 'ajax_crud/publicaciones_autor.php',
           // type: 'POST',
           // data: 'valor=' + valor,
           // beforeSend: function(){
                // showLoading();
           // },
           // complete: function(){
                // hideLoading();
           // },
           // success: function(r){
                // $('#result').html("").append(r);
                // $('#titulo').text("");
                // loadAutoresFunctions();
                // loadDatosPersonales();
           // },
           // error: function(err){
               // alert("Error:" + err.responseText);
           // }
        // });
        // return false;
    // });

// }

// function loadAutoresFunctions(){

    // loadDatosPersonales();
    // loadDatosPublicaciones();

    // $('.autor').unbind("click");
    // $('.autor').click(function(){
            // var valor = $(this).attr('id');
            // $.ajax({
               // url: 'ajax_crud/publicaciones_autor.php',
               // type: 'POST',
               // data: 'valor=' + valor,
               // beforeSend: function(){
                    // showLoading();
               // },
               // complete: function(){
                    // hideLoading();
               // },
               // success: function(r){
                    // $('#result').html("").append(r);
                    // $('#titulo').text("");
                    // loadAutoresFunctions();
               // }
            // });
            // return false;
    // });

    // $('.publicacion').unbind("click");
    // $('.publicacion').click(function(){
            // var valor = $(this).attr('id');
            // $.ajax({
               // url: 'ajax_crud/mostrar_publicacion.php',
               // type: 'POST',
               // data: 'valor=' + valor,
               // beforeSend: function(){
                    // showLoading();
               // },
               // complete: function(){
                    // hideLoading();
               // },
               // success: function(r){
                    // $('#result').html("").append(r);
                    // loadAutoresFunctions();
                    // $('#titulo').text('');
               // }
            // });
            // return false;
    // });

    // $('#buscar_text_next').keypress(function(event) {
        // if (event.which == '13') {

            // var busqueda = $('#buscar_text_next').val();

            // if(!busqueda){
                // alert('Debe introducior algun patron de busqueda');
                // return false;
            // }

            // var html;

            // if($('#buscar_text_next').hasClass("publicacion_next")){

                // html = '<INPUT type="text" name="buscar_text" id="buscar_text" value="' + busqueda + '"/>\n\
                            // <button id="buscar_button" value="Buscar">\n\
                                // <img class="img_button" src="img/search.png" alt="img_search" />\n\
                                // Buscar\n\
                            // </button>\n\
                            // <button id="borrar_button" value="Borrar">\n\
                                // <img class="img_button" src="img/delete.png" alt="img_search" />\n\
                                // Borrar\n\
                            // </button>\n\
                            // <h2>\n\
                                // <span id="titulo_resultado">Resultado de: ' + busqueda + '</span>\n\
                            // </h2>\n\
                            // <div id="resultado"></div>';

                // $("#titulo").html("Buscar Publicación");
                // $("#result").html(html);
                // loadBuscarFunctions(2,"Publicación");

                // loadInfo('ajax_crud/cargar_publicacion.php', 'busqueda=' + busqueda,1);

            // }else{

                // html = '<INPUT type="text" name="buscar_text" id="buscar_text" value="' + busqueda + '"/>\n\
                            // <button id="buscar_button" value="Buscar">\n\
                                // <img class="img_button" src="img/search.png" alt="img_search" />\n\
                                // Buscar\n\
                            // </button>\n\
                            // <button id="borrar_button" value="Borrar">\n\
                                // <img class="img_button" src="img/delete.png" alt="img_search" />\n\
                                // Borrar\n\
                            // </button>\n\
                            // <h2>\n\
                                // <span id="titulo_resultado">Resultado de: ' + busqueda + '</span>\n\
                            // </h2>\n\
                            // <div id="resultado"></div>';

                // $("#titulo").html("Buscar Autor");
                // $("#result").html(html);
                // loadBuscarFunctions(1,"Autor");

                // loadInfo('ajax_crud/cargar_autores.php', 'busqueda=' + busqueda,0);
            // }
        // }
    // });
// }

// function loadDatosPersonales(){
   // $('#datos_autor_img').unbind("click");
  // $('#datos_autor_img').live("click",function(){
   // $('#datos_autor_img').click(function(){
            // var valor = $(this).attr('class');
            // $.ajax({
               // url: 'ajax_crud/mostrar_autor.php',
               // type: 'POST',
               // data: 'valor=' + valor,
               // beforeSend: function(){
                    // showLoading();
               // },
               // complete: function(){
                    // hideLoading();
               // },
               // success: function(r){
                    // $('#result').html("").append(r);
                    // var nombre = $('#result').find('#nombre').html();
                    // $('#titulo').text('Datos del Autor: ' + nombre);

                    // $('#button_volver').unbind("click");
                    // $("#button_volver").click(function(){
                        // var id = $("#id_autor").val();
                        // $.ajax({
                               // url: 'ajax_crud/publicaciones_autor.php',
                               // type: 'POST',
                               // data: 'valor=' + id,
                               // beforeSend: function(){
                                    // showLoading();
                               // },
                               // complete: function(){
                                    // hideLoading();
                               // },
                               // success: function(r){
                                    // $('#result').html("").append(r);
                                    // $('#titulo').text("");
                                    // loadAutoresFunctions();
                                    // loadDatosPersonales();
                               // },
                               // error: function(err){
                                   // alert("Error:" + err.responseText);
                               // }
                        // });
                    // });
               // }
            // });
            // return false;

    // });

    // $('#editar_autor_img').unbind("click");
   // $('#editar_autor_img').live("click",function(){
    // $('#editar_autor_img').click(function(){
        // var valor = $(this).attr('class');
        // $.ajax({
           // url: 'ajax_crud/editar_autor.php',
           // type: 'POST',
           // data: 'valor=' + valor,
           // beforeSend: function(){
                // showLoading();
           // },
           // complete: function(){
                // hideLoading();
           // },
           // success: function(r){
                // $('#result').html("").append(r);
                // $( "#datepicker" ).datepicker({
                    // changeMonth: true,
                    // changeYear: true,
                    // dateFormat: 'yy-mm-dd',
                    // minDate: new Date(1900, 1 - 1, 1)
                // });
                // loadEditarAutorFunctions();
                // var nombre = $('#result').find('#nombre').val();
                // $('#titulo').text('Editar Datos del Autor: ' + nombre);
           // }
        // });
        // return false;
    // });

// }

//CARGAR CENTRO
// function loadCargarCentroFunctions(){
    // $('#resultado_busqueda a').click(function(){
            // var valor = $(this).attr('id');
            // var tipo  = 1;
            // $.ajax({
               // url: 'ajax_crud/datos_centro_estudios_sql.php',
               // type: 'POST',
               // data: 'valor=' + valor +
                     // '&tipo='+ tipo,
               // beforeSend: function(){
                    // showLoading();
               // },
               // complete: function(){
                    // hideLoading();
               // },
               // success: function(r){
                    // $('#result').html("").append(r);
                    // $('#titulo').text("");
                    // loadEditarCentroFunctions()
               // }
            // });
            // return false;
    // });    
// }

//CARGAR GRUPO DE INVESTIGACION
// function loadCargarGrupoFunctions(){
    // $('#resultado_busqueda a').click(function(){
            // var valor = $(this).attr('id');
            // var tipo=1;
            // $.ajax({
               // url: 'ajax_crud/datos_grupo_investigacion_sql.php',
               // type: 'POST',
               // data: 'valor=' + valor +
                     // '&tipo='+ tipo,
               // beforeSend: function(){
                    // showLoading();
               // },
               // complete: function(){
                    // hideLoading();
               // },
               // success: function(r){
                    // $('#result').html("").append(r);
                    // $('#titulo').text("");
                    // loadEditarGrupoFunctions();
               // }
            // });
            // return false;
    // });
    
// }

//UPDATE PARA EDITAR CENTRO
// function loadEditarCentroFunctions(){
   
    // $('#editar_centro_img').unbind('click');
    // $('#editar_centro_img').click(function(){
            // var valor = $(this).attr('class');
            // $.ajax({
               // url: 'ajax_crud/editar_centro.php',
               // type: 'POST',
               // data: 'valor=' + valor,
               // beforeSend: function(){
                    // showLoading();
               // },
               // complete: function(){
                    // hideLoading();
               // },
               // success: function(r){
                    // $('#result').html("").append(r);
                    // loadEditarCentroFunctions();
                    // var nombre = $('#result').find('#nombre_centro').val();
                    // $('#titulo').text('Editar Centro de Estudios: ' + nombre);
               // }
            // });
            // return false;
    // });

    // $('#editar_centro').unbind('click');
    // $('#editar_centro').click(function(){
            // var id      = $("#id_centro").val();
            // var nombre  = $("#nombre_centro").val();

            // if(nombre == ""){
                // alert("El nombre del centro no puede estar vacio");
                // return false;
            // }

            // var pais    = $("#nombre_pais").val();
            // var ciudad  = $("#ciudad_input").val();
            // var pagina  = $("#pagina_input").val();
            // var tipo    = 2;
            // var sw      = 0;

            // if(pais == "" || ciudad == ""  || pagina == ""){
                // sw = 1;
            // }

            // if(sw){
                // if(!confirm("Ha dejado campos vacios, ¿Desea Continuar?"))
                    // return false;
            // }

            // if(pais == "")
                // pais = "NULL";

            // if(ciudad == "")
                // ciudad = "NULL";

            // if(pagina == "")
                // pagina = "NULL";          

            // $.ajax({
               // url: 'ajax_crud/datos_centro_estudios_sql.php',
               // type: 'POST',
               // data: 'id=' + id +
                     // '&nombre_centro='+ nombre +
                     // '&pais='+ pais +
                     // '&ciudad='+ ciudad +
                     // '&pagina='+ pagina +
                     // '&tipo='+ tipo,
               // beforeSend: function(){
                    // showLoading();
               // },
               // complete: function(){
                    // hideLoading();
               // },
               // success: function(r){
                    // alert('Editado con Exito');

                    // $.ajax({
                       // url: 'ajax_crud/datos_centro_estudios_sql.php',
                       // type: 'POST',
                       // data: 'valor=' + id +
                             // '&tipo='+ 1,
                       // beforeSend: function(){
                            // showLoading();
                       // },
                       // complete: function(){
                            // hideLoading();
                       // },
                       // success: function(r){
                            // $('#result').html("").append(r);
                            // $('#titulo').text("");
                            // loadEditarCentroFunctions()
                       // }
                    // });
               // }
            // });
            // return false;
    // });

    // $("#button_cancelar").click(function(){

        // var id = $("#id_centro").val();
        // $.ajax({
           // url: 'ajax_crud/datos_centro_estudios_sql.php',
           // type: 'POST',
           // data: 'valor=' + id +
                 // '&tipo='+ 1,
           // beforeSend: function(){
                // showLoading();
           // },
           // complete: function(){
                // hideLoading();
           // },
           // success: function(r){
                // $('#result').html("").append(r);
                // $('#titulo').text("");
                // loadEditarCentroFunctions()
           // }
        // });

    // });

    // $('#buscar_text_next').keypress(function(event) {
        // if (event.which == '13') {

            // var busqueda = $('#buscar_text_next').val();

            // if(!busqueda){
                // alert('Debe introducior algun patron de busqueda');
                // return false;
            // }

            // var html = '<INPUT type="text" name="buscar_text" id="buscar_text" value="' + busqueda + '"/>\n\
                            // <button id="buscar_button" value="Buscar">\n\
                                // <img class="img_button" src="img/search.png" alt="img_search" />\n\
                                // Buscar\n\
                            // </button>\n\
                            // <button id="borrar_button" value="Borrar">\n\
                                // <img class="img_button" src="img/delete.png" alt="img_search" />\n\
                                // Borrar\n\
                            // </button>\n\
                            // <h2>\n\
                                // <span id="titulo_resultado">Resultado de: ' + busqueda + '</span>\n\
                            // </h2>\n\
                            // <div id="resultado"></div>';

            // $("#titulo").html("Buscar Centro de Estudios");
            // $("#result").html(html);
            // loadBuscarFunctions(3,"Centro de Estudios");
            // loadInfo('ajax_crud/cargar_centro.php', 'busqueda=' + busqueda,2);
        // }
    // });

// }

//UPDATE PARA EDITAR GRUPO DE INVESTIGACION
// function loadEditarGrupoFunctions(){

    // $('#editar_grupo_img').unbind('click');
    // $('#editar_grupo_img').click(function(){
            // var valor = $(this).attr('class');
            // $.ajax({
               // url: 'ajax_crud/editar_grupo.php',
               // type: 'POST',
               // data: 'valor=' + valor,
               // beforeSend: function(){
                    // showLoading();
               // },
               // complete: function(){
                    // hideLoading();
               // },
               // success: function(r){
                    // $('#result').html("").append(r);
                    // loadEditarGrupoFunctions();
                    // var nombre = $('#result').find('#nombre_grupo').val();
                    // $('#titulo').text('Editar Grupo de Investigación: ' + nombre);
               // }
            // });
            // return false;
    // });

    // $('#editar_grupo').unbind('click');
    // $('#editar_grupo').click(function(){
            // var id              = $("#id_grupo").val();
            // var id_centro       = $("#centro_estudios").val();
            // var nombre_grupo    = $("#nombre_grupo").val();

            // if(nombre_grupo == ""){
                // alert("El nombre del grupo no puede estar vacio");
                // return false;
            // }

            // var tema            = $("#tema").val();
            // var direccion_grupo = $("#direccion_input").val();
            // var correo_grupo    = $("#correo_input").val();
            // var fecha_creacion  = $("#fecha_input").val();
            // var pagina_centro   = $("#pagina_input").val();
            // var tipo            = 2;
            // var sw              = 0;

            // if(tema == "" || direccion_grupo == ""  || correo_grupo == "" ||
               // fecha_creacion == "" || pagina_centro == ""){
                // sw = 1;
            // }

            // if(sw){
                // if(!confirm("Ha dejado campos vacios, ¿Desea Continuar?"))
                    // return false;
            // }

            // if(tema == "")
                // tema = "NULL";

            // if(direccion_grupo == "")
                // direccion_grupo = "NULL";

            // if(correo_grupo != ""){
                // if(!$("#correo_input").correo()) {
                    // alert("Correo Electronico Invalido");
                    // return false;
                // }
            // }else{
                // correo_grupo = "NULL";
            // }

            // if(fecha_creacion == "")
                // fecha_creacion = "NULL";

            // if(pagina_centro == "")
                // pagina_centro = "NULL";

            // $.ajax({
               // url: 'ajax_crud/datos_grupo_investigacion_sql.php',
               // type: 'POST',
               // data: 'id=' + id +
                     // '&id_centro=' + id_centro +
                     // '&nombre_grupo='+ nombre_grupo +
                     // '&tema='+ tema +
                     // '&direccion_grupo='+ direccion_grupo +
                     // '&correo_grupo='+ correo_grupo +
                     // '&fecha_creacion='+ fecha_creacion +
                     // '&pagina_centro='+ pagina_centro +
                     // '&tipo='+ tipo,
               // beforeSend: function(){
                    // showLoading();
               // },
               // complete: function(){
                    // hideLoading();
               // },
               // success: function(r){
                    // alert('Editado con Exito');
                    // $.ajax({
                       // url: 'ajax_crud/datos_grupo_investigacion_sql.php',
                       // type: 'POST',
                       // data: 'valor=' + id +
                             // '&tipo='+ 1,
                       // beforeSend: function(){
                            // showLoading();
                       // },
                       // complete: function(){
                            // hideLoading();
                       // },
                       // success: function(r){
                            // $('#result').html("").append(r);
                            // $('#titulo').text("");
                            // loadEditarGrupoFunctions()
                       // }
                    // });
               // }
            // });
            // return false;
    // });

    // $("#button_cancelar").click(function(){
        // var id = $("#id_grupo").val();
        // $.ajax({
           // url: 'ajax_crud/datos_grupo_investigacion_sql.php',
           // type: 'POST',
           // data: 'valor=' + id +
                 // '&tipo='+ 1,
           // beforeSend: function(){
                // showLoading();
           // },
           // complete: function(){
                // hideLoading();
           // },
           // success: function(r){
                // $('#result').html("").append(r);
                // $('#titulo').text("");
                // loadEditarGrupoFunctions()
           // }
        // });
    // });

    // $('#buscar_text_next').keypress(function(event) {
        // if (event.which == '13') {

            // var busqueda = $('#buscar_text_next').val();

            // if(!busqueda){
                // alert('Debe introducior algun patron de busqueda');
                // return false;
            // }

            // var html = '<INPUT type="text" name="buscar_text" id="buscar_text" value="' + busqueda + '"/>\n\
                            // <button id="buscar_button" value="Buscar">\n\
                                // <img class="img_button" src="img/search.png" alt="img_search" />\n\
                                // Buscar\n\
                            // </button>\n\
                            // <button id="borrar_button" value="Borrar">\n\
                                // <img class="img_button" src="img/delete.png" alt="img_search" />\n\
                                // Borrar\n\
                            // </button>\n\
                            // <h2>\n\
                                // <span id="titulo_resultado">Resultado de: ' + busqueda + '</span>\n\
                            // </h2>\n\
                            // <div id="resultado"></div>';

            // $("#titulo").html("Buscar Grupo de Investigación");
            // $("#result").html(html);
            // loadBuscarFunctions(4,"Grupo de Investigación");
            // loadInfo('ajax_crud/cargar_grupo.php', 'busqueda=' + busqueda,3);
        // }
    // });
// }

//UPDATE PARA EDITAR AUTOR
// function loadEditarAutorFunctions(){

    // $('#button_autor').click(function(){
        
            // var id           = $("#id_autor").val();
            // var nombre_autor = $("#nombre").val();

            // if(nombre_autor == ""){
                // alert("El nombre del autor no puede estar vacio");
                // return false;
            // }

            // var nacionalidad = $("#nacionalidad_input").val();
            // var fecha_nac    = $("#datepicker").val();
            // var grupo        = $("#grupo_input").val();
            // var formacion    = $("#formacion_input").val();
            // var direccion    = $("#direccion_input").val();
            // var email        = $("#email_input").val();
            // var pagina       = $("#paginaweb_input").val();
            // var sexo         = $("#sexo_input").val();
            // var sw = 0;

            // if(nacionalidad == "seleccionar_pais" || fecha_nac == ""
               // || grupo == "seleccionar_grupo" || formacion == "" || direccion == ""
               // || email == "" || pagina == "" || sexo == "seleccionar_sexo"){

                    // sw = 1;

               // }

            // if(sw){
                // if(!confirm("Ha dejado campos vacios, ¿Desea Continuar?"))
                    // return false;
            // }

            // if(email != "")
                // if(!$("#email_input").correo()) {
                    // alert("Correo Electronico Invalido");
                    // return false;
                // }

            // if(nacionalidad == "seleccionar_pais")
                // nacionalidad = "NULL";

            // if(fecha_nac == "")
                // fecha_nac = "NULL";

            // if(grupo == "seleccionar_grupo")
                // grupo = "NULL";

            // if(formacion == "")
                // formacion = "NULL";

            // if(direccion == "")
                // direccion = "NULL";

            // if(email == "")
                // email = "NULL";

            // if(pagina == "")
                // pagina = "NULL";

            // if(sexo == "seleccionar_sexo")
                // sexo = "NULL";

            // $.ajax({
               // url: 'ajax_crud/editar_autores_ajax.php',
               // type: 'POST',
               // data: 'id=' + id +
                     // '&nombre_autor='+ nombre_autor +
                     // '&nacionalidad='+ nacionalidad +
                     // '&fecha_nac='+ fecha_nac +
                     // '&grupo='+ grupo +
                     // '&formacion='+ formacion +
                     // '&direccion='+ direccion +
                     // '&email='+ email +
                     // '&pagina='+ pagina +
                     // '&sexo='+ sexo,
               // beforeSend: function(){
                    // showLoading();
               // },
               // complete: function(){
                    // hideLoading();
               // },
               // success: function(r){
                   // if(r >= 1){
						// if(r != 1)
							// id = eval(r);
                        // alert('Los Dator del Autor fueron Guardados correctamente');
                        // $.ajax({
                               // url: 'ajax_crud/publicaciones_autor.php',
                               // type: 'POST',
                               // data: 'valor=' + id,
                               // beforeSend: function(){
                                    // showLoading();
                               // },
                               // complete: function(){
                                    // hideLoading();
                               // },
                               // success: function(r){
                                    // $('#result').html("").append(r);
                                    // $('#titulo').text("");
                                    // loadAutoresFunctions();
                                    // loadDatosPersonales();
                               // },
                               // error: function(err){
                                   // alert("Error:" + err.responseText);
                               // }
                        // });
                   // }else{
                        // alert('Ocurrio un Error al intentar actualizar los datos del Autor');
                   // }
               // }
            // });
            // return false;
        
    // });

    // $("#button_cancelar").click(function(){

        // var id = $("#id_autor").val();
        // $.ajax({
               // url: 'ajax_crud/publicaciones_autor.php',
               // type: 'POST',
               // data: 'valor=' + id,
               // beforeSend: function(){
                    // showLoading();
               // },
               // complete: function(){
                    // hideLoading();
               // },
               // success: function(r){
                    // $('#result').html("").append(r);
                    // $('#titulo').text("");
                    // loadAutoresFunctions();
                    // loadDatosPersonales();
               // },
               // error: function(err){
                   // alert("Error:" + err.responseText);
               // }
        // });

    // });


// }

//UPDATE PARA EDITAR PUBLICACION
// function loadEditarPublicacionFunctions(){

    // $('#editar_public').click(function(){

            // var id      = $("#id_pub").val();
            // var titulo  = $("#titulo_pub").val();

            // if(titulo == ""){
                // alert("El titulo de la publicacion no puede estar vacio");
                // return false;
            // }

            // var anno_pub  = $("#input_anno").val();

            // if(anno_pub == ""){
                // alert("El año de la publicacion no puede estar vacio");
                // return false;
            // }

            // if(eval(anno_pub) < 1900){
                // alert("El año introducido es incorrecto");
                // return false;
            // }

            // var booktitle       = $("#input_booktitle").val();
            // var dblpkey         = $("#input_dblpkey").val();
			// var tipo_publi		= 0;
			
			// if($("#input_tipo_publi").length > 0){
				// tipo_publi      = $("#input_tipo_publi").val();
			// }else{
				// tipo_publi		= $(".option_tipo_publi:selected").attr("id");
			// }
			
            // var series          = $("#input_series").val();
            // var serieshref      = $("#input_serieshref").val();
            // var journal         = $("#input_journal").val();
            // var cdrom           = $("#input_cdrom").val();
            // var volumen         = $("#input_volumen").val();
            // var number          = $("#input_number").val();
            // var mes             = $("#input_mes").val();
            // var paginas         = $("#input_paginas").val();
            // var ee              = $("#input_ee").val();
            // var url             = $("#input_url").val();
            // var publisher       = $("#input_publisher").val();
            // var publisherhref   = $("#input_publisherhref").val();
            // var isbn            = $("#input_isbn").val();
            // var crossref        = $("#input_crossref").val();
            // var mdate           = $("#input_mdate").val();
            // var address         = $("#input_address").val();
            // var reviewid        = $("#input_reviewid").val();
            // var rating          = $("#input_rating").val();
            // var notas           = $("#notas").val();
            // var school          = $("#input_school").val();
            // var chapter         = $("#input_chapter").val();

            // var sw = 0;

            // if(booktitle == "" || dblpkey == "" || tipo_publi == "" || series == "" || serieshref == ""
               // || journal == "" || cdrom == "" || volumen == "" || number == "" || mes == ""
               // || paginas == "" || ee == "" || url == "" || publisher == "" || publisherhref == ""
               // || isbn == "" || crossref == "" || mdate == "" || address == "" || reviewid == ""
               // || rating == "" || notas == "" || school == "" || chapter == ""){

                    // sw = 1;

               // }

            // if(sw){
                // if(!confirm("Ha dejado campos vacios, ¿Desea Continuar?"))
                    // return false;
            // }

            // if(booktitle     == "") booktitle = "NULL";
            // if(dblpkey       == "") dblpkey = "NULL";
            // if(series        == "") series = "NULL";
            // if(serieshref    == "") serieshref = "NULL";
            // if(cdrom         == "") cdrom = "NULL";
            // if(volumen       == "") volumen = "NULL";
            // if(number        == "") number = "NULL";
            // if(mes           == "") mes = "NULL";
            // if(paginas       == "") paginas = "NULL";
            // if(ee            == "") ee = "NULL";
            // if(url           == "") url = "NULL";
            // if(publisher     == "") publisher = "NULL";
            // if(publisherhref == "") publisherhref = "NULL";
            // if(isbn          == "") isbn = "NULL";
            // if(mdate         == "") mdate = "NULL";
            // if(address       == "") address = "NULL";
            // if(reviewid      == "") reviewid = "NULL";
            // if(rating        == "") rating = "NULL";
            // if(notas         == "") notas = "NULL";
            // if(school        == "") school = "NULL";
            // if(chapter       == "") chapter = 0;

            // $.ajax({
               // url: 'ajax_crud/editar_publicacion_ajax.php',
               // type: 'POST',
               // data: 'id=' + id +
                     // '&titulo=' + titulo +
					 // '&tipo_publi=' + tipo_publi + 
                     // '&anno_pub=' + eval(anno_pub) +
                     // '&booktitle=' + booktitle +
                     // '&dblpkey=' + dblpkey +
                     // '&series=' + series +
                     // '&serieshref=' + serieshref +
                     // '&cdrom=' + cdrom +
                     // '&volumen=' + volumen +
                     // '&number=' + number +
                     // '&mes=' + mes +
                     // '&paginas=' + paginas +
                     // '&ee=' + ee +
                     // '&url=' + url +
                     // '&publisher=' + publisher +
                     // '&publisherhref=' + publisherhref +
                     // '&isbn=' + isbn +
                     // '&mdate=' + mdate +
                     // '&address=' + address +
                     // '&reviewid=' + reviewid +
                     // '&rating=' + rating +
                     // '&notas=' + notas +
                     // '&school=' + school +
                     // '&chapter=' + chapter,
               // beforeSend: function(){
                    // showLoading();
               // },
               // complete: function(){
                    // hideLoading();
               // },
               // success: function(r){
                   // if(r >= 1){
						// if(r != 1)
							// id = eval(r);
							
                        // alert('Los Dator de la Publicacion fueron Guardados correctamente');
                        // $.ajax({
                           // url: 'ajax_crud/mostrar_publicacion.php',
                           // type: 'POST',
                           // data: 'valor=' + id,
                           // beforeSend: function(){
                                // showLoading();
                           // },
                           // complete: function(){
                                // hideLoading();
                           // },
                           // success: function(r){
                                // $('#result').html("").append(r);
                                // loadAutoresFunctions();
                                // loadDatosPublicaciones();
                                // $('#titulo').text('');
                           // }
                        // });
                   // }else{
                        // alert('Ocurrio un Error al intentar actualizar los datos de la Publicacion');
                   // }
               // }
            // });
            // return false;

    // });

    // $("#button_cancelar").click(function(){
        // var id = $("#id_pub").val();
        // $.ajax({
               // url: 'ajax_crud/mostrar_publicacion.php',
               // type: 'POST',
               // data: 'valor=' + id,
               // beforeSend: function(){
                    // showLoading();
               // },
               // complete: function(){
                    // hideLoading();
               // },
               // success: function(r){
                    // $('#result').html("").append(r);
                    // loadAutoresFunctions();
                    // loadDatosPublicaciones();
                    // $('#titulo').text('');
               // }
            // });
    // });


// }

//PARA MANDAR A HACER EL INSERT
// function loadCentroEstudiosFunctions(){

      // $('#agregar_centro_estudio').click(function(){
            // var nombre=$("#nombre").val();
            // var pais=$("#nombre_pais").val();
            // var ciudad=$("#ciudad").val();
            // var pagina=$("#pagina").val();
            // var tipo=0;
            
            // $.ajax({
               // url: 'ajax_crud/datos_centro_estudios_sql.php',
               // type: 'POST',
               // data: '&nombre=' + nombre +
                     // '&pais='+ pais +
                     // '&ciudad='+ ciudad +
                     // '&pagina='+ pagina +
                     // '&tipo='+ tipo,
               // beforeSend: function(){
                    // showLoading();
               // },
               // complete: function(){
                    // hideLoading();
               // },
               // success: function(r){
                    // $('#result').html("").append(r);
                    // /*var nombre = $('#result').find('#nombre').html();
                    // $('#titulo').text('Datos de Autor: ' + nombre);

                    // alert('Agregado con exito');*/
               // }
            // });
            // return false;
    // });


// }

//PARA MANDAR A HACER EL INSERT en Grupo de Investigacion
// function loadGrupoInvestigacionFunctions(){

      // $('#agregar_grupo_investigacion').click(function(){
            // var nombre_centro=$("#nombre").val();
            // var id_centro=$("#centro_estudios").val();
            // var tema=$("#tema").val();
            // var direccion_grupo=$("#direccion").val();
            // var correo_grupo=$("#correo").val();
            // var fecha_creacion=$("#datepicker").val();
            // var pagina_centro=$("#pagina").val();
            // var tipo=0;
            
            // $.ajax({
               // url: 'ajax_crud/datos_grupo_investigacion_sql.php',
               // type: 'POST',
               // data: 'nombre_centro=' + nombre_centro +
                     // '&id_centro=' + id_centro +
                     // '&tema='+ tema +
                     // '&direccion_grupo='+ direccion_grupo +
                     // '&correo_grupo='+ correo_grupo +
                     // '&fecha_creacion='+ fecha_creacion +
                     // '&pagina_centro='+ pagina_centro +
                     // '&tipo='+ tipo,
               // beforeSend: function(){
                    // showLoading();
               // },
               // complete: function(){
                    // hideLoading();
               // },
               // success: function(r){
                    // $('#result').html("").append(r);
                    // /*var nombre = $('#result').find('#nombre').html();
                    // $('#titulo').text('Datos de Autor: ' + nombre);

                    // alert('Agregado con exito');*/
               // }
            // });
            // return false;
    // });


// }

//MOSTRAR PUBLICACIONES
// function loadPublicacionesFunctions(){

    // $('#resultado_busqueda a').click(function(){
            // var valor = $(this).attr('id');
            // $.ajax({
               // url: 'ajax_crud/mostrar_publicacion.php',
               // type: 'POST',
               // data: 'valor=' + valor,
               // beforeSend: function(){
                    // showLoading();
               // },
               // complete: function(){
                    // hideLoading();
               // },
               // success: function(r){
                    // $('#result').html("").append(r);
                   // loadAutoresPublicacionesFunctions();
                    // loadAutoresFunctions();
                    // loadDatosPublicaciones();
                   // var nombre = $('#result').find('#titulo').html();
                    // $('#titulo').text('');
               // }
            // });
            // return false;
    // });       
// }

// function loadDatosPublicaciones(){
    // $('#editar_pub_img').unbind("click");
   // $('#editar_pub_img').live("click",function(){
    // $('#editar_pub_img').click(function(){
            // var valor = $(this).attr('class');
            // $.ajax({
               // url: 'ajax_crud/editar_publicacion.php',
               // type: 'POST',
               // data: 'valor=' + valor,
               // beforeSend: function(){
                    // showLoading();
               // },
               // complete: function(){
                    // hideLoading();
               // },
               // success: function(r){
                    // $('#result').html("").append(r);
                    // $('#titulo').text('Datos de Publicacion:');
                    // loadEditarPublicacionFunctions();
               // }
            // });
            // return false;
    // });
// }

// function loadEstadisticasFunctions(){

    // $("#pub_anno").click(function(){

        // if($(this).hasClass("active")){
            // $('#div_pub_anno').slideUp(400);
            // $(this).removeClass("active");
            // return false;
        // }
        
        // if($(this).hasClass("loaded")){
            // $(this).addClass("active");
            // $('#div_pub_anno').slideDown(400);            
            // return false;
        // }

        // $(this).addClass("active");
        // $(this).addClass("loaded");

        // $.ajax({
            // url: 'ajax_crud/graficar.php',
            // type: 'POST',
            // data: 'graficar=pub_anno',
            // beforeSend: function(){
                // showLoading();
            // },
            // dataType: "json",
            // success: function(responce){
                // if(responce != 0){
                    // google.setOnLoadCallback(drawChart(responce,'div_pub_anno','Cantidad de Publicaciones por Anno desde ','Pub/Anno','Cant/Pub'),true);
                    // $('#div_pub_anno').slideDown(400);
                // }else{
                    // alert("No hay datos que graficar");
                // }
            // },
            // complete: function(){
                // hideLoading();
            // }
        // });
    // });

    // $("#autores_anno").click(function(){

        // if($(this).hasClass("active")){
            // $('#div_autores_anno').slideUp(400);
            // $(this).removeClass("active");
            // return false;
        // }

        // if($(this).hasClass("loaded")){
            // $(this).addClass("active");
            // $('#div_autores_anno').slideDown(400);            
            // return false;
        // }

        // $(this).addClass("active");
        // $(this).addClass("loaded");

        // $.ajax({
            // url: 'ajax_crud/graficar.php',
            // type: 'POST',
            // data: 'graficar=autores_anno',
            // beforeSend: function(){
                // showLoading();
            // },
            // dataType: "json",
            // success: function(responce){
                // if(responce != 0){
                    // google.setOnLoadCallback(drawChart(responce,'div_autores_anno','Cantidad de Autores por Anno desde ','Autores/Anno','Cant/Aut'),true);
                    // $('#div_autores_anno').slideDown(300);
                // }else{
                    // alert("No hay datos que graficar");
                // }
            // },
            // complete: function(){
                // hideLoading();
            // }
        // });
    // });

    // $("#mujeres_anno").click(function(){

        // if($(this).hasClass("active")){
            // $('#div_mujeres_anno').slideUp(400);
            // $(this).removeClass("active");
            // return false;
        // }

        // if($(this).hasClass("loaded")){
            // $(this).addClass("active");
            // $('#div_mujeres_anno').slideDown(400);            
            // return false;
        // }

        // $(this).addClass("active");
        // $(this).addClass("loaded");

        // $.ajax({
            // url: 'ajax_crud/graficar.php',
            // type: 'POST',
            // data: 'graficar=mujeres_anno',
            // beforeSend: function(){
                // showLoading();
            // },
            // dataType: "json",
            // success: function(responce){
                // if(responce != 0){
                    // google.setOnLoadCallback(drawChart(responce,'div_mujeres_anno','Cantidad de Publicaciones por Anno (x Mujeres) desde ','Autores/Anno','Cant/Pub'),true);
                    // $('#div_mujeres_anno').slideDown(300);
                // }else{
                    // alert("No hay datos que graficar");
                // }
            // },
            // complete: function(){
                // hideLoading();
            // }
        // });
    // });

    // $("#hombres_anno").click(function(){

        // if($(this).hasClass("active")){
            // $('#div_hombres_anno').slideUp(400);
            // $(this).removeClass("active");
            // return false;
        // }
		
        // if($(this).hasClass("loaded")){
            // $(this).addClass("active");
            // $('#div_hombres_anno').slideDown(400);            
            // return false;
        // }

        // $(this).addClass("active");
        // $(this).addClass("loaded");

        // $.ajax({
            // url: 'ajax_crud/graficar.php',
            // type: 'POST',
            // data: 'graficar=hombres_anno',
            // beforeSend: function(){
                // showLoading();
            // },
            // dataType: "json",
            // success: function(responce){
                // if(responce != 0){
                    // google.setOnLoadCallback(drawChart(responce,'div_hombres_anno','Cantidad de Publicaciones por Anno (x Hombres) desde ','Autores/Anno','Cant/Pub'),true);
                    // $('#div_hombres_anno').slideDown(300);
                // }else{
                    // alert("No hay datos que graficar");
                // }
            // },
            // complete: function(){
                // hideLoading();
            // }
        // });
    // });

    // $("#nacionalidad_anno").click(function(){

        // if($(this).hasClass("active")){
            // $('#div_autores_nacionalidad_anno').slideUp(400);
            // $(this).removeClass("active");
            // return false;
        // }
		
        // if($(this).hasClass("loaded")){
            // $(this).addClass("active");
            // $('#div_autores_nacionalidad_anno').slideDown(400);            
            // return false;
        // }
        
        // $(this).addClass("active");
        // $(this).addClass("loaded");

        // $.ajax({
            // url: 'ajax_crud/graficar.php',
            // type: 'POST',
            // data: 'graficar=nacionalidad_anno',
            // beforeSend: function(){
                // showLoading();
            // },
            // dataType: "json",
            // success: function(responce){
                // if(responce != 0){
                    // google.setOnLoadCallback(drawChartAutoresNacionalidad(responce,'div_autores_nacionalidad_anno'),true);
                    // $('#div_autores_nacionalidad_anno').slideDown(300);
                // }else{
                    // alert("No hay datos que graficar");
                // }
            // },
            // complete: function(){
                // hideLoading();
            // }
        // });
    // });

    // $('#estadisticas_content li').hover(function(){
        // $(this).find("span").css("color","red");
        // $(this).css("cursor","pointer");
    // }, function(){
        // $(this).find("span").css("color","#B5B5B5");
        // $(this).css("cursor","default");
    // });
// }

//PARA AGREGAR USUARIO
// function loadUsuariosFunctions(){

      // $('#boton_agregar_usuario').click(function(){
            // var nombre          = $("#nombre").val();
            // var nombre_user     = $("#nombre_user").val();
            // var pass            = $("#user_pass").val();
            // var pass_confirm    = $("#user_pass_confirm").val();
            // var correo          = $("#correo").val();
            // var tipo_usuario    = $("#tipo_usuario").val();
            // var tipo            = 0;


            // if(nombre == "" || nombre_user == "" || pass == "" || correo == ""){
                // alert("Debe llenar todos los campos solicitados");
                // return false;
            // }

            // if(pass != pass_confirm){
                // alert("Las contraseñas no coinciden");
                // return false;
            // }

            // if(!$("#correo").correo()) {
                // alert("Correo Electronico Invalido");
                // return false;
            // }

            // if(tipo_usuario == "seleccionar_tipo"){
                // alert("Debe seleccionar el tipo de usuario");
                // return false;
            // }            

            // pass = $.md5(pass_confirm);

            // $.ajax({
               // url: 'ajax_crud/usuarios_sql.php',
               // type: 'POST',
               // data: 'nombre=' + nombre +
                     // '&nombre_user=' + nombre_user +
                     // '&pass=' + pass +
                     // '&correo=' + correo +
                     // '&tipo_usuario=' + tipo_usuario +
                     // '&tipo=' + tipo,
               // beforeSend: function(){
                    // showLoading();
               // },
               // complete: function(){
                    // hideLoading();
               // },
               // success: function(r){
                    // if(r == "1"){
                        // alert("Usuario Creado orrectamente");
                        // $("#container").html("<h2><span id='titulo'>Inicio</span></h2><div id='result'></div>");
                    // }
                   
               // }
            // });
            // return false;
    // });


// }

// function drawChart(data,div_chart,titulo_general,titulo_columna, titulo_y){
    // var grafica = new google.visualization.DataTable();

    // grafica.addColumn('string', 'Year');
    // grafica.addColumn('number', titulo_columna);
    // grafica.addRows(data.length);

    // for(var i = 0; i < data.length; i++){
        // grafica.setValue(i, 0, data[i].year);
        // grafica.setValue(i, 1, eval(data[i].cantidad));
    // }

    // var inicio  = data[0].year;
    // var fin     = data[data.length -1].year;

    // var chart = new google.visualization.ColumnChart(document.getElementById(div_chart));
    // chart.draw(grafica, {
        // width: 780,
        // height: 450,
        // title: titulo_general + inicio + ' hasta ' + fin,
        // hAxis: {title: 'Anno', titleTextStyle: {color: 'red'}},
        // vAxis: {title: titulo_y, titleTextStyle: {color: 'red'}}
    // });
// }

//drawChartAutoresNacionalidad(data,div_chart) {
//    var grafica = new google.visualization.DataTable();
//
//    grafica.addColumn('string', 'Year');
//    grafica.addColumn('number', 'Autores/Anno');
//    grafica.addRows(data.length);
//
//    for(var i = 0; i < data.length; i++){
//        grafica.setValue(i, 0, data[i].year);
//        grafica.setValue(i, 1, eval(data[i].cantidad));
//    }
//
//    var inicio  = data[0].year;
//    var fin     = data[data.length -1].year;
//
//    var chart = new google.visualization.ColumnChart(document.getElementById(div_chart));
//    chart.draw(grafica, {
//        width: 780,
//        height: 450,
//        title: 'Cantidad de Autores/Nacionalidad por Anno desde ' + inicio + ' hasta ' + fin,
//        hAxis: {title: 'Anno', titleTextStyle: {color: 'red'}},
//        vAxis: {title: 'Cant/Aut', titleTextStyle: {color: 'red'}}
//    });
//}

function showLoading(){
    $('#bloquear_pantalla').css('height', "100%");
    $('#bloquear_pantalla').css('width', "100%");
    $('#bloquear_pantalla').css('display','block');
    var loading = $('#loading');
    loading.css('left', ($(window).width() / 2) - (loading.width() / 2));
    loading.css('display','block');
}

function hideLoading(){
    $('#bloquear_pantalla').css('display','none');
    $('#loading').css('display','none');
}

function loadBuscarCaminoFunctions(){

    $("#buscar_camino_button").click(function(){

		var id_1 = $("#autor_1").val();
		var id_2 = $("#autor_2").val();

        if(id_1 == "" || id_2 == ""){
            alert("Debe Introducir el Nombre de los Autores");
            return false;
        }

        $.ajax({
            url: 'ajax_crud/buscar_ruta.php',
            type: 'POST',
            data: 'id_1=' + id_1 + '&id_2=' + id_2,
			// async: false,
            beforeSend: function(){
                showLoading();
				$('#resultado').html("");
            },
            success: function(responce){
                $('#resultado').html(responce);
				// $('#resultado').html("").append('<div id="camino_container"><div class="camino_separacion">Fin respuesta</div></div>');
				
            },
            complete: function(){
				hideLoading();
				// $('#resultado').html("").append('<div id="camino_container"><div class="camino_separacion">Fin complete</div></div>');
            }
			// error: function() {
					// $('#resultado').html("").append('<div id="camino_container"><div class="camino_separacion">Error</div></div>');
			// }
			
        });
    });
    
    // $("input#autor_2, input#autor_1").focus().autocomplete('ajax_crud/autocompletar_autor.php');   
    
}

// function loadOpcionesBDFunctions(){
    // $("#button_cargar_xml").click(function(){

        // if(confirm("¿Esta seguro que desea Cargar un Nuevo XML?\nNOTA: Esto Borrara la BD actual y la llenara con el nuevo XML")){
           // console.log($("#nuevo_xml").val());
           // console.log($("#nuevo_xml"));
        // }

    // });
// }

// function loadBuscarFunctions(active,seccion){

    // $('#titulo').text('Buscar ' + seccion);

    // $('#buscar_button').click(function(){

        // var busqueda = $('#buscar_text').val();
       
       // var busqueda = valor.replace("\'","\\\'\\\'");

        // if(!busqueda){
            // alert('Debe introducior algun patron de busqueda');
            // return false;
        // }

        // $('#resultado_busqueda').remove();
        // $('#resultado').html("");
        // $('#titulo_resultado').text('Resultado de: ' + busqueda);

        // switch (active) {

            // case 1:loadInfo('ajax_crud/cargar_autores.php', 'busqueda=' + busqueda,0);
                    // break;

            // case 2:loadInfo('ajax_crud/cargar_publicacion.php', 'busqueda=' + busqueda,1);
                    // break;

            // case 3:loadInfo('ajax_crud/cargar_centro.php', 'busqueda=' + busqueda,2);
                    // break;

            // case 4:loadInfo('ajax_crud/cargar_grupo.php', 'busqueda=' + busqueda,3);
                    // break;

            // default:break;
        // }
    // });


    // $('#buscar_text').keypress(function(event) {
        // if (event.which == '13') {
            // var busqueda = $('#buscar_text').val();

            // if(!busqueda){
                // alert('Debe introducior algun patron de busqueda');
                // return false;
            // }

            // $('#resultado_busqueda').remove();
            // $('#resultado').html("");
            // $('#titulo_resultado').text('Resultado de: ' + busqueda);

            // switch (active) {

                // case 1:loadInfo('ajax_crud/cargar_autores.php', 'busqueda=' + busqueda,0);
                        // break;

                // case 2:loadInfo('ajax_crud/cargar_publicacion.php', 'busqueda=' + busqueda,1);
                        // break;

                // case 3:loadInfo('ajax_crud/cargar_centro.php', 'busqueda=' + busqueda,2);
                        // break;

                // case 4:loadInfo('ajax_crud/cargar_grupo.php', 'busqueda=' + busqueda,3);
                        // break;

                // default:break;
            // }

        // }
    // });

    // $("#borrar_button").click(function(){
        // $('#buscar_text').val("");
        // $('#resultado').html("");
        // $('#titulo_resultado').text("");
    // });

// }

// function loadInfo(url,data,bandera){
    // $.ajax({
        // url: url,
        // type: 'POST',
        // data: data,
        // beforeSend: function(){
            // showLoading();
        // },
        // success: function(r){
            // $('#resultado').append(r);
            // $('#titulo_resultado').append(" (" + $('#resultado').find("[name='num_elements']").val() + ")");
            // if (bandera==0){
                // loadListadoAutoresFunctions();
            // }
            // if (bandera==1){
                // loadPublicacionesFunctions();
            // }

            // if (bandera==2){
                // loadCargarCentroFunctions();
            // }

            // if (bandera==3){
                // loadCargarGrupoFunctions();
            // }

            // $("#myTable").tablesorter({
                // widthFixed: true,
                // sortList: [[0,0]],
                // headers: { 
                    // 1: {
                        // sorter: false
                    // }
                // }
            // }).tablesorterPager({
                // container: $("#pager"),
                // size: 25
            // });
        // },
        // error: function(err){
            // alert(err.responseText);
        // },
        // complete: function(){
            // hideLoading();
        // }
    // });
// }

$(function(){

    $("#link_principal").click(function(){
        $("#container").html("<h2>" +
                                   "<span id='titulo'>Inicio</span>"+
                             "</h2>" +
                             "<div id='result'>" +
                                   "<img src='img/urjc_logo.jpg' style='margin: 0 60px 10px; text-align: center; width: 750px;'  />" +
                             "</div>");
    });

    $(".art-menu li>a").click(function(){
        if(($(this).attr("id") != "menu_opciones") && ($(this).attr("id") != "menu_administrar")){
            if(!$(this).hasClass("active")){
                $(this).parents(".art-menu:first").find(".active:first").removeClass("active");
                if($(this).hasClass("opciones")){
                    $("#menu_opciones").addClass("active");
                }else {
                    if($(this).hasClass("administrar")){
                        $("#menu_administrar").addClass("active");
                    }else {
                        $(this).addClass("active");
                    }
                }
            }
        }

        switch($(this).attr("id")){

            case "menu_inicio"      :$("#container").html("<h2>\n\
                                                                <span id='titulo'>Inicio</span>\n\
                                                           </h2>\n\
                                                           <div id='result'>\n\
                                                                <img src='img/urjc_logo.jpg' style='margin: 0 60px 10px; text-align: center; width: 750px;'  />\n\
                                                           </div>");
                                      break;

            // case "sub_autor"        :$.ajax({
                                            // url: "ajax_crud/buscar_index.php",
                                            // type: "POST",
                                            // success: function(responce){
                                                // $("#result").html("").append(responce);
                                                // loadBuscarFunctions(1,"Autor");
                                            // }
                                      // });
                                      // break;
                                      
            // case "sub_publicacion"  :$.ajax({
                                            // url: "ajax_crud/buscar_index.php",
                                            // type: "POST",
                                            // success: function(responce){
                                                // $("#result").html("").append(responce);                                                
                                                // loadBuscarFunctions(2,"Publicación");
                                            // }
                                      // });
                                      // break;

            // case "sub_estadisticas" :$.ajax({
                                            // url: "ajax_crud/mostrar_estadisticas.php",
                                            // type: "POST",
                                            // success: function(responce){
                                                // $("#result").html("").append(responce);
                                                // $("#titulo").text("Estadisticas");
                                                // loadEstadisticasFunctions();
                                            // }
                                      // });
                                      // break;

            // case "sub_centro"       :$.ajax({
                                            // url: "ajax_crud/buscar_index.php",
                                            // type: "POST",
                                            // success: function(responce){
                                                // $("#result").html("").append(responce);
                                                // loadBuscarFunctions(3,"Centro de Estudios");
                                            // }
                                      // });
                                      // break;

            // case "sub_agregar_centro":$('#titulo').html("Agregar Centro de Estudios");
                                      // $.ajax({
                                            // url: "ajax_crud/datos_centro_estudios.php",
                                            // type: "POST",
                                            // success: function(responce){
                                                // $("#result").html("").append(responce);
                                                // loadCentroEstudiosFunctions();
                                            // }
                                      // });
                                      // break;

            // case "sub_grupo"        :$.ajax({
                                            // url: "ajax_crud/buscar_index.php",
                                            // type: "POST",
                                            // success: function(responce){
                                                // $("#result").html("").append(responce);
                                                // loadBuscarFunctions(4,"Grupo de Investigación");
                                            // }
                                      // });
                                      // break;

            // case "sub_agregar_grupo":$('#titulo').html("Agregar Grupo de Investigación");
                                      // $.ajax({
                                            // url: "ajax_crud/datos_grupo_investigacion.php",
                                            // type: "POST",
                                            // success: function(responce){
                                                // $("#result").html("").append(responce);
                                                // $( "#datepicker" ).datepicker({
                                                    // changeMonth: true,
                                                    // changeYear: true,
                                                    // dateFormat: 'yy-mm-dd',
                                                    // minDate: new Date(1900, 1 - 1, 1)
                                                // });                                                
                                                // loadGrupoInvestigacionFunctions()
                                            // }
                                      // });
                                      // break;

            case "sub_camino"       :$.ajax({
                                            url: "ajax_crud/buscar_ruta_index.php",
                                            type: "POST",
                                            success: function(responce){
                                                $('#titulo').html("");
                                                $('#result').html("").append(responce);
                                                loadBuscarCaminoFunctions();
                                            }
                                      });
                                      break;

            // case "sub_new_user"     :$('#titulo').html("Agregar Nuevo Usuario del Sistema");
                                      // $.ajax({
                                           // url: 'ajax_crud/datos_usuario.php',
                                           // type: 'POST',
                                           // beforeSend: function(){
                                                // showLoading();
                                           // },
                                           // complete: function(){
                                                // hideLoading();
                                           // },
                                           // success: function(r){
                                                // $('#result').html("").append(r);
                                                // loadUsuariosFunctions();
                                           // }
                                      // });
                                      // break;
									  
			// case "sub_new_pub"      :$('#titulo').html("Agregar Nueva Publicaci&oacute;n");
                                      // $.ajax({
                                           // url: 'ajax_crud/editar_publicacion.php',
                                           // type: 'POST',
										   // data: 'valor=0',
                                           // beforeSend: function(){
                                                // showLoading();
                                           // },
                                           // complete: function(){
                                                // hideLoading();
                                           // },
                                           // success: function(r){
                                                // $('#result').html("").append(r);
                                                // loadEditarPublicacionFunctions();
                                           // }
                                      // });
                                      // break;
									  
			// case "sub_new_autor"    :$('#titulo').html("Agregar Nuevo Autor");
                                      // $.ajax({
                                           // url: 'ajax_crud/editar_autor.php',
                                           // type: 'POST',
										   // data: 'valor=0',
                                           // beforeSend: function(){
                                                // showLoading();
                                           // },
                                           // complete: function(){
                                                // hideLoading();
                                           // },
                                           // success: function(r){
                                                // $('#result').html("").append(r);
                                                // loadEditarAutorFunctions();
												// $("#datepicker").datepicker();
                                           // }
                                      // });
                                      // break;

            // case "sub_opciones_bd"  :$('#titulo').html("");
                                      // $.ajax({
                                           // url: 'ajax_crud/cargar_opciones_bd_index.php',
                                           // type: 'POST',
                                           // beforeSend: function(){
                                                // showLoading();
                                           // },
                                           // complete: function(){
                                                // hideLoading();
                                           // },
                                           // success: function(r){
                                                // $('#result').html("").append(r);
                                                // loadOpcionesBDFunctions();
                                           // }
                                      // });
                                      // break;
            // case "sub_status"       :$('#titulo').html("Estado de la BD");
                                      // $.ajax({
                                           // url: 'ajax_crud/ver_status.php',
                                           // type: 'POST',
                                           // beforeSend: function(){
                                                // showLoading();
                                           // },
                                           // complete: function(){
                                                // hideLoading();
                                           // },
                                           // success: function(r){
                                                // $('#result').html("").append(r);
                                                // loadOpcionesBDFunctions();
                                           // }
                                      // });
                                      // break;

            case "menu_about"       :$("#container").html("<h2><span id='titulo'>About</span></h2><div id='result'><p>Oscar Parrilla <a href='mailto:oparrilla@gmail.com'>oparrilla@gmail.com</a></p>	</div>");
                                      break;

        }

        return false;
    });

  $("#form_sesion_ini").click(function(){
      
        if($(this).hasClass("activo")){
            $(this).removeClass("activo");
            $('#ini_sesion').slideUp(500);
        }else{
            $(this).addClass("activo");
            $("#usuario").val("");
            $("#pass").val("");
            $("#mensaje_login").html("");
            $('#ini_sesion').slideDown(500);
        }
        
        return false;
  });

  $("#form_sesion_close").click(function(){
        $.ajax({
               url: 'ajax_crud/logout.php',
               type: 'POST',
               beforeSend: function(){
                    showLoading();
               },
               complete: function(){
                    hideLoading();
               },
               success: function(){
                    location.reload(true);
               }
            });

        return false;      
  });

  $("#sesion_ini_button").click(function(){
        $("#mensaje_login").html("");
        var nombre = $("#usuario").val();
        var passw  = $.md5($("#pass").val());

        if(nombre == "" || passw == ""){
            $("#mensaje_login").html("&ensp;&ensp;&ensp;¡No puede dejar campos vacios!");
            return false;
        }

                $.ajax({
                   url: 'ajax_crud/comprobacion.php',
                   type: 'POST',
                   data: 'nombre=' + nombre +
                         '&passw=' + passw,
                   beforeSend: function(){
                        showLoading();
                   },
                   complete: function(){
                        hideLoading();
                   },
                   success: function(r){
                        switch(eval(r)){

                            case  0:$("#mensaje_login").html("&ensp;&ensp;&ensp;¡Usuario o Contraseña incorrecta!");
                                     break;
                            case  1:location.reload(true);
                                     break;
                            case -1:alert("Datos vacios");
                                     break;
                        }
                   }
                });

        return false;
  });

  $("#pass").keypress(function(event) {
        if (event.which == '13') {
            $("#mensaje_login").html("");
            var nombre = $("#usuario").val();
            var passw  = $.md5($("#pass").val());

            if(nombre == "" || passw == ""){
                $("#mensaje_login").html("&ensp;&ensp;&ensp;¡No puede dejar campos vacios!");
                return false;
            }

            $.ajax({
               url: 'ajax_crud/comprobacion.php',
               type: 'POST',
               data: 'nombre=' + nombre +
                     '&passw=' + passw,
               beforeSend: function(){
                    showLoading();
               },
               complete: function(){
                    hideLoading();
               },
               success: function(r){
                    switch(eval(r)){

                        case  0:$("#mensaje_login").html("&ensp;&ensp;&ensp;¡Usuario o Contraseña incorrecta!");
                                 break;
                        case  1:location.reload(true);
                                 break;
                        case -1:alert("Datos vacios");
                                 break;
                    }
               }
            });
            return false;
        }
   });
});

