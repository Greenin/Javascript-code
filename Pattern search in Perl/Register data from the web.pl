# Register data from the web

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
# use HTML::Entities;
use DBI;
use LWP::UserAgent;
use HTTP::Request;

# use lib('C:/Strawberry/perl/site/lib'); 
# use Win32::Sound;

use warnings;


##########################################################################################################
## 									         Variables							    					##
##########################################################################################################


my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) ;

my $database;
my $host;
my $user;
my $password;
my $connection;
my $query_handle;
my $row;
my $delete;


my $time_serie_file_name;
my $time_serie_actual;
my $url;
my $sucess;
my $attempt_num;
my $agent;
my $header;
my $request;
my $response;
my $content;
my @arreglo;
my $i;
my $session_data_beginning_row;
my $time_serie_name;
my @arreglo2;
my $datestring;
my @arreglo3;
my @arreglo4;
my $variation;
my $percent;
my $session_beginning;
my $session_final;
my $session_minutes_num;
my $query;
my $rows_number;
my $holiday;
my $save_timestamp;
my $is_time;

# sub insertarAutores {

# }


##########################################################################################################
## 												Main 													##
##########################################################################################################

			  
($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time);
print  "\n\n\n########################################\n";
printf "                     Hora de Inicio: %02d:%02d:%02d %02d-%02d-%4d\n",$hour,$min,$sec,$mday,$mon+1,$year+1900;
print  "########################################\n";


$database = "time_serie_db";
$host = "localhost";
$user = "root";
#$password = "12369";

$connection = DBI->connect("dbi:mysql:database=$database; host=$host", $user, $password) or die "Could not connect to the database: $!\n";

$query_handle = $connection->prepare("SET NAMES 'utf8'"); 
$query_handle->execute();


$time_serie_file_name = "E:/Binary_time_series.txt";


$is_time = 1;

while (1)
{


	if ($is_time)
	{
	
	$is_time = 0;
	$save_timestamp = time();

	open (Input_File,"<$time_serie_file_name") || die "ERROR: Could not open the file $time_serie_file_name\n";
		
	while ($time_serie_actual = <Input_File>)
	{
		# print "\nIt read the ticker symbol: \'".$time_serie_actual."\'\n"; ###########################################
		if (chop($time_serie_actual) eq "\n")
		{
			chomp($time_serie_actual);
			print "Read ticker symbol: \'".$time_serie_actual."\'\n"; ###########################################
		}			
	
		$url = "http://chartstoostudy.com/".$time_serie_actual;
		# print "\nUrl: $url\n\n\n\n\n"; ###########################################
		
		$sucess = 0;
		$attempt_num = 0;
		while (!$sucess and $attempt_num<2000)
		{

			$agent = LWP::UserAgent->new(env_proxy  => 1,
										 keep_alive => 1,
										 timeout    => 30);
			
			$header = HTTP::Request->new(GET => $url);
			
			$request = HTTP::Request->new('GET', $url, $header);
			
			$response = $agent->request($request);
			
			$sucess = $response->is_success;
			
			if ($sucess) 
			{
				# print "URL:$url\nHeaders:\n";
				# print $response->headers_as_string;
				# print "\nContent:\n";
				# print $response->decoded_content();	
				$content = $response->content();
				# print "Url content: \n\n";###########################################
				# print $content."\n\n\n\n\n";###########################################								
			} 
			elsif ($response->is_error) 
			{
				print "Error: $url\n";
				print $response->status_line;
				print "Codigo de respuesta: " . $response->code . "\n";    
				# die;				
				sleep(5);  # Argumento de entrada en segundos					
			}									
			
			$attempt_num = $attempt_num + 1;
		}

		# Otra posible forma de leer el contenido de una url
		# use IO::All;
		# @html = io->http("www.google.com")->slurp;
		
		@arreglo = split("\n",$content);
		$session_data_beginning_row = 1000000;
		$session_final = 0;
		$session_minutes_num = 0;
		
		for ( $i = 0;   $i< scalar(@arreglo) ;   $i++)
		{ 			

			if (index($arreglo[$i],"Company-Name") > -1) 
			{
				$time_serie_name = substr($arreglo[$i],13,length($arreglo[$i])-13+1);
				$time_serie_name=~ s/\'//g; # Sustituye la comilla simple por nada
				print "\'".$time_serie_name."\'\n";###########################################
			}
			
			if (index($arreglo[$i],"volume:") > -1) 
			{
				$session_data_beginning_row = $i+1;
				# print "\n\n\nsession_data_beginning_row: $session_data_beginning_row\n\n\n\n\n";###########################################
				# $session_minutes_num =scalar(@arreglo)-$session_data_beginning_row;
				# print "\nsession_minutes_num: $session_minutes_num (numero de minutos)\n\n\n\n\n";###########################################
			}

			if ($i>=$session_data_beginning_row)
			{
				@arreglo2 = split(",",$arreglo[$i]);
				
				if (scalar(@arreglo2)>2)
				{
					
					# $session_beginning = 0;
					# if ($i==$session_data_beginning_row) 
					# {
						# $session_beginning = 1;					
					# } 
					
					# if ($i==scalar(@arreglo)-1) 
					# {
						# $session_final = 1;
						# $datestring = localtime($arreglo2[0]);   #http://www.tutorialspoint.com/perl/perl_date_time.htm, salida: Fri Feb 15 19:05:39 2013
						# print "\nHora del ultimo minuto: \'". $datestring."\'\n\n\n\n\n";###########################################							
					# } 
				
					# my $nombreFicheroSalida2="C:/Salida2.txt";###########################################
					# open (FicheroSalida2,">>$nombreFicheroSalida2") || die "ERROR: No se pudo abrir el fichero $nombreFicheroSalida2\n";###########################################
					# print FicheroSalida2 "\n\narreglo2[0]: $arreglo2[0]\n\n";###########################################
					# close (FicheroSalida2);###########################################
					# print "\n\n\nArreglo2[0]: \'". $arreglo2[0]."\'\n\n\n\n\n";###########################################
					# print "\n\n\nArreglo2[1]: \'". $arreglo2[1]."\'\n\n\n\n\n";###########################################
					# print "\n\n\nArreglo2[4]: \'". $arreglo2[4]."\'\n\n\n\n\n";###########################################
					# print "\n\n\nArreglo2[5]: \'". $arreglo2[5]."\'\n\n\n\n\n";###########################################
					$datestring = localtime($arreglo2[0]);   #http://www.tutorialspoint.com/perl/perl_date_time.htm, salida: Fri Feb 15 19:05:39 2013
					# print "\n\n\ndatestring: \'". $datestring."\'\n\n\n\n\n";###########################################
					
					@arreglo3 = split(" ",$datestring);
					# print "\n\n\narreglo3[0]: \'". $arreglo3[0]."\' (weekday)\n\n\n\n\n";###########################################
					# print "\n\n\narreglo3[1]: \'". $arreglo3[1]."\' (month) \n\n\n\n\n";###########################################
					# print "\n\n\narreglo3[2]: \'". $arreglo3[2]."\' (day) \n\n\n\n\n";###########################################
					# print "\n\n\narreglo3[3]: \'". $arreglo3[3]."\' (time)\n\n\n\n\n";###########################################
					# print "\n\n\narreglo3[4]: \'". $arreglo3[4]."\' (year)\n\n\n\n\n";###########################################
					#Sun Mon Tue Wed Thu Fri Sat						
					#jan. feb. mar. apr. may. jun. jul. aug. sep. oct. nov. dec
					# my $nombreFicheroSalida2="C:/Salida2.txt";###########################################
					# open (FicheroSalida2,">>$nombreFicheroSalida2") || die "ERROR: No se pudo abrir el fichero $nombreFicheroSalida2\n";###########################################
					# print FicheroSalida2 "\n\narreglo3: @arreglo3\n\n";###########################################
					# close (FicheroSalida2);###########################################
					
					@arreglo4 = split(":",$arreglo3[3]);
					# print "\n\n\narreglo4[0]: \'". $arreglo4[0]."\' (hours)\n\n\n\n\n";###########################################
					# print "\n\n\narreglo4[1]: \'". $arreglo4[1]."\' (minutes)\n\n\n\n\n";###########################################
					# print "\n\n\narreglo4[2]: \'". $arreglo4[2]."\'  (seconds) \n\n\n\n\n";###########################################
					
					$variation = $arreglo2[1]-$arreglo2[4] ;
					# print "\n\n\nvariation: ". $variation."\n\n\n\n\n";###########################################

					if ($arreglo2[4]!=0)
					{
						$percent = ($variation /$arreglo2[4])*100;
					}
					else
					{
						$percent=0;
					}
					# print "\n\n\npercent: ". $percent."\n\n\n\n\n";###########################################
									
						
					# if ($session_beginning==1) 
					# {			
						# $delete = "DELETE  FROM TB_MINUTE WHERE time_serie = \'$time_serie_actual\' AND day = $arreglo3[2] AND month = \'$arreglo3[1]\' AND year = $arreglo3[4];\n\n";
						# print "\ndelete:  $delete";###########################################
						# $query_handle = $connection->prepare($delete); 
						# $query_handle->execute();					
						
						# my $nombreFicheroSalida2="C:/Salida2.txt";###########################################
						# open (FicheroSalida2,">>$nombreFicheroSalida2") || die "ERROR: No se pudo abrir el fichero $nombreFicheroSalida2\n";###########################################
						# print FicheroSalida2 "\n\nDELETE  FROM TB_MINUTE WHERE time_serie = \'$time_serie_actual\' AND day = $arreglo3[2] AND month = \'$arreglo3[1]\' AND year = $arreglo3[4];\n\n";###########################################
						# close (FicheroSalida2);###########################################
												
						# $query = "SELECT * FROM TB_MINUTE WHERE time_serie = $time_serie_actual AND day = $arreglo3[2] AND month = $arreglo3[1] AND year = $arreglo3[4];";
						# print "\nquery:  $query";###########################################
						# $query_handle = $connection->prepare($query);
						# $query_handle->execute();

						# if ($row = $query_handle->fetchrow_hashref()) {		
							# $delete = "DELETE  FROM TB_MINUTE WHERE time_serie = $time_serie_actual AND day = $arreglo3[2] AND month = $arreglo3[1] AND year = $arreglo3[4];";
							# print "\ndelete:  $delete";###########################################
							# $query_handle = $connection->prepare($delete); 
							# $query_handle->execute();
						# }									
					# } 			
					 
					 $holiday = 0;
					 if  ($arreglo3[0] eq "Sun"  || $arreglo3[0] eq "Sat")
					 {
						$holiday = 1;
					 }
					 					 
					# if (index($time_serie_name,"Corporation Common") > -1) 
					# {
						# $autores[$i] =~ s/\'/\\\'/g;
						# $insert =~ s/\'NULL\'/NULL/g;
						# print "\ntime_serie_name: \'".$time_serie_name."\'\n\n\n\n\n";###########################################
						# $time_serie_name=~ s/\'//g;
						# print "\ntime_serie_name sin comillas simples: \'".$time_serie_name."\'\n\n\n\n\n";###########################################
						# print "INSERT INTO TB_MINUTE (time_serie,timestamp,day_hour_f,hour_minute_f,second_f, day,month,year,open,high,low,close,variation,percent, volume, weekday,time_serie_name, holiday, holiday_day_name,later_holiday_day_number,  previous_holiday_day_number, session_beginning, session_final, session_minutes_num) VALUES (\'".$time_serie_actual."\',".$arreglo2[0].",".$arreglo4[0].",".$arreglo4[1].",".$arreglo4[2].",".$arreglo3[2].",\'".$arreglo3[1]."\',".$arreglo3[4].",".$arreglo2[4].",".$arreglo2[2].",".$arreglo2[3].",".$arreglo2[1].",".$variation.",".$percent.",".$arreglo2[5].",\'".$arreglo3[0]."\',\'".$time_serie_name ."\',".$holiday.","."\'Ninguno\'".","."0".","."0".",".$session_beginning.",".$session_final.",".$session_minutes_num.");\n\n";
						# sleep(60*2);  # Argumento de entrada en segundos	 
					# }
						
					# print "\n\n\nValues: ".$time_serie_actual.",".$arreglo2[0].",".$arreglo4[0].",".$arreglo4[1].",".$arreglo4[2].",".$arreglo3[2].",".$arreglo3[1].",".$arreglo3[4].",".$arreglo2[4].",".$arreglo2[2].",".$arreglo2[3].",".$arreglo2[1].",".$variation.",".$percent.",".$arreglo2[5].",".$arreglo3[0].",".$time_serie_name .","."Ninguno".","."0".","."0".",".$session_beginning.",".$session_final.",".$session_minutes_num;###########################################
					
					# my $nombreFicheroSalida="C:/Salida.txt";###########################################
					# open (FicheroSalida,">>$nombreFicheroSalida") || die "ERROR: No se pudo abrir el fichero $nombreFicheroSalida\n";###########################################
					# print FicheroSalida "\n\nINSERT INTO TB_MINUTE (time_serie,timestamp,day_hour_f,hour_minute_f,second_f, day,month,year,open,high,low,close,variation,percent, volume, weekday,time_serie_name, holiday, holiday_day_name,later_holiday_day_number,  previous_holiday_day_number, session_beginning, session_final, session_minutes_num) VALUES (\'".$time_serie_actual."\',".$arreglo2[0].",".$arreglo4[0].",".$arreglo4[1].",".$arreglo4[2].",".$arreglo3[2].",\'".$arreglo3[1]."\',".$arreglo3[4].",".$arreglo2[4].",".$arreglo2[2].",".$arreglo2[3].",".$arreglo2[1].",".$variation.",".$percent.",".$arreglo2[5].",\'".$arreglo3[0]."\',\'".$time_serie_name ."\',".$holiday.","."\'Ninguno\'".","."0".","."0".",".$session_beginning.",".$session_final.",".$session_minutes_num.");\n\n";###########################################
					# close (FicheroSalida);###########################################
										
					$query = "SELECT * FROM TB_MINUTE WHERE time_serie = \'".$time_serie_actual."\' AND timestamp=".$arreglo2[0].";";
					$query_handle = $connection->prepare($query);
					$query_handle->execute();
					
					$rows_number = $query_handle->rows;					
					
					if(!$rows_number)
					{					
						$connection->do("INSERT INTO TB_MINUTE (time_serie,timestamp,day_hour_f,hour_minute_f,second_f, day,month,year,open,high,low,close,variation,percent, volume, weekday,time_serie_name, holiday, holiday_day_name,later_holiday_day_number,  previous_holiday_day_number) VALUES (\'".$time_serie_actual."\',".$arreglo2[0].",".$arreglo4[0].",".$arreglo4[1].",".$arreglo4[2].",".$arreglo3[2].",\'".$arreglo3[1]."\',".$arreglo3[4].",".$arreglo2[4].",".$arreglo2[2].",".$arreglo2[3].",".$arreglo2[1].",".$variation.",".$percent.",".$arreglo2[5].",\'".$arreglo3[0]."\',\'".$time_serie_name ."\',".$holiday.","."\'Ninguno\'".","."0".","."0".");");
					}
											
				}

							
			}
		 
		} # for
		
	} # while
	
	close (Input_File);
	
	print "\nEND\n";
	
	} # if
	
	if (abs($save_timestamp-time())>14400) #60*60*4=14400
	{
		$is_time = 1;
	}
	else
	{
		#print "s";
		sleep(60*2);  # Argumento de entrada en segundos		
	}
	
} # while

# }	
# else
# {
		# print "\n\n\nThe file does not exit.\n\n\n"
# }
	
	
$connection->disconnect();


($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time);
print  "\n\n\n########################################\n";
printf "                        Hora de Fin: %02d:%02d:%02d %02d-%02d-%4d\n",$hour,$min,$sec,$mday,$mon+1,$year+1900;
print  "########################################\n";