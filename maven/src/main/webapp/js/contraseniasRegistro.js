window.addEventListener("load", init);

function init(){
    
    var contrs = document.getElementsByClassName("verContr");
    
    for (let i=0; i<contrs.length; i++){
        contrs[i].addEventListener('click', gestionaContrasenia);
    }
    
    function gestionaContrasenia(ev){
        ev.preventDefault();
        
        let padre = this.parentNode;
        let hijos = padre.childNodes;
        
        let input = hijos[3];
        let a = hijos[5];
        let img = a.firstChild;
        
        if (input.getAttribute("type") === "password"){
            input.setAttribute("type","text");
            img.setAttribute("class","fa-solid fa-eye-slash");
        } else {
            input.setAttribute("type","password");
            img.setAttribute("class","fa-solid fa-eye");
        }
    }
    
    
}