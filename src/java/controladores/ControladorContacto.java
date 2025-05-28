/*
 * Servlet ControladorContacto
 */
package controladores;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import utilidades.Email;
import utilidades.Utilidades;

/**
 *
 * @author Lu
 */
@WebServlet(name = "ControladorContacto", urlPatterns = {"/ControladorContacto"})
public class ControladorContacto extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String nombre = request.getParameter("nombre");
        String emailUsuario = request.getParameter("email");
        String mensaje = request.getParameter("mensaje");

        String error = null;

        // Validaciones simples
        if (nombre == null || nombre.trim().isEmpty()) {
            error = "El nombre es obligatorio";
        } else if (emailUsuario == null || emailUsuario.trim().isEmpty()) {
            error = "El correo electrónico es obligatorio";
        } else if (!emailUsuario.matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$")) {
            error = "El correo electrónico no es válido";
        } else if (mensaje == null || mensaje.trim().isEmpty()) {
            error = "El mensaje no puede estar vacío";
        }

        if (error == null) {
            try {
                // Construir email para enviar al administrador
                Email email = new Email();
                email.setTo("berro.garcia.lucia@iescamas.es");
                email.setFrom(emailUsuario);
                email.setSubject("Nuevo mensaje de contacto de " + nombre);

                StringBuilder sb = new StringBuilder();
                sb.append("Has recibido un nuevo mensaje de contacto.\n\n");
                sb.append("Nombre: ").append(nombre).append("\n");
                sb.append("Email: ").append(emailUsuario).append("\n\n");
                sb.append("Mensaje:\n").append(mensaje).append("\n");

                // Forma el cuerpo del email como cadena de texto
                email.setText(sb.toString());

                // Enviar email con la clase Utilidades 
                Utilidades util = new Utilidades();
                util.enviarEmail(email, "efim hvkj pkys kzsu");

                // Confirmación exitosa
                request.setAttribute("mensajeExito", "Gracias por contactarnos, " + nombre + ". Te responderemos pronto.");
            } catch (Exception e) {
                error = "Error al enviar el mensaje: " + e.getMessage();
                request.setAttribute("error", error);
            }
        } else {
            // Si hay error de validación, lo pasamos
            request.setAttribute("error", error);
        }

        if (error != null) {
            request.getSession().setAttribute("error", error);
        } else {
            request.getSession().setAttribute("mensajeExito", "Gracias por contactarnos, " + nombre + ". Te responderemos pronto.");
        }

        response.sendRedirect("ControladorPrincipal#contacto");

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
        processRequest(request, response);
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
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
