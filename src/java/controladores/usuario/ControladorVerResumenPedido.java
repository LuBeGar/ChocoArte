/*
 * Servlet ControladorVerResumenPedido
 */
package controladores.usuario;

import java.io.IOException;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.entidades.Pedido;
import modelo.servicio.ServicioPedido;
import modelo.servicio.ServicioProductoPersonalizado;

/**
 *
 * @author Lu
 */
@WebServlet(name = "ControladorVerResumenPedido", urlPatterns = {"/ControladorVerResumenPedido"})
public class ControladorVerResumenPedido extends HttpServlet {

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
        String pedidoIdStr = request.getParameter("pedidoId");
        String productoPersonalizadoIdStr = request.getParameter("productoPersonalizadoId");

        if (pedidoIdStr == null) {
            response.sendRedirect("index.html");
            return;
        }

        EntityManagerFactory emf = Persistence.createEntityManagerFactory("ChocoartePU");

        try {
            long pedidoId = Long.parseLong(pedidoIdStr);
            ServicioPedido servicioPedido = new ServicioPedido(emf);
            ServicioProductoPersonalizado servicioPP = new ServicioProductoPersonalizado(emf);

            // Si hay un productoPersonalizadoId, eliminar el producto personalizado
            if (productoPersonalizadoIdStr != null && !productoPersonalizadoIdStr.isEmpty()) {
                long productoPersonalizadoId = Long.parseLong(productoPersonalizadoIdStr);
                servicioPP.destroy(productoPersonalizadoId);
            }

            // Mostrar el resumen del pedido
            Pedido pedido = servicioPedido.findPedidoConProductosPersonalizados(pedidoId);
            request.setAttribute("pedido", pedido);
            request.getRequestDispatcher("/usuario/resumenPedido.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("index.html");
        } finally {
            emf.close();
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
