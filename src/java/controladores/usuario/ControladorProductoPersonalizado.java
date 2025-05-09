/*
 * Servlet ControladorProductoPersonalizado
 */
package controladores.usuario;

import java.io.IOException;
import java.util.ArrayList;
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
import modelo.entidades.Producto;
import modelo.entidades.ProductoPersonalizado;
import modelo.entidades.Usuario;
import modelo.servicio.ServicioPedido;
import modelo.servicio.ServicioProducto;
import modelo.servicio.ServicioProductoPersonalizado;

/**
 *
 * @author Lu
 */
@WebServlet(name = "ControladorProductoPersonalizado", urlPatterns = {"/ControladorProductoPersonalizado"})
public class ControladorProductoPersonalizado extends HttpServlet {

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
         // Se obtiene el usuario de la sesión
        HttpSession session = request.getSession();
        Usuario usuario = (Usuario) session.getAttribute("usuario");

        // Si no hay usuario en sesión, se redirige al login
        if (usuario == null) {
            response.sendRedirect("ControladorLogin");
            return;
        }

        EntityManagerFactory emf = Persistence.createEntityManagerFactory("ChocoartePU");
        ServicioProducto sp = new ServicioProducto(emf);

        String idProductoStr = request.getParameter("idProducto");
        String tipoProducto = request.getParameter("tipo");

        try {
            // Se convierte el ID de producto a long
            long idProducto = Long.parseLong(idProductoStr);
            Producto productoBase = sp.findProducto(idProducto);

            // Si el producto no existe, se muestra error
            if (productoBase == null) {
                request.setAttribute("error", "Producto no encontrado");
                return;
            }

            // Se obtiene el pedido actual en curso desde la sesión
            Pedido pedidoEnCurso = (Pedido) session.getAttribute("pedidoEnCurso");

            // Se establecen atributos para mostrar en el JSP
            request.setAttribute("productoBase", productoBase);
            request.setAttribute("tipoProducto", tipoProducto);
            request.setAttribute("pedido", pedidoEnCurso);

            // Se redirige al formulario de personalización
            getServletContext().getRequestDispatcher("/usuario/personalizarProducto.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            request.setAttribute("error", "ID de producto inválido");
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
         // Se obtiene el usuario desde la sesión
        HttpSession session = request.getSession();
        Usuario usuario = (Usuario) session.getAttribute("usuario");

        // Si no hay usuario, redirige al login
        if (usuario == null) {
            response.sendRedirect("ControladorLogin");
            return;
        }

        EntityManagerFactory emf = Persistence.createEntityManagerFactory("ChocoartePU");

        try {
            // Parámetros recibidos del formulario
            String idProductoStr = request.getParameter("idProducto");
            String forma = request.getParameter("forma");
            String alergenos = request.getParameter("alergenos");
            String otrosAlergenos = request.getParameter("otrosAlergenos");
            String descripcionPersonalizada = request.getParameter("descripcionPersonalizada");
            String accion = request.getParameter("accion");

            // Descripción de alérgenos
            String alergenosCompletos = "otros".equals(alergenos)
                    ? "Otros: " + otrosAlergenos
                    : alergenos;

            ServicioProducto sp = new ServicioProducto(emf);
            ServicioPedido sPedido = new ServicioPedido(emf);
            ServicioProductoPersonalizado spp = new ServicioProductoPersonalizado(emf);

            // Se busca el producto base
            long idProducto = Long.parseLong(idProductoStr);
            Producto productoBase = sp.findProducto(idProducto);

            if (productoBase == null) {
                request.setAttribute("error", "Producto no encontrado");
                return;
            }

            // Se recupera o inicializa el pedido en curso
            Pedido pedidoEnCurso = (Pedido) session.getAttribute("pedidoEnCurso");

            if (pedidoEnCurso == null) {
                pedidoEnCurso = new Pedido();
                pedidoEnCurso.setUsuario(usuario);
                pedidoEnCurso.setFecha(new Date());
                pedidoEnCurso.setEstado("En proceso");
                pedidoEnCurso.setPrecio(0.0);

                // Creamos el pedido nuevo en la BD
                sPedido.create(pedidoEnCurso);
                session.setAttribute("pedidoEnCurso", pedidoEnCurso);
            }

            // Creamos el producto personalizado
            ProductoPersonalizado productoPersonalizado = new ProductoPersonalizado();
            productoPersonalizado.setForma(forma);
            productoPersonalizado.setAlergenos(alergenosCompletos);
            productoPersonalizado.setDescripcion(descripcionPersonalizada);
            productoPersonalizado.setPrecio(productoBase.getPrecio());
            productoPersonalizado.setProducto(productoBase);
            productoPersonalizado.setPedido(pedidoEnCurso);

            // Guardamos en la BD
            spp.create(productoPersonalizado);

            // Añadimos a la lista de productos personalizados del pedido
            if (pedidoEnCurso.getProductosPersonalizados() == null) {
                pedidoEnCurso.setProductosPersonalizados(new ArrayList<>());
            }
            pedidoEnCurso.getProductosPersonalizados().add(productoPersonalizado);
            sPedido.edit(pedidoEnCurso);

            // Actualizamos el precio del pedido
            pedidoEnCurso.setPrecio(pedidoEnCurso.getPrecio() + productoBase.getPrecio());
            sPedido.edit(pedidoEnCurso);

            // Si el usuario decide finalizar el pedido
            if ("finalizar".equals(accion)) {
                pedidoEnCurso.setEstado("Completado");
                sPedido.edit(pedidoEnCurso);
                session.removeAttribute("pedidoEnCurso");

                response.sendRedirect("ControladorVerResumenPedido?pedidoId=" + pedidoEnCurso.getId());
            } else {
                // Si solo añadió el producto, lo llevamos al inicio
                response.sendRedirect("ControladorPrincipal");
            }

        } catch (Exception e) {
            request.setAttribute("error", "Error al procesar el pedido: " + e.getMessage());
            getServletContext().getRequestDispatcher("/usuario/personalizarProducto.jsp").forward(request, response);
        } finally {
            emf.close();
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
