window.addEventListener("load", init);

function init(){
    var selects = document.querySelectorAll(".contenido select");
    
    for (let i =0; i<selects.length; i++){
        selects[i].addEventListener("change", function(){
            selects[i].form.submit();
        });
    }
    /*Aunque implementa funcionalidad de búsqueda automática, al hacer scroll hacia abajo
    * del todo y despues cambiar alguno de los valores de los selectores, la barra lateral
    * vuelve al comienzo y resulta incómodo para el usuario, la página se recarga por completo. */
    
}