/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Filter.java to edit this template
 */
package sol.fil;

import java.io.IOException;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import paw.model.Cliente;

/**
 *
 * @author Joka
 */
@WebFilter(filterName = "Autenticador", urlPatterns = {"/clientes/*"})
public class Autenticador implements Filter {
    
       
    // The filter configuration object we are associated with.  If
    // this value is null, this filter instance is not currently
    // configured. 

    /**
     *
     * @param request The servlet request we are processing
     * @param response The servlet response we are creating
     * @param chain The filter chain we are processing
     *
     * @exception IOException if an input/output error occurs
     * @exception ServletException if a servlet error occurs
     */
    @Override
    public void doFilter(ServletRequest request, ServletResponse response,
            FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession sesion = httpRequest.getSession();
        Cliente cliente = (Cliente) sesion.getAttribute("cliente");
        if (cliente == null){
            String returnURL;
            if (httpRequest.getQueryString() != null){
                returnURL = httpRequest.getRequestURL()+"?"+httpRequest.getQueryString(); 
            } else {
                returnURL = httpRequest.getRequestURL().toString();
            }
            sesion.setAttribute("returnURL", returnURL);
            sesion.setAttribute("cliente",cliente);
            httpResponse.sendRedirect(httpRequest.getContextPath()+"/Login");
        } else {
            chain.doFilter(request, response);
        }
    }

    public void destroy() {        
    }

    /**
     * Init method for this filter
     */
    public void init(FilterConfig filterConfig) {        
    }

}
