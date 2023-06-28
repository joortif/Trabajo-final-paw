/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package sol.ser;

import java.io.IOException;
import java.util.logging.Level;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import paw.model.Cliente;
import paw.model.ExcepcionDeAplicacion;
import paw.model.Pedido;
import paw.model.PedidoAnulado;

/**
 *
 * @author Joka
 */
@WebServlet(name = "VerPedidoAnulado", urlPatterns = {"/clientes/VerPedidoAnulado"})
public class VerPedidoAnulado extends GestionaBDPedidos {

  
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
            String cp = request.getParameter("cp");
            if (cp != null){
                PedidoAnulado p = gbdp.getPedidoAnulado(cp);
                if (p != null){
                    if (p.getCliente().equals(cliente)){
                        request.setAttribute("pedido", p);
                        RequestDispatcher rd = request.getRequestDispatcher("verPedidoAnulado.jsp");
                        rd.forward(request, response);
                    } else {
                        request.setAttribute("enlaceSalir", "../Salir");
                        response.sendError(HttpServletResponse.SC_FORBIDDEN, "Usted no está autorizado para consultar esta información");
                    }
                } else {
                    request.setAttribute("enlaceSalir", "./PedidosCliente");
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "Código de pedido inválido");
                }
            } else {
                response.sendRedirect("PedidosCliente");
            }
        } catch (ExcepcionDeAplicacion ex) {
            java.util.logging.Logger.getLogger(VerPedidoAnulado.class.getName()).log(Level.WARNING, null, ex);
            throw new ServletException(ex);
        }
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
    }

    
}
