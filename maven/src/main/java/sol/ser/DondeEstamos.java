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
import paw.model.ExcepcionDeAplicacion;
import static paw.util.servlet.UtilesServlet.doForward;

/**
 *
 * @author Joka
 */
@WebServlet(name = "DondeEstamos", urlPatterns = {"/DondeEstamos"})
public class DondeEstamos extends GestionaBDPedidos {

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
            request.setAttribute("almacenes" ,gbd.getAlmacenes());
            request.setAttribute("almacenCentral", gbd.getAlmacenDeCP("28001"));
            doForward(request, response, "/donde.jsp");
        } catch (ExcepcionDeAplicacion ex) {
            java.util.logging.Logger.getLogger(DondeEstamos.class.getName()).log(Level.WARNING, null, ex);
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
