window.addEventListener("load", init);

function init() {
    document.getElementById("manejador").onclick = function () {
        console.log('Hola mundo 2');
    };

    var h = document.getElementById('eventListener');
    h.addEventListener('click', function (e) {
        console.log('Hola mundo 3');
        e.preventDefault();
    });
}
