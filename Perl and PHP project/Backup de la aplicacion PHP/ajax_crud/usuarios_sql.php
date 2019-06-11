<?php

/**
 * DBLP Explorer
 *
 * @author Mary Luque
 * @author Jesus Dominguez
 * @copyright 2011
 *
 */

    include("../lib/DBLP_DB.php");

    $db = new DBLP_DB();
    $db->conectar();

    $tipo = $_POST['tipo'];
    if ($tipo==0){
        $nombre = $_POST['nombre'];
        $pass = $_POST['pass'];
        $correo = $_POST['correo'];
        $tipo_usuario = $_POST['tipo_usuario'];

//        $query = $db->query("INSERT INTO tb_dblp_usuario (nombre_usuario,contrasena,correo_usuario,id_tipo_usuario)
//                             VALUES ('$nombre', '$pass','$correo','$tipo_usuario');");

        echo "1";
    }

    if ($tipo==1){
        $valor = $_POST['valor'];
        $query2 = $db->query("SELECT tb_dblp_grupo_investigacion.id_grupo as id_grupo,tb_dblp_grupo_investigacion.nombre_grupo as nombre_grupo,tb_dblp_grupo_investigacion.tema as tema,tb_dblp_grupo_investigacion.direccion_grupo as direccion_grupo,tb_dblp_grupo_investigacion.correo_grupo as correo_grupo,tb_dblp_grupo_investigacion.fecha_creacion as fecha_creacion,tb_dblp_grupo_investigacion.pagina_centro as pagina_centro
                              FROM tb_dblp_grupo_investigacion
                              WHERE id_grupo= $valor;");


        $row = mysql_fetch_array($query2);

        echo '<div id="grupo">';
        echo '<table id="table_body" class="table_width"><tbody>';

        echo'<tr><th class="table_title" colspan="2" align="center">Nombre:</th></tr>';
        echo'<tr><td>'.$row["nombre_grupo"].'</td></tr>';

        echo'<tr><th class="table_title" colspan="2" align="center">Tema:</th></tr>';
        echo'<tr><td>'.$row["tema"].'</td></tr>';

        echo'<tr><th class="table_title" colspan="2" align="center">Direcci&oacute;n:</th></tr>';
        echo'<tr><td>'.$row["direccion_grupo"].'</td></tr>';

        echo'<tr><th class="table_title" colspan="2" align="center">Correo:</th></tr>';
        echo'<tr><td>'.$row["correo_grupo"].'</td></tr>';

        echo'<tr><th class="table_title" colspan="2" align="center">Fecha de Creaci&oacute;n:</th></tr>';
        echo'<tr><td>'.$row["fecha_creacion"].'</td></tr>';

        echo'<tr><th class="table_title" colspan="2" align="center">P&aacute;gina:</th></tr>';
        echo'<tr><td>'.$row["pagina_centro"].'</td></tr>';

        echo'</tbody></table>';
        echo '<div>';
    }


    if (tipo==2){
        //DATOS RECIBIDOS
        $id_grupo = $_POST['id'];
        $id_centro=$_POST['id_centro'];
        $nombre_grupo = $_POST['nombre_grupo'];
        $tema = $_POST['tema'];
        $direccion_grupo = $_POST['ciudad'];
        $correo_grupo = $_POST['correo_grupo'];
        $fecha_creacion = $_POST['fecha_creacion'];
        $pagina_centro = $_POST['pagina_centro'];

	$sql = $db->query("UPDATE tb_dblp_grupo_investigacion
			   SET id_centro=$id_centro,nombre_grupo = $nombre_grupo,tema=$tema,direccion_grupo=$direccion_grupo,correo_grupo=$correo_grupo,fecha_creacion=$fecha_creacion,pagina_centro=$pagina_centro
                	   WHERE id_grupo=$id_grupo ;");

    }
?>

