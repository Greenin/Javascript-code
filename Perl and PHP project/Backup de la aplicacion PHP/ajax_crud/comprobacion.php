<?php
/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
session_start();
include("../lib/DBLP_DB.php");
$db = new DBLP_DB();
$db->conectar();

$nombre= $_POST['nombre'];
//$passw= md5($_POST['passw']);
$passw= $_POST['passw'];

if($nombre!="" && $passw !="") {

         $query = $db->query("SELECT a.id_tipo_usuario AS id_tipo_usuario,a.nombre_usuario, a.nombre as nombre,a.contrasena,b.id_tipo_usuario,b.detalle_tipo_usuario as detalle
                              FROM tb_dblp_usuario as a,tb_dblp_tipo_usuario as b
                              WHERE nombre_usuario= '$nombre'
                              AND contrasena= '$passw'
                              AND b.id_tipo_usuario=a.id_tipo_usuario;");

        if(mysql_num_rows($query)){
       
                $row = mysql_fetch_array($query);
       
                if ($row["detalle"]== "admin"){
                     $_SESSION['autentificado'] = 1;
                     $_SESSION['admin'] = $nombre;                     
                     $_SESSION['tipo'] = $row["detalle"];
                     $_SESSION['nombre'] = $row["nombre"];
                 }
               else {
                    $_SESSION['autentificado'] = 1;
                    $_SESSION['normal'] = $nombre;                    
                    $_SESSION['tipo'] = $row["detalle"];
                    $_SESSION['nombre'] = $row["nombre"];
                }
                echo "1";
        }
        else {
            $_SESSION['error'] ="Login incorrecto";
            echo "0";
        }

} else{
	$_SESSION['llene'] ="Llene los campos";
        echo "-1";
}

?>
