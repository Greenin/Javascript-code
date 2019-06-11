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
use encoding 'utf8';
use strict;
use DBI;


use warnings;




my $id_autor=0;
my $num_row = 0;
my $resultado=1;




my $num_rel_insertadas=0; 
my $cadNumRelInsertadasPorAutor=""; 
my $numeroRelLeer=30000; 
my $sumaTiemposBloque=0;
my $sumaCantidadesRelInsertPorAutor=0;
my $numeroAutores=0;
my $cadenaTiemposBloque="";
my $numeroDescansos=0;
my $numeroBloquesTotal=0;
my $tiempoTotal=0;
my $tiempoBloque=0;
	
# my $minutosDormir=0.25; 
my $minutosDormir=2; 

my ($secAux,$minAux,$hourAux,$mdayAux,$monAux,$yearAux,$wdayAux,$ydayAux,$isdstAux) = localtime(time);

my ($secAux3,$minAux3,$hourAux3,$mdayAux3,$monAux3,$yearAux3,$wdayAux3,$ydayAux3,$isdstAux3) = localtime(time);





##########################################################################################################
## 									         Variables							    					##
##########################################################################################################

my $database = "db_dblp";
my $host = "localhost";
my $user = "root";
my $password = "12369";


my $conexion = DBI->connect("dbi:mysql:database=$database; host=$host", $user, $password) or die "No se pudo conectar con la Base de Datos: $!\n";

my $query_handle = $conexion->prepare("SET NAMES 'utf8'"); 
$query_handle->execute();



##########################################################################################################
## 											 Funciones													##
##########################################################################################################

sub loadTableRelationship {
	
	my ( $db ) = @_;

	my $query = "SELECT MIN(id_autor) as autor_id from tb_dblp_detalle_autor";
	my $query_handle = $db->prepare($query);
	$query_handle->execute();
	my $row = $query_handle->fetchrow_hashref();

	my $min_id = $row->{'autor_id'};
	
		
	
	
	my $query2 = "SELECT MAX(id_autor) as autor_id from tb_dblp_rel";
	my $query_handle2 = $db->prepare($query2);
	$query_handle2->execute();
	my $row2 = $query_handle2->fetchrow_hashref();
	$min_id = $row2->{'autor_id'};

	
	
	$query = "SELECT MAX(id_autor) as autor_id from tb_dblp_detalle_autor";
	$query_handle = $db->prepare($query);
	$query_handle->execute();
	$row = $query_handle->fetchrow_hashref();

	my $max_id = $row->{'autor_id'};

		
	
	# my $count_global = 0;
	# my $id_autor;

	for(my $id_autor = $min_id; ($id_autor<= $max_id) ; $id_autor++){

		# $query = "SELECT DISTINCT(b.id_autor) as coautor_id
				  # FROM tb_dblp_autor as a, tb_dblp_autor as b
				  # WHERE a.id_autor = $i AND a.id_publicacion = b.id_publicacion AND b.id_autor != $i";
				  # ORDER BY b.id_autor";


		$query = "SELECT id_autor as coautor_id
				  FROM tb_dblp_autor 
				  WHERE id_autor > $id_autor AND editor = 0 AND id_publicacion IN (
				  SELECT id_publicacion FROM tb_dblp_autor WHERE id_autor = $id_autor)";
				  # ORDER BY B.id_autor";		
				  
				  
		$query_handle = $db->prepare($query);
		$query_handle->execute();
		
		

		# print "ID Autor: $id_autor\n";		
		
		$num_row = $query_handle->rows;
		
		$sumaCantidadesRelInsertPorAutor+=$num_row;
		$numeroAutores++;
		$cadNumRelInsertadasPorAutor.= $num_row.", ";

		if($num_row > 0){
			while($row = $query_handle->fetchrow_hashref()) {


				my $query_exist = "SELECT id_autor, id_coautor FROM tb_dblp_rel WHERE id_autor = $id_autor AND id_coautor = $row->{'coautor_id'};";
				my $query_handle_exist = $db->prepare($query_exist);
				$query_handle_exist->execute();

				
				if($query_handle_exist->rows == 0){
				
					$resultado=$db->do("INSERT INTO tb_dblp_rel (id_autor, id_coautor) VALUES ($id_autor, $row->{'coautor_id'})");
				}
								

				$num_rel_insertadas++;
				
				
				# Dormimos el proceso si se han insertado un número determinado de relaciones 
				if ( $num_rel_insertadas%$numeroRelLeer==0 && $num_rel_insertadas>$numeroRelLeer-1){
				
					for(my $k = 1; ($k<= 50) ; $k++){ print "********************************************************************************************************************************************\n"; }
					print "Se han insertado un multiplo de ".$numeroRelLeer." relaciones.\n\n"; 
				
					print "Cadena de cantidades de relaciones insertadas por autor: ".$cadNumRelInsertadasPorAutor."\n\n";
					$cadNumRelInsertadasPorAutor="";
					print "Numero medio de cantidad de relaciones por autor: ".($sumaCantidadesRelInsertPorAutor/$numeroAutores)."\n\n";
					print "Numero estimado de relaciones a insertar: ".(($sumaCantidadesRelInsertPorAutor/$numeroAutores)*(1557000-$id_autor))." de registros\n\n";
					
					print "Id de autor actual: ".$id_autor."\n\n";
					
					my ($secAux2,$minAux2,$hourAux2,$mdayAux2,$monAux2,$yearAux2,$wdayAux2,$ydayAux2,$isdstAux2) = localtime(time);
					
					$tiempoTotal=($minAux2+($hourAux2*60))-($minAux3+($hourAux3*60));
					print "Numero de relaciones insertadas en total: ".$num_rel_insertadas."      (Se han leido en ".$tiempoTotal." minutos)\n\n";
					
					$tiempoBloque=($minAux2+($hourAux2*60))-($minAux+($hourAux*60));
					if ($tiempoBloque>0){
						print "Numero de relaciones insertadas en bloque: ".$numeroRelLeer."      (Se han leido en ".$tiempoBloque." minutos)\n\n";
						
						$cadenaTiemposBloque=$cadenaTiemposBloque.$tiempoBloque.", ";
						print "Ultimos tiempos de insercion de bloque: ".$cadenaTiemposBloque."\n\n";
						
						$numeroBloquesTotal++;
						$sumaTiemposBloque=$sumaTiemposBloque+$tiempoBloque;
						print "Tiempo medio en insertar un bloque: ".($sumaTiemposBloque/$numeroBloquesTotal)." minutos.\n\n";
					}
					else {
						print "No se muestra el numero de relaciones insertadas en bloque porque el tiempo es negativo.\n\n"
					}
					
					print "Numero de dias estimados en insertar todas las relaciones: ".(((((($sumaCantidadesRelInsertPorAutor/$numeroAutores)*(1557000-$id_autor))/$numeroRelLeer)*(($sumaTiemposBloque/$numeroBloquesTotal)+$minutosDormir))/60)/24)." dias.\n\n";
					
					print "Durmiendo.\n"; 
					print "Comprobar temperatura de la CPU.\n\n";			
					
					
					$numeroDescansos++;
					if ($numeroDescansos==40){
			
						$numeroDescansos=0;
						$cadenaTiemposBloque="";
					}
				
					
					
					print "Comprobar temperatura de la CPU.\n\n";	
					
					
					($secAux,$minAux,$hourAux,$mdayAux,$monAux,$yearAux,$wdayAux,$ydayAux,$isdstAux) = localtime(time);			
					
					print "Tiempo durmiendo: ".(($secAux+($minAux*60)+($hourAux*60*60))-($secAux2+($minAux2*60)+($hourAux2*60*60)))." segundos\n\n";
					
				}
					
					
					
					
					
				# }
				
			}
		}
	}


	print "\n".$num_rel_insertadas." Nuevas Relaciones Agregadas \n";
}

##########################################################################################################
## 												Main 													##
##########################################################################################################


my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time);
print  "########################################\n";
printf "                     Hora de Inicio: %02d:%02d:%02d %02d-%02d-%4d\n",$hour,$min,$sec,$mday,$mon+1,$year+1900;
print  "########################################\n";

loadTableRelationship($conexion);

my ($sec2,$min2,$hour2,$mday2,$mon2,$year2,$wday2,$yday2,$isdst2) = localtime(time);
print  "#######################################\n";
printf "  Hora de Inicio: %02d:%02d:%02d %02d-%02d-%4d\n",$hour,$min,$sec,$mday,$mon+1,$year+1900;
printf "   Hora de Fin: %02d:%02d:%02d %02d-%02d-%4d\n",$hour2,$min2,$sec2,$mday2,$mon2+1,$year2+1900;
print  "#######################################\n";
