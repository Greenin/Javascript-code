#!c:\strawberry\perl\bin\perl.exe -w

use strict;

use DBI;

use warnings;


use Queue::Base; #Para la cola de prioridad que utilizaremos en el algoritmo de Dijkstra



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
my $MAX_INTEGER = 2147483648;


my @distancias;
my @padres;

my $id_autor;
my $queue; 

my $row;
my $coautor = 0;
my $sumaDistancia = 0;

my @adyacentes;


my @pila;
my $nodoCamino;
my $i;
my $camino;
my $distancia;


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



# Se busca el id autor máximo que hay en tabla "tb_dblp_detalle_autor" para la inicialización del array de distancias y de padres del algoritmo de Dijkstra
$query = "SELECT MAX(id_autor) as autor_id from tb_dblp_detalle_autor";
$query_handle = $conexion->prepare($query);
$query_handle->execute();
$row = $query_handle->fetchrow_hashref();
$id_autor_max = $row->{'autor_id'};



# Entrada de datos
$autorOrigen=1;
$autorDestino=1;

while ($autorOrigen == $autorDestino) {
	print "Id autor origen (numero entre 1 y $id_autor_max): ";
	$autorOrigen=<STDIN>;
	chop($autorOrigen); 
	
	print "Id autor destino (numero entre 1 y $id_autor_max): ";
	$autorDestino=<STDIN>;
	chop($autorDestino);
	
	if ($autorOrigen == $autorDestino) {
		print "El id autor origen no puede ser igual que id autor destino\n";
	}
}



# Comienzo del algoritmo de Dijkstra
$terminarBusqueda=0;

for($id_autor = 1; $id_autor <= $id_autor_max; $id_autor++){	
	$distancias[$id_autor] = $MAX_INTEGER;
	$padres[$id_autor] = 0;	
}


$distancias[$autorOrigen] = 0;

$queue = new Queue::Base;
# Se introduce el primer autor en la cola de prioridad
$queue->add($autorOrigen);


while (!$queue->empty && !$terminarBusqueda) {

	# Se saca el primero de la cola de prioridad
	$id_autor = $queue->remove;
		
	# A continuación buscamos los coautores de autor actual
	undef @adyacentes;
 		
	$query = "SELECT id_coautor FROM tb_dblp_rel where id_autor=$id_autor;";
	$query_handle = $conexion->prepare($query);
	$query_handle->execute();
		
	
	while($row = $query_handle->fetchrow_hashref()) {	
		push(@adyacentes,$row->{'id_coautor'});
	}
	
	$query = "SELECT id_autor FROM tb_dblp_rel where id_coautor=$id_autor;";
	$query_handle = $conexion->prepare($query);
	$query_handle->execute();
	
	while($row = $query_handle->fetchrow_hashref()) {	
		push(@adyacentes,$row->{'id_autor'});
	}
	
	
	while(scalar(@adyacentes)>0 && !$terminarBusqueda) {

			$coautor = pop(@adyacentes);
			if ($coautor == $autorDestino){  #Dado que la distancia entre autor y coautor es siempre 1 y dado que tenemos el adyacente mínimo entonces sabemos que si encontramos el autor destino habremos encontrado el camino mínimo
				$terminarBusqueda=1;
			}
					
			$sumaDistancia = $distancias[$id_autor]+1;
			
			if ($distancias[$coautor] > $sumaDistancia) {
				
				$distancias[$coautor] = $sumaDistancia;
				$padres[$coautor] = $id_autor;
				$queue->add($coautor); # Se introduce al final de la cola el coautor

			}

	}
	

}


# A continuación se muestra el camino si ha encontrado
if ($padres[$autorDestino] != 0) {
	

	undef @pila; # Haremos uso de una pila para dar la vuelta al camino que nos traza el array de padres

	push(@pila, $autorDestino);

	$nodoCamino = $autorDestino;

	while ($padres[$nodoCamino]!=$autorOrigen){
		$nodoCamino=$padres[$nodoCamino];
		push(@pila,$nodoCamino)
	}

	push(@pila,$autorOrigen);


	$camino ="";
	$distancia = scalar(@pila)-1;

	while (scalar(@pila)>0) {
		$nodoCamino = pop(@pila);
		$camino .= $nodoCamino.", ";	
	}

	chop($camino);
	chop($camino);

	print "Camino de $autorOrigen a $autorDestino: $camino\n";
	print "Distancia: $distancia\n";
	
}
else {
	print "No se ha encontrado camino entre el autor $autorOrigen y el autor $autorDestino\n";
}




($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time);
print  "########################################\n";
printf "                        Hora de Fin: %02d:%02d:%02d %02d-%02d-%4d\n",$hour,$min,$sec,$mday,$mon+1,$year+1900;
print  "########################################\n";