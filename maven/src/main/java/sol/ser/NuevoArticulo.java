/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package sol.ser;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import org.springframework.web.context.support.SpringBeanAutowiringSupport;
import paw.model.Articulo;
import paw.model.ExcepcionDeAplicacion;
import paw.util.UtilesString;
import paw.util.servlet.UtilesServlet;
import static paw.util.servlet.UtilesServlet.doForward;
import sol.usecases.GuardarArticuloRequest;
import sol.usecases.GuardarArticuloUseCase;

@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 1,
        maxFileSize = 1024 * 1024 * 1,
        maxRequestSize = 1024 * 1024 * 1 + 10 * 1024)
@WebServlet(name = "NuevoArticulo", urlPatterns = {"/admin/NuevoArticulo"})
public class NuevoArticulo extends HttpServlet {

    private static long CONT_FICH = 0;
    private paw.bd.GestorBD gbd = new paw.bd.GestorBD();
    
    @Inject
    private GuardarArticuloUseCase guardarArticuloUseCase;

    @Override
    public void init() throws ServletException {
        super.init();
        SpringBeanAutowiringSupport.processInjectionBasedOnCurrentContext(this);
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
        try {
            request.setAttribute("fabricantes", gbd.getFabricantes());
            request.setAttribute("tipos", gbd.getTiposArticulos());
            doForward(request, response, "nuevoArticulo.jsp");
        } catch (ExcepcionDeAplicacion ex) {
            java.util.logging.Logger.getLogger(NuevoArticulo.class.getName()).log(Level.WARNING, null, ex);
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
        try {
            String historicoFich = (String) request.getAttribute("historicoFich");
            Articulo articulo = (Articulo) UtilesServlet.populateBean(Articulo.class, request);
            Part foto = request.getPart("fichFoto");
            String accion = request.getParameter("accion");
            if (accion != null && accion.equals("quitar")) {
                articulo.setFoto(null);
                historicoFich = " ";
                request.setAttribute("foto", null);
                enviarParametros(request, response, articulo, foto, historicoFich);
            } else {
                List<String> errores;
                if (foto.getSize() > 0) {  // Solo si se ha recibido un fichero
                    String nombre = foto.getSubmittedFileName();
                    if (historicoFich == null || !historicoFich.equals(nombre)) {
                        String filename = buildFotoFilename(foto);
                        if (filename != null) {
                            articulo.setFoto(String.format("%s/%s", articulo.getTipo(), filename));
                        }
                        historicoFich = foto.getSubmittedFileName();
                    }
                } else if (!historicoFich.equals(" ")){
                    String filename = buildFotoFilename(foto);
                    articulo.setFoto(String.format("%s/%s", articulo.getTipo(), filename));
                }
                errores = valida(articulo, foto);
                if (!errores.isEmpty()) {
                    request.setAttribute("errores", errores);
                    enviarParametros(request, response, articulo, foto, historicoFich);
                } else {
                    String folder = String.format("%s%s", getServletContext().getRealPath("/img/fotosElectr"), File.separator);
                    GuardarArticuloRequest artReq = new GuardarArticuloRequest(articulo, foto, folder);
                    guardarArticuloUseCase.execute(artReq);
                    request.removeAttribute("historicoFich");
                    doForward(request, response, "listadoArticulos.jsp");
                }
            }

        } catch (ExcepcionDeAplicacion ex) {
            java.util.logging.Logger.getLogger(NuevoArticulo.class.getName()).log(Level.WARNING, null, ex);
            throw new ServletException(ex);
        }

    }

    private String buildFotoFilename(Part foto) {
        String fn = foto.getSubmittedFileName();
        if (fn == null) {
            return null;
        }
        // En los viejos navegadores IE y Edge el nombre del fichero incluye la ruta
        // Por si acaso, la quitamos
        fn = fn.replaceAll("\\\\", "/");
        fn = fn.substring(fn.lastIndexOf("/") + 1);
        // Devolver el nombre
        return (System.currentTimeMillis()) + "" + (CONT_FICH++) + fn;
    }

    /**
     * Realiza las validaciones para los campos del formulario de alta de nuevo
     * artículo
     *
     * @param art objeto paw.model.Articulo con los datos leídos del formulario
     * @param foto objeto Part con el fichero de la foto del artículo
     * @return Una lista de String con mensajes de error correspondientes a las
     * reglas de validación que no se cumplen
     */
    private List<String> valida(Articulo art, Part foto) {
        List<String> errores = new ArrayList<>();

        if (UtilesString.isVacia(art.getNombre())
                || UtilesString.isVacia(art.getTipo())
                || UtilesString.isVacia(art.getFabricante())) {
            errores.add("Debes proporcionar valor para todos los campos requeridos");
        }

        if (art.getNombre() != null && art.getNombre().length() > 50) {
            errores.add("La longitud máxima del nombre son 50 caracteres");
            art.setNombre(null);
        }

        if (art.getTipo() != null && art.getTipo().length() > 15) {
            errores.add("La longitud máxima del tipo son 15 caracteres");
            art.setTipo(null);
        }

        if (art.getFabricante() != null && art.getFabricante().length() > 11) {
            errores.add("La longitud máxima del fabricante son 15 caracteres");
            art.setFabricante(null);
        }

        if (art.getDescripcion() != null && art.getDescripcion().length() > 200) {
            errores.add("La longitud máxima de la descripción son 200 caracteres");
            art.setDescripcion(null);
        }

        if (art.getFoto() != null && art.getFoto().length() > 50) {
            errores.add("El nombre de la foto es demasiado largo");
            art.setFoto(null);
        }

        if (foto.getSize() > 0 && !foto.getContentType().startsWith("image")) {
            errores.add("El fichero subido debe ser una imagen.");
        }

        if (art.getPvp() <= 0) {
            errores.add("El precio debe ser una cantidad positiva");
        }

        return errores;
    }

    private void enviarParametros(HttpServletRequest request, HttpServletResponse response, Articulo articulo, Part foto, String histFich)
            throws ServletException, ExcepcionDeAplicacion {
        try {
            request.setAttribute("nombre", articulo.getNombre());
            request.setAttribute("pvp", articulo.getPvp());
            request.setAttribute("descr", articulo.getDescripcion());
            request.setAttribute("fabricantes", gbd.getFabricantes());
            request.setAttribute("tipos", gbd.getTiposArticulos());
            request.setAttribute("foto", foto.getSubmittedFileName());
            request.setAttribute("tipo", (String) request.getParameter("tipo"));
            request.setAttribute("fabricante", (String) request.getParameter("fabricante"));
            request.setAttribute("historicoFich", histFich);
            doForward(request, response, "/admin/nuevoArticulo.jsp");
        } catch (IOException ex) {
            Logger.getLogger(NuevoArticulo.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
