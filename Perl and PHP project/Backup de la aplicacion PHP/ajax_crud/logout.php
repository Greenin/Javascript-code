<?php
/**
 * DBLP Explorer
 *
 * @author Mary Luque
 * @author Jesus Dominguez
 * @copyright 2011
 *
 */
    session_start();
    if(isset($_SESSION['autentificado'])) {
        unset($_SESSION['autentificado']);
        unset($_SESSION['admin']);
        unset($_SESSION['normal']);
        unset($_SESSION['tipo']);
        unset($_SESSION['nombre']);
    }

?>