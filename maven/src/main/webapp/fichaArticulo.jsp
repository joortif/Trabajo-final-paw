<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" lang="es-ES">
        <title>${art.nombre}</title>
        <meta name="description" content="${art.descripcion}" lang="es-ES">
        <meta name="keywords" content="${art.fabricante} ${art.tipo}" lang="es-ES">
        <meta name="language" content="es-ES">
        <meta name="robots" content="index,follow">

        <link href="css/electrosa.css" rel="stylesheet" media="all" type="text/css">
        <link href="css/fichaProducto.css" rel="stylesheet" media="all" type="text/css">
        <link href="fontawesome/css/all.min.css" rel="stylesheet">
        <script src="js/pr9-mostrarstock.js"></script>
        <script src="js/pr9-actualizarstock.js"></script>
    </head>

    <body>
        <%@include file="cabecera.html" %> 

        <div class="sombra">
            <div class="nucleo">
                <div id="migas">
                    <a href="index.html" title="Inicio" >Inicio</a>&nbsp; | &nbsp;
                    <c:set var="url" value="FichaArticulo?cart=${art.codigo}"/>
                    <c:choose>
                        <c:when test = "${!fn:contains(header.referer, 'BuscarArticulos')}">
                            <a href="BuscarArticulos" title="Hojear catalogo">Hojear catálogo</a>&nbsp; | &nbsp; ${art.codigo}
                        </c:when>
                        <c:otherwise>
                            <a href="${header.referer}" title="Hojear catalogo">Hojear catálogo</a>&nbsp; | &nbsp; ${art.codigo}
                        </c:otherwise>
                    </c:choose>

                </div>

                <div class="contenido">
                    <h1>Ficha t&eacute;cnica de ${art.codigo}</h1>
                    <div class="fotoDetalle">
                        <img src="img/fotosElectr/${art.foto}" alt="${art.codigo}" longdesc="${art.nombre}">
                    </div>
                    <div class="datosDetalle">
                        <h2>${art.nombre}</h2>
                        <p>${art.descripcion}</p>
                        <div class="precio">
                            <span>Precio: ${art.pvp} &euro;</span>	
                        </div>
                        <br>
                        <div class="stock">
                            <b>Stock:</b>
                            <span id="stockQuantity"></span>
                            <i class="fa-sharp fa-solid fa-rotate-right"></i>
                            <a href="" id="actStock">Actualizar stock</a>
                        </div>
                        <div class="carroDetalle" >
                            <a href="clientes/GestionaPedido?accion=Comprar&ca=${art.codigo}"><img src="img/AddCart2-50.png" title="Añadir a mi pedido en realización"></a>
                        </div>
                    </div>
                    <div class="clear"></div>
                </div>
            </div>

            <div class="separa"></div>

            <%@include file="pie.html" %>

        </div>
    </body>
</html>