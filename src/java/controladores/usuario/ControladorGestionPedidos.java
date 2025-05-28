/*
 * Servlet ControladorGestionPedidos
 */
package controladores.usuario;

import java.io.IOException;
import java.util.List;
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
import modelo.servicio.ServicioPedido;
import modelo.servicio.ServicioUsuario;

/**
 *
 * @author Lu
 */
@WebServlet(name = "ControladorGestionPedidos", urlPatterns = {"/ControladorGestionPedidos"})
public class ControladorGestionPedidos extends HttpServlet {

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
        HttpSession session = request.getSession();
        String vista = "/usuario/inicioUsuario.jsp";
        String error = "";

        // Usuario de la sesión
        Usuario usuarioSesion = (Usuario) session.getAttribute("usuario");

        EntityManagerFactory emf = Persistence.createEntityManagerFactory("ChocoartePU");
        ServicioUsuario su = new ServicioUsuario(emf);
        // Busca al usuario para obtener sus pedidos
        Usuario usuario = su.findUsuario(usuarioSesion.getId());
        List<Pedido> pedidosUsuario = usuario.getPedidos();
        
        // Actualiza al usuario
        session.setAttribute("usuario", usuario); 
        request.setAttribute("pedidos", pedidosUsuario);

        if (!error.isEmpty()) {
            request.setAttribute("error", error);
        }

        request.getRequestDispatcher(vista).forward(request, response);
        emf.close();
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
        HttpSession session = request.getSession();
        Usuario usuario = (Usuario) session.getAttribute("usuario");

        EntityManagerFactory emf = Persistence.createEntityManagerFactory("ChocoartePU");
        ServicioPedido sp = new ServicioPedido(emf);
        String error = "";

        String accion = request.getParameter("accion");

        // Si cancela el pedido
        if ("cancelar".equals(accion)) {
            try {
                long idPedido = Long.parseLong(request.getParameter("id"));
                Pedido pedido = sp.findPedido(idPedido);

                // Verifica que el pedido pertenezca al usuario actual
                if (pedido != null && pedido.getUsuario().getId().equals(usuario.getId())) {
                    // Solo si el pedido está confirmado se cancela
                    if ("confirmado".equalsIgnoreCase(pedido.getEstado())) {
                        pedido.setEstado("cancelado");
                        sp.edit(pedido);
                    } else {
                        error = "Solo se pueden cancelar pedidos confirmados";
                    }
                } else {
                    error = "Pedido no válido o no pertenece al usuario";
                }
            } catch (Exception e) {
                error = "Error al cancelar el pedido: " + e.getMessage();
            }
        }

        emf.close();

        if (!error.isEmpty()) {
            request.setAttribute("error", error);
            request.getRequestDispatcher("/usuario/inicioUsuario.jsp").forward(request, response);
        } else {
            response.sendRedirect("ControladorGestionPedidos");
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
