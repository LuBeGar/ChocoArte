/*
 * Servlet ControladorConfirmarPedido
 */
package controladores.usuario;

import java.io.IOException;
import java.util.Date;
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

/**
 *
 * @author Lu
 */
@WebServlet(name = "ControladorConfirmarPedido", urlPatterns = {"/ControladorConfirmarPedido"})
public class ControladorConfirmarPedido extends HttpServlet {

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
        String pedidoIdStr = request.getParameter("pedidoId");
        String tipoEntrega = request.getParameter("tipoEntrega");
        String direccion = request.getParameter("direccion");

        if (pedidoIdStr == null) {
            response.sendRedirect("index.html");
            return;
        }

        EntityManagerFactory emf = null;

        try {
            long pedidoId = Long.parseLong(pedidoIdStr);
            emf = Persistence.createEntityManagerFactory("ChocoartePU");
            ServicioPedido servicioPedido = new ServicioPedido(emf);

            // Confirmar el pedido
            Pedido pedidoConfirmado = servicioPedido.confirmarPedido(pedidoId, tipoEntrega, direccion);

            // Eliminar el pedido en curso de la sesión
            session.removeAttribute("pedidoEnCurso");

            // Mostrar el pedido confirmado con productos personalizados
            pedidoConfirmado = servicioPedido.findPedidoConProductosPersonalizados(pedidoId);
            request.setAttribute("pedido", pedidoConfirmado);

            request.getRequestDispatcher("/usuario/confirmacionPedido.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("index.html");
        } finally {
            if (emf != null && emf.isOpen()) {
                emf.close();
            }
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
