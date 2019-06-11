<?php

/**
 * DBLP Explorer
 *
 * @author Mary Luque
 * @author Jesus Dominguez
 * @copyright 2011
 *
 */

    include("../lib/DBLP_DB.php");

    $db = new DBLP_DB();
    $db->conectar();
    $query = $db->query("SELECT * FROM tb_dblp_tipo_usuario ORDER BY detalle_tipo_usuario;");

?>
<table id="tabla_new_user">
<tr>
<td class="edit_td">
<div class="span_text">Nombre y Apellido:</div>
</td>
<td>
<input type="text" value="" class="editbox" id="nombre"/>
</td>
</tr>

<tr>
<td class="edit_td">
<div class="span_text">Nombre de Usuario:</div>
</td>
<td>
<input type="text" value="" class="editbox" id="nombre_user"/>
</td>
</tr>


<tr>
<td class="edit_td">
<div class="span_text">Contrasena:</div>
</td>
<td>
<input type="password" value="" class="editbox" id="user_pass"/>
</td>
</tr>

<tr>
    <td class="edit_td">
        <div class="span_text">Confirmar Contrase&ntilde;a:</div>
    </td>
    <td>
        <input type="password" value="" class="editbox" id="user_pass_confirm"/>
    </td>
</tr>

<tr>
<td class="edit_td">
<div class="span_text">Correo:</div>
</td>
<td>
<input type="text" value="" class="editbox" id="correo"/>
</td>
</tr>

<tr>
<td class="edit_td">
<div class="span_text">Tipo de Usuario:</div>
</td>
<td>
<select name="tipo" id="tipo_usuario">
     <option value="seleccionar_tipo">-- Seleccionar --</option>
     <?php while ( $row = mysql_fetch_array($query) ) { ?>
     <option value="<?php echo $row["id_tipo_usuario"] ?>"><?php echo $row["detalle_tipo_usuario"] ?> </option>
     <?php }?>
</select>
</td>
</tr>


<tr>
   <td colspan="2">
    <div style="text-align: center;">
        <input type="button" value="Guardar" id="boton_agregar_usuario"/>
    </div>
   </td>
</tr>


</table>
