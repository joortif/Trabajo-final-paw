/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package sol.ser;

import java.io.IOException;
import java.util.logging.Level;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import paw.bd.GestorBD;
import paw.model.ExcepcionDeAplicacion;
import paw.util.UtilesString;

/**
 *
 * @author Joka
 */
public class Login extends HttpServlet {

    private static GestorBD gbd = new GestorBD();

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
        request.setAttribute("error", false);
        RequestDispatcher rd = request.getRequestDispatcher("/login.jsp");
        rd.forward(request, response);
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
        try {
            request.setAttribute("error", true);
            request.setCharacterEncoding("UTF-8");
            String usr = request.getParameter("usr");
            String pwd = request.getParameter("pwd");
            if (!UtilesString.isVacia(usr) && !UtilesString.isVacia(pwd)) {
                if (gbd.comprobarLogin(usr, pwd)) {
                    HttpSession sesion = request.getSession();
                    sesion.setAttribute("cliente", gbd.getClienteByUserName(usr));
                    response.sendRedirect("clientes/AreaCliente");
                    return;
                }
            }
            request.setAttribute("usr", usr);
            RequestDispatcher rd = request.getRequestDispatcher("/login.jsp");
            rd.forward(request, response);
        } catch (ExcepcionDeAplicacion ex) {
            java.util.logging.Logger.getLogger(Login.class.getName()).log(Level.WARNING, null, ex);
            throw new ServletException(ex);
        }

    }

}
