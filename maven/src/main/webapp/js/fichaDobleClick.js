window.addEventListener("load", init);

function init(){
    var items = document.querySelectorAll('[class="item redondeo"]');
    
    items.forEach(function(item){
       item.addEventListener("dblclick", function(){
         var href = item.childNodes[1];
         href = href.childNodes[1].getAttribute("href");
         //window.location='http://localhost:8080/pr9/'+href;
         window.open('http://localhost:8080/pr9/'+href, "Ventana", 'width=800,height=600');
       });
    });
}