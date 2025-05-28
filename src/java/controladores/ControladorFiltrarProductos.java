/*
 * Servlet ControladorFiltrarProductos
 */
package controladores;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
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
@WebServlet(name = "ControladorFiltrarProductos", urlPatterns = {"/ControladorFiltrarProductos"})
public class ControladorFiltrarProductos extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");

        String filtro = request.getParameter("filtro");
        String precioMinStr = request.getParameter("precioMin");
        String precioMaxStr = request.getParameter("precioMax");

        if (filtro == null) {
            filtro = "";
        }
        filtro = filtro.toLowerCase().trim();

        // Inicializar los valores de precio con valores por defecto
        double precioMin = 0;
        double precioMax = Double.MAX_VALUE;

        try {
            if (precioMinStr != null && !precioMinStr.isEmpty()) {
                precioMin = Double.parseDouble(precioMinStr);
            }
            if (precioMaxStr != null && !precioMaxStr.isEmpty()) {
                precioMax = Double.parseDouble(precioMaxStr);
            }
        } catch (NumberFormatException e) {
            // Si el usuario escribe un número inválido, se ignora el error y se usan los valores por defecto
        }

        // Listar productos
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("ChocoartePU");
        ServicioProducto sp = new ServicioProducto(emf);
        List<Producto> productos = sp.findProductoEntities();
        emf.close();

        // Crear una lista vacía para almacenar los productos que cumplan los filtros
        List<Producto> filtrados = new ArrayList<>();
        // Recorrer todos los productos y aplicar los filtros
        for (Producto p : productos) {
            // Verificar si el producto coincide con el texto en tipo o descripción
            boolean coincideTexto = p.getTipo().toLowerCase().contains(filtro)
                    || p.getDescripcion().toLowerCase().contains(filtro);
            // Verificar si el precio está dentro del rango especificado
            boolean enRangoPrecio = p.getPrecio() >= precioMin && p.getPrecio() <= precioMax;

            // Si cumple ambas condiciones, se agrega a la lista de resultados
            if (coincideTexto && enRangoPrecio) {
                filtrados.add(p);
            }
        }

        // Enviar la lista de productos filtrados al JSP para mostrarla
        request.setAttribute("productos", filtrados);
        getServletContext().getRequestDispatcher("/principal.jsp").forward(request, response);
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
