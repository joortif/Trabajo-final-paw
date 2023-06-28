window.addEventListener("load", init);

function init(){
    var selects = document.querySelectorAll(".cantidad");
    
    for (let i =0; i<selects.length; i++){
        selects[i].addEventListener("change", compruebaStock);
    }
}

function compruebaStock() {
    var cantidad = this;
    articuloId = this.parentNode.parentNode.querySelector('.codigo').textContent;
    
    fetch('../api/stock/articulo/' + articuloId)
            .then(response => response.text())
            .then(response => cambiarColor(parseInt(response), cantidad))
            .catch(err => console.error(err));
}

function cambiarColor(data, input) {
    if (data < parseInt(input.value)){
        if (!input.classList.contains("vacio")){
            input.classList.remove("disponible");
            input.classList.add("vacio");
        }
    } else {
        if (!input.classList.contains("disponible")){
            input.classList.remove("vacio");
            input.classList.add("disponible");
        }
    }
    
}
