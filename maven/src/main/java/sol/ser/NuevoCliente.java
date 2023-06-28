/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package sol.ser;

import static com.mysql.cj.conf.PropertyKey.logger;
import jakarta.mail.MessagingException;
import jakarta.mail.internet.AddressException;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import paw.bd.GestorBD;
import paw.captcha.CaptchaValidator;
import paw.captcha.ReCaptchaConfig;
import paw.captcha.ReCaptchaValidatorV2;
import paw.model.Cliente;
import paw.model.ExcepcionDeAplicacion;
import paw.util.*;
import paw.util.mail.DatosCorreo;
import paw.util.mail.GestorCorreo;
import paw.util.mail.conf.ConfiguracionCorreo;
import static paw.util.servlet.UtilesServlet.*;

/**
 *
 * @author Joka
 */
public class NuevoCliente extends HttpServlet {

    private static GestorBD gbd = new GestorBD();

    private final Logger logger = LoggerFactory.getLogger(this.getClass());
    private final String siteKey = "6LchRPklAAAAAL4TwJW_eC189KX7tlcZjjjew3Lq"; //Mejor en el web.xml
    private final String secret = "6LchRPklAAAAALjyKP_hTMAlgBGp9mLmma0ZJDDg";

    private final ReCaptchaConfig recaptchaConfig = new ReCaptchaConfig(siteKey, secret);

    /**
     * Realiza las validaciones para los campos del formulario de registro de
     * nuevo cliente
     *
     * @param cli objeto paw.model.Cliente con los datos leídos del formulario
     * @param usr valor del campo "nombre de usuario" del formulario
     * @param pwd valor del campo "contraseña" del formulario
     * @param rpwd valor del campo "Repita contraseña" del formulario
     * @param privacidadOK debe tener valor 1 si la casilla de "Política de
     * privacidad" está marcada
     * @param gbd objeto GestorBD para ser usado en las comprobaciones que
     * requieran de conexión a al BD
     * @return Una lista de String con mensajes de error correspondientes a las
     * reglas de validación que no se cumplen
     * @throws ExcepcionDeAplicacion
     */
    private List<String> valida(Cliente cli,
            String usr,
            String pwd,
            String rpwd,
            int privacidadOK,
            GestorBD gbd)
            throws ExcepcionDeAplicacion {

        List<String> errores = new ArrayList<>();

        if (UtilesString.isVacia(cli.getNombre())
                || UtilesString.isVacia(cli.getCif())
                || UtilesString.isVacia(cli.getDireccion().getCalle())
                || UtilesString.isVacia(cli.getDireccion().getCiudad())
                || UtilesString.isVacia(cli.getDireccion().getProvincia())
                || UtilesString.isVacia(cli.getDireccion().getCp())
                || UtilesString.isVacia(cli.getEmail())
                || UtilesString.isVacia(usr)
                || UtilesString.isVacia(pwd)
                || UtilesString.isVacia(rpwd)) {
            errores.add("Debes proporcionar valor para todos los campos requeridos");
        }

        if (cli.getNombre() != null && cli.getNombre().length() > 50) {
            errores.add("La longitud máxima del nombre son 50 caracteres");
        }

        if (cli.getCif() != null && cli.getCif().length() > 12) {
            errores.add("La longitud máxima del CIF son 12 caracteres");
        }

        if (cli.getTfno() != null && cli.getTfno().length() > 11) {
            errores.add("La longitud máxima del teléfono son 11 caracteres");
        }

        if (cli.getEmail() != null && cli.getEmail().length() > 100) {
            errores.add("La longitud máxima del email son 100 caracteres");
        }

        if (usr != null && usr.length() > 50) {
            errores.add("La longitud máxima del userName son 50 caracteres");
        }

        if (cli.getDireccion().getCalle() != null && cli.getDireccion().getCalle().length() > 50) {
            errores.add("La longitud máxima de la calle son 50 caracteres");
        }

        if (cli.getDireccion().getCiudad() != null && cli.getDireccion().getCiudad().length() > 20) {
            errores.add("La longitud máxima de la ciudad son 20 caracteres");
        }

        if (privacidadOK != 1) {
            errores.add("Debes leer la cláusula de privacidad y marcar la casilla correspondiente");
        }

        if (!UtilesString.isVacia(pwd) && !UtilesString.isVacia(rpwd) && !pwd.equals(rpwd)) {
            errores.add("Las constraseñas son diferentes");
        }

        if (!UtilesString.isVacia(usr) && usr.contains(" ")) {
            errores.add("El nombre de usuario tiene espacios en blanco");
        }

        if (!UtilesString.isVacia(usr) && gbd.getClienteByUserName(usr) != null) {
            errores.add("Ya existe un usuario en la BD con ese nombre de usuario");
        }

        if (!UtilesString.isVacia(cli.getCif()) && gbd.getClienteByCIF(cli.getCif()) != null) {
            errores.add("Ya existe un usuario en la BD con ese CIF");
        }

        if (!UtilesString.isVacia(cli.getEmail()) && !Validacion.isEmailValido(cli.getEmail())) {
            errores.add("El email no parece una dirección de correo válida");
        }

        if (!UtilesString.isVacia(cli.getDireccion().getCp()) && !Validacion.isCPValido(cli.getDireccion().getCp())) {
            errores.add("El CP no parece un código postal válido");
        }

        return errores;
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
        request.setAttribute("recaptchaConfig", recaptchaConfig);
        doForward(request, response, "/nuevoCliente.jsp");
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
            request.setCharacterEncoding("UTF-8");
            List<String> errores = new ArrayList<>();
            String usuario = request.getParameter("login");
            String pwd1 = request.getParameter("pwd");
            String pwd2 = request.getParameter("rpwd");
            String privacidad = request.getParameter("privacidad");
            int privacidadValor = privacidad != null ? 1 : 0;
            paw.model.Direccion direccion = (paw.model.Direccion) populateBean("paw.model.Direccion", request);
            paw.model.Cliente cliente = (paw.model.Cliente) populateBean("paw.model.Cliente", request);
            cliente.setDireccion(direccion);
            /* if (UtilesString.isVacia(usuario) || UtilesString.isVacia(pwd1) || UtilesString.isVacia(pwd2) || UtilesString.isVacia(cliente.getNombre())
                    || UtilesString.isVacia(cliente.getCif()) || UtilesString.isVacia(cliente.getEmail())
                    || UtilesString.isVacia(cliente.getDireccion().getCalle()) || UtilesString.isVacia(cliente.getDireccion().getCiudad())
                    || UtilesString.isVacia(cliente.getDireccion().getProvincia()) || UtilesString.isVacia(cliente.getDireccion().getCp())) {
                errores.add("Debes proporcionar valor para todos los campos requeridos");
            }
            if (UtilesString.isVacia(cliente.getCif()) || UtilesString.isVacia(cliente.getNombre()) || UtilesString.isVacia(usuario)  
                    || UtilesString.isVacia(cliente.getEmail()) || UtilesString.isVacia(cliente.getDireccion().getCalle()) || UtilesString.isVacia(cliente.getDireccion().getCp())
                    ||  UtilesString.isVacia(cliente.getDireccion().getCiudad()) || cliente.getCif().length() > 12 
                    || cliente.getNombre().length() > 50 || usuario.length() > 50 || cliente.getEmail().length() > 100
                    || cliente.getDireccion().getCalle().length() > 50 || cliente.getDireccion().getCp().length() > 5 || cliente.getDireccion().getCiudad().length() > 20) {
                errores.add("Alguno de los campos completados excede el tamaño permitido");
            }
            if (!pwd1.equals(pwd2)) {
                errores.add("Las contraseñas son distintas");
            }
            if (privacidad == null) {
                errores.add("Debes leer la cláusula de privacidad y marcar la casilla correspondiente");
            }
            if (!UtilesString.isVacia(cliente.getCif()) && gbd.getClienteByCIF(cliente.getCif()) != null) {
                errores.add("Ya existe un cliente con el mismo CIF");
            }
            if (!usuario.isEmpty() && gbd.comprobarNombreUsuario(usuario)) {
                errores.add("Ya existe un usuario con el mismo nombre");
            }
            if (!usuario.isEmpty() && usuario.split(" ").length > 1) {
                errores.add("El nombre de usuario no puede contener espacios");
            }
            if (!UtilesString.isVacia(cliente.getDireccion().getCp()) && !paw.util.Validacion.isCPValido(cliente.getDireccion().getCp())) {
                errores.add("El código postal no es válido");
            }
            if (!UtilesString.isVacia(cliente.getEmail()) && !paw.util.Validacion.isEmailValido(cliente.getEmail())) {
                errores.add("El email no es válido");
            }*/

            errores = valida(cliente, usuario, pwd1, pwd2, privacidadValor, gbd);

            logger.info("Procesando formulario");
            CaptchaValidator captchaValidator = new ReCaptchaValidatorV2(recaptchaConfig);

            boolean verifyResponse;
            try {
                verifyResponse = captchaValidator.checkUserResponse(request);
            } catch (ReCaptchaException ex) {
                logger.error("Error validando captcha", ex);
                verifyResponse = false;
            }
            if (!verifyResponse){
                errores.add("Captcha incorrecto.");
            }
            logger.info("Captcha success? {}", verifyResponse);

            request.setAttribute("errores", errores);

            if (errores.isEmpty()) {
                gbd.insertaCliente(cliente, usuario, pwd1);
                HttpSession sesion = request.getSession();
                sesion.setAttribute("cliente", cliente);
                DatosCorreo mens = new DatosCorreo("joortif@unirioja.es",cliente.getEmail(), "Bienvenido a electrosa.com",
                    "Es un placer para nosotros tenerle como cliente. Visite nuestra web en la dirección: "
                            + "http://" + request.getServerName()+":"+request.getServerPort()+"/pr9/");
                mens.setMimeType("text/plain;charset=UTF-8");
                mens.setCharset("UTF-8");
                GestorCorreo.envia(mens, ConfiguracionCorreo.getDefault());
                response.sendRedirect("clientes/AreaCliente");
            } else {
                request.setAttribute("cliente", cliente);
                request.setAttribute("login", usuario);
                request.setAttribute("privacidad", privacidad);
                request.setAttribute("recaptchaConfig", recaptchaConfig);
                doForward(request, response, "/nuevoCliente.jsp");
            }

        } catch (ExcepcionDeAplicacion ex) {
            java.util.logging.Logger.getLogger(NuevoCliente.class.getName()).log(Level.WARNING, null, ex);
            throw new ServletException(ex);
        } catch (AddressException ex) {
            java.util.logging.Logger.getLogger(NuevoCliente.class.getName()).log(Level.SEVERE, null, ex);
        } catch (MessagingException ex) {
            java.util.logging.Logger.getLogger(NuevoCliente.class.getName()).log(Level.SEVERE, null, ex);
        }

    }
}
