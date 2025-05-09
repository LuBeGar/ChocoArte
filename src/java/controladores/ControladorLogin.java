/*
 * Servlet ControladorLogin
 */
package controladores;

import java.io.IOException;
import java.io.PrintWriter;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import modelo.entidades.Pedido;
import modelo.entidades.Usuario;
import modelo.servicio.ServicioUsuario;

/**
 *
 * @author Lu
 */
@WebServlet(name = "ControladorLogin", urlPatterns = {"/ControladorLogin"})
public class ControladorLogin extends HttpServlet {

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
        getServletContext().getRequestDispatcher("/login.jsp").forward(request, response);
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
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String error = "";

        // Verificaci�n de datos vac�os
        if (email == null || password == null || email.isEmpty() || password.isEmpty()) {
            error = "El email y la contrase�a son obligatorios";
        } else {
            EntityManagerFactory emf = Persistence.createEntityManagerFactory("ChocoartePU");
            ServicioUsuario su = new ServicioUsuario(emf);
            Usuario usu = su.validarUsuario(email, password);
            emf.close();

            if (usu != null) {
                // Si el usuario es v�lido, crear una nueva sesi�n
                HttpSession sesion = request.getSession();
                sesion.setAttribute("usuario", usu);

                // Crear un nuevo pedido si no existe uno en la sesi�n
                if (sesion.getAttribute("pedido") == null) {
                    Pedido nuevoPedido = new Pedido();
                    nuevoPedido.setUsuario(usu);  // Asociar el pedido al usuario
                    sesion.setAttribute("pedido", nuevoPedido);  // Guardar el pedido en la sesi�n
                }

                // Redirigir al usuario al controlador principal
                response.sendRedirect("ControladorPrincipal");
                return;
            } else {
                error = "Email o contrase�a incorrectos";
            }
        }

        // Si hubo error, mostrar el mensaje en el login.jsp
        request.setAttribute("error", error);
        getServletContext().getRequestDispatcher("/login.jsp").forward(request, response);
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
