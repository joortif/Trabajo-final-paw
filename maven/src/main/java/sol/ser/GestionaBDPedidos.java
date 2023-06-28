/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package sol.ser;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;

/**
 *
 * @author Joka
 */
public abstract class GestionaBDPedidos extends HttpServlet{
    
    protected paw.bd.GestorBDPedidos gbdp;
    protected paw.bd.GestorBD gbd;
    protected ServletContext context;
    
    @Override
    public void init(ServletConfig config) throws ServletException {
        gbdp = new paw.bd.GestorBDPedidos();
        gbd = new paw.bd.GestorBD();
        ServletContext application = config.getServletContext();
        context = application;
        application.setAttribute("gbdp", gbdp);
        application.setAttribute("gbd", gbd);

    }
    
}
