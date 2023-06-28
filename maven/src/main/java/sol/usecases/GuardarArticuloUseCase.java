package sol.usecases;

import paw.model.Articulo;
import paw.model.ExcepcionDeAplicacion;

public interface GuardarArticuloUseCase {

    public Articulo execute(GuardarArticuloRequest request) throws ExcepcionDeAplicacion;
}
