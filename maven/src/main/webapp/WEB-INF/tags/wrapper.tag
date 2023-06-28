
<%@tag description="Simple Wrapper Tag" pageEncoding="UTF-8"%>
<%@attribute name="pageTitle" required="false"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" lang="es-ES">
        <title>Electrosa <c:if test="${pageTitle != null}">>> ${pageTitle}</c:if></title>
        <meta name="description" content="Aplicación de prueba de Programación de aplicaciones Web; Grado en informática; Universidad de La Rioja." lang="es-ES">
        <meta name="keywords" content="electrodomesticos" lang="es-ES">
        <meta name="language" content="es-ES">
        <meta name="robots" content="index,follow">

        <link href="../css/electrosa.css" rel="stylesheet" media="all" type="text/css">
        <link href="../css/clientes.css" rel="stylesheet" media="all" type="text/css">
        <link href="../css/pedidoR.css" rel="stylesheet" media="all" type="text/css">
    </head>

    <body >
        <div class="logo"><a href="../index.html"><img src="../img/LogoElectrosa200.png" border="0"></a></div>


        <div class="sombra">
            <div class="nucleo">
                <div id="lang">
                    <a href="index.html">Español</a> &nbsp; | &nbsp; <a href="index.html">English</a>
                </div>
            </div>
        </div>  

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
                        <a href="../Salir">Cerrar sesión </a>	
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
                    Bienvenido, PEPE PEREZ
                </div>
                <div class="clear"></div>
                <div class="contenido">

                    <jsp:doBody/>

                </div>
                <div class="clear"></div>
            </div>

            <div class="separa"></div>

            <div class="pie">
                <span class="pie_izda">
                    <a href="mailto:francisco-jose.pascual@unirioja.es">Contacto</a> &nbsp; | &nbsp; <a href="../mapa.html">Mapa</a> </span>
                <span class="pie_dcha">
                    &copy; 2023 Francisco Pascual </span>
                <div class="clear"></div>  
            </div>

        </div>
    </body>
</html>