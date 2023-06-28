package sol.ser;

import java.io.IOException;
import java.util.logging.*;
import javax.servlet.*;
import javax.servlet.http.*;
import paw.bd.GestorBD;
import paw.model.*;
import paw.util.UtilesString;

public class FichaArticulo extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String cart = request.getParameter("cart");
        try {
            if (UtilesString.isVacia(cart)) {
                response.sendRedirect("index.html");
            } else {
                Articulo articulo = new GestorBD().getArticulo(cart);
                if (articulo == null) {
                    request.setAttribute("enlaceSalir", "BuscarArticulos");
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "El artículo " + cart + " no existe");
                    return;
                } else {
                    request.setAttribute("art", articulo);
                    RequestDispatcher rd = request.getRequestDispatcher("fichaArticulo.jsp");
                    rd.forward(request, response);
                }
            }
        } catch (ExcepcionDeAplicacion ex) {
            Logger.getLogger(FichaArticulo.class.getName()).log(Level.SEVERE, null, ex);
            request.setAttribute("enlaceSalir", "index.html");
            throw new ServletException(ex);
        }
    }

}
