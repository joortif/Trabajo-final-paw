window.addEventListener("load", updateCurrentStock());

function updateCurrentStock() {
    const searchParams = window.location.search;
    //console.log(window.location.search);
    const params = new URLSearchParams(window.location.search);
    const articuloId = params.get('cart');
    //console.log(`cart=${articuloId}: reloading stock`);
    
    fetch('api/stock/articulo/' + articuloId)
            .then(response => response.text())
            .then(response => renderCurrentStock(response))
            .catch(err => console.error(err));
}

function renderCurrentStock(data) {
    //console.log(data);
    const stockQuantity = document.getElementById("stockQuantity");
    stockQuantity.innerHTML = data + ' unidades';
}