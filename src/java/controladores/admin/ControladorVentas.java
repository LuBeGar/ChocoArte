/*
 * Servlet ControladorVentas
 */
package controladores.admin;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.entidades.Pedido;
import modelo.entidades.ProductoPersonalizado;
import modelo.servicio.ServicioPedido;

/**
 *
 * @author Lu
 */
@WebServlet(name = "ControladorVentas", urlPatterns = {"/ControladorVentas"})
public class ControladorVentas extends HttpServlet {

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
        ServicioPedido servicioPedido = new ServicioPedido(emf);

        String fechaInicioStr = request.getParameter("fechaInicio");
        String fechaFinStr = request.getParameter("fechaFin");

        SimpleDateFormat formatoFecha = new SimpleDateFormat("yyyy-MM-dd");
        Date fechaInicio = null;
        Date fechaFin = null;

        try {
            if (fechaInicioStr != null && !fechaInicioStr.isEmpty()) {
                fechaInicio = formatoFecha.parse(fechaInicioStr);
            }
            if (fechaFinStr != null && !fechaFinStr.isEmpty()) {
                fechaFin = formatoFecha.parse(fechaFinStr);
            }
        } catch (Exception e) {
            getServletContext().getRequestDispatcher("/admin/graficaVentas.jsp").forward(request, response);
            emf.close();
            return;
        }

        // Obtener todos los pedidos
        List<Pedido> pedidos = servicioPedido.findPedidoEntities();

        // Map para acumular la cantidad de veces que se pidió cada producto
        Map<String, Integer> productosMasVendidos = new HashMap<>();

        for (Pedido pedido : pedidos) {
            Date fechaPedido = pedido.getFecha();

            // Filtrar pedidos dentro del rango de fechas
            if ((fechaInicio == null || !fechaPedido.before(fechaInicio))
                    && (fechaFin == null || !fechaPedido.after(fechaFin))) {

                // Recorrer productos personalizados de cada pedido
                List<ProductoPersonalizado> productosPersonalizados = pedido.getProductosPersonalizados();

                // Obtiene el tipo de producto de cada producto personalizado
                for (ProductoPersonalizado productoPersonalizado : productosPersonalizados) {
                    if (productoPersonalizado.getProducto() != null) {
                        String nombreProducto = productoPersonalizado.getProducto().getTipo();

                        // Suma los productos, si el producto ya fue contado, suma 1. Si no, empieza desde 0
                        productosMasVendidos.put(nombreProducto, productosMasVendidos.getOrDefault(nombreProducto, 0) + 1);
                    }
                }
            }
        }

        // Pasar datos a la vista JSP
        request.setAttribute("productosMasVendidos", productosMasVendidos.entrySet());
        emf.close();
        getServletContext().getRequestDispatcher("/admin/graficaVentas.jsp").forward(request, response);
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
