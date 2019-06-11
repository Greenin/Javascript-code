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

die "El archivo \"$xmlfile\" no existe" unless -f $xmlfile;

my %datos_pub;
my %publicaciones;


my @autor_list;
my @editor_list;
my @citas_list;
my @label_list;

my $cont = 0;
my $cont_www = 0;
my $clave;
my $i;
my $tag = "";
my $sw_lista = 0;
my $sw_fin_elemento = 1;

my $new_publication = 0;

my $host = "localhost";
my $database = "db_dblp";
my $user = "root";
my $password = "JaMa1522";

my $conexion = DBI->connect("dbi:mysql:database=$database; host=$host", $user, $password) or die "No Se pudo conectar con la Base de Datos: $!\n";
my $query_handle = $conexion->prepare("SET NAMES 'utf8'"); $query_handle->execute();

my $parser = new XML::Parser;

##########################################################################################################
## 											 Funciones													##
##########################################################################################################

sub startElement {
    my( $parseinst, $element, %attrs ) = @_;

		SWITCH: {

				if ($element eq "dblp") { last SWITCH; }

				if ($element eq "article") {
					$datos_pub{"tipo"} = $publicaciones{$element};
					$datos_pub{"key"} = $attrs{'key'};
					if (exists($attrs{'reviewid'})){ $datos_pub{"reviewid"} = $attrs{'reviewid'} };
					if (exists($attrs{'rating'})){ $datos_pub{"rating"} = $attrs{'rating'} };
					$datos_pub{"mdate"} = $attrs{'mdate'};

					$new_publication = keyExist($conexion,$attrs{'key'});

					last SWITCH;
				}

				if (($element eq "inproceedings") || ($element eq "proceedings") || ($element eq "book") || ($element eq "incollection") || ($element eq "phdthesis") || ($element eq "mastersthesis") || ($element eq "www")){
					$datos_pub{"tipo"} =  $publicaciones{$element};
					$datos_pub{"key"} = $attrs{'key'};
					$datos_pub{"mdate"} = $attrs{'mdate'};

					$new_publication = keyExist($conexion,$attrs{'key'});

					last SWITCH;
				}

				if (($element eq "publisher") && (!$new_publication)) {
					if (exists($attrs{'href'})){ $datos_pub{"PUBHREF"} = $attrs{'href'} };
					$tag = $element;
					last SWITCH;
				}

				if (($element eq "series") && (!$new_publication)) {
					if (exists($attrs{'href'})){ $datos_pub{"SERHREF"} = $attrs{'href'} };
					$tag = $element;
					last SWITCH;
				}

				if (($element eq "cite") && (!$new_publication)) {
					if (exists($attrs{'label'})){ push(@label_list, $attrs{'label'}); }else{ push(@label_list,"..."); }
					$tag = $element;
					last SWITCH;
				}

				$tag = $element;
        }
}

sub endElement {
      my( $parseinst, $element ) = @_;

        if (($element eq "article") || ($element eq "inproceedings") || ($element eq "proceedings") || ($element eq "book") || ($element eq "incollection") || ($element eq "phdthesis") || ($element eq "mastersthesis") || ($element eq "www")){

			if( !$new_publication ){

				#if (scalar(@autor_list) > 0) {
				#	for($i=0; $i < scalar(@autor_list); $i++){
				#		print "AUTHOR = ".$autor_list[$i]."\n";
				#	}
				#}

				#if (scalar(@editor_list) > 0) {
				#	for($i=0; $i < scalar(@editor_list); $i++){
				#		print "EDITOR = ".$editor_list[$i]."\n";
				#	}
				#}

				#foreach $clave (keys(%datos_pub)) {
				#	print uc($clave)." = ".$datos_pub{$clave}."\n";
				#}


				#if (scalar(@citas_list) > 0) {
				#	for($i=0; $i < scalar(@citas_list); $i++){
				#		if($citas_list[$i] ne "..."){
				#			print "CITE = ".$citas_list[$i]." ";
				#
				#			if (scalar(@label_list) > 0) {
				#				print "LABEL = ".$label_list[$i]."\n";
				#			}
				#		}
				#	}
				#}

				if (($element eq "www") && (exists($datos_pub{"title"})) && ($datos_pub{"title"} eq "Home Page")){

					if(!exists($datos_pub{"url"})){
						actualizarDatosAutor($conexion,"NULL",@autor_list);
					}else{
						actualizarDatosAutor($conexion,$datos_pub{"url"},@autor_list);
					}
					print "A -> ".$cont_www++."\n";

				}else{

					my $id_pub = insertarPublicacion($conexion,%datos_pub);

					if (scalar(@autor_list) > 0) {
						insertarAutores($id_pub,$conexion,@autor_list);
					}

					if (scalar(@editor_list) > 0) {
						insertarEditores($id_pub,$conexion,@editor_list);
					}

					my $query;
					my $query_handle;

					if (scalar(@citas_list) > 0) {
						for($i=0; $i < scalar(@citas_list); $i++){
							if($citas_list[$i] ne "..."){

								$citas_list[$i] =~ s/\'/\\\'/g;

								$query = "SELECT id_cita FROM tb_dblp_cita WHERE id_publicacion = ".$id_pub." AND id_cita = \'".$citas_list[$i]."\';";
								$query_handle = $conexion->prepare($query);
								$query_handle->execute();

								my $numRows = $query_handle->rows;

								if($numRows == 0){
									if ( (scalar(@label_list) > 0) && (defined($label_list[$i])) && ($label_list[$i] ne "...") ){
										$label_list[$i] =~ s/\'/\\\'/g;
										$conexion->do("INSERT INTO tb_dblp_cita (id_cita,id_publicacion,label) VALUES (\'".$citas_list[$i]."\',".$id_pub.",\'".$label_list[$i]."\');");
									}else{
										$conexion->do("INSERT INTO tb_dblp_cita (id_cita,id_publicacion) VALUES (\'".$citas_list[$i]."\',".$id_pub.");");
									}
								}
							}
						}
					}

					#print "\n########################################\n";
					print "P -> ".$cont++."\n";
				}
			}

			undef %datos_pub;
			undef @label_list;
			undef @autor_list;
			undef @editor_list;
			undef @citas_list;

			$new_publication = 0;

		}else{

			if( ($element eq "author") || ($element eq "editor") ){
				$sw_fin_elemento = 1;
			}
		}

		$tag = "";
}

sub characterData {
	my( $parseinst, $data ) = @_;

	if( !$new_publication ){

		SWITCH: {

			if ($tag eq "") {
				if (($data ne "") && ($data ne "\n")) {
					$datos_pub{"title"} .= " ".$data;
				}
				last SWITCH;
			}

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

			if ($tag eq "cite") {
				push(@citas_list, $data);
				last SWITCH;
			}

			if ( ($tag eq "sup") || ($tag eq "sub") || ($tag eq "i") || ($tag eq "tt") ) {

				if(exists($datos_pub{"title"})) {
					$datos_pub{"title"} .= " ".$data;
				}else{
					$datos_pub{"title"} = $data;
				}
				last SWITCH;
			}

			if(exists($datos_pub{$tag})) {
				$datos_pub{$tag} .= $data;
			}else{
				$datos_pub{$tag} = $data;
			}

		}
	}
}

sub default {
	my( $parseinst, $data ) = @_;

    if( !$new_publication ){

		SWITCH: {

			if($data!~/&/) { last SWITCH; }

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

			$datos_pub{$tag} .= decode_entities($data);

		}
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

sub getPublicationList {
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

sub keyExist{
	my ( $db , $key ) = @_;

	my $query;
	my $query_handle;

	$query = "SELECT dblp_key FROM tb_dblp_datos_publicacion WHERE dblp_key = \'".$key."\';";
	$query_handle = $db->prepare($query);
	$query_handle->execute();

	my $row = $query_handle->fetchrow_hashref();
	my $numRows = $query_handle->rows;

	if($numRows){
		return 1;
	}else{
		return 0;
	}
}

sub insertarPublicacion {
	my ( $db , %datos ) = @_;

	my $clave;

	foreach $clave (keys(%datos)) {
		$datos{$clave} =~ s/\'/\\\'/g;
	}

	if (!exists($datos{"reviewid"})) { $datos{"reviewid"} = "NULL"; }
    if (!exists($datos{"rating"})) 	 { $datos{"rating"} = "NULL"; }
	if (!exists($datos{"title"})) 	 { $datos{"title"} = "NULL"; } else { $datos{"title"} =~ s/\\\\\'/\\\'/g; }
	if (!exists($datos{"booktitle"})){ $datos{"booktitle"} = "NULL"; }
	if (!exists($datos{"pages"})) 	 { $datos{"pages"} = "NULL"; }
	if (!exists($datos{"year"})) 	 { $datos{"year"} = 0; }
	if (!exists($datos{"address"}))  { $datos{"address"} = "NULL"; }
	if (!exists($datos{"journal"}))  { $datos{"journal"} = "NULL"; }
	if (!exists($datos{"volume"})) 	 { $datos{"volume"} = "NULL"; }
	if (!exists($datos{"number"})) 	 { $datos{"number"} = "NULL"; }
	if (!exists($datos{"month"})) 	 { $datos{"month"} = "NULL"; }
	if (!exists($datos{"url"})) 	 { $datos{"url"} = "NULL"; }
	if (!exists($datos{"ee"})) 		 { $datos{"ee"} = "NULL"; }
	if (!exists($datos{"cdrom"})) 	 { $datos{"cdrom"} = "NULL"; }
	if (!exists($datos{"note"})) 	 { $datos{"note"} = "NULL"; }
	if (!exists($datos{"crossref"})) { $datos{"crossref"} = "NULL"; }
	if (!exists($datos{"isbn"})) 	 { $datos{"isbn"} = "NULL"; }
	if (!exists($datos{"school"})) 	 { $datos{"school"} = "NULL"; }
	if (!exists($datos{"chapter"}))  { $datos{"chapter"} = 0; }
	if (!exists($datos{"publisher"})){ $datos{"publisher"} = "NULL"; }
	if (!exists($datos{"pubhref"}))  { $datos{"pubhref"} = "NULL"; }
	if (!exists($datos{"series"})) 	 { $datos{"series"} = "NULL"; }
	if (!exists($datos{"serhref"}))  { $datos{"serhref"} = "NULL"; }

	my $query = "INSERT INTO tb_dblp_datos_publicacion
	(dblp_key,title,booktitle,series,series_href,year,id_tipo,journal,cdrom,volumen,number,month,pages,ee,url,publisher,publisher_href,isbn,crossref,mdate,address,reviewid,rating,notas,school,chapter) VALUES
	('$datos{'key'}','$datos{'title'}','$datos{'booktitle'}','$datos{'series'}','$datos{'serhref'}',$datos{'year'},$datos{'tipo'},'$datos{'journal'}','$datos{'cdrom'}','$datos{'volume'}','$datos{'number'}',
	'$datos{'month'}','$datos{'pages'}','$datos{'ee'}','$datos{'url'}','$datos{'publisher'}','$datos{'pubhref'}','$datos{'isbn'}','$datos{'crossref'}','$datos{'mdate'}','$datos{'address'}','$datos{'reviewid'}',
	'$datos{'rating'}','$datos{'note'}','$datos{'school'}',$datos{'chapter'});";

	$query =~ s/\'NULL\'/NULL/g;

	$db->do($query);

	return $db->{'mysql_insertid'};
}

sub insertarAutores {
	my ( $id_pub , $db , @autores ) = @_;

	my $query;
	my $query_handle;

	for(my $i = 0, my $cont = 0; $i < scalar(@autores); $i++, $cont++){

		$autores[$i] =~ s/\'/\\\'/g;

		$query = "SELECT id_autor FROM tb_dblp_detalle_autor WHERE nombre = \'".$autores[$i]."\';";
		$query_handle = $db->prepare($query);
		$query_handle->execute();

		my $row = $query_handle->fetchrow_hashref();
		my $numRows = $query_handle->rows;

		if(!$numRows){
			$db->do("INSERT INTO tb_dblp_detalle_autor (nombre) VALUES (\'".$autores[$i]."\');");
			my $id_autor = $db->{'mysql_insertid'};
			$db->do("INSERT INTO tb_dblp_autor (id_autor,id_publicacion,editor,autor_num) VALUES (".$id_autor.",".$id_pub.",0,".$cont.");");
		}else{
			$db->do("INSERT INTO tb_dblp_autor (id_autor,id_publicacion,editor,autor_num) VALUES (".$row->{'id_autor'}.",".$id_pub.",0,".$cont.");");
		}
	}
}

sub actualizarDatosAutor {
	my ( $db , $url , @autores ) = @_;

	my $query;
	my $query_handle;
	my $id_autor;

	for(my $i = 0; $i < scalar(@autores); $i++){

		$autores[$i] =~ s/\'/\\\'/g;

		if($i == 0){

			$query = "SELECT id_autor FROM tb_dblp_detalle_autor WHERE nombre = \'".$autores[$i]."\';";
			$query_handle = $db->prepare($query);
			$query_handle->execute();

			my $row = $query_handle->fetchrow_hashref();
			my $numRows = $query_handle->rows;

			if(!$numRows){
				if($url eq "NULL"){
					$db->do("INSERT INTO tb_dblp_detalle_autor (nombre) VALUES (\'".$autores[$i]."\');");
				}else{
					$db->do("INSERT INTO tb_dblp_detalle_autor (nombre,paginaweb) VALUES (\'".$autores[$i]."\',\'".$url."\');");
				}
				$id_autor = $db->{'mysql_insertid'};
			}else{
				if($url ne "NULL"){
					$db->do("UPDATE tb_dblp_detalle_autor SET paginaweb = \'".$url."\' WHERE id_autor = ".$row->{'id_autor'}.";");
				}
				$id_autor = $row->{'id_autor'};
			}

		}else{

			$query = "SELECT id_autor FROM tb_dblp_detalle_autor WHERE nombre = \'".$autores[$i]."\';";
			$query_handle = $db->prepare($query);
			$query_handle->execute();

			my $row = $query_handle->fetchrow_hashref();
			my $numRows = $query_handle->rows;

			if(!$numRows){
				if($url eq "NULL"){
					$db->do("INSERT INTO tb_dblp_detalle_autor (nombre,parent) VALUES (\'".$autores[$i]."\',".$id_autor.");");
				}else{
					$db->do("INSERT INTO tb_dblp_detalle_autor (nombre,paginaweb,parent) VALUES (\'".$autores[$i]."\',\'".$url."\',".$id_autor.");");
				}
			}else{
				if($url eq "NULL"){
					$db->do("UPDATE tb_dblp_detalle_autor SET parent = ".$id_autor." WHERE id_autor = ".$row->{'id_autor'}.";");
				}else{
					$db->do("UPDATE tb_dblp_detalle_autor SET paginaweb = \'".$url."\', parent = ".$id_autor." WHERE id_autor = ".$row->{'id_autor'}.";");
				}
				#~ $db->do("UPDATE tb_dblp_autor SET id_autor = ".$id_autor." WHERE id_autor = ".$row->{'id_autor'}.";");
			}

		}
	}
}

sub insertarEditores {
	my ( $id_pub , $db , @editores ) = @_;

	my $query;
	my $query_handle;

	for(my $i = 0, my $cont = 0; $i < scalar(@editores); $i++, $cont++){

		$editores[$i] =~ s/\'/\\\'/g;

		$query = "SELECT id_autor FROM tb_dblp_detalle_autor WHERE nombre = \'".$editores[$i]."\';";
		$query_handle = $db->prepare($query);
		$query_handle->execute();

		my $row = $query_handle->fetchrow_hashref();
		my $numRows = $query_handle->rows;

		if(!$numRows){
			$db->do("INSERT INTO tb_dblp_detalle_autor (nombre) VALUES (\'".$editores[$i]."\');");
			my $id_autor = $db->{'mysql_insertid'};
			$db->do("INSERT INTO tb_dblp_autor (id_autor,id_publicacion,editor,autor_num) VALUES (".$id_autor.",".$id_pub.",1,".$cont.");");
		}else{
			$db->do("INSERT INTO tb_dblp_autor (id_autor,id_publicacion,editor,autor_num) VALUES (".$row->{'id_autor'}.",".$id_pub.",1,".$cont.");");
		}
	}
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

%publicaciones = getPublicationList($conexion);

$parser->parsefile($xmlfile);

print "\n Cantidad de elementos = ".$cont."\n";
print "\n Cantidad de Autores = ".$cont_www."\n";

$conexion->disconnect();

($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time);
print  "########################################\n";
printf "                        Hora de Fin: %02d:%02d:%02d %02d-%02d-%4d\n",$hour,$min,$sec,$mday,$mon+1,$year+1900;
print  "########################################\n";
