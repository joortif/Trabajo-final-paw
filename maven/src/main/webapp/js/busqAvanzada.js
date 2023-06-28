window.addEventListener("load", init);

function init() {
    var inpNombre = document.getElementById("nombre");
    var inpCodigo = document.getElementById("codigo");
    var lbNombre = document.getElementById("lbNombre");
    var lbCodigo = document.getElementById("lbCodigo");
    var selectPrecio = document.getElementById("precio");

    if (inpNombre.value === "" && inpCodigo.value === "") {
        //Se ocultan
        inpNombre.hidden = true;
        inpCodigo.hidden = true;
        lbNombre.hidden = true;
        lbCodigo.hidden = true;

        //No se envian al formulario
        inpNombre.disabled = true;
        inpCodigo.disabled = true;
        lbNombre.disabled = true;
        lbCodigo.disabled = true;

        //Añadir el nodo despues de select
        var iconoNuevo = document.createElement("span");
        iconoNuevo.innerHTML = "&nbsp; <a id='toggleBusquedaAvanzada' title='Búsqueda avanzada'><i class='fa-solid fa-ellipsis-vertical'></i></a>";
        selectPrecio.after(iconoNuevo);

        //Manejador del icono de tres puntos
        var t = document.getElementById("toggleBusquedaAvanzada");
        t.addEventListener("click", function () {
            inpNombre.hidden = false;
            inpCodigo.hidden = false;
            lbNombre.hidden = false;
            lbCodigo.hidden = false;

            inpNombre.disabled = false;
            inpCodigo.disabled = false;
            lbNombre.disabled = false;
            lbCodigo.disabled = false;

            t.hidden = true;
        });
    }
}