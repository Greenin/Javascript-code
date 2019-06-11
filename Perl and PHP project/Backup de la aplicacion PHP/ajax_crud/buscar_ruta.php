<?php

/**
 * Distancia entre investigadores
 * 
 * @author Oscar Parrilla
 * @copyright 2015 
 * 
 */

	include("../lib/DBLP_DB.php");
	
	
	
	function buscarNombreAutorCompleto($nombre,$db){
		$nombre = preg_replace('/\'/','\\\'',$nombre);

		$query = $db->query("SELECT nombre FROM tb_dblp_detalle_autor WHERE nombre LIKE '".$nombre."%' LIMIT 1;");

		$row = $db->fetch_array($query);

                // if($row["parent"] != 0){
                    // return $row["parent"];
                // }else{
                    return $row["nombre"];
                // }
	}	

		
		
	function buscarIdAutor($nombre,$db){
		$nombre = preg_replace('/\'/','\\\'',$nombre);

		// $query = $db->query("SELECT id_autor, parent FROM tb_dblp_detalle_autor
				     // WHERE nombre = '$nombre';");
		$query = $db->query("SELECT id_autor FROM tb_dblp_detalle_autor WHERE nombre = '$nombre';");

		$row = $db->fetch_array($query);

                // if($row["parent"] != 0){
                    // return $row["parent"];
                // }else{
                    return $row["id_autor"];
                // }
	}	
	
	
	function hayRelacion($id_autor1,$id_autor2,$db){
		$query = $db->query("SELECT id_autor, id_coautor
							 FROM tb_dblp_rel
							 WHERE (id_autor=$id_autor1 AND id_coautor=$id_autor2);");
		
		return $db->fetch_array($query);
	}	
	
	
	
	function hayCamino($id_autor1,$id_autor2,$db){
		$query = $db->query("SELECT camino, num_nodos
							 FROM tb_dblp_caminos
							 WHERE (id_autor_inicial=$id_autor1 AND id_autor_final=$id_autor2);");
		
		return $db->fetch_array($query);
	}
	

	
	function buscarNombreAutor($id_autor,$db){		
		$query = $db->query("SELECT nombre FROM tb_dblp_detalle_autor WHERE id_autor=$id_autor;");
		$row = $db->fetch_array($query);
		return $row["nombre"];
	}
	

	function buscarIdPublicacion($id_autor1,$id_autor2,$db){
		$query = $db->query("SELECT id_publicacion FROM tb_dblp_autor
				     WHERE id_publicacion IN (
				         SELECT id_publicacion
				         FROM tb_dblp_autor
				         WHERE id_autor = $id_autor1
				     )
				     AND id_autor = $id_autor2
				     LIMIT 1;");

		$row = $db->fetch_array($query);
		return $row["id_publicacion"];	
	}
	

	function buscarTituloPublicacion($id_pub,$db){
		$query = $db->query("SELECT dblp_key FROM tb_dblp_datos_publicacion WHERE id_publicacion = $id_pub;");
		$row = $db->fetch_array($query);
		return $row["dblp_key"];
	}

	
	
	//INICIO
	
	$db = new DBLP_DB();
	$db->conectar();

	
	
	$nombre_1 = buscarNombreAutorCompleto($_POST['id_1'],$db);
	$nombre_2 = buscarNombreAutorCompleto($_POST['id_2'],$db);

	$id_1 = buscarIdAutor($nombre_1,$db);
	$id_2 = buscarIdAutor($nombre_2,$db);	
	
	
	if($id_1 != $id_2){

		
		$hay_camino = false;
		$camino_opuesto = false;
		
		if(!$camino = hayRelacion($id_1,$id_2,$db)){
			if($camino = hayRelacion($id_2,$id_1,$db)){
				$hay_camino = true;
				$camino_opuesto = true;
				$camino = $camino["id_autor"].'#'.$camino["id_coautor"];
			}
		}else{
			$hay_camino = true;
			$camino = $camino["id_autor"].'#'.$camino["id_coautor"];	   
		}

		
		
		if(!$hay_camino){
			if(!$camino = hayCamino($id_1,$id_2,$db)){
				if($camino = hayCamino($id_2,$id_1,$db)){
					$hay_camino = true;
					$camino_opuesto = true;
					$camino = $camino["camino"];
				}
			}else{
			   $hay_camino = true; 
			   $camino = $camino["camino"];
			}
		
		}	


		
		if(!$hay_camino){
		
			$camino = "" ;
			
			$command = "C:\Strawberry\perl\bin\perl.exe ../perl_scripts/caminoMasCortoDijkstra.pl $id_1 $id_2";
			set_time_limit(900); //Establecemos 15 minutos como tiempo máximo que puede tardar en ejecutarse el comando anterior indicado
			$camino = exec($command);	
			
			if ($camino == "" ){
				$hay_camino = false;
			}
			else {
				if ($camino != "") {
					$hay_camino = true;
				}
			}
		}
		
	  
			
		if($hay_camino){					

		
			// echo '<div id="camino_container">';
			// echo '<div class="camino_separacion">';	
			// echo $camino.'</div>';	
		
			$array_id_autores = preg_split("/#/", $camino);
					
			
			if($camino_opuesto){
				$array_id_autores = array_reverse($array_id_autores);
			}

			
			$cont = count($array_id_autores)-1;  //Calculamos la distancia entre los autores
			
			
			echo '<div id="camino_container">';
			echo '<div class="camino_separacion">';

			if($cont == 1) 
				echo $cont.' Publicacion de Separaci&oacute;n</div>';
			else
				echo $cont.' Publicaciones de Separaci&oacute;n</div>';

			
			for($i = 0, $j = $i+1; $j < $cont +1; $i++,$j++){
				echo '<div class="camino_autor" id="'.$array_id_autores[$i].'">'.buscarNombreAutor($array_id_autores[$i],$db).'</div>';
				echo '<img class="camino_img_down" src="img/img_down.png" />';

				$id_publicacion = buscarIdPublicacion($array_id_autores[$i],$array_id_autores[$j],$db);
				$titulo_pub = buscarTituloPublicacion($id_publicacion,$db);

				echo '<div class="camino_publicacion" id="'.$id_publicacion.'">'.$titulo_pub.'</div>';
				echo '<img class="camino_img_down" src="img/img_down.png" />';
			}
			
			
			echo '<div class="camino_autor" id="'.$array_id_autores[$cont].'">'.buscarNombreAutor($array_id_autores[$cont],$db).'</div>';
			echo '</div>';
		
		}else{
			echo '<div id="camino_container">';
			echo '<div class="camino_separacion">No hay camino entre los autores</div>';
			echo '</div>';
		}
	}else{
		echo '<div id="camino_container">';
		echo '<div class="camino_separacion">Los autores deben ser diferentes</div>';
		echo '</div>';
	}

?>
