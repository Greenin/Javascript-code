<?php  

class DBLP_DB{  
	
	private $conexion;  
	private $total_consultas;
	
	private $servidor = "localhost"; //"localhost"  "MySQL56"
	private $usuario = "root";
	private $password = "12369";
	private $db = "db_dblp";

	public function __construct(){  
		 $this->conexion = NULL;
		 $this->total_consultas = 0;
	} 
		
	public function conectar(){	
		if(!$this->hayConexion()){ 
			$this->conexion = (@mysql_connect($this->servidor,$this->usuario,$this->password)) or die(mysql_error()); 
			@mysql_select_db($this->db,$this->conexion) or die(mysql_error());  
		}		
	}
		 
	public function desconectar(){		
		mysql_close($this->conexion);
	}
		 
	private function hayConexion(){
		
			return isset($this->conexion);
	}	 
	
	public function query($query){  
		$this->total_consultas++;  
		mysql_query("SET NAMES 'utf8'");
		$resultado = mysql_query($query,$this->conexion);  
		if(!$resultado){  
			echo 'MySQL Error: ' . mysql_error();  
			exit;  
		}  
		return $resultado;   
	}  
	
	public function fetch_array($query){   
		return mysql_fetch_array($query);  
		
		/* 
		 * array mysql_fetch_array ( resource $result [, int $result_type = MYSQL_BOTH ] )
		 * 
		 * Devuelve un array de cadenas que corresponde a la fila recuperada, o FALSE si no hay más filas. 
		 * El tipo del array retornado depende de como esté definido result_type. 
		 * Mediante MYSQL_BOTH (predeterminado), se obtendrá un array con ambos índices: asociativos y numéricos. 
		 * Usando MYSQL_ASSOC, se obtienen solo los índices asociativos (tal como funciona mysql_fetch_assoc()). 
		 * Usando MYSQL_NUM, se obtienen solo los índices numéricos (tal como funciona mysql_fetch_row()).*/		
	}  
	
	public function num_rows($query){   
		return mysql_num_rows($query);  
	}  
	
	public function getTotalConsultas(){  
		return $this->total_consultas;  
	}
	
	public function getLastId(){
		return mysql_insert_id();
		
		/*
		 * 	Devuelve: int - El Ultimo ID de una columna AUTO_INCREMENT
		 *             0  - Si la anterior consulta no genera un valor AUTO_INCREMENT
		 *  		 FALSE- Si no se estableció una conexión MySQL.
		 */
	}
	
	
}



/* Ejemplo de Uso
 * 
	include("mysql.php");  

	$db = new MySQL();  

	$consulta = $db->consulta("SELECT id FROM mitabla1");  

	if($db->num_rows($consulta)>0){  
		while($resultados = $db->fetch_array($consulta)){  
			echo "ID: ".$resultados['id']."<br />";  
		}  
	}  
 *  
 */

?>  
