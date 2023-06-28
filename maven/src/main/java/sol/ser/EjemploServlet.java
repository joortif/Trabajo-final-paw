package sol.ser;

import java.io.IOException;
import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.context.support.SpringBeanAutowiringSupport;
import sol.usecases.GuardarArticuloUseCase;

@WebServlet(name = "EjemploServlet", urlPatterns = {"/EjemploServlet"})
public class EjemploServlet extends HttpServlet {

    final Logger logger = LoggerFactory.getLogger(this.getClass());

    @Inject
    private GuardarArticuloUseCase guardarArticuloUseCase;

    @Override
    public void init() throws ServletException {
        super.init();
        SpringBeanAutowiringSupport.processInjectionBasedOnCurrentContext(this);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (guardarArticuloUseCase == null) {
            logger.warn("GuardarArticuloUseCase is null");
        } else {
            System.out.println(guardarArticuloUseCase);
            logger.info("GuardarArticuloUseCase is not null");
        }
    }

}
