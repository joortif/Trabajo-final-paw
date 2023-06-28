<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${not empty param.lang}" >
    <fmt:setLocale value="${param.lang}" scope="session"/>
</c:if>
<fmt:setBundle basename="electrosaMsg"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" lang="es-ES">
        <title><fmt:message key="home.tit"/></title>
        <meta name="description" content="Aplicación de prueba de Programación de aplicaciones Web; Grado en informática; Universidad de La Rioja." lang="es-ES">
        <meta name="keywords" content="electrodomesticos" lang="es-ES">
        <meta name="language" content="es-ES">
        <meta name="robots" content="index,follow">

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
        <link href="css/electrosa.css" rel="stylesheet" media="all" type="text/css">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
        <script src="js/enlaces.js"></script>
    </head>
    <body>
        <jsp:include page="cabecera2.jsp"/>
        <div class="sombra">
            <div class="nucleo">
                <div id="migas">
                    <a href="index.jsp" title="Inicio" ><fmt:message key="lnk.home"/></a><!-- &nbsp; | &nbsp; 
                    <a href="..." title="Otra cosa">Otra cosa</a>   -->	
                </div>
                <div class="contenido">
                    <h1><fmt:message key="home.tit"/></h1>
                    <p><fmt:message key="home.txt"/></p>
                </div>
                <div class="centro">
                    <a href="#" onclick="console.log('Hola mundo 1')">Evento inline</a>
                    <a href="#" id="manejador">Manejador como método</a>
                    <a href="#" id="eventListener">Manejador eventListener</a>
                    <ul>
                        <li class="columna">  
                            <ul>  
                                <li class="celda">
                                    <div class="parteCelda">
                                        <a href="generica.html"><img src="img/motif_b2c_1_194.jpg" alt="" title=""></a>
                                    </div>
                                    <div class="parteCelda2">
                                        <h3><a href="generica.html"><fmt:message key="home.secc.sat.tit"/></a></h3>
                                            <fmt:message key="home.secc.sat.txt"/>
                                        <div style="float:right; padding:10px 5px">
                                            <a style="padding:5px 8px 5px 10px;background:#5C7E72;color:#FFF" href="generica.html" ><span><fmt:message key="home.secc.sat.btn"/></span> </a>
                                        </div>
                                    </div>
                                    <div class="clear"></div>
                                </li> 
                                <li class="celda">
                                    <div class="parteCelda">
                                        <a class="parteCelda" href="generica.html"><img src="img/imag_teaser_encuentre-solucion.jpg" alt="" title="" ></a>
                                    </div>
                                    <div class="parteCelda2">
                                        <h3><a href="generica.html"><fmt:message key="home.secc.sol.tit"/></a></h3>
                                            <fmt:message key="home.secc.sat.txt"/>
                                        <div style="float:right; padding:10px 5px">
                                            <a style="padding:5px 8px 5px 10px;background:#5C7E72;color:#FFF" href="generica.html" ><span><fmt:message key="home.secc.sol.btn"/></span> </a>
                                        </div>
                                    </div>
                                    <div class="clear"></div>
                                </li> 
                            </ul>
                        </li>

                        <li class="columna"> 
                            <ul>  
                                <li class="celda">
                                    <div class="parteCelda">
                                        <a href="generica.html"><img src="img/registre-garantia.jpg" alt="" title=""></a>
                                    </div>
                                    <div class="parteCelda2">
                                        <h3 ><a href="generica.html"><fmt:message key="home.secc.garant.tit"/></a></h3>
                                            <fmt:message key="home.secc.garant.txt"/>
                                        <div style="float:right; padding:10px 5px">
                                            <a style="padding:5px 8px 5px 10px;background:#5C7E72;color:#FFF" href="generica.html" ><span><fmt:message key="home.secc.garant.btn"/></span> </a>
                                        </div>
                                    </div>
                                    <div class="clear"></div>
                                </li> 
                                <li class="celda">
                                    <div class="parteCelda">
                                        <a href="generica.html"><img src="img/atencion-cliente.jpg" alt="" title=""></a>
                                    </div>
                                    <div class="parteCelda2">
                                        <h3><a href="generica.html"><fmt:message key="home.secc.atn.tit"/></a></h3>
                                        <fmt:message key="home.secc.atn.txt"/><br><strong><fmt:message key="home.secc.atn.tfn"/></strong>
                                        <div style="float:right; padding:10px 5px">
                                            <a style="padding:5px 8px 5px 10px;background:#5C7E72;color:#FFF" href="generica.html" ><span><fmt:message key="home.secc.atn.btn"/></span> </a>
                                        </div>
                                    </div>
                                    <div class="clear"></div>
                                </li> 			
                            </ul>
                        </li>
                    </ul>

                </div>
                <div class="clear"></div>
            </div>

            <div class="separa"></div>
            <div class="pie">
                <span class="pie_izda">
                    <a href="#exampleModal" data-bs-toggle="modal" data-bs-target="#exampleModal"><fmt:message key="lnk.contacto"/></a> &nbsp; | &nbsp; <a href="mapa.html"><fmt:message key="lnk.mapa"/></a> </span>
                <span class="pie_dcha">
                    &copy; 2023 Francisco Pascual  </span>
                <div class="clear"></div>

            </div>
        </div>
        <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="exampleModalLabel">Información de contacto</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                    </div>
                    <div class="modal-body">
                        <p>Franciso Pascual</p><br>
                        <p>C/ Luis de Ulloa, s.n. 26004 - Logroño</p>
                        <p>La Rioja - Spain</p>
                        <a href="mailto:francisco-jose.pascual@unirioja.es">Email</a>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary" data-bs-dismiss="modal">Cerrar</button>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>