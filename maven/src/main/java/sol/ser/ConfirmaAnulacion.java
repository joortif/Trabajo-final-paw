/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package sol.ser;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Level;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import paw.model.Cliente;
import paw.model.ExcepcionDeAplicacion;
import paw.model.Pedido;

/**
 *
 * @author Joka
 */
@WebServlet(name = "ConfirmaAnulacion", urlPatterns = {"/clientes/ConfirmaAnulacion"})
public class ConfirmaAnulacion extends GestionaBDPedidos {

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
                Pedido p = gbdp.getPedido(cp);
                if (p != null){
                    if (p.getCliente().equals(cliente)){
                        if (!p.isCursado()){
                            gbdp.anulaPedido(p);
                            response.sendRedirect("./PedidosCliente");
                        } else {
                            request.setAttribute("enlaceSalir", "./PedidosCliente");
                            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "El pedido está cursado. No puede anularlo");
                        }
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
            java.util.logging.Logger.getLogger(ConfirmaAnulacion.class.getName()).log(Level.WARNING, null, ex);
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
