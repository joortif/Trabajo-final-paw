package sol.usecases;

import javax.servlet.http.Part;
import paw.model.Articulo;

public class GuardarArticuloRequest {

    public final Articulo articulo;
    public final Part foto;
    public final String folderPath;

    public GuardarArticuloRequest(Articulo articulo, Part foto, String folderPath) {
        this.articulo = articulo;
        this.foto = foto;
        this.folderPath = folderPath;
    }

}
