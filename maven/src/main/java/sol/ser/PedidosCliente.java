/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package sol.ser;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.logging.Level;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import paw.bd.GestorBDPedidos;
import paw.model.Cliente;
import paw.model.ExcepcionDeAplicacion;
import paw.model.Pedido;
import paw.model.PedidoAnulado;
import paw.model.PedidoEnRealizacion;

/**
 *
 * @author Joka
 */
@WebServlet(name = "PedidosCliente", urlPatterns = {"/clientes/PedidosCliente"})
public class PedidosCliente extends GestionaBDPedidos {

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
            Cliente cliente = (Cliente) sesion.getAttribute("cliente");
            List<Pedido> pedidosPend = gbdp.getPedidosPendientes(cliente.getCodigo());
            List<Pedido> pedidosCompl = gbdp.getPedidosCompletados(cliente.getCodigo());
            List<PedidoAnulado> pedidosAnul = gbdp.getPedidosAnulados(cliente.getCodigo());
            sesion.setAttribute("cliente", cliente);
            request.setAttribute("pendientes", pedidosPend);
            request.setAttribute("completados", pedidosCompl);
            request.setAttribute("anulados", pedidosAnul);
            PedidoEnRealizacion carrito = (PedidoEnRealizacion) sesion.getAttribute("carrito");
            if (carrito == null){
                carrito = gbdp.getPedidoEnRealizacion(cliente.getCodigo());
            }
            sesion.setAttribute("carrito", carrito);
            RequestDispatcher rd = request.getRequestDispatcher("pedidosCliente.jsp");
            rd.forward(request, response);

        } catch (ExcepcionDeAplicacion ex) {
            java.util.logging.Logger.getLogger(PedidosCliente.class.getName()).log(Level.WARNING, null, ex);
            throw new ServletException(ex);
        }
    }

}
