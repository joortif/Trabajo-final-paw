<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:wrapper pageTitle="Pedido en realización">
    
    <h1>Contenido de su  pedido</h1>
    <p>Pedido iniciado el 17/02/2023 a las 01:44.</p>
    <form action="GestionaPedido" method="post">
        <table width="95%" cellspacing="0">
            <tr>
                <td colspan="2"><img src="../img/AddCartb.png" style="vertical-align:middle;margin-bottom:3px; margin-left:15px">&nbsp; Art&iacute;culos del pedido</td>
                <td width="10%">P.V.P.</td>
                <td width="10%">Cantidad</td>
                <td width="16%">Fecha de entrega (dd/mm/yyyy)</td>
            </tr>
            <tr >
                <td width="6%" style="text-align:center"><a href="GestionaPedido?accion=Quitar&cl=L-87601"><img src="../img/cancel.png" alt="Quitar del pedido" border="0" title="Quitar del pedido"></a></td>
                <td width="58%"><span class="codigo">Ede-445CA</span> - <br/><span class="descr">Campana CD5-60 N - Edesa</span></td>
                <td>205,2 &euro;</td>
                <td>
                    <input class="cantidad" type="text" name="textfield" size="3" value="3">
                </td>
                <td>
                    <input type="text" name="textfield" size="10" value="08/02/2023">			  
                </td>
            </tr>

            <tr>
                <td style="text-align:center"><a href="GestionaPedido?accion=quitar&cl=L-87602"><img src="../img/cancel.png" alt="Quitar del pedido" border="0" title="Quitar del pedido"></a></td>
                <td><span class="codigo">Mie-043MO</span> - <br/><span class="descr">Microondas Miele M 611-3S - Miele</span>
                </td>
                <td>180 &euro;</td>
                <td class="cantidad">
                    <input type="text" name="textfield" size="3" value="15">
                </td>
                <td>
                    <input type="text" name="textfield" size="10" value="06/02/2023">				  
                </td>
            </tr>
        </table>
        <input class="submitb" type="submit" name="accion" value="Seguir comprando">
        <input class="submitb" type="submit" name="accion" value="Guardar pedido">
        <input class="submitb cerrar" type="submit" name="accion" value="Cerrar pedido">	
        <input class="submitb cancelar" type="submit" name="accion" value="Cancelar">
    </form>
</t:wrapper>