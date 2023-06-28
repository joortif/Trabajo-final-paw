<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" lang="es-ES">
    <title>Lista de pedidos del cliente</title>
    <meta name="description" content="Aplicación de prueba de Programación de aplicaciones Web; Grado en informática; Universidad de La Rioja." lang="es-ES">
    <meta name="keywords" content="electrodomesticos" lang="es-ES">
    <meta name="language" content="es-ES">
    <meta name="robots" content="index,follow">

    <link href="../css/electrosa.css" rel="stylesheet" media="all" type="text/css">
    <link href="../css/clientes.css" rel="stylesheet" media="all" type="text/css">
    <link href="../css/listado.css" rel="stylesheet" media="all" type="text/css">
    <link href="../css/estilomenu.css" rel="stylesheet" media="all" type="text/css" />
  </head>

  <body >
    <div class="logo"><a href="../index.jsp"><img src="../img/LogoElectrosa200.png" border="0"></a></div>
    <div class="sombra">
      <div class="nucleo">
        <div id="lang">
          <a href="index.jsp">Español</a> &nbsp; | &nbsp; <a href="index.jsp">English</a>
        </div>
      </div>
    </div>  
    <div class="barra_menus">
      <div class="pestanias">
        <div class="grupoPestanias">
          <div class="pestaniaNoSel"><a href="../index.jsp">Para usuarios</a></div>
          <div class="pestaniaSel">Intranet</div>
        </div>
      </div>

      <div id="cssmenu">
        <ul>
          <li class='has-sub'><a href="index.jsp">Art&iacute;culos</a>
            <ul>
              <li><a href="listadoArticulos.jsp">Listar</a></li>
              <li><a href="NuevoArticulo">A&ntilde;adir</a> </li>
              <li><a href="HazEstadistica">Estadísticas</a> </li>
            </ul>
          </li>
          <li class='has-sub'><a href="index.jsp">Clientes</a>	
            <ul>
              <li><a href="index.jsp">Listar</a> </li>
              <li><a href="index.jsp">A&ntilde;adir</a> </li>
            </ul>    
          </li>
          <li><a href="index.jsp">Pedidos</a></li>
          <li class='last'><a href="index.jsp">Stocks</a></li>
        </ul>
        <div style="clear: left;"></div>
      </div>
    </div> 

    <div class="sombra">
      <div class="nucleo">
        <div id="migas">
          <a href="index.jsp" title="Inicio" >Inicio</a>
        </div>
        <div class="clear"></div>
        <div class="contenido">
          <h1>Listado de art&iacute;culos     </h1>
          <a name="inicio"></a>
          <table width="95%">
            <colgroup>
              <col width="4%"><col width="4%"><col width="11%"><col width="12%">
              <col width="12%"><col width="36%"><col width="10%"><col width="11%">
            </colgroup>
            <tr>
              <td colspan="8">Listado de art&iacute;culos en la BD </td>
            </tr>


              <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>C&oacute;digo</td>
              <td>Fabricante</td>
              <td>Tipo</td>
              <td>Nombre</td>
              <td>Stock</td>
              <td>P.V.P.</td>
            </tr>  
            <sql:query dataSource="jdbc/electrosa" var="res">
              select a.codigo, a.nombre, a.pvp, a.tipo, a.fabricante, a.foto, a.descripcion, sum(cantidad) as stock
              from articulo a left join stock on a.codigo = stock.codigoArticulo
              group by a.codigo, a.nombre, a.pvp, a.tipo, a.fabricante, a.foto, a.descripcion
            </sql:query>
            <%-- Recorrer el resultado, almacenado en "res" --%>
            <c:forEach var="f" items="${res.rows}" varStatus="st">
              <tr ${st.index % 2==0 ? 'class="par"':''}>
                <td style="text-align: center"><a href="<c:url value="EditaArticulo"><c:param name="idArt" value="${f.codigo}"/></c:url>"><img src="../img/edit.gif" title="Editar"/></a></td>
                  <td style="text-align: center"><img src="../img/cancel.png" title="Descatalogar"/></td>
                  <td><a href="<c:url value="../FichaArticulo"><c:param name="cart" value="${f.codigo}"/></c:url>">${f.codigo}</a></td>
                <td>F${f.fabricante}</td> <!-- La F está añadida, mal añadida, adrede -->
                <td>${f.tipo}</td>
                <td>${f.nombre}</td>
                <td>${f.stock!=null?f.stock:0}</td>
                <td style="text-align: right"><fmt:formatNumber type="currency" value="${f.pvp}" /></td>
              </tr>   
            </c:forEach>     
          </table>

          <span class="atajo"><a href="#inicio">Inicio</a></span>          
        </div>
        <div class="clear"></div>
      </div>
      <div class="separa"></div>
      <div class="pie">
        <span class="pie_izda">
          <a href="mailto:francisco-jose.pascual@unirioja.es">Contacto</a> &nbsp; | &nbsp; <a href="../mapa.html">Mapa</a> </span>
        <span class="pie_dcha">
          &copy; 2023 Francisco Pascual  </span>
        <div class="clear"></div>  
      </div>
    </div>
  </body>
</html>