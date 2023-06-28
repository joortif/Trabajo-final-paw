<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" lang="es-ES">
        <title>Dónde estamos</title>
        <meta name="description" content="Aplicación de prueba de Programación de aplicaciones Web; Grado en informática; Universidad de La Rioja." lang="es-ES">
        <meta name="keywords" content="electrodomesticos" lang="es-ES">
        <meta name="language" content="es-ES">
        <meta name="robots" content="index,follow">

        <link href="css/electrosa.css" rel="stylesheet" media="all" type="text/css">
        <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.3/dist/leaflet.css"
              integrity="sha256-kLaT2GOSpHechhsozzB+flnD+zUyjE2LlfWPgU04xyI="
              crossorigin=""/>
        <script src="https://unpkg.com/leaflet@1.9.3/dist/leaflet.js"
                integrity="sha256-WBkoXOwTeyKclOHuWtc+i2uENFpDZ9YPdf5Hf+D7ewM="
        crossorigin=""></script>
        <script>
            var map;

            window.addEventListener("load", inicializa);

            function inicializa() {

                var cnf = {
                    center: [${almacenCentral.coordX}, ${almacenCentral.coordY}],
                    zoom: 6
                };

                map = L.map('mapId', cnf);

                L.tileLayer('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
                    attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://cloudmade.com">CloudMade</a>'
                }).addTo(map);


            <c:forEach var="almacen" items="${almacenes}">
                L.marker([${almacen.coordX}, ${almacen.coordY}]).bindPopup("Zona ${almacen.zona}: ${almacen.direccion.calle}. ${almacen.direccion.cp} - ${almacen.direccion.ciudad}. ${almacen.direccion.provincia}").addTo(map);
            </c:forEach>


                function obtener_localizacion() {
                    if (navigator.geolocation) {
                        navigator.geolocation.getCurrentPosition(muestraPosicion);
                    } else {
                        alert('Su navegador no soporta la API de geolocalizacion');
                    }
                }

                function muestraPosicion(posicion) {
                    var latitud = posicion.coords.latitude;
                    var longitud = posicion.coords.longitude;
                    var homeIcon = L.icon({
                        iconUrl: 'img/home.png',
                        iconSize: [32, 37], // size of the icon
                        iconAnchor: [16, 35], // point of the icon which will correspond to marker's location
                        popupAnchor: [0, -37]  // point from which the popup should open relative to the iconAnchor
                    });

                    L.marker([latitud, longitud], {icon: homeIcon, title: "Su situación"}).bindPopup("Su situación").addTo(map).togglePopup();
                }

                var bt = document.getElementById("btLocalizacion");
                bt.addEventListener('click', obtener_localizacion);
                
            }


        </script>
    </head>


    <body >
        <div class="logo"><a href="index.jsp"><img src="img/LogoElectrosa200.png" border="0"></a></div>

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
                    <div class="pestaniaSel">Para usuarios</div>
                    <div class="pestaniaNoSel"><a href="admin/index.html">Intranet</a></div>
                </div>
            </div>

            <div id="menu" >
                <ul>
                    <li>
                        <a href="index.jsp">Sobre electrosa<br/><img src="img/Home4.png"/></a>
                    </li>
                    <li>
                        <a href="DondeEstamos">Dónde estamos<br/><img src="img/map.png"/></a>
                    </li>
                    <li>
                        <a href="BuscarArticulos">Hojear catálogo<br/><img src="img/catalog.png"/></a>
                    </li>
                    <li>
                        <a href="clientes/AreaCliente">Usuario registrado<br/><img src="img/registrado.png"/></a>
                    </li>
                </ul>
                <div style="clear: left;"></div>
            </div>
        </div> 

        <div class="sombra">
            <div class="nucleo">
                <div id="migas">
                    <a href="index.jsp" title="Inicio" >Inicio</a><!-- &nbsp; | &nbsp; 
                    <a href="..." title="Otra cosa">Otra cosa</a>   -->	
                </div>
                <div class="contenido">
                    <h1>Donde estamos</h1>
                    <div class="centro">
                        <h2>Oficinas centrales </h2>
                        <p><strong>Electrosa S.L. </strong><br>
                            C/ Luis de Ulloa, s.n. 
                            26004 - Logro&ntilde;o <br>
                            La Rioja - Spain <br><br>
                            Tfno: (+34) 941 000 000 - FAX:  (+34) 941 000 001</p>
                        <h2>Almacenes de zona </h2>
                        <p>Para  facilitar la gesti&oacute;n ELECTROSA considera la superficie nacional dividida en  cinco zonas: centro, norte, sur, este y oeste. En cada zona dispone de un  almac&eacute;n (almac&eacute;n de referencia de la zona). Puede visitarlos en las siguientes direcciones:</p>
                        <c:forEach var="a" items="${almacenes}">
                            <div class="dirAlmacen"><strong>${a.zona}</strong><br>
                                ${a.direccion.calle} <br>
                                ${a.direccion.cp} - ${a.direccion.ciudad} <br>
                                ${a.direccion.provincia} - Spain <br>
                            </div>
                        </c:forEach>
                    </div>
                    <div class="clear"></div>
                    <p class="centro">
                        <button id="btLocalizacion">Dime dónde estoy</button>
                    <div id="mapId" style="margin: auto; width: 512px; height: 512px; position: relative; overflow: hidden;"></div>
                    </p>
                </div>
            </div>
        </div>

        <div class="separa"></div>

        <div class="pie">
            <span class="pie_izda">
                <a href="mailto:francisco-jose.pascual@unirioja.es">Contacto</a> &nbsp; | &nbsp; <a href="mapa.html">Mapa</a> </span>
            <span class="pie_dcha">&copy; 2023 Francisco Pascual</span>
            <div class="clear"></div>  
        </div>

    </div>
</body>
</html>
