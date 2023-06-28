<%-- 
    Document   : error
    Created on : 21-mar-2023, 17:33:18
    Author     : Joka
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@page contentType="text/html" pageEncoding="UTF-8" isErrorPage="true"%>
<!DOCTYPE html>
<html>
    <c:set var="context" value="${pageContext.request.contextPath}/"></c:set>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" lang="es-ES">
        <title>Electrosa >> Error de aplicación</title>
        <meta name="description" content="Aplicación de prueba de Programación de aplicaciones Web; Grado en informática; Universidad de La Rioja." lang="es-ES">
        <meta name="keywords" content="electrodomesticos" lang="es-ES">
        <meta name="language" content="es-ES">
        <meta name="robots" content="index,follow">

        <link href="${context}css/electrosa.css" rel="stylesheet" media="all" type="text/css">
    </head>

    <body>
        <jsp:include page="${requestScope['javax.servlet.forward.servlet_path'].substring(0,requestScope['javax.servlet.forward.servlet_path'].lastIndexOf('/'))}/cabecera.html"></jsp:include>
        
        
        <div class="sombra">
            <div class="nucleo">
                <div id="migas">
                    <a href="index.html" title="Inicio" >Inicio</a><!-- &nbsp; | &nbsp; 
                    <a href="..." title="Otra cosa">Otra cosa</a>   -->	
                </div>

                <div class="contenido">
                    <div style="float:left"><img src="${context}img/alerta.png"></div>
                    <div class="error">
                        <div><c:out default="Error de aplicación"
                               value="Error ${requestScope['javax.servlet.error.status_code']}:  
                               ${requestScope['javax.servlet.error.message']}"/></div>
                        <div class="errorb"><a href="${enlaceSalir}">Salir de aqui</a></div>
                    </div>
                    <div class="clear"></div>

                </div>
            </div>

            <%@ include file="pie.html"%>

        </div>
    </body>
</html>
