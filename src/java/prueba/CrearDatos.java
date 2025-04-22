/*
 * Datos de prueba
 */
package prueba;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
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
@WebServlet(name = "CrearDatos", urlPatterns = {"/CrearDatos"})
public class CrearDatos extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");
        
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("ChocoartePU");
        ServicioUsuario su = new ServicioUsuario(emf);

        Usuario usuario = new Usuario();
        usuario.setNombre("Lucía");
        usuario.setEmail("lucia@correo.com");
        usuario.setPassword("Contrasena123@");
        usuario.setDireccion("Calle Chocolate 123");
        usuario.setTipo("normal");
        usuario.setPuntos(0);
        usuario.setTelefono("123456789");
        try {
            usuario.setFechaNacimiento(new SimpleDateFormat("yyyy-MM-dd").parse("1997-04-24"));
        } catch (Exception e) {
            e.printStackTrace();
        }
        usuario.setGenero("Femenino");
        usuario.setSaborFavorito("Negro");
        usuario.setComentarios("Usuario de prueba creado automáticamente");

        try {
            su.create(usuario);
        } catch (Exception e) {
            e.printStackTrace(); 
        }

        emf.close();

        // Mostrar respuesta en HTML
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Crear Usuario de Prueba</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Usuario de prueba creado con éxito</h1>");
            out.println("<p>Email: " + usuario.getEmail() + "</p>");
            out.println("<p>Nombre: " + usuario.getNombre() + "</p>");
            out.println("</body>");
            out.println("</html>");
        }
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
