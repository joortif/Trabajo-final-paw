window.addEventListener("load", init);

function init(){
    calcular();
    var inputsCantidad = document.querySelectorAll(".cantidad");
    
    inputsCantidad.forEach(function(input){
       input.addEventListener("change", calcular); 
    });
}

function calcular(){
    var pvps = document.getElementsByClassName("pvp");
    var suma = 0.0;
    for (let i=0; i<pvps.length; i++){
        let pvpFila = pvps[i].textContent;
        let cant = pvps[i].nextSibling;
        while (cant.nodeType !== 1){
            cant = cant.nextSibling;
        }
        cant = cant.childNodes.item(1).value;
        suma = suma + parseFloat(pvpFila.slice(0,-2)*cant);
    }
    suma = parseFloat(suma.toFixed(2)); // Redondear a dos decimales
    var precioTotal = document.getElementById("precioTotal");
    precioTotal.textContent = "TOTAL: " + suma + " €"; 
}