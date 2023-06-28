<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>PAW</title>
        <script src="https://www.google.com/recaptcha/api.js" async defer></script>
        <link href="css/electrosa.css" rel="stylesheet" media="all" type="text/css">
        <link href="css/formulario.css" rel="stylesheet" media="all" type="text/css">
        <link href="css/clientes.css" rel="stylesheet" media="all" type="text/css">
        <link href="css/estilomenu.css" rel="stylesheet" media="all" type="text/css" />
        <link href="css/nuevoArticulo.css" rel="stylesheet" media="all" type="text/css" />
    </head>
    <body>
        <h1>ReCaptcha: versión 2</h1>
        <form action="" method="POST">
            <fieldset> 
                <legend>Captcha</legend> 
                <div class="field">
                    <div class="g-recaptcha" data-sitekey="${recaptchaConfig.siteKey}"></div>
                </div>
            </fieldset>
            <fieldset class="submit"> 
                <div class="left">
                    <div class="field">			  
                        <input type="checkbox" name="privacidad" value="1" id="privacidad"> <label for="privacidad" style="float:none">He leido y acepto la <a href="privacidad.html">Política de privacidad</a></label>
                    </div>
                </div>
                <div class="right">
                    <div class="field">
                        <button type="submit" value="submit">Guardar cliente</button>
                    </div>
                </div>
            </fieldset>
        </form>



    </body>
</html>
