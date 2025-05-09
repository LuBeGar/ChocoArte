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
        // Obtener el ID del pedido desde los parámetros de la solicitud
        String pedidoIdStr = request.getParameter("pedidoId");

        // Validar que se haya proporcionado un ID
        if (pedidoIdStr == null) {
            response.sendRedirect("index.html");
            return;
        }

        try {
            long pedidoId = Long.parseLong(pedidoIdStr);

            // Crear el EntityManagerFactory (puedes mejorar esto centralizándolo en la aplicación)
            EntityManagerFactory emf = Persistence.createEntityManagerFactory("ChocoartePU");
            ServicioPedido servicio = new ServicioPedido(emf);

            // Utilizar el nuevo método del servicio para obtener el pedido con sus productos personalizados
            Pedido pedido = servicio.findPedidoConProductosPersonalizados(pedidoId);

            // Cerrar el EntityManagerFactory
            emf.close();

            // Enviar el pedido como atributo a la vista
            request.setAttribute("pedido", pedido);
            request.getRequestDispatcher("/usuario/resumenPedido.jsp").forward(request, response);

        } catch (Exception e) {
            // En caso de error, redirigir al inicio
            e.printStackTrace();
            response.sendRedirect("index.html");
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
