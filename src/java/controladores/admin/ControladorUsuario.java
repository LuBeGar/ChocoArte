/*
 * Servlet ControladorUsuario
 */
package controladores.admin;

import java.io.IOException;
import java.io.PrintWriter;
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
@WebServlet(name = "ControladorUsuario", urlPatterns = {"/ControladorUsuario"})
public class ControladorUsuario extends HttpServlet {

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

        String vista = "/admin/administracion.jsp";
        String error = "";

        String editar = request.getParameter("editar");
        String eliminar = request.getParameter("eliminar");

        // Editar usuario
        if (request.getParameter("id") != null && editar != null) {
            long id = Long.parseLong(request.getParameter("id"));
            Usuario usuario = su.findUsuario(id);
            SimpleDateFormat formato = new SimpleDateFormat("yyyy-MM-dd");

            request.setAttribute("id", id);
            request.setAttribute("nombre", usuario.getNombre());
            request.setAttribute("email", usuario.getEmail());
            request.setAttribute("direccion", usuario.getDireccion());
            request.setAttribute("telefono", usuario.getTelefono());
            request.setAttribute("fechaNacimiento", formato.format(usuario.getFechaNacimiento()));
            request.setAttribute("genero", usuario.getGenero());
            request.setAttribute("saborFavorito", usuario.getSaborFavorito());
            request.setAttribute("comentarios", usuario.getComentarios());

            vista = "/admin/editarUsuario.jsp";

            // Eliminar usuario
        } else if (eliminar != null && request.getParameter("id") != null) {
            try {
                long id = Long.parseLong(request.getParameter("id"));
                su.destroy(id);
                response.sendRedirect("ControladorUsuario");
                return;
            } catch (Exception e) {
                error = "No se pudo eliminar el usuario: " + e.getMessage();
            }
        }

        // Cargar usuarios para la vista de administración
        List<Usuario> usuarios = su.findUsuarioEntities();
        request.setAttribute("usuarios", usuarios);

        if (!error.isEmpty()) {
            request.setAttribute("error", error);
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
        EntityManagerFactory emf = null;
        try {
            emf = Persistence.createEntityManagerFactory("ChocoartePU");
            ServicioUsuario su = new ServicioUsuario(emf);

            String idStr = request.getParameter("id");
            String nombre = request.getParameter("nombre");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String repetirPassword = request.getParameter("repetirPassword");
            String direccion = request.getParameter("direccion");
            String tipo = request.getParameter("tipo");
            String telefono = request.getParameter("telefono");
            String fechaNacimientoStr = request.getParameter("fechaNacimiento");
            String genero = request.getParameter("genero");
            String saborFavorito = request.getParameter("saborFavorito");
            String comentarios = request.getParameter("comentarios");

            String error = "";
            SimpleDateFormat formatoFecha = new SimpleDateFormat("yyyy-MM-dd");

            // Editar usuario existente
            if (request.getParameter("editar") != null && idStr != null) {
                try {
                    long id = Long.parseLong(idStr);
                    Usuario usuario = su.findUsuario(id);

                    if (usuario == null) {
                        error = "Usuario no encontrado";
                    } else {
                        if (!password.isEmpty()) {
                            if (!password.equals(repetirPassword)) {
                                error = "Las contraseñas no coinciden";
                            } else {
                                usuario.setPassword(password);
                            }
                        }

                        if (error.isEmpty()) {
                            usuario.setEmail(email);
                            usuario.setNombre(nombre);
                            usuario.setDireccion(direccion);
                            usuario.setTipo(tipo);
                            usuario.setTelefono(telefono);
                            usuario.setGenero(genero);
                            usuario.setSaborFavorito(saborFavorito);
                            usuario.setComentarios(comentarios);

                            try {
                                usuario.setFechaNacimiento(formatoFecha.parse(fechaNacimientoStr));
                            } catch (Exception e) {
                                error = "Fecha de nacimiento inválida";
                            }

                            if (error.isEmpty()) {
                                su.edit(usuario);
                                response.sendRedirect("ControladorUsuario");
                                return;
                            }
                        }
                    }
                } catch (Exception e) {
                    error = "Error al editar el usuario: " + e.getMessage();
                }
            }

            request.setAttribute("error", error);
            request.setAttribute("usuarios", su.findUsuarioEntities()); 

            getServletContext().getRequestDispatcher("/admin/administracion.jsp").forward(request, response);

        } finally {
            if (emf != null) {
                emf.close();
            }
        }
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
