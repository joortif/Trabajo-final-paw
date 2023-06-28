/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package sol.ajax;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Level;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import paw.model.ExcepcionDeAplicacion;
import sol.ser.DondeEstamos;
import sol.ser.GestionaBDPedidos;

/**
 *
 * @author Joka
 */
@WebServlet(name = "ApiStockArticulo", urlPatterns = {"/api/stock/articulo/*"})
public class ApiStockArticulo extends GestionaBDPedidos {


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
            String pathInfo = request.getPathInfo();
            String trozos[] = pathInfo.split("/");
            String codigo = trozos[trozos.length-1];
            response.setContentType("text/plain");
            int stock = gbd.getStockArticulo(codigo);
            try (PrintWriter out = response.getWriter()) {
                out.write(Integer.toString(stock));
                out.flush();
            }
        } catch (ExcepcionDeAplicacion ex) {
            java.util.logging.Logger.getLogger(ApiStockArticulo.class.getName()).log(Level.WARNING, null, ex);
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
