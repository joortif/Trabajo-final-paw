window.addEventListener("load",init);

function init(){
    var as = document.querySelector(".modovisual").getElementsByTagName("a");
    as[0].addEventListener("click",function (evt){
        cambiadorCss.setHojaCss("mosaico");
        evt.preventDefault();
    });
    as[1].addEventListener("click",function (evt){
        cambiadorCss.setHojaCss("lista");
        evt.preventDefault();
    });
}
