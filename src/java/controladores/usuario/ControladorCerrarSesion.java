/*
 * ControladorCerrarSesion
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
import javax.servlet.http.HttpSession;
import modelo.entidades.Pedido;
import modelo.entidades.ProductoPersonalizado;
import modelo.servicio.ServicioPedido;
import modelo.servicio.ServicioProductoPersonalizado;

/**
 *
 * @author Lu
 */
@WebServlet(name = "ControladorCerrarSesion", urlPatterns = {"/ControladorCerrarSesion"})
public class ControladorCerrarSesion extends HttpServlet {

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
        HttpSession session = request.getSession();
        EntityManagerFactory emf = null;

        try {
            // Si hay sesión obtiene el pedidoEnCurso
            if (session != null) {
                Pedido pedidoEnCurso = (Pedido) session.getAttribute("pedidoEnCurso");

                // Si el pedido está en proceso se borra al cerrar la sesión
                if (pedidoEnCurso != null
                        && pedidoEnCurso.getId() != null
                        && "En proceso".equals(pedidoEnCurso.getEstado())) {
                    emf = Persistence.createEntityManagerFactory("ChocoartePU");
                    ServicioPedido servicioPedido = new ServicioPedido(emf);

                    servicioPedido.destroy(pedidoEnCurso.getId());
                }
                session.invalidate();
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (emf != null) {
                emf.close();
            }
            response.sendRedirect("index.html");
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
