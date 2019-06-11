<?php
    session_start();
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" lang="en-US" xml:lang="en">
<head>

    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>Distancia entre investigadores</title>
    <link href="css/mainstyle.css" rel="stylesheet" type="text/css" />
    <!--<link href="css/ui-lightness/jquery-ui-1.8.11.custom.css" rel="StyleSheet" type="text/css" />-->
    <link href="css/jquery.autocomplete.css" rel="stylesheet" type="text/css" />
    <!--<link href="css/jquery.tablesorter.css" rel="stylesheet" type="text/css" />
    <link href="css/jquery.tablesorter.pager.css" rel="stylesheet" type="text/css" />-->
    <link href="css/style.css" rel="StyleSheet" type="text/css" />    
    <!--<script src="https://www.google.com/jsapi" type="text/javascript"></script>-->
    <script src="js/jquery-1.5.1.min.js" type="text/javascript"></script> 
    <!--<script src="js/jquery.json-2.2.js" type="text/javascript"></script>   
    <script src="js/jquery-ui-1.8.11.custom.min.js" type="text/javascript"></script>-->
    <script src='js/jquery.autocomplete.js' type='text/javascript' ></script>
    <!--<script src='js/jquery.md5.js' type='text/javascript' ></script>
    <script src="js/jquery.tablesorter.min.js" type="text/javascript"></script>
    <script src="js/jquery.tablesorter.pager.js" type="text/javascript"></script>-->
    <script src='js/script.js' type='text/javascript' ></script>
    <!--<script type="text/javascript">
        google.load("visualization", "1", {packages:["corechart"]});
    </script>-->

</head>
<body>
    <div id="art-page-background-gradient"></div>
    <div id="art-main">
        <div class="art-sheet">
            <div class="art-sheet-tl"></div>
            <div class="art-sheet-tr"></div>
            <div class="art-sheet-bl"></div>
            <div class="art-sheet-br"></div>
            <div class="art-sheet-tc"></div>
            <div class="art-sheet-bc"></div>
            <div class="art-sheet-cl"></div>
            <div class="art-sheet-cr"></div>
            <div class="art-sheet-cc"></div>
            <div class="art-sheet-body">
                <div class="art-header">
                    <div class="art-header-png"></div>
                    <div class="art-header-jpeg"></div>
                    <div class="art-logo">
                        <h1 id="name-text" class="art-logo-name"><a id="link_principal" >Distancia entre investigadores</a></h1>
                    </div>
                </div>
                <div class="art-nav">
                	<div class="l"></div>
                	<div class="r"></div>
                	<ul class="art-menu">
                		<li>
					<a id="menu_inicio"  class="active"><span class="l"></span><span class="r"></span><span class="t">Inicio</span></a>
                		</li>
				<li class="art-menu-li-separator"><span class="art-menu-separator"></span></li>
                		<li>
                			<a id="menu_opciones" ><span class="l"></span><span class="r"></span><span class="t">Opciones</span></a>
                			<!--<ul>
                				<li><a >Menu Subitem 1</a>
                					<ul>
                						<li><a >Menu Subitem 1.1</a></li>
                						<li><a >Menu Subitem 1.2</a></li>
                						<li><a >Menu Subitem 1.3</a></li>
                					</ul>
                				</li>
                				<li><a >Menu Subitem 2</a></li>
                				<li><a >Menu Subitem 3</a></li>
                			</ul>-->
					<ul>
                				<!--<li><a  id="sub_autor" class="submenu_item opciones">Buscar Autor</a></li>
                				<li><a  id="sub_publicacion" class="submenu_item opciones">Buscar Publicaci&oacute;n</a></li>
                				<li><a  id="sub_estadisticas" class="submenu_item opciones">Estadisticas</a></li>
						<li><a  id="sub_centro" class="submenu_item opciones">Centros de Estudios</a></li>
						<li><a  id="sub_grupo" class="submenu_item opciones">Grupos de Investigacion</a></li>-->
						<li><a  id="sub_camino" class="submenu_item opciones">Buscar Camino</a></li>
                			</ul>
                		</li>
				<li class="art-menu-li-separator"><span class="art-menu-separator"></span></li>	
                		
                                <?php if(isset($_SESSION['admin'])){ ?>

                                <li>
					<a id="menu_administrar" ><span class="l"></span><span class="r"></span><span class="t">Administrar</span></a>
                                        <ul>
<!--                				<li><a  id="sub_status" class="submenu_item administrar">Ver Estado</a></li>
                				<li><a  id="sub_opciones_bd" class="submenu_item administrar">Administrar BD</a></li>
                				<li><a  id="sub_update_xml" class="submenu_item administrar">Actualizar BD con XML</a></li>
                				<li><a  id="sub_update_relions" class="submenu_item administrar">Actualizar Relaciones</a></li>
                				<li><a  id="sub_new_user" class="submenu_item administrar">Agregar Usuario</a></li>
                				<li><a  id="sub_new_autor" class="submenu_item administrar">Agregar Autor</a></li>
								<li><a  id="sub_new_pub" class="submenu_item administrar">Agregar Publicaci&oacute;n</a></li>
								<li><a  id="sub_agregar_centro" class="submenu_item administrar">Agregar Centros de Estudios</a></li>
								<li><a  id="sub_agregar_grupo" class="submenu_item administrar">Agregar G. de Investigacion</a></li>-->
                			</ul>
                		</li>
				<li class="art-menu-li-separator"><span class="art-menu-separator"></span></li>

                                <?php } ?>

                                <li>
                			<a id="menu_about" ><span class="l"></span><span class="r"></span><span class="t">About</span></a>
                		</li>
                	</ul>
                        <!-- <div id="sesion">
                            <?php if(isset($_SESSION['autentificado'])){
                                        echo "<a id='form_sesion_close'>Desconectarse [ <b>".$_SESSION['nombre']."</b> ]</a>";
                                  }else{
                                      echo "<a id='form_sesion_ini'>Identificarse</a>";
                                  }?>
                            <div id="ini_sesion">
                                <h1>Login de Usuario</h1>                                
                                <span class="login_span">&ensp;&ensp;&ensp;Nombre:</span>
                                <input id="usuario" type="text" name="usuario"/>
                                <span class="login_span">Contrase&ntilde;a:</span>
                                <input id="pass" type="password" name="pass"/>
                                <div style="clear:both"></div>
                                <div id="mensaje_login"></div>
                                <button id="sesion_ini_button">
                                    <img id="img_ini_sesion" src="img/ok.png" alt="img_ini_sesion" />
                                    <span>Iniciar Sesi&oacute;n</span>
                                </button>
                                        <a id="us_ag">Agregar Usuario</a><br/>                                
                            </div>-->  
                        </div>
                </div>
                <div class="art-content-layout">
                    <div class="art-content-layout-row">
                        <div class="art-layout-cell art-content">
                            <div class="art-post" id="container">
								<h2>
									<span id="titulo">Inicio</span>                                       
								</h2>
						
								<div id="result">
									<img src="img/urjc_logo.jpg" style="margin: 0 60px 10px; text-align: center; width: 750px;"  />
								</div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="cleared"></div>
		<div class="art-footer">
                    <div class="art-footer-t"></div>
                    <div class="art-footer-l"></div>
                    <div class="art-footer-b"></div>
                    <div class="art-footer-r"></div>
                    <div class="art-footer-body">
                        <div class="art-footer-text">
                            <!--<p><a >Contact Us</a> | <a >Terms of Use</a> | <a >Trademarks</a>                                 | <a >Privacy Statement</a><br/> --><br/>
                                Copyright &reg; Universidad Rey Juan Carlos 2015 --- All Rights Reserved.</p>
                        </div>
                	<div class="cleared"></div>
                    </div>
                </div>
        	<div class="cleared"></div>
            </div>
        </div>
        <div class="cleared"></div>
    </div>
    <div id="bloquear_pantalla"></div>
    <div id="loading"><img src="img/loading.gif" alt="Cargando..."/></div>
    
</body>
</html>
