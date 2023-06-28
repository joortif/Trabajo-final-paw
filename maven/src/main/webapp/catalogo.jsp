<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<c:if test="${not empty param.lang}" >
    <fmt:setLocale value="${param.lang}" scope="session"/>
</c:if>
<fmt:setBundle basename="electrosaMsg"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" lang="es-ES">
        <title><fmt:message key="catalogo.tit"/></title>
        <meta name="description" content="Aplicación de prueba de Programación de aplicaciones Web; Grado en informática; Universidad de La Rioja." lang="es-ES">
        <meta name="keywords" content="electrodomesticos" lang="es-ES">
        <meta name="language" content="es-ES">
        <meta name="robots" content="index,follow">

        <link href="css/electrosa.css" rel="stylesheet" media="all" type="text/css">
        <link href="css/catalogoMosaico.css" title="mosaico" rel="stylesheet" media="all" type="text/css">
        <link href="css/catalogoLista.css" title="lista" rel="alternate stylesheet" media="all" type="text/css">
        <link href="fontawesome/css/all.min.css" rel="stylesheet">
        <script src="js/styleswitcherFGI.js"></script>
        <script src="js/manejadorCatalogo.js"></script>
        <script src="js/busqAvanzada.js"></script>
        <script src="js/busqAutomatica.js"></script>
        <script src="js/fichaDobleClick.js"></script>
    </head>
    <body>
        <jsp:include page="cabecera2.jsp"/>
        <div class="sombra">
            <div class="nucleo">

                <div id="migas">
                    <a href="index.jsp" title="Inicio" ><fmt:message key="lnk.home"/></a>&nbsp; | &nbsp; 
                    <a href="BuscarArticulos" title="Hojear catalogo"><fmt:message key="lnk.hojear"/></a>	<!-- &nbsp; | &nbsp; 
                    <a href="..." title="Otra cosa">Otra cosa</a>   -->	
                </div>
                <div class="contenido">
                    <h1><fmt:message key="catalogo.head"/></h1>
                    <p><fmt:message key="catalogo.txt"/></p>
                    <div class="filtroCatalogo">
                        <form name="filtroCatalogo" id="filtroCatalogo" action="BuscarArticulos">

                            <label for="tipo"><fmt:message key="catalogo.fltr.tipo"/>: </label>
                            <select name="tipo" id="tipo">
                                <option value="-1">- Cualquiera -</option>
                                <c:forEach var="t" items="${tipos}">
                                    <option value="${t}" ${(t eq tipo ? 'selected' : '')}>${t}</option>
                                </c:forEach>
                            </select>

                            <label for="fabricante"><fmt:message key="catalogo.fltr.fab"/>: </label>
                            <select name="fabricante" id="fabricante">
                                <option value="-1">- Cualquiera -</option>
                                <c:forEach var="f" items="${fabricantes}">
                                    <option value="${f}" ${(f eq fabricante ? 'selected' : '')}>${f}</option>
                                </c:forEach>
                            </select>

                            <label for="precio"><fmt:message key="catalogo.fltr.pvp"/>: </label>
                            <select name="precio" id="precio">
                                <option value="-1">- Cualquiera -</option>
                                <option value="10-50" ${("10-50" eq precio ? 'selected' : '')}>10-50 &euro;</option>
                                <option value="50-100" ${("50-100" eq precio ? 'selected' : '')}>50-100 &euro;</option>
                                <option value="100-200" ${("100-200" eq precio ? 'selected' : '')}>100-200 &euro;</option>
                                <option value="200-500" ${("200-500" eq precio ? 'selected' : '')}>200-500 &euro;</option>
                                <option value="500-1000" ${("500-1000" eq precio ? 'selected' : '')}>500-1.000 &euro;</option>
                                <option value="1000" ${("1000" eq precio ? 'selected' : '')}>Mas de 1.000 &euro;</option>
                            </select>
                            
                            <input name="buscar" id="buscar" type="image" title="Buscar" src="img/search25.png" alt="Buscar">
                            <br>
                            <label for="nombre" id="lbNombre"><fmt:message key="catalogo.fltr.name"/>: </label>
                            <input type="text" name="nombre" id="nombre" value="${nombre}" placeholder="<fmt:message key="catalogo.fltr.namePlaceholder"/>">
                            <label for="cod" id="lbCodigo"><fmt:message key="catalogo.fltr.code"/>: </label>
                            <input type="text" name="cod" id="codigo" value="${cod}" placeholder="<fmt:message key="catalogo.fltr.codePlaceholder"/>">

                        </form>

                        <div class="modovisual">
                            <a href="#"><fmt:message key="catalogo.fltr.mos"/></a> &nbsp; | &nbsp; <a href="#"><fmt:message key="catalogo.fltr.lst"/></a>
                        </div>
                        <div class="clear"></div>
                    </div>
                    <c:if test="${not empty paginador}">
                        <div class="resumResul redondeo">
                            Encontrados ${paginador.numRegistros} artículos.
                            <c:if test="${paginador.numRegistros > 0}">
                                Mostrando página ${pag} de ${paginador.numPaginas}.
                            </c:if>          
                            <span class="paginador">
                                <c:if test="${pag>1}">
                                    <a href="BuscarArticulos?tipo=${tipo}&fabricante=${fabricante}&precio=${precio}&nombre=${nombre}&cod=${cod}&p=${paginador.anterior(pag)}">Anterior</a>
                                </c:if>
                                <c:forEach var="i" items="${paginador.adyacentes(pag)}">
                                    <choose>
                                        <c:if test="${i eq pag}">
                                            <span>${i}</span>
                                        </c:if>
                                        <c:if test="${i != pag}">
                                            <a href="BuscarArticulos?tipo=${tipo}&fabricante=${fabricante}&precio=${precio}&nombre=${nombre}&cod=${cod}&p=${i}">${i}</a>
                                        </c:if>
                                    </choose>
                                </c:forEach>
                                <c:if test="${pag < paginador.numPaginas}">
                                    <a href="BuscarArticulos?tipo=${tipo}&fabricante=${fabricante}&precio=${precio}&nombre=${nombre}&cod=${cod}&p=${paginador.siguiente(pag)}">Siguiente</a>
                                </c:if>                                                  
                            </span>
                        </div>
                    </c:if>

                    <ul class="resultBusqueda">
                        <c:forEach var="art" items="${articulos}" varStatus="loop">
                            <li class="item redondeo">
                                <div class="foto">
                                    <a href="FichaArticulo?cart=${art.codigo}"><img src="img/fotosElectr/${art.foto}" alt="${art.codigo}" longdesc="${art.descripcion}" width="80"></a>
                                </div>
                                <div class="datos">
                                    <span>${art.nombre}</span>
                                    <div class="precio">
                                        <c:choose>
                                            <c:when test="${loop.index eq 0 or loop.index mod 3 eq 0}">
                                                <span class="oferta">${art.pvp} &euro;</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span>${art.pvp} &euro;</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div class="carro">
                                        <a href="clientes/GestionaPedido?accion=Comprar&ca=${art.codigo}"><img src="img/shopcartadd_16x16.png" title="Añadir a mi carro de la compra"></a>
                                    </div>
                                </div>			  
                                <div class="codigo"><a href="FichaArticulo?cart=${art.codigo}">${art.codigo}</a></div>
                            </li>
                        </c:forEach>
                    </ul>			
                    <div class="clear"></div>

                </div>

                <div class="separa"></div>
            </div>

            <jsp:include page="pie2.jsp"/>
        </div>
    </body>
</html>
