window.addEventListener("load", init);

function init(){
    var inputs = document.querySelectorAll("input");
    
    inputs.forEach(function(input){
        input.addEventListener("keydown", function(ev){
            if (ev.keyCode === 13){ //El keyCode 13 se corresponde con el intro
                ev.preventDefault();
            }
        });
    });    
}