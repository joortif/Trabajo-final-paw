window.onload = function () {
    document
            .querySelectorAll(".modal-detalle-pedido")
            .forEach(addDetallePedidoEventListener);
    // Pregunta 1
	// forEach no era un método de Array? 
	// Qué devuelve querySelectorAll?
    // Habíamos visto que para usar .map, primero se transformaba el objeto a un Array con Array.from()
	
	// Pregunta 2
	// Se podría hacer de otra forma usando delegación de eventos?
};

function addDetallePedidoEventListener(element) {
    element.addEventListener('click',
            function (event)
            {
                event = event || window.event;
                var el = event.target || event.srcElement;
                if (el instanceof HTMLAnchorElement)
                {
					event.preventDefault();
                    href = el.getAttribute('href');
                    modalDetallePedido(href);
                }
            });
}

function modalDetallePedido(url) {
    console.log(url);
    fetch(url, {
        headers: {
            'Accept': 'application/json',
        },
    })
            .then(response => response.json())
            .then(response => renderDetallesPedido(response, url))
            .catch(err => console.error(err));
}

function renderDetallesPedido(data, url) {
	// recuperar la plantilla
    var rawTemplate = document.getElementById("pedidoTemplate").innerHTML;
    var template = Handlebars.compile(rawTemplate);
    pedidoHtml = template({pedido: data, codigoPedido: data.codigo});

	// incluir el html generado dentro del modal
    document.getElementById("pedidoTableDetails").innerHTML = pedidoHtml;
    window.modalDetallesPedido.showModal();
}