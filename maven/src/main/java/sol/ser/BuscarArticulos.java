/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package sol.ser;

import java.io.IOException;
import java.util.List;
import java.util.logging.Level;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import paw.bd.CriteriosArticulo;
import paw.bd.GestorBD;
import paw.bd.Paginador;
import paw.model.Articulo;
import paw.model.ExcepcionDeAplicacion;
import paw.util.UtilesString;

/**
 *
 * @author Joka
 */
public class BuscarArticulos extends HttpServlet {

    private static int tamanioPagina = 15;
    private static GestorBD gbd = new GestorBD();

    @Override
    public void init() throws ServletException {
        super.init();
        try {
            tamanioPagina = Integer.parseInt(this.getInitParameter("tamanioPagina"));
        } catch (Exception ex) {
            java.util.logging.Logger.getLogger(BuscarArticulos.class.getName()).log(Level.WARNING, null, ex);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Paginador paginador;
            CriteriosArticulo critArt = new CriteriosArticulo();
            request.setAttribute("tipos", gbd.getTiposArticulos());
            request.setAttribute("fabricantes", gbd.getFabricantes());
            String tipo = request.getParameter("tipo");
            String fabricante = request.getParameter("fabricante");
            String precio = request.getParameter("precio");
            String nombre = request.getParameter("nombre");
            String codigo = request.getParameter("cod");
            if (UtilesString.isVacia(tipo) && UtilesString.isVacia(fabricante) && UtilesString.isVacia(precio) && UtilesString.isVacia(nombre) && UtilesString.isVacia(codigo)) {
                paginador = gbd.getPaginadorArticulos(critArt, tamanioPagina);
                String p = request.getParameter("p");
                int numPag = 1;
                try {
                    if (!UtilesString.isVacia(p) && Integer.parseInt(p) > 1) {
                        numPag = Integer.parseInt(p);
                        if (numPag > paginador.getNumPaginas()) {
                            numPag = paginador.getNumPaginas();
                        }
                    }
                } catch (NumberFormatException nfe) {
                    response.sendRedirect("BuscarArticulos?p=" + numPag);
                    return;
                }
                List<Articulo> lista = gbd.getArticulos(critArt, numPag, tamanioPagina);
                request.setAttribute("tipo", "");
                request.setAttribute("fabricante", "");
                request.setAttribute("precio", "");
                request.setAttribute("nombre", "");
                request.setAttribute("cod", "");
                request.setAttribute("articulos", lista);
                RequestDispatcher rd = request.getRequestDispatcher("/catalogo.jsp");
                rd.forward(request, response);
            } else {
                critArt.setTipo(tipo);
                critArt.setFabricante(fabricante);
                critArt.setPrecio(precio);
                critArt.setNombre(nombre);
                critArt.setCodigo(codigo);
                paginador = gbd.getPaginadorArticulos(critArt, tamanioPagina);
                String p = request.getParameter("p");
                int numPag = 1;
                try {
                    if (!UtilesString.isVacia(p) && Integer.parseInt(p) > 1) {
                        numPag = Integer.parseInt(p);
                        if (numPag > paginador.getNumPaginas()) {
                            numPag = paginador.getNumPaginas();
                        }
                    }
                } catch (NumberFormatException nfe) {
                    response.sendRedirect("BuscarArticulos?tipo=" + tipo + "&fabricante=" + fabricante + "&precio=" + precio + "&nombre=" + nombre + "&cod=" + codigo + "&p=" + numPag);
                    return;
                }
                List<Articulo> lista = gbd.getArticulos(critArt, numPag, tamanioPagina);
                if (lista.size() == 1 && numPag == 1) {
                    Articulo art = lista.get(0);
                    response.sendRedirect("FichaArticulo?cart=" + art.getCodigo());
                    return;
                }
                request.setAttribute("tipo", tipo);
                request.setAttribute("fabricante", fabricante);
                request.setAttribute("precio", precio);
                request.setAttribute("nombre", nombre);
                request.setAttribute("cod", codigo);
                request.setAttribute("pag", numPag);
                request.setAttribute("paginador", paginador);
                request.setAttribute("articulos", lista);
                RequestDispatcher rd = request.getRequestDispatcher("/catalogo.jsp");
                rd.forward(request, response);
            }

        } catch (ExcepcionDeAplicacion ex) {
            java.util.logging.Logger.getLogger(BuscarArticulos.class.getName()).log(Level.WARNING, null, ex);
            throw new ServletException(ex);
        }

    }

}
