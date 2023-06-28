package sol.usecases;

import java.io.File;
import java.io.IOException;
import java.util.logging.Level;
import javax.inject.Named;
import javax.servlet.ServletException;
import javax.servlet.http.Part;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import paw.bd.GestorBD;
import paw.model.Articulo;
import paw.model.ExcepcionDeAplicacion;
import static paw.util.servlet.UtilesServlet.doForward;

@Named
public class GuardarArticuloUseCaseImpl implements GuardarArticuloUseCase {

    private final Logger logger = LoggerFactory.getLogger(this.getClass());

    private GestorBD gestorBD = new GestorBD();

    @Override
    public Articulo execute(GuardarArticuloRequest request) throws ExcepcionDeAplicacion {
        Articulo a = null;
        if (request.foto.getSize() > 0) {
            try {
                saveFotoArticulo(request.foto, request.articulo, request.folderPath);
            }   catch (IOException ex) {
                java.util.logging.Logger.getLogger(GuardarArticuloUseCaseImpl.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        try {
            a = gestorBD.insertaArticulo(request.articulo);
        } catch (ExcepcionDeAplicacion ex) {
            java.util.logging.Logger.getLogger(GuardarArticuloUseCaseImpl.class.getName()).log(Level.WARNING, null, ex);
            throw new ExcepcionDeAplicacion(ex); 
        }
        return a;
    }

    
    private void saveFotoArticulo(Part foto, Articulo art, String folderPath) throws IOException {
        String folderpath = folderPath;
        String filepath = String.format("%s%s", folderpath, art.getFoto());
        if (foto.getSize() > 0) {
            foto.write(filepath);
            foto.delete();
        }
        logger.info("File saved as {}", filepath);
    }

}
