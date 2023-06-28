<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" lang="es-ES">
        <title>Electrosa >> Pedido en realización</title>
        <meta name="description" content="Aplicación de prueba de Programación de aplicaciones Web; Grado en informática; Universidad de La Rioja." lang="es-ES">
        <meta name="keywords" content="electrodomesticos" lang="es-ES">
        <meta name="language" content="es-ES">
        <meta name="robots" content="index,follow">

        <link href="../css/electrosa.css" rel="stylesheet" media="all" type="text/css">
        <link href="../css/clientes.css" rel="stylesheet" media="all" type="text/css">
        <link href="../css/pedidoR.css" rel="stylesheet" media="all" type="text/css">
        <script src="../js/evitarEnvioAccidental.js"></script>
        <script src="../js/calculoImporteTotal.js"></script>
        <script src="../js/pr9-compruebastock.js"></script>
    </head>
    <body>

        <div class="logo"><a href="../index.html"><img src="../img/LogoElectrosa200.png" border="0"></a></div>


        <div class="sombra">
            <div class="nucleo">
                <div id="lang">
                    <a href="index.html">Español</a> &nbsp; | &nbsp; <a href="index.html">English</a>
                </div>
            </div>
        </div>  
        <form action="GestionaPedido" method="post">

            <div class="barra_menus">
                <div class="pestanias">
                    <div class="grupoPestanias">
                        <div class="pestaniaSel">Para usuarios</div>
                        <div class="pestaniaNoSel">Intranet</div>
                    </div>
                </div>

                <div id="menu">
                    <ul>
                        <li>
                            <a href="../BuscarArticulos">Comprar </a>
                        </li>
                        <li>
                            <a href="PedidosCliente">Mis pedidos </a>
                        </li>
                        <li>
                            <a href="EditaCliente">Cambiar datos personales </a>	
                        </li>
                        <li>
                            <button type="submit" name="accion" value="CerrarSesion" style="background:transparent; border:none; font-size: 14.5px"><a>Cerrar sesión </a></button>	
                        </li>
                    </ul>
                    <div style="clear: left;"></div>
                </div>
            </div> 
            <div class="sombra">
                <div class="nucleo">
                    <div id="migas">
                        <a href="../index.html" title="Inicio" >Inicio</a> &nbsp; | &nbsp; 
                        <a href="AreaCliente" title="Área de cliente">Área de cliente</a>
                    </div>
                    <div id="cliente">
                        Bienvenido, ${cliente.nombre}
                    </div>
                    <div class="clear"></div>
                    <div class="contenido">
                        <h1>Contenido de su  pedido</h1>

                        <c:choose>
                            <c:when test="${carrito eq null}">
                                <p>Actualmente no está realizando ninguna compra en Electrosa. Use el enlace "Comprar" en la barra de menú.</p>
                            </c:when>
                            <c:otherwise>
                                <p>Pedido iniciado el <fmt:formatDate pattern="dd/MM/yyyy 'a las ' HH:mm" value="${carrito.inicio.time}"/></p>
                                <table width="95%" cellspacing="0">
                                    <tr>
                                        <td colspan="2"><img src="../img/AddCartb.png" style="vertical-align:middle;margin-bottom:3px; margin-left:15px">&nbsp; Art&iacute;culos del pedido</td>
                                        <td width="10%">P.V.P.</td>
                                        <td width="10%">Cantidad</td>
                                        <td width="16%">Fecha de entrega (dd/mm/yyyy)</td>
                                    </tr>
                                    <c:forEach var="p" items="${carrito.lineas}">
                                        <tr><!-- <a href="GestionaPedido?accion=Quitar&cl=${p.codigo}"><img src="../img/cancel.png" alt="Quitar del pedido" border="0" title="Quitar del pedido"></a> -->
                                            <td width="6%" style="text-align:center"><button type="submit" name="accion" value="Quitar" formaction="GestionaPedido?&cl=${p.codigo}" class="quitar" style="background:transparent; border:none;"><img src="../img/cancel.png" alt="Quitar del pedido" border="0" title="Quitar del pedido"></button></td>
                                            <td width="58%"><span class="codigo">${p.articulo.codigo}</span> - <br/><span class="descr">${p.articulo.nombre}-${p.articulo.fabricante}</span></td>
                                            <td class="pvp">${p.articulo.pvp} &euro;</td>
                                            <td>
                                                <input class="cantidad" type="number" min="1" name="C_${p.codigo}" size="3" value="${p.cantidad}">
                                            </td>
                                            <td>
                                                <input type="date" name="F_${p.codigo}" size="10" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${p.fechaEntregaDeseada.time}"/>">			  
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <tr class="precTotal"><td id="precioTotal" colspan="5"> TOTAL: </td></tr>
                                </table>
                                <button class="submitb" type="submit" name="accion" value="SeguirComprando">Seguir comprando</button>
                                <button class="submitb" type="submit" name="accion" value="GuardarPedido">Guardar pedido</button>
                                <button class="submitb cerrar" type="submit" name="accion" value="CerrarPedido">Cerrar pedido</button>
                                <button class="submitb cancelar" type="submit" name="accion" value="Cancelar">Cancelar</button>

                            </c:otherwise>
                        </c:choose>

                    </div>
                    <div class="clear"></div>
                </div>

                <div class="separa"></div>

                <%@include file="pie.html" %>

            </div>
        </form>
    </body>
</html>
