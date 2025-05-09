/*
 * Servlet ControladorPedido
 */
package controladores.admin;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.entidades.Pedido;
import modelo.entidades.Producto;
import modelo.entidades.ProductoPersonalizado;
import modelo.entidades.Usuario;
import modelo.servicio.ServicioPedido;
import modelo.servicio.ServicioUsuario;
import modelo.servicio.ServicioProducto;

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
        String crear = request.getParameter("crear");
        String idStr = request.getParameter("id");
        String vista = "/producto.jsp";
        String error = "";

        if (crear != null && idStr != null) {
            try {
                long id = Long.parseLong(idStr);
                EntityManagerFactory emf = Persistence.createEntityManagerFactory("ChocoartePU");
                ServicioProducto sp = new ServicioProducto(emf);
                Producto producto = sp.findProducto(id);
                if (producto != null) {
                    request.setAttribute("producto", producto);
                } else {
                    error = "Producto no encontrado.";
                }
                emf.close();
            } catch (Exception e) {
                error = "Error al cargar el producto: " + e.getMessage();
            }
        } else {
            error = "Solicitud inválida.";
        }

        if (!error.isEmpty()) {
            request.setAttribute("error", error);
        }

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
