<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" lang="es-ES">
    <title>Nuevo art&iacute;culo</title>
    <meta name="description" content="Aplicación de prueba de Programación de aplicaciones Web; Grado en informática; Universidad de La Rioja." lang="es-ES">
    <meta name="keywords" content="electrodomesticos" lang="es-ES">
    <meta name="language" content="es-ES">
    <meta name="robots" content="index,follow">

    <link href="../css/electrosa.css" rel="stylesheet" media="all" type="text/css">
    <link href="../css/formulario.css" rel="stylesheet" media="all" type="text/css">
    <link href="../css/clientes.css" rel="stylesheet" media="all" type="text/css">
    <link href="../css/estilomenu.css" rel="stylesheet" media="all" type="text/css" />
	<link href="../css/nuevoArticulo.css" rel="stylesheet" media="all" type="text/css" />
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
          <div class="pestaniaNoSel"><a href="../index.html">Para usuarios</a></div>
          <div class="pestaniaSel">Intranet</div>
        </div>
      </div>

      <div id="cssmenu">
        <ul>
          <li class='has-sub'><a href="index.html">Art&iacute;culos</a>
            <ul>
              <li><a href="listadoArticulos.jsp">Listar</a></li>
              <li><a href="NuevoArticulo">A&ntilde;adir</a> </li>
              <li><a href="HazEstadistica">Estadísticas</a> </li>
            </ul>
          </li>
          <li class='has-sub'><a href="index.html">Clientes</a>	
            <ul>
              <li><a href="index.html">Listar</a> </li>
              <li><a href="index.html">A&ntilde;adir</a> </li>
            </ul>    
          </li>
          <li><a href="index.html">Pedidos</a></li>
          <li class='last'><a href="index.html">Stocks</a></li>
        </ul>
        <div style="clear: left;"></div>
      </div>
    </div> 

    <div class="sombra">
      <div class="nucleo">
        <div id="migas">
          <a href="index.html" title="Inicio" >Inicio</a>
        </div>

        <div class="clear"></div>

        <div class="contenido">

          <h1>A&ntilde;adir un art&iacute;culo    </h1>
          <p>Utilice el siguiente formulario.   </p>

          <c:if test="${not empty errores}">
              <div class="alerta">
                  <c:forEach var="e" items="${errores}">
                      <p>${e}</p>
                  </c:forEach>
              </div>   
          </c:if>

          <form id="fArtic" name="fArtic" action="NuevoArticulo" method="post" enctype="multipart/form-data">
            <fieldset> 
              <legend>Datos del art&iacute;culo </legend> 
              <div class="field">
                <label for="nombre">Nombre:
                  <span class='Requerido'>Requerido</span>
                </label>
                <input type="text" name="nombre" id="nombre" size="55" value="${nombre}" required>
              </div>
              <div class="field">
                <label for="pvp">P.V.P:
                  <span class='Requerido'>Requerido</span>
                </label>
                <input type="text" name="pvp" id="pvp" size="15" value="${pvp}" required>
              </div>
              <div>
                <div class="left">
                  <div class="field">
                    <label for="tipo">Tipo:
                      <span class='Requerido'>Requerido</span>
                    </label>
                    <select name="tipo" id="tipo" required>
                      <option disabled selected value="">- Elige -</option>                      
                      <c:forEach var="t" items="${tipos}">
                        <option value="${t}" ${(t eq tipo ? 'selected' : '')}>${t}</option>
                      </c:forEach>
                    </select>       
                    <input id="otroTip" type="checkbox" name="" value="" title="Introduce otro tipo" disabled/>               
                    Otro 
                    <div id="otrotipoCont"><!--<label>&nbsp;</label><input class="text" type="text" name="tipo" id="tipo" value="" >--></div>
                  </div>
                </div>
                <div class="right">
                  <div class="field">
                    <label for="fabricante">Fabricante:
                      <span class='Requerido'>Requerido</span>
                    </label>
                    <select name="fabricante" id="fabricante" required>
                      <option disabled selected value="">- Elige -</option>    
                      <c:forEach var="f" items="${fabricantes}">
                        <option value="${f}" ${(f eq fabricante ? 'selected' : '')}>${f}</option>
                      </c:forEach>                      
                    </select>
                    <input id="otroFab" type="checkbox" name="" value=""  title="Introduce otro fabricante" disabled/>
                    Otro 
                    <div id="otrofabricanteCont"><!--<label>&nbsp;</label><input class="text" type="text" name="fabricante" id="fabricante" value="" >--></div>
                  </div>
                </div>		
              </div>

              <div class="field">
                <label for="descripcion">
                  Descripci&oacute;n:
                </label>
                <textarea name="descripcion" id="descripcion" cols="70" rows="3">${descr}</textarea>
              </div>
                       

              <div class="field">
                <label for="fichFoto" class="fotoBtn">
                  Fichero fotograf&iacute;a
                </label>
                <input type="file" name="fichFoto" id="fichFoto" style="display:none">
                <c:if test="${not empty foto}">
                   <p>${foto}</p> 
                   <button type="submit" name="accion" value="quitar" class="quitar" style="background:transparent; border:none;"><img src="../img/cancel.png" alt="Quitar imagen" border="0" title="Quitar imagen"></button>
                </c:if>
                
                
              </div>


            </fieldset>


            <fieldset class="submit"> 
              <div class="right">
                <div class="field">
                  <button class="submitb" type="submit"  value="Enviar los datos" >Guardar</button>  
                </div>
              </div>
            </fieldset>  
          </form>

        </div>
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
