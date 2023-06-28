# Ayuda para Práctica 8

**Nota**: este fichero tiene formato [markdown](https://daringfireball.net/projects/markdown/syntax). Puedes usar algún plugin de navegador para ver el contenido del fichero de una forma más agradable (ej.: "Markdown Viewer Webext" para Firefox; o "Markdown Viewer" en G. Chrome).


## Efecto sombra en los resultados de búsqueda
```css
-webkit-box-shadow: 0px 20px 20px 0px rgba(0, 0, 0, 0.15);
-moz-box-shadow: 0px 20px 20px 0px rgba(0, 0, 0, 0.15);
box-shadow: 0px 20px 20px 0px rgba(0, 0, 0, 0.15);
z-index: 10;
position: relative;
transform: translate(0,-5px);
```

## Visualización de mapas con [Leaflet](https://leafletjs.com)


Ejemplo de mapa 
```html
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Ejemplo base de leaflet</title>

        <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.3/dist/leaflet.css"
              integrity="sha256-kLaT2GOSpHechhsozzB+flnD+zUyjE2LlfWPgU04xyI="
              crossorigin=""/>
        <script src="https://unpkg.com/leaflet@1.9.3/dist/leaflet.js"
                integrity="sha256-WBkoXOwTeyKclOHuWtc+i2uENFpDZ9YPdf5Hf+D7ewM="
        crossorigin=""></script>
        <script>
            var map;

            function inicializa() {
                var cnf = {
                    center: [40.4169473, -3.7035285],
                    zoom: 6
                }

                map = L.map('mapId', cnf)

                L.tileLayer('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
                    attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://cloudmade.com">CloudMade</a>'
                }).addTo(map);

                // Añade un marcador al mapa 
                L.marker([42.4666700, -2.4238500]).bindPopup("Universidad de La Rioja - CCT").addTo(map);

                // Puedes añadir más marcadores de la misma manera

            }

            window.addEventListener("load", inicializa);

        </script>
    </head>
    <body>
        <div id="mapId" style="margin: auto; width: 512px; height: 512px; position: relative; overflow: hidden;"></div>
    </body>
</html>
```

### Ejemplo de código de geolocalización
```html
<script language="javascript">
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
    alert('Estas en '+latitud+', '+longitud)
  }
</script>
...
<button onclick="obtener_localizacion()">Dime dónde estoy</button>
```

## Ejercicio 3.3.1
Código para la mejora
```css
    input:required:invalid, select:required:invalid {
        border-left: 5px solid #a94442; /* red */
        padding-left: 3px;
        color: #C02C11;
    }

    input:required:valid, select:required:valid  {
        border-left: 5px solid #5C7E6F; /* green */
        padding-left: 3px;
    }
```

## Bootstrap

```html
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Ejemplo base de bootstrap</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>

    </head>
    <body>
        <!-- Button trigger modal -->
        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal">
            Launch demo modal
        </button>

        <!-- Modal -->
        <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="exampleModalLabel">Información de contacto</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                    </div>
                    <div class="modal-body">
                        <a href="mailto:francisco-jose.pascual@unirioja.es">Email</a>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                        <button type="button" class="btn btn-primary" data-bs-dismiss="modal">Cerrar</button>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
```


### Código para el icono "home"
```javascript
var homeIcon = L.icon({
  iconUrl    : 'img/home.png',
  iconSize   : [32, 37], // size of the icon
  iconAnchor : [16, 35], // point of the icon which will correspond to marker's location
  popupAnchor: [0, -37]  // point from which the popup should open relative to the iconAnchor
});

L.marker([…la latitud…, …la longitud…], { icon: homeIcon, title: "Su situación"} )
  .bindPopup("Su situación")
  .addTo(map) 
  .togglePopup();
```


## Font-Awesome

### Mostrar contraseñas en la página de registro de cliente

HTML con el icono con forma de ojo:
```html
<a href="#" class="verContr"><i class="fa-solid fa-eye"></i></a>
```

HTML con el icono con forma de ojo tachado:
```html
<a href="#" class="verContr"><i class="fa-solid fa-eye-slash"></i></a>
```

## Búsqueda "avanzada" de artículos
HTML con los inputs de búsqueda avanzada
```html
<br>
<input type="text" name="nombre" id="nombre" value="" placeHolder="Nombre" style="margin-left: 10px"/>
<input type="text" name="codigo" id="codigo" value="" placeholder="Código" />
```

HTML para añadir el botón con el icono de "tres puntos"
```html
<span>
	&nbsp; 
	<a id="toggleBusquedaAvanzada" title="Búsqueda avanzada"><i class="fa-solid fa-ellipsis-vertical"></i></a>
</span>
```










## HTML de la fila del importe total

```html
<tr class="precTotal"><td id="precioTotal" colspan="5"> TOTAL: </td></tr>
```



