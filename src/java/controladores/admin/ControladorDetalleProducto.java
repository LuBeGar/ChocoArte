/*
 * Servlet ControladorDetalleProducto
 */
package controladores.admin;

import java.io.IOException;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.entidades.Producto;
import modelo.servicio.ServicioProducto;

/**
 *
 * @author Lu
 */
@WebServlet(name = "ControladorDetalleProducto", urlPatterns = {"/ControladorDetalleProducto"})
public class ControladorDetalleProducto extends HttpServlet {

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
        String idStr = request.getParameter("id");
        String vista = "/producto.jsp";
        String error = "";

        if ( idStr != null) {
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
