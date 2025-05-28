/*
 * Servlet ControladorPedido
 */
package controladores.admin;

import java.io.IOException;
import java.util.List;
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
@WebServlet(name = "ControladorPedido", urlPatterns = {"/ControladorPedido"})
public class ControladorPedido extends HttpServlet {

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
        ServicioPedido sp = new ServicioPedido(emf);
        String vista = "/admin/gestionPedidos.jsp";
        String error = "";
        String eliminar = request.getParameter("eliminar");

        // Si se selecciona eliminar, se elimina el pedido con ese id
        if (eliminar != null && request.getParameter("id") != null) {
            try {
                long id = Long.parseLong(request.getParameter("id"));
                sp.destroy(id);
                emf.close();
                response.sendRedirect("ControladorPedido");
                return;
            } catch (Exception e) {
                error = "No se pudo eliminar el pedido: " + e.getMessage();
            }
        }

        // Listar los pedidos
        List<Pedido> pedidos = sp.findPedidoEntities();
        request.setAttribute("pedidos", pedidos);

        if (!error.isEmpty()) {
            request.setAttribute("error", error);
        }
        getServletContext().getRequestDispatcher(vista).forward(request, response);
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
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("ChocoartePU");
        ServicioPedido sp = new ServicioPedido(emf);
        String error = "";

        String actualizar = request.getParameter("actualizar");

        // Si se selecciona actualizar el estado
        if ("estado".equals(actualizar)) {
            try {
                long id = Long.parseLong(request.getParameter("id"));
                String nuevoEstado = request.getParameter("estado");

                // Se busca ese pedido y se le pone el nuevo estado
                Pedido pedido = sp.findPedido(id);
                if (pedido != null) {
                    pedido.setEstado(nuevoEstado);
                    sp.edit(pedido);

                    // Redirigir a EnviarEmail pasando id y nuevoEstado
                    emf.close();
                    response.sendRedirect("EnviarEmail?id=" + id + "&estado=" + nuevoEstado);
                    return;
                } else {
                    error = "Pedido no encontrado";
                }
            } catch (Exception e) {
                error = "Error al actualizar el estado: " + e.getMessage();
            }

            if (!error.isEmpty()) {
                request.setAttribute("error", error);
                request.getServletContext().getRequestDispatcher("/admin/gestionPedidos.jsp").forward(request, response);
                return;
            }
        }
        emf.close();
        response.sendRedirect("ControladorPedido");
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
