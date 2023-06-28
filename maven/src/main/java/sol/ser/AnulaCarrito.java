/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package sol.ser;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Level;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import paw.model.Cliente;
import paw.model.ExcepcionDeAplicacion;
import paw.model.Pedido;
import paw.model.PedidoEnRealizacion;

/**
 *
 * @author Joka
 */
@WebServlet(name = "AnulaCarrito", urlPatterns = {"/clientes/AnulaCarrito"})
public class AnulaCarrito extends GestionaBDPedidos {

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
            HttpSession sesion = request.getSession();
            PedidoEnRealizacion carritoACancelar = (PedidoEnRealizacion) sesion.getAttribute("carritoACancelar");
            Cliente cliente = (Cliente) sesion.getAttribute("cliente");
            if (carritoACancelar != null){
                String accion = request.getParameter("accion");
                if (accion.equals("anular")){
                    gbdp.anulaPedido(carritoACancelar);
                    sesion.removeAttribute("carritoACerrar");
                    sesion.removeAttribute("carrito");
                    response.sendRedirect("AreaCliente");
                } else {
                    sesion.removeAttribute("carritoACerrar");
                    response.sendRedirect("Carrito");
                }
            } else {
                request.setAttribute("enlaceSalir", "AreaCliente");
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "La aplicación no puede determinar el pedido a cerrar.");
            }
        } catch (ExcepcionDeAplicacion ex) {
            java.util.logging.Logger.getLogger(AnulaCarrito.class.getName()).log(Level.WARNING, null, ex);
            throw new ServletException(ex);
        }
    }

}
