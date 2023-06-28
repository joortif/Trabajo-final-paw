<%-- 
    Document   : verPedido
    Created on : 27-abr-2023, 11:45:56
    Author     : Joka
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" lang="es-ES">
    <title>Electrosa >> Hoja de pedido</title>
    <meta name="description" content="Aplicación de prueba de Programación de aplicaciones Web; Grado en informática; Universidad de La Rioja." lang="es-ES">
    <meta name="keywords" content="electrodomesticos" lang="es-ES">
    <meta name="language" content="es-ES">
    <meta name="robots" content="index,follow">

    <link href="../css/electrosa.css" rel="stylesheet" media="all" type="text/css">
    <link href="../css/clientes.css" rel="stylesheet" media="all" type="text/css">
    <link href="../css/pedido.css" rel="stylesheet" media="all" type="text/css">
    <link href="../css/listado.css" rel="stylesheet" media="all" type="text/css">
  </head>

  <body >
    <%@include file="cabecera.html" %> 

    <div class="sombra">
      <div class="nucleo">
        <div id="migas">
          <a href="../index.html" title="Inicio" >Inicio</a> &nbsp; | &nbsp; 
          <a href="AreaCliente" title="Área de cliente">Área de cliente</a>&nbsp; | &nbsp; 
          <a href="PedidosCliente" title="Mis pedidos">Mis pedidos</a>
        </div>
        <div id="cliente">
          Bienvenido ${cliente.nombre}
        </div>
        <div class="clear"></div>
        <div class="contenido">
          <h1>Hoja de pedido    </h1>
          <div class="cabPedido"> <span class="izda">ELECTROSA - Hoja de pedido</span> <span class="dcha">Ref. Pedido: ${pedido.codigo}</span>
            <div class="clear"></div>
          </div>
          <div class="cabIdCliente">Identificación del cliente</div>
          <div class="detIdCliente">
            <div class="izda">Cliente: ${pedido.cliente.codigo}</div>
            <div class="izda">${cliente.nombre}</div>
            <div class="dcha">Fecha: <fmt:formatDate value="${pedido.fechaCierre.time}"/></div>
            <div class="dcha"> CIF: ${cliente.cif}</div>
            <div class="clear"></div>
          </div>

          <div class="izda direccionEntregaPedLabel">A entregar en:</div>
          <div class="izda direccionEntregaPed">${pedido.dirEntrega.calle}<br>${pedido.dirEntrega.ciudad}<br>${pedido.dirEntrega.cp} - ${pedido.dirEntrega.provincia}</div>
          <div class="clear"></div>
          <table width="95%">
            <colgroup>
              <col width="9%">
              <col width="49%">
              <col width="11%">
              <col width="11%">
              <col width="10%">
              <col width="10%">
            </colgroup>
            <tr>
              <td colspan="6">Detalle del pedido</td>
            </tr>
            <tr>
              <td>Cantidad</td>
              <td>Art&iacute;culo</td>
              <td>P.V.P.</td>
              <td>Su precio</td>
              <td>F. Entrega deseada</td>
              <td>F. Entrega prevista</td>
            </tr>
            <c:forEach var="l" items="${pedido.lineas}" varStatus="loop">
                <tr <c:if test="${loop.index mod 2 != 0}"> class="par" </c:if>>
                <td style="text-align: center">${l.cantidad}</td>
                <td>${l.articulo.codigo} / ${l.articulo.nombre}</td>
                <td style="text-align: right"><fmt:formatNumber type="currency" value="${l.precioBase}"/></td>
                <td style="text-align: right"><fmt:formatNumber type="currency" value="${l.precioReal}"/></td>
                <td><fmt:formatDate pattern="dd/MM/yyyy" value="${l.fechaEntregaDeseada.time}"/></td>
                <td>
                    <c:choose>
                        <c:when test="${l.fechaEntregaPrevista.time eq null}">
                        S.D
                    </c:when>
                    <c:otherwise>
                        <fmt:formatDate pattern="dd/MM/yyyy" value="${l.fechaEntregaPrevista.time}"/>
                    </c:otherwise>
                    </c:choose>
                </td>
                </tr>
            </c:forEach>
          
          </table>

          <div class="resPedido">
            <span>TOTAL: <fmt:formatNumber type="currency" value="${pedido.importe}"/></span>
            <div class="clear"></div>
          </div>  

          <div>
            * S.D.: sin disponibilidad. Recibirá una notificación de entrega en el momento en que podamos atender su petición.
          </div>   
        </div>
            <c:if test="${not pedido.cursado}">
                <div  class="anulab">
                    <a href="./ConfirmaAnulacion?cp=${pedido.codigo}">ANULAR PEDIDO</a>
                </div> 
            </c:if>
          
          <div  class="NOanulab">
            <a href="./PedidosCliente">Volver a mis pedidos</a>
          </div> 
          <div class="clear"></div>
      </div>

      <div class="separa"></div>

      <%@include file="pie.html" %>

    </div>
  </body>
</html>
