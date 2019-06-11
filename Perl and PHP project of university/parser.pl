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
use XML::Parser;
use HTML::Entities;
use DBI;


use warnings;


##########################################################################################################
## 									         Variables							    					##
##########################################################################################################

my $xmlfile = "dblp.xml";
#my $xmlfile = "XmlDePrueba.xml";

die "El archivo \"$xmlfile\" no existe" unless -f $xmlfile;

my %datos_pub;		# Lista asociativa (hash) donde el parser guardará los datos de la publicación que haya encontrado hasta que termine de analizarla por completo
my %publicaciones;	# Una lista asociativa (hash) donde se guardaran los tipos de publicacion y sus números de identificación. Ej: %publicaciones=('article' => 1, 'inproceedings' => 2)


my @autor_list;	#Lista donde el parser guardará todos los autores de la publicación que haya encontrado en el xml mientras busca otros elementos de dicha publicación. Cuando termine de analizar la publicación insertará todos su autores, que están guardados en esta lista, a la vez en la tabla de base de datos correspondiente.
my @editor_list;	#Lista donde el parser guardará todos los editores de la publicación que haya encontrado en el xml mientras busca otros elementos de dicha publicación. Cuando termine de analizar la publicación insertará todos su editores, que están guardados en esta lista, a la vez en la tabla de base de datos correspondiente.


my $num_pub_leidas = 0;	#Número de publicaciones leídas
my $tag = "";	#Variable donde se guardará la etiqueta encontrada, no corresponiente con la de una publicación, para saber más adelante si el evento char (función characterData) se produce más de una vez para una misma etiqueta contenida en una misma publicación
my $sw_lista = 0;
my $sw_fin_elemento = 1;


my $database = "db_dblp";
my $host = "localhost";
my $user = "root";
my $password = "12369";

my $conexion = DBI->connect("dbi:mysql:database=$database; host=$host", $user, $password) or die "No se pudo conectar con la base de datos: $!\n";

my $query_handle = $conexion->prepare("SET NAMES 'utf8'"); 
$query_handle->execute();

my $parser = new XML::Parser;




my $numeroPubLeer=50000; 	

# my $minutosDormir=0.25; 
my $minutosDormir=2; 

my ($secAux,$minAux,$hourAux,$mdayAux,$monAux,$yearAux,$wdayAux,$ydayAux,$isdstAux) = localtime(time);

my ($secAux3,$minAux3,$hourAux3,$mdayAux3,$monAux3,$yearAux3,$wdayAux3,$ydayAux3,$isdstAux3) = localtime(time);


##########################################################################################################
## 											 Funciones													##
##########################################################################################################

sub startElement {
    
	my( $parseinst, $element, %attrs ) = @_;

	if (exists($attrs{"key"})) {  # Si el elemento corresponde con el de una publicacion entonces
		
		$datos_pub{"tipo"} = $publicaciones{$element};
		$datos_pub{"key"} = $attrs{'key'};
		
	}
	else {
		
		$tag = $element; # Guardamos el nombre de la etiqueta para saber más adelante si el evento char (función characterData) se produce más de una vez para una misma etiqueta contenida en una misma publicación
	}
	
	
 }

 

sub addListData {
	
	my( $list, $data ) = @_;

	my $old_data = "";
	my $new_data = "";

	SWITCH: {

		if($list == 1){
			$old_data = pop(@autor_list) unless ((scalar(@autor_list) == 0) || $sw_fin_elemento );
			$new_data = $old_data.$data;
			push(@autor_list,$new_data);
			if($sw_fin_elemento) { $sw_fin_elemento = 0; }
			last SWITCH;
		}

		if($list == 2){
			$old_data = pop(@editor_list) unless ((scalar(@editor_list) == 0) || $sw_fin_elemento );
			$new_data = $old_data.$data;
			push(@editor_list,$new_data);
			if($sw_fin_elemento) { $sw_fin_elemento = 0; }
			last SWITCH;
		}
	}
}

 
sub characterData {
	
	my( $parseinst, $data ) = @_;

	SWITCH: {


		if ($tag eq "author") {

			if($sw_lista){
				addListData(1,$data);
				$sw_lista = 0;
			}else{

				if($sw_fin_elemento){
					push(@autor_list, $data);
					$sw_fin_elemento = 0;
				}else{
					addListData(1,$data);
				}

			}
			last SWITCH;
		}

		if ($tag eq "editor") {

			if($sw_lista){
				addListData(2,$data);
				$sw_lista = 0;
			}else{

				if($sw_fin_elemento){
					push(@editor_list, $data);
					$sw_fin_elemento = 0;
				}else{
					addListData(2,$data);
				}

			}
			last SWITCH;
		}


		if(exists($datos_pub{$tag}))
		{
			$datos_pub{$tag} .= $data;   #Si ya se han anadido datos para la etiqueta entonces concatenamos los nuevos datos encontrados a los anteriores
		}
		else {
			if ($tag eq "year") {
				$datos_pub{$tag} = $data;
			}
		}

	}
}
 
 

 
sub insertarPublicacion {
	
	my ( $db , %datos ) = @_;

	my $clave;

	$datos{"key_1"} = "";
	$datos{"key_2"} = "";
	$datos{"key_3"} = "";
	$datos{"key_4"} = "";
	
	my @arreglo = split("/",$datos{'key'});
	
	if (scalar(@arreglo)>0){
		$datos{"key_1"} = $arreglo[0];
	}
	if (scalar(@arreglo)>1){
		$datos{"key_2"} = $arreglo[1];
	}
	if (scalar(@arreglo)>2){
		$datos{"key_3"} = $arreglo[2];
	}

	
	
	foreach $clave (keys(%datos)) {
		$datos{$clave} =~ s/\'/\\\'/g;
	}

	
	if (!exists($datos{"year"})) { 
	$datos{"year"} = 0; 
	}
		
	
	my $insert = "INSERT INTO tb_dblp_datos_publicacion
	(dblp_key,dblp_key_1,dblp_key_2,dblp_key_3,dblp_key_4,id_tipo,year,tipo) 
	VALUES('$datos{'key'}','$datos{'key_1'}','$datos{'key_2'}','$datos{'key_3'}','$datos{'key_4'}',$datos{'tipo'},$datos{'year'},'');";

		
	$insert =~ s/\'NULL\'/NULL/g;

	$db->do($insert);

	return $db->{'mysql_insertid'};
} 



sub insertarAutores {

	my ( $id_pub , $db , @autores ) = @_;

	my $query;
	my $query_handle;

	for(my $i = 0, my $orden_autor = 0; $i < scalar(@autores); $i++, $orden_autor++){

		$autores[$i] =~ s/\'/\\\'/g;

		$query = "SELECT id_autor FROM tb_dblp_detalle_autor WHERE nombre = \'".$autores[$i]."\';";
		$query_handle = $db->prepare($query);
		$query_handle->execute();

		my $row = $query_handle->fetchrow_hashref();
		my $numRows = $query_handle->rows;
		

		if(!$numRows){
			my $aux = $autores[$i];
			$aux =~ s/\s/\//g;
		
			my @arreglo = split("/",$aux);
			my $nombrecorto = $arreglo[0];
		
			$db->do("INSERT INTO tb_dblp_detalle_autor (nombre, nombrecorto) VALUES (\'".$autores[$i]."\',\'".$nombrecorto."\');");
			my $id_autor = $db->{'mysql_insertid'};
			$db->do("INSERT INTO tb_dblp_autor (id_autor,id_publicacion,editor,autor_num) VALUES (".$id_autor.",".$id_pub.",0,".$orden_autor.");");
		}else{
			$db->do("INSERT INTO tb_dblp_autor (id_autor,id_publicacion,editor,autor_num) VALUES (".$row->{'id_autor'}.",".$id_pub.",0,".$orden_autor.");");
		}
	}
}



sub insertarEditores {
	
	my ( $id_pub , $db , @editores ) = @_;

	my $query;
	my $query_handle;

	for(my $i = 0, my $orden_autor = 0; $i < scalar(@editores); $i++, $orden_autor++){

		$editores[$i] =~ s/\'/\\\'/g;

		$query = "SELECT id_autor FROM tb_dblp_detalle_autor WHERE nombre = \'".$editores[$i]."\';";
		$query_handle = $db->prepare($query);
		$query_handle->execute();

		my $row = $query_handle->fetchrow_hashref();
		my $numRows = $query_handle->rows;

		
		if(!$numRows){
			my $aux = $editores[$i];
			$aux =~ s/\s/\//g;
		
			my @arreglo = split("/",$aux);
			my $nombrecorto = $arreglo[0];
		
			$db->do("INSERT INTO tb_dblp_detalle_autor (nombre, nombrecorto) VALUES (\'".$editores[$i]."\',\'".$nombrecorto."\');");
			my $id_autor = $db->{'mysql_insertid'};
			$db->do("INSERT INTO tb_dblp_autor (id_autor,id_publicacion,editor,autor_num) VALUES (".$id_autor.",".$id_pub.",1,".$orden_autor.");");
		}else{
			$db->do("INSERT INTO tb_dblp_autor (id_autor,id_publicacion,editor,autor_num) VALUES (".$row->{'id_autor'}.",".$id_pub.",1,".$orden_autor.");");
		}
	}
}



sub endElement {
	
	my( $parseinst, $element ) = @_;

	if (($element eq "article") || ($element eq "inproceedings") || ($element eq "proceedings") || ($element eq "book") || ($element eq "incollection") || ($element eq "phdthesis") || ($element eq "mastersthesis") || ($element eq "www")){

		
		my $id_pub = insertarPublicacion($conexion,%datos_pub);

		if (scalar(@autor_list) > 0) {
			insertarAutores($id_pub,$conexion,@autor_list);
		}

		if (scalar(@editor_list) > 0) {
			insertarEditores($id_pub,$conexion,@editor_list);
		}

				
		$num_pub_leidas++;		
		
		
		# Dormimos el proceso si se han leído un número determinado de publicaciones 	
		if ( $num_pub_leidas%$numeroPubLeer==0 && $num_pub_leidas>$numeroPubLeer-1){
		
			print "Se han leido un multiplo de ".$numeroPubLeer." publicaciones.\n\n"; 
		
			my ($secAux2,$minAux2,$hourAux2,$mdayAux2,$monAux2,$yearAux2,$wdayAux2,$ydayAux2,$isdstAux2) = localtime(time);
			
			print "Numero de publicaciones leidas en total: ".$num_pub_leidas."      (Se han leido en ".(($minAux2+($hourAux2*60))-($minAux3+($hourAux3*60)))." minutos)\n\n";
			print "Numero de publicaciones leidas en bloque-> ".$numeroPubLeer."      (Se han leido en ".($minAux2-$minAux)." minutos)\n\n";
			
			print "Durmiendo.\n"; 
			
			if ($minutosDormir<1) {
				sleep(2);
			}
			else {
				sleep($minutosDormir*60);
			}
			
			print "Comprobar temperatura de la CPU.\n\n";	
			
			($secAux,$minAux,$hourAux,$mdayAux,$monAux,$yearAux,$wdayAux,$ydayAux,$isdstAux) = localtime(time);			
			
		}
		
		
	

		undef %datos_pub;
		undef @autor_list;
		undef @editor_list;

	}else{

		if( ($element eq "author") || ($element eq "editor") ){
			$sw_fin_elemento = 1;
		}
	}

	$tag = "";
}



sub default {
	
	my( $parseinst, $data ) = @_;

    SWITCH: {

		if($data!~/&/) { 
			last SWITCH; 
		}

		if ($tag eq "author") {

			  $data = decode_entities($data);

			  addListData(1,$data);
			  $sw_lista = 1;
			  last SWITCH;
		}

		if ($tag eq "editor") {

			  $data = decode_entities($data);

			  addListData(2,$data);
			  $sw_lista = 1;
			  last SWITCH;
		}

		
		if ($tag eq "year") {
			$datos_pub{$tag} .= decode_entities($data);
		}

	}
}




sub obtenerListaTiposPublicacion {
	
	my( $db ) = @_;

	my %resultado;

	my $query = "SELECT id_tipo, descripcion_tipo FROM tb_dblp_detalle_tipo;";
	my $query_handle = $db->prepare($query);
	$query_handle->execute();

	while(my $row = $query_handle->fetchrow_hashref()) {
		$resultado{$row->{'descripcion_tipo'}} = $row->{'id_tipo'};
	}

	$query_handle->finish;

	return %resultado;
}




##########################################################################################################
## 												Main 													##
##########################################################################################################

$parser->setHandlers(   Start => \&startElement,
                          End => \&endElement,
                         Char => \&characterData,
                      Default => \&default);

					  
my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time);
print  "########################################\n";
printf "                     Hora de Inicio: %02d:%02d:%02d %02d-%02d-%4d\n",$hour,$min,$sec,$mday,$mon+1,$year+1900;
print  "########################################\n";


%publicaciones = obtenerListaTiposPublicacion($conexion);


$parser->parsefile($xmlfile);


print "\n Cantidad de publicaciones = ".$num_pub_leidas."\n";



$conexion->disconnect();


($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time);
print  "########################################\n";
printf "                        Hora de Fin: %02d:%02d:%02d %02d-%02d-%4d\n",$hour,$min,$sec,$mday,$mon+1,$year+1900;
print  "########################################\n";