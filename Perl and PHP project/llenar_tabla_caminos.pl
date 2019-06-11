# Distancia entre Investigadores

# Copyright (c) 2015 Oscar Parrilla

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.


#!c:\strawberry\perl\bin\perl.exe -w

use strict;
use Graph;
use DBI;


use warnings;


use Queue::Base;



##########################################################################################################
## 									         Variables							    					##
##########################################################################################################


my $database = "db_dblp";
my $host = "localhost";
my $user = "root";
my $password = "12369";



my $conexion;
my $query_handle;
my $query; 
my $id_autor_max;



my $autorOrigen;
my $autorDestino;
my $terminarBusqueda;
my $profundidadFinBusqueda;
my $MAX_INTEGER = 2147483648;


my @distancias;
my @padres;

my $id_autor;
my $queue; 

my $row;
my $coautor;
my $sumaDistancia = 0;




my $contCaminosDist2=0;
my $contCaminosDist3=0;
my $num_caminos_insertados=0; 
my $tiempoMaximo=2;
my $numeroCaminosInsertadosEnBloque=0; 
my $sumaTiemposBloque=0;
my $contCaminosTotal=0;
my $numeroAutores=0;
my $mediaCantidadCaminosInsertadosPorAutor=0;
my $cadenaTiemposBloque="";
my $numeroDescansos=0;
my $numeroBloquesTotal=0;
my $tiempoTotal=0;
my $tiempoBloque=0;
my $maximoNumeroDescansos=70;
my $tiempoDescansoGrande=15;

my $minutosDormir=2; 

my ($secAux,$minAux,$hourAux,$mdayAux,$monAux,$yearAux,$wdayAux,$ydayAux,$isdstAux) = localtime(time);

my ($secAux3,$minAux3,$hourAux3,$mdayAux3,$monAux3,$yearAux3,$wdayAux3,$ydayAux3,$isdstAux3) = localtime(time);



##########################################################################################################
## 											 Funciones													##
##########################################################################################################



##########################################################################################################
## 												Main 													##
##########################################################################################################

my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time);
print  "########################################\n";
printf "                     Hora de Inicio: %02d:%02d:%02d %02d-%02d-%4d\n",$hour,$min,$sec,$mday,$mon+1,$year+1900;
print  "########################################\n";





$conexion = DBI->connect("dbi:mysql:database=$database; host=$host", $user, $password) or die "No se pudo conectar con la Base de Datos: $!\n";
$query_handle = $conexion->prepare("SET NAMES 'utf8'"); 
$query_handle->execute();	



$query = "SELECT MAX(id_autor) as id_autor_max from tb_dblp_detalle_autor";
$query_handle = $conexion->prepare($query);
$query_handle->execute();
$row = $query_handle->fetchrow_hashref();
$id_autor_max = $row->{'id_autor_max'};




$query = "SELECT MAX(id_autor_inicial) as id_autor_inicial_max from tb_dblp_caminos";
$query_handle = $conexion->prepare($query);
$query_handle->execute();
$row = $query_handle->fetchrow_hashref();
my $id_autor_inicial_max = $row->{'id_autor_inicial_max'};





$profundidadFinBusqueda=3;

# for($autorOrigen = 1; $autorOrigen <= $id_autor_max; $autorOrigen++){	
for($autorOrigen = $id_autor_inicial_max; $autorOrigen <= $id_autor_max; $autorOrigen++){	

	$numeroAutores++;
	
	$terminarBusqueda=0;
	my ($secAux4,$minAux4,$hourAux4,$mdayAux4,$monAux4,$yearAux4,$wdayAux4,$ydayAux4,$isdstAux4) = localtime(time);
	# print "Autor origen actual: $autorOrigen\n";


	for($id_autor = 1; $id_autor <= $id_autor_max; $id_autor++){	
		$distancias[$id_autor] = $MAX_INTEGER;
		$padres[$id_autor] = "";	
	}


	$distancias[$autorOrigen] = 0;
	
	$queue = new Queue::Base;
	$queue->add($autorOrigen);



	while (!$queue->empty && !$terminarBusqueda) {

		$id_autor = $queue->remove;
			
			
		$query = "SELECT id_coautor FROM tb_dblp_rel where id_autor=$id_autor;";
		$query_handle = $conexion->prepare($query);
		$query_handle->execute();
		

		$row = $query_handle->fetchrow_hashref();
		while($row && !$terminarBusqueda) {	
			
			$coautor =$row->{'id_coautor'};
					
			$sumaDistancia = $distancias[$id_autor]+1;
			
			if ($distancias[$coautor] > $sumaDistancia) {
				
				$distancias[$coautor] = $sumaDistancia;
				$padres[$coautor] = $padres[$id_autor]."#".$id_autor;
				$queue->add($coautor);
				
				if ($sumaDistancia == $profundidadFinBusqueda) {
					$terminarBusqueda = 1;
					$distancias[$coautor] = $MAX_INTEGER;
					$padres[$coautor] = "";
				};

			}
			
			$row = $query_handle->fetchrow_hashref();
			
		}
		
		
		$query = "SELECT id_autor FROM tb_dblp_rel where id_coautor=$id_autor;";
		$query_handle = $conexion->prepare($query);
		$query_handle->execute();
		
		$row = $query_handle->fetchrow_hashref();
		while($row && !$terminarBusqueda) {	
			
			$coautor = $row->{'id_autor'};
					
			$sumaDistancia = $distancias[$id_autor]+1;
			
			if ($distancias[$coautor] > $sumaDistancia) {
				
				$distancias[$coautor] = $sumaDistancia;
				$padres[$coautor] = $padres[$id_autor]."#".$id_autor;
				$queue->add($coautor);
				
				if ($sumaDistancia == $profundidadFinBusqueda) {
					$terminarBusqueda = 1;
					$distancias[$coautor] = $MAX_INTEGER;
					$padres[$coautor] = "";
				};

			}	

			$row = $query_handle->fetchrow_hashref();
			
		}
			

	}
	
	# my ($secAux5,$minAux5,$hourAux5,$mdayAux5,$monAux5,$yearAux5,$wdayAux5,$ydayAux5,$isdstAux5) = localtime(time);
	# print "Tiempo para calcular todos los caminos de distancia<$profundidadFinBusqueda para el autor origen id_autor=$autorOrigen: ".(($secAux5+($minAux5*60)+($hourAux5*60*60))-($secAux4+($minAux4*60)+($hourAux4*60*60)))." segundos  (".((($secAux5+($minAux5*60)+($hourAux5*60*60))-($secAux4+($minAux4*60)+($hourAux4*60*60)))/60)." minutos)\n";
	# my $variableEntrada=<STDIN>;
	$contCaminosDist2=0;
	$contCaminosDist3=0;
	
	for($autorDestino = $autorOrigen+1; $autorDestino <= $id_autor_max; $autorDestino++){	
		
		if ($padres[$autorDestino] ne "" && $distancias[$autorDestino] > 1) {
			
			$padres[$autorDestino].="#".$autorDestino;
			$padres[$autorDestino]=substr($padres[$autorDestino],1);


			
			if ($distancias[$autorDestino]==2){
				$contCaminosDist2++;
			}
			if ($distancias[$autorDestino]==3){
				$contCaminosDist3++;
			}			

			
			
			$conexion->do("INSERT INTO tb_dblp_caminos (id_autor_inicial, id_autor_final, num_nodos, camino) VALUES ($autorOrigen, $autorDestino, $distancias[$autorDestino], '$padres[$autorDestino]')");
			
			
			$num_caminos_insertados++;
			$numeroCaminosInsertadosEnBloque++;
			
			# Dormimos el proceso si se ha pasado un tiempo determinado
			my ($secAux2,$minAux2,$hourAux2,$mdayAux2,$monAux2,$yearAux2,$wdayAux2,$ydayAux2,$isdstAux2) = localtime(time);
			$tiempoBloque=(($secAux2+($minAux2*60)+($hourAux2*60*60))-($secAux+($minAux*60)+($hourAux*60*60)))/60;
			if ($tiempoBloque<0) { ($secAux,$minAux,$hourAux,$mdayAux,$monAux,$yearAux,$wdayAux,$ydayAux,$isdstAux) = localtime(time);};
			
			if ($tiempoBloque>$tiempoMaximo){
						
				for(my $k = 1; ($k<= 3) ; $k++){ print "********************************************************************************************************************************************\n"; }
							
				print "Se han cumplido $tiempoBloque minutos cargando caminos\n\n";
				
				print "Ultimo registro insertado: id_autor_inicial=$autorOrigen, id_autor_final=$autorDestino, num_nodos=$distancias[$autorDestino], camino=$padres[$autorDestino]\n";
				
				$tiempoTotal=($minAux2+($hourAux2*60))-($minAux3+($hourAux3*60));
				print "Numero de caminos insertados en total: ".$num_caminos_insertados."      (Se han leido en ".$tiempoTotal." minutos)(En ".($tiempoTotal/60)." horas)\n\n";
				
				
				if ($tiempoBloque<$tiempoMaximo+5){
					# print "Numero de caminos insertados en bloque: ".$numeroCaminosInsertar."      (Se han leido en ".($tiempoBloque*60)." segundos)(En ".$tiempoBloque." minutos)\n\n";
					print "Numero de caminos insertados en bloque: ".$numeroCaminosInsertadosEnBloque."      (Se han leido en ".($tiempoBloque*60)." segundos)(En ".$tiempoBloque." minutos)\n\n";
					
					$cadenaTiemposBloque.=$tiempoBloque.", ";
					print "Ultimos tiempos de insercion de bloque: ".$cadenaTiemposBloque."\n\n";
					
					print "Numero medio de caminos que tiene cada autor: $mediaCantidadCaminosInsertadosPorAutor caminos/autor\n";
					print "Numero de dias estimados en insertar todos los caminos: ".(((((($mediaCantidadCaminosInsertadosPorAutor)*(1557000-$autorOrigen))/$numeroCaminosInsertadosEnBloque)*($tiempoMaximo+$minutosDormir+($tiempoDescansoGrande/$maximoNumeroDescansos)))/60)/24)." dias.\n\n";
					print "Numero de dias estimados en insertar todos los caminos con la media total: ".((((((341)*(1557000-$autorOrigen))/$numeroCaminosInsertadosEnBloque)*($tiempoMaximo+$minutosDormir))/60)/24)." dias.\n\n";
				
					
				}
				else {
					print "No se muestra el numero de caminos insertados en bloque porque el tiempo es negativo.\n\n"
				}
				
						
				print "Durmiendo.\n"; 
		
				
				$numeroDescansos++;
				if ($numeroDescansos==$maximoNumeroDescansos){
					
					$numeroDescansos=0;
					$cadenaTiemposBloque="";
				}
				
							
				print "Comprobar temperatura de la CPU.\n\n";	
				

				($secAux,$minAux,$hourAux,$mdayAux,$monAux,$yearAux,$wdayAux,$ydayAux,$isdstAux) = localtime(time);			
				
				print "Tiempo durmiendo: ".(($secAux+($minAux*60)+($hourAux*60*60))-($secAux2+($minAux2*60)+($hourAux2*60*60)))." segundos\n\n";
				
				$numeroCaminosInsertadosEnBloque=0;
				
			}
		

			
		}

	}
	
	# print "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n";
	# print "Numero de caminos de distancia 2 para id autor origen $autorOrigen: $contCaminosDist2\n";
	# print "Numero de caminos de distancia 3 para id autor origen $autorOrigen: $contCaminosDist3\n";
	# print "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n";
	$contCaminosTotal+=$contCaminosDist2+$contCaminosDist3;
	$mediaCantidadCaminosInsertadosPorAutor=($contCaminosTotal)/$numeroAutores;
}
		
		



($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time);
print  "########################################\n";
printf "                        Hora de Fin: %02d:%02d:%02d %02d-%02d-%4d\n",$hour,$min,$sec,$mday,$mon+1,$year+1900;
print  "########################################\n";