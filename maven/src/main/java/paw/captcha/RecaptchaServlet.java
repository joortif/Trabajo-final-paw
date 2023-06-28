package paw.captcha;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import paw.util.ReCaptchaException;

@WebServlet(name = "RecaptchaServlet", urlPatterns = {"/recaptcha"})
public class RecaptchaServlet extends HttpServlet {

    private final Logger logger = LoggerFactory.getLogger(this.getClass());

    private final String siteKey = "6Lf513AlAAAAAKM7XSXwV15s76ZehLK7suwvEBEE"; // TODO: parametros de la aplicacion grabados en el propio codigo?
    private final String secret = "6Lf513AlAAAAAGwrJwIygVuQvpgomBY7ZQTXdsv3";  // estarian mejor en otro sitio? En un fichero aparte.

    private final ReCaptchaConfig recaptchaConfig = new ReCaptchaConfig(siteKey, secret);

    @Override

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("recaptchaConfig", recaptchaConfig);
        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/pages/recaptcha.jsp");
        rd.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        logger.info("Procesando formulario");
        CaptchaValidator captchaValidator = new ReCaptchaValidatorV2(recaptchaConfig);

        boolean verifyResponse;
        PrintWriter out = response.getWriter();
        try {
            verifyResponse = captchaValidator.checkUserResponse(request);
        } catch (ReCaptchaException ex) {
            logger.error("Error validando captcha", ex);
            verifyResponse = false;
        }
        logger.info("Captcha success? {}", verifyResponse);
        out.println("Captcha success?: " + verifyResponse);

    }

}
