#!c:\strawberry\perl\bin\perl.exe -w
use encoding 'utf8';
use strict;
use DBI;


use warnings;





my $num_rel_insertadas=0; ########################################################
# my $numeroRelLeer=100000; ########################################################	
my $numeroRelLeer=25000; ########################################################

# my $minutosDormir=0.25; ########################################################
my $minutosDormir=1; ########################################################

my ($secAux,$minAux,$hourAux,$mdayAux,$monAux,$yearAux,$wdayAux,$ydayAux,$isdstAux) = localtime(time);########################################################

my ($secAux3,$minAux3,$hourAux3,$mdayAux3,$monAux3,$yearAux3,$wdayAux3,$ydayAux3,$isdstAux3) = localtime(time);########################################################






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
	$min_id = 1; ########################################################
	
	$query = "SELECT MAX(id_autor) as autor_id from tb_dblp_detalle_autor";
	$query_handle = $db->prepare($query);
	$query_handle->execute();
	$row = $query_handle->fetchrow_hashref();

	my $max_id = $row->{'autor_id'};

	
	
	my $count_global = 0;
	my $id_autor;

	# for(my $i = $min_id; ($i<= $max_id) ; $i++){

		# $query = "SELECT B.id_autor as coautor_id, B.id_publicacion
				  # FROM tb_dblp_autor as A, tb_dblp_autor as B
				  # WHERE A.id_autor = $i AND A.id_publicacion = B.id_publicacion AND B.id_autor != $i";
				  # ORDER BY B.id_autor";
		
		
		my ($secAux,$minAux,$hourAux,$mdayAux,$monAux,$yearAux,$wdayAux,$ydayAux,$isdstAux) = localtime(time);
		for (my $j=1; $j<=10000; $j++){
		
		my $i = $min_id;
		$query = "SELECT id_autor as coautor_id, id_publicacion
				  FROM tb_dblp_autor 
				  WHERE id_autor > $i AND editor = 0 AND id_publicacion IN (
				  SELECT id_publicacion FROM tb_dblp_autor WHERE id_autor = $i)";
				  # ORDER BY B.id_autor";
				  
		}
		my ($secAux2,$minAux2,$hourAux2,$mdayAu2,$monAux2,$yearAux2,$wdayAux2,$ydayAux2,$isdstAux2) = localtime(time);
		print "Tiempo en la linea 84: ".($secAux2-$secAux)." segundos\n";
		
		($secAux,$minAux,$hourAux,$mdayAux,$monAux,$yearAux,$wdayAux,$ydayAux,$isdstAux) = localtime(time);
		for (my $j=1; $j<=10000; $j++){	
		
		$query_handle = $db->prepare($query);
		
		}
		($secAux2,$minAux2,$hourAux2,$mdayAu2,$monAux2,$yearAux2,$wdayAux2,$ydayAux2,$isdstAux2) = localtime(time);
		print "Tiempo en la linea 98: ".($secAux2-$secAux)." segundos\n";	
			

		($secAux,$minAux,$hourAux,$mdayAux,$monAux,$yearAux,$wdayAux,$ydayAux,$isdstAux) = localtime(time);
		for (my $j=1; $j<=1; $j++){
		
		 $query_handle->execute();

		}
		($secAux2,$minAux2,$hourAux2,$mdayAu2,$monAux2,$yearAux2,$wdayAux2,$ydayAux2,$isdstAux2) = localtime(time);
		print "Tiempo en la linea 108: ".($secAux2-$secAux)." segundos\n";	
			
		

		# my $query_parent = "SELECT parent FROM tb_dblp_detalle_autor WHERE id_autor = $i";
		# my $query_handle_parent = $db->prepare($query_parent);
		# $query_handle_parent->execute();
		
		# my $id_parent = $query_handle_parent->fetchrow_hashref();
		
		# if($id_parent->{'parent'} == 0){
			# $id_autor = $i;
		# }else{
			# $id_autor = $id_parent->{'parent'};
		# }		

		$id_autor = 1;
		
		# print "ID Autor: $id_autor\n";

		# if($query_handle->rows > 0){
			# while($row = $query_handle->fetchrow_hashref()) {

				# my $query_exist = "SELECT id_autor, id_coautor, id_publicacion FROM tb_dblp_relaciones 
									# WHERE id_autor = $id_autor AND id_coautor = $row->{'coautor_id'} 
									# AND id_publicacion = $row->{'id_publicacion'};";
				# my $query_handle_exist = $db->prepare($query_exist);
				# $query_handle_exist->execute();

				# if($query_handle_exist->rows == 0){
				
		($secAux,$minAux,$hourAux,$mdayAux,$monAux,$yearAux,$wdayAux,$ydayAux,$isdstAux) = localtime(time);
		for (my $j=1; $j<=20000; $j++){				
				
				$db->do("INSERT INTO tb_dblp_relaciones (id_autor, id_coautor, id_publicacion) VALUES (1, 48, 103979)");
				# $db->do("INSERT INTO tb_dblp_relaciones (id_autor, id_coautor) VALUES (1, 48)");
				# print "Insertado: $id_autor -> $row->{'coautor_id'}\n";
				# $count_global++;
				# $num_rel_insertadas++;########################################################
				# }
				
		}
		($secAux2,$minAux2,$hourAux2,$mdayAu2,$monAux2,$yearAux2,$wdayAux2,$ydayAux2,$isdstAux2) = localtime(time);
		print "Tiempo en la linea 146: ".($secAux2-$secAux)." segundos\n";				
						

						

					
						
				# if ( $num_rel_insertadas%$numeroRelLeer==0 && $num_rel_insertadas>$numeroRelLeer-1){########################################################
				
					# print "Se han insertado un multiplo de ".$numeroRelLeer." relaciones.\n\n"; ########################################################
				
					# my ($secAux2,$minAux2,$hourAux2,$mdayAux2,$monAux2,$yearAux2,$wdayAux2,$ydayAux2,$isdstAux2) = localtime(time);########################################################
					
					# print "Id de autor actual: ".$id_autor."\n\n";########################################################
					# print "Numero de relaciones insertadas en total: ".$num_rel_insertadas."      (Se han insertado en ".(($minAux2+($hourAux2*60))-($minAux3+($hourAux3*60)))." minutos)\n\n";########################################################
					# print "Numero de publicaciones insertadas en bloque-> ".$numeroRelLeer."      (Se han insertado en ".($minAux2-$minAux)." minutos)\n\n";########################################################
					
					# print "Durmiendo.\n"; ########################################################
					# print "Comprobar temperatura de la CPU.\n\n";########################################################			
					
					# if ($minutosDormir<1) {
						# sleep(30);########################################################
					# }
					# else {
						# sleep($minutosDormir*60);
					# }
					
					# print "Comprobar temperatura de la CPU.\n\n";########################################################	
					
					# print "Ingresa el numero de publicaciones que quieres leer antes de dormir la proxima vez: "; ########################################################
					# $numeroPubLeer = <STDIN>; ########################################################
					# print "Ingresa los minutos que quieres dormir la proxima vez que se duerma: "; ########################################################
					# $minutosDormir = <STDIN>; ########################################################	

					# ($secAux,$minAux,$hourAux,$mdayAux,$monAux,$yearAux,$wdayAux,$ydayAux,$isdstAux) = localtime(time);########################################################			
					
				# }########################################################
						
				
				
				
				
				
			# }
		# }
	# }

	# Me aseguro que las relaciones sean bidireccionales
	# $query = "SELECT complete_relationship();";
	# $query_handle = $db->prepare($query);
	# $query_handle->execute();

	# $query_handle->finish;

	print "\n".$count_global." Nuevas Relaciones Agregadas \n";
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
