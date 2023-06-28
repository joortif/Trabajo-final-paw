/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package sol.ser;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Calendar;
import java.util.Enumeration;
import java.util.logging.Level;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import paw.model.Articulo;
import paw.model.Cliente;
import paw.model.ExcepcionDeAplicacion;
import paw.model.LineaEnRealizacion;
import paw.model.PedidoEnRealizacion;
import paw.util.UtilesString;
import paw.util.servlet.ParameterParser;
import paw.util.servlet.UtilesServlet;

/**
 *
 * @author Joka
 */
@WebServlet(name = "GestionaPedido", urlPatterns = {"/clientes/GestionaPedido"})
public class GestionaPedido extends GestionaBDPedidos {

    private void procesaParams(PedidoEnRealizacion carrito, HttpServletRequest req) {
        ParameterParser pp = new ParameterParser(req);
        Enumeration<String> pnames = req.getParameterNames();
        while (pnames.hasMoreElements()) {
            String paramName = pnames.nextElement();
            if (paramName.startsWith("C_")) {
                String codLinea = paramName.substring(2);
                LineaEnRealizacion linea = carrito.getLinea(codLinea);
                int cantidad = pp.getIntParameter(paramName, 1);
                linea.setCantidad(cantidad);
            } else if (paramName.startsWith("F_")) {
                String codLinea = paramName.substring(2);
                LineaEnRealizacion linea = carrito.getLinea(codLinea);
                Calendar fe = pp.getCalendarParameter(paramName, "dd/MM/yyyy", Calendar.getInstance());
                linea.setFechaEntregaDeseada(fe);
            }
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
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    private void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            HttpSession sesion = request.getSession();
            PedidoEnRealizacion carrito = (PedidoEnRealizacion) sesion.getAttribute("carrito");
            Cliente cliente = (Cliente) sesion.getAttribute("cliente");
            if (carrito == null) {
                PedidoEnRealizacion carritoBD = gbdp.getPedidoEnRealizacion(cliente.getCodigo());
                if (carritoBD != null) {
                    carrito = carritoBD;
                } else {
                    carrito = new PedidoEnRealizacion(cliente);
                }
            }
            sesion.setAttribute("carrito", carrito);
            String accion = request.getParameter("accion");

            switch (accion) {
                case "Comprar":
                    String codigoArticulo = request.getParameter("ca");
                    Articulo art = gbd.getArticulo(codigoArticulo);
                    if (UtilesString.isVacia(codigoArticulo) || gbd.getArticulo(codigoArticulo) == null) {
                        request.setAttribute("enlaceSalir", request.getHeader("referer"));
                        response.sendError(HttpServletResponse.SC_NOT_FOUND, "El artículo solicitado no existe.");
                    } else {
                        carrito.addLinea(art);
                        //UtilesServlet.doForward(request, response, "carrito.jsp"); Al hacer F5 realiza la request otra vez, hay que hacer Redirect por el PRG
                        response.sendRedirect("Carrito");
                    }
                    break;
                case "SeguirComprando":
                    procesaParams(carrito, request);
                    response.sendRedirect("../BuscarArticulos");
                    break;
                case "GuardarPedido": 
                    procesaParams(carrito, request);
                    gbdp.grabaPedidoEnRealizacion(carrito);
                    response.sendRedirect("AreaCliente");
                    break;
                case "Quitar": 
                    procesaParams(carrito, request);    
                    String codigoLinea = request.getParameter("cl");
                    if (UtilesString.isVacia(codigoLinea) || carrito.getLinea(codigoLinea) == null){
                        request.setAttribute("enlaceSalir", request.getHeader("referer"));
                        response.sendError(HttpServletResponse.SC_NOT_FOUND, "La línea a eliminar no existe.");
                    } else {
                        carrito.removeLinea(codigoLinea);
                        response.sendRedirect("Carrito");
                    }
                    break;
                case "CerrarPedido":
                    procesaParams(carrito, request);
                    sesion.setAttribute("carritoACerrar", carrito);
                    request.setAttribute("msg", "Se va a proceder a cerrar su pedido en realización. ¿Está usted seguro?");
                    request.setAttribute("siLink", "CierraCarrito?accion=cerrar");
                    request.setAttribute("noLink", "CierraCarrito?accion=cancelar");
                    UtilesServlet.doForward(request, response, "confirmacion.jsp");
                    break;
                case "Cancelar":
                    procesaParams(carrito, request);
                    sesion.setAttribute("carritoACancelar", carrito);
                    request.setAttribute("msg", "Se va a proceder a eliminar su pedido en realización. ¿Está usted seguro?");
                    request.setAttribute("siLink", "AnulaCarrito?accion=anular");
                    request.setAttribute("noLink", "AnulaCarrito?accion=cancelar");
                    UtilesServlet.doForward(request, response, "confirmacion.jsp");
                    break;
                case "CerrarSesion":
                    procesaParams(carrito, request);
                    gbdp.grabaPedidoEnRealizacion(carrito);
                    response.sendRedirect("../Salir");
                    break;
            }
        } catch (ExcepcionDeAplicacion ex) {
            java.util.logging.Logger.getLogger(GestionaPedido.class.getName()).log(Level.WARNING, null, ex);
            throw new ServletException(ex);
        }
    }

}
