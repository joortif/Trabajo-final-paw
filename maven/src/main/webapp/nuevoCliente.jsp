<%-- 
    Document   : nuevoCliente
    Created on : 18-abr-2023, 17:24:37
    Author     : Joka
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" lang="es-ES">
        <title>Registro</title>
        <script src="https://www.google.com/recaptcha/api.js" async defer></script>
        
        çç<meta name="description" content="Aplicación de prueba de Programación de aplicaciones Web; Grado en informática; Universidad de La Rioja." lang="es-ES">
        <meta name="keywords" content="electrodomesticos" lang="es-ES">
        <meta name="language" content="es-ES">
        <meta name="robots" content="index,follow">

        <link href="css/electrosa.css" rel="stylesheet" media="all" type="text/css">
        <link href="css/formulario.css" rel="stylesheet" media="all" type="text/css">
        <link href="fontawesome/css/all.min.css" rel="stylesheet">
        <script src="js/contraseniasRegistro.js"></script>
    </head>

    <body >
        <jsp:include page="cabecera2.jsp"/>

        <div class="sombra">
            <div class="nucleo">
                <div id="migas">
                    <a href="index.html" title="Inicio" >Inicio</a><!-- &nbsp; | &nbsp; 
                    <a href="..." title="Otra cosa">Otra cosa</a>   -->	
                </div>

                <div class="contenido">

                    <h1>Registro de cliente   </h1>
                    <p>Para poder realizar pedidos on-line a trav&eacute;s de nuestro sistema de pedidos es necesario que se registre. Desde Electrosa le agradecemos su confianza en nosotros. </p>
                    <p>Introduzca los datos solicitados mediante el  siguiente formulario.   </p>

                    <c:if test="${not empty errores}">
                        <div class="alerta">
                            <c:forEach var="e" items="${errores}">
                                <p>${e}</p>
                            </c:forEach>
                        </div>   
                    </c:if>

                    <form name="fCliente" id="fCliente" action="NuevoCliente" method="post">
                        <fieldset> 
                            <legend>Datos de la empresa </legend> 
                            <div class="field">
                                <label for="nombre">Raz&oacute;n social :<span class="Requerido">Requerido</span></label>
                                <input type="text" name="nombre" id="nombre" size="63" value="${cliente.nombre}" required/>
                            </div>
                            <div class="field">
                                <label for="cif">CIF:<span class="Requerido">Requerido</span></label>
                                <input type="text" name="cif" id="cif" size="15" maxsize="12" value="${cliente.cif}" required/>
                            </div>
                            <div class="field">
                                <label for="calle">Dirección:<span class="Requerido">Requerido</span></label>
                                <input class="text" type="text" name="calle" id="calle" size="63" value="${cliente.direccion.calle}" required/>
                            </div>

                            <div>
                                <div class="left">
                                    <div class="field">
                                        <label for="ciudad">Población:<span class="Requerido">Requerido</span></label>
                                        <input class="text" size="15" type="text" name="ciudad" id="ciudad" value="${cliente.direccion.ciudad}" required/>
                                    </div>
                                    <div class="field">
                                        <label for="cp">C.P.:<span class="Requerido">Requerido</span></label>
                                        <input class="text" type="text" name="cp" id="cp" maxsize="5" size="10" value="${cliente.direccion.cp}" required/>
                                    </div>
                                </div>					
                                <!--
                                A Coruña,Álava,Albacete,Alicante,Almería,Araba,Asturias,Ávila,Badajoz,Baleares,Barcelona,Bizkaia,Burgos,Cáceres,Cádiz,Cantabria,Castellón,Ceuta,Ciudad Real,Córdoba,Cuenca,Gerona,Gipuzkoa,Girona,Granada,Guadalajara,Guipuzcoa,Huelva,Huesca,Illes Balears,Jaén,La Coruña,La Rioja,Las Palmas,León,Lérida,Lleida,Lugo,Madrid,Málaga,Melilla,Murcia,Navarra,Orense,Ourense,Palencia,Pontevedra,Salamanca,Santa Cruz de Tenerife,Segovia,Sevilla,Soria,Tarragona,Teruel,Toledo,Valencia,Valladolid,Vizcaya,Zamora,Zaragoza
                                -->
                                <div class="right">
                                    <div class="field">
                                        <label for="provincia">Provincia:<span class="Requerido">Requerido</span></label>					
                                        <select name="provincia" id="provincia" required>
                                            <option value="">- Elige -</option>
                                            <option value="A Coruña">A Coruña</option>
                                            <option value="Álava">Álava</option>
                                            <option value="Albacete">Albacete</option>
                                            <option value="Alicante">Alicante</option>
                                            <option value="Almería">Almería</option>
                                            <option value="Araba">Araba</option>
                                            <option value="Asturias">Asturias</option>
                                            <option value="Ávila">Ávila</option>
                                            <option value="Badajoz">Badajoz</option>
                                            <option value="Baleares">Baleares</option>
                                            <option value="Barcelona">Barcelona</option>
                                            <option value="Bizkaia">Bizkaia</option>
                                            <option value="Burgos">Burgos</option>
                                            <option value="Cáceres">Cáceres</option>
                                            <option value="Cádiz">Cádiz</option>
                                            <option value="Cantabria">Cantabria</option>
                                            <option value="Castellón">Castellón</option>
                                            <option value="Ceuta">Ceuta</option>
                                            <option value="Ciudad Real">Ciudad Real</option>
                                            <option value="Córdoba">Córdoba</option>
                                            <option value="Cuenca">Cuenca</option>
                                            <option value="Gerona">Gerona</option>
                                            <option value="Gipuzkoa">Gipuzkoa</option>
                                            <option value="Girona">Girona</option>
                                            <option value="Granada">Granada</option>
                                            <option value="Guadalajara">Guadalajara</option>
                                            <option value="Guipuzcoa">Guipuzcoa</option>
                                            <option value="Huelva">Huelva</option>
                                            <option value="Huesca">Huesca</option>
                                            <option value="Illes Balears">Illes Balears</option>
                                            <option value="Jaén">Jaén</option>
                                            <option value="La Coruña">La Coruña</option>
                                            <option value="La Rioja">La Rioja</option>
                                            <option value="Las Palmas">Las Palmas</option>
                                            <option value="León">León</option>
                                            <option value="Lérida">Lérida</option>
                                            <option value="Lleida">Lleida</option>
                                            <option value="Lugo">Lugo</option>
                                            <option value="Madrid">Madrid</option>
                                            <option value="Málaga">Málaga</option>
                                            <option value="Melilla">Melilla</option>
                                            <option value="Murcia">Murcia</option>
                                            <option value="Navarra">Navarra</option>
                                            <option value="Orense">Orense</option>
                                            <option value="Ourense">Ourense</option>
                                            <option value="Palencia">Palencia</option>
                                            <option value="Pontevedra">Pontevedra</option>
                                            <option value="Salamanca">Salamanca</option>
                                            <option value="Santa Cruz de Tenerife">Santa Cruz de Tenerife</option>
                                            <option value="Segovia">Segovia</option>
                                            <option value="Sevilla">Sevilla</option>
                                            <option value="Soria">Soria</option>
                                            <option value="Tarragona">Tarragona</option>
                                            <option value="Teruel">Teruel</option>
                                            <option value="Toledo">Toledo</option>
                                            <option value="Valencia">Valencia</option>
                                            <option value="Valladolid">Valladolid</option>
                                            <option value="Vizcaya">Vizcaya</option>
                                            <option value="Zamora">Zamora</option>
                                            <option value="Zaragoza">Zaragoza</option>
                                        </select>
                                    </div>
                                    <div class="field">
                                        <label for="tfno">Teléfono:<!--<span class="Requerido">Requerido</span> --></label>
                                        <input class="text" type="text" name="tfno" id="tfno" value="${cliente.tfno}" />
                                    </div>
                                </div>		
                            </div>

                            <div class="field">
                                <label for="email">Email:<span class="Requerido">Requerido</span></label>
                                <input class="text" type="email" name="email" id="email" size="40" value="${cliente.email}" required/>
                            </div>
                        </fieldset>

                        <fieldset> 
                            <legend>Datos de acceso</legend>
                            <div class="field">
                                <label for="login">Nombre de usuario:<span class="Requerido">Requerido</span></label>
                                <input class="text" type="text" name="login" id="login" size="10" value="${login}" required/>
                            </div>

                            <div>
                                <div class="left">
                                    <div class="field">
                                        <label for="pwd">Contraseña:<span class="Requerido">Requerido</span></label>
                                        <input class="text" type="password" name="pwd" id="pwd" size="10" value="" required/>
                                        <a class="verContr"><i class="fa-solid fa-eye"></i></a>
                                    </div>
                                </div>					

                                <div class="right">
                                    <div class="field">
                                        <label for="rpwd">Repita contraseña:<span class="Requerido">Requerido</span></label> 
                                        <input class="text" type="password" name="rpwd" id="rpwd" size="10" value="" required/> <%-- Se ha quitado el href="#" para que no aparezca en el link de la pagina --%>
                                        <a class="verContr"><i class="fa-solid fa-eye"></i></a>
                                    </div>
                                </div>		
                            </div>
                        </fieldset>
                        <fieldset> 
                            <legend>Captcha</legend> 
                            <div class="field">
                                <div class="g-recaptcha" data-sitekey="${recaptchaConfig.siteKey}"></div>
                            </div>
                        </fieldset>
                        <fieldset class="submit"> 
                            <div class="left">
                                <div class="field">			  
                                    <input type="checkbox" name="privacidad" value="1" id="privacidad" <c:if test="${not empty privacidad}"> checked </c:if> required> <label for="privacidad" style="float:none">He leido y acepto la <a href="privacidad.html">Política de privacidad</a></label>
                                    </div>
                                </div>
                                <div class="right">
                                    <div class="field">
                                        <button type="submit" value="submit">Guardar cliente</button>
                                    </div>
                                </div>
                            </fieldset>
                        </form>
                    </div>

                </div>

                <div class="separa"></div>
            <%@ include file="pie.html"%>

        </div>
    </body>
</html>
