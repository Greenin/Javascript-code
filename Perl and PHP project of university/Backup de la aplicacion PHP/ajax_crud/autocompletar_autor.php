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

	$limit = $_GET["limit"];
	$search = $_GET["autor_1"]; /*$search = $_GET["autor_1"];*/

	$db = new DBLP_DB();
	$db->conectar();
	$query = $db->query("SELECT nombre FROM tb_dblp_detalle_autor WHERE nombre LIKE '".$search."%' LIMIT 100;");

	$rows = array();
	while ( $row = $db->fetch_array($query) ) {
            echo $row["nombre"]."\n";
	}

?>
