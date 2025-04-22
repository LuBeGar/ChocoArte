/*
 * Servlet ControladorRegistro
 */
package controladores;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.entidades.Usuario;
import modelo.servicio.ServicioUsuario;

/**
 *
 * @author Lu
 */
@WebServlet(name = "ControladorRegistro", urlPatterns = {"/ControladorRegistro"})
public class ControladorRegistro extends HttpServlet {

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
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("ChocoartePU");
        ServicioUsuario su = new ServicioUsuario(emf);
        String vista = "/registro.jsp";  

        // Listar usuarios 
        if (request.getParameter("crear") == null) {
            List<Usuario> usuarios = su.findUsuarioEntities();
            request.setAttribute("usuarios", usuarios);
        }

        emf.close();
        getServletContext().getRequestDispatcher(vista).forward(request, response);
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

        String nombre = request.getParameter("nombre");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmarPassword = request.getParameter("confirmarPassword");
        String telefono = request.getParameter("telefono");
        String direccion = request.getParameter("direccion");
        String fechaNacimiento = request.getParameter("fechaNacimiento");
        String genero = request.getParameter("genero");
        String sabor = request.getParameter("sabor");
        String comentarios = request.getParameter("comentarios");
        String terminos = request.getParameter("terminos");

        String error = "";

        EntityManagerFactory emf = Persistence.createEntityManagerFactory("ChocoartePU");
        ServicioUsuario su = new ServicioUsuario(emf);

        if (nombre == null || nombre.trim().isEmpty()) {
            error = "El nombre de usuario es obligatorio";
        } else if (email == null || email.trim().isEmpty()) {
            error = "El correo electrónico es obligatorio";
        } else if (password == null || password.trim().isEmpty()) {
            error = "La contraseña es obligatoria";
        } else if (confirmarPassword == null || confirmarPassword.trim().isEmpty()) {
            error = "Debe confirmar su contraseña";
        } else if (!password.equals(confirmarPassword)) {
            error = "Las contraseñas no coinciden";
        } else if (telefono == null || telefono.trim().isEmpty()) {
            error = "El teléfono es obligatorio";
        } else if (direccion == null || direccion.trim().isEmpty()) {
            error = "La dirección es obligatoria";
        } else if (fechaNacimiento == null || fechaNacimiento.trim().isEmpty()) {
            error = "La fecha de nacimiento es obligatoria";
        } else if (genero == null || genero.trim().isEmpty()) {
            error = "Debe seleccionar un género";
        } else if (sabor == null || sabor.trim().isEmpty()) {
            error = "Debe seleccionar un sabor favorito";
        } else if (terminos == null) {
            error = "Debe aceptar los términos y condiciones";
        }

        if (error.isEmpty()) {

            Usuario usuario = new Usuario();
            usuario.setNombre(nombre);
            usuario.setEmail(email);
            usuario.setPassword(password);
            usuario.setTelefono(telefono);
            usuario.setDireccion(direccion);
            usuario.setGenero(genero);
            usuario.setSaborFavorito(sabor);
            usuario.setComentarios(comentarios);
            usuario.setTipo("normal");
            usuario.setPuntos(0);

            try {
                usuario.setFechaNacimiento(new SimpleDateFormat("yyyy-MM-dd").parse(fechaNacimiento));
            } catch (ParseException e) {
                error = "La fecha de nacimiento no es válida";
            }

            try {
                su.create(usuario);
                emf.close();

                // Obtener la página anterior y redirigir
                String referer = request.getHeader("Referer");
                if (referer != null && !referer.isEmpty()) {
                    response.sendRedirect(referer);
                } else {
                    response.sendRedirect("ControladorInicio");
                }
                return;
            } catch (Exception e) {
                error = "Error al registrar el usuario";
                if (e.getMessage().contains("Duplicate")) {
                    error = "Ya existe un usuario con ese correo o nombre de usuario";
                }
            }

        }

        // Volver a mostrar el formulario con datos y error
        request.setAttribute("error", error);
        request.setAttribute("nombre", nombre);
        request.setAttribute("email", email);
        request.setAttribute("telefono", telefono);
        request.setAttribute("direccion", direccion);
        request.setAttribute("fechaNacimiento", fechaNacimiento);
        request.setAttribute("genero", genero);
        request.setAttribute("sabor", sabor);
        request.setAttribute("comentarios", comentarios);

        request.getRequestDispatcher("/registro.jsp").forward(request, response);

        emf.close();
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
