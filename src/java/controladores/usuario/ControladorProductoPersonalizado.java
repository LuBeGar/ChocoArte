/*
 * Servlet ControladorProductoPersonalizado
 */
package controladores.usuario;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
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
@MultipartConfig(maxFileSize = 1000000)
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
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("ChocoartePU");
        ServicioProducto sp = new ServicioProducto(emf);

        String idProductoStr = request.getParameter("idProducto");
        String tipoProducto = request.getParameter("tipo");

        try {
            long idProducto = Long.parseLong(idProductoStr);
            Producto productoBase = sp.findProducto(idProducto);

            // Si el producto no existe, se muestra error
            if (productoBase == null) {
                request.setAttribute("error", "Producto no encontrado");
                return;
            }

            // Se obtiene el pedido actual en curso desde la sesión
            Pedido pedidoEnCurso = (Pedido) session.getAttribute("pedidoEnCurso");

            request.setAttribute("productoBase", productoBase);
            request.setAttribute("tipoProducto", tipoProducto);
            request.setAttribute("pedido", pedidoEnCurso);

            // Se redirige al formulario de personalización
            getServletContext().getRequestDispatcher("/usuario/personalizarProducto.jsp").forward(request, response);

        } catch (Exception e) {
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
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("ChocoartePU");

        try {
            Pedido pedidoEnCurso = (Pedido) session.getAttribute("pedidoEnCurso");

            // Si hay pedido en curso, refrescarlo desde la bbdd
            ServicioPedido sPedido = new ServicioPedido(emf);
            if (pedidoEnCurso != null) {
                pedidoEnCurso = sPedido.findPedidoConProductosPersonalizados(pedidoEnCurso.getId());

                // Si el pedido ya está confirmado, se quita del en curso
                if ("Confirmado".equals(pedidoEnCurso.getEstado())) {
                    pedidoEnCurso = null;
                    session.removeAttribute("pedidoEnCurso");
                }
            }

            // Obtener parámetros del formulario
            String idProductoStr = request.getParameter("idProducto");
            String forma = request.getParameter("forma");
            String alergenos = request.getParameter("alergenos");
            String otrosAlergenos = request.getParameter("otrosAlergenos");
            String descripcionPersonalizada = request.getParameter("descripcionPersonalizada");
            String accion = request.getParameter("accion");
            List<String> imagen = new ArrayList<>();

            // Si los alérgenos son otros se guarda con lo que escriba en el campo
            String alergenosCompletos = "otros".equals(alergenos)
                    ? "Otros: " + otrosAlergenos
                    : alergenos;

            String nombreImagen = null;
            Part imagenPart = request.getPart("imagen");
            if (imagenPart != null && imagenPart.getSize() > 0) {
                nombreImagen = imagenPart.getSubmittedFileName();
                String path = getServletContext().getRealPath("/imagenes");
                String rutaArchivo = path + "/" + nombreImagen;

                try (InputStream contenido = imagenPart.getInputStream(); FileOutputStream fos = new FileOutputStream(rutaArchivo)) {
                    byte[] buffer = new byte[8192];
                    int bytesLeidos;
                    while ((bytesLeidos = contenido.read(buffer)) != -1) {
                        fos.write(buffer, 0, bytesLeidos);
                    }
                } catch (IOException e) {
                    String error = "Error al guardar la imagen: " + e.getMessage();
                }
                imagen.add(nombreImagen);
            }
            // Validar que todos los campos requeridos estén presentes
            if (forma == null || forma.trim().isEmpty()
                    || alergenos == null || alergenos.trim().isEmpty()
                    || ("otros".equals(alergenos) && (otrosAlergenos == null || otrosAlergenos.trim().isEmpty()))
                    || descripcionPersonalizada == null || descripcionPersonalizada.trim().isEmpty()) {

                request.setAttribute("error", "Todos los campos requeridos deben estar completos");
                request.setAttribute("idProducto", request.getParameter("idProducto"));
                request.setAttribute("tipoProducto", request.getParameter("tipoProducto"));

                // Reenviar al formulario con los datos cargados para que el usuario corrija
                getServletContext().getRequestDispatcher("/usuario/personalizarProducto.jsp").forward(request, response);
                return;
            }

            ServicioProducto sp = new ServicioProducto(emf);
            ServicioProductoPersonalizado spp = new ServicioProductoPersonalizado(emf);

            long idProducto = Long.parseLong(idProductoStr);
            Producto productoBase = sp.findProducto(idProducto);

            if (productoBase == null) {
                request.setAttribute("error", "Producto no encontrado");
                return;
            }

            // Crear nuevo pedido solo si no hay uno válido
            if (pedidoEnCurso == null) {
                pedidoEnCurso = new Pedido();
                pedidoEnCurso.setUsuario(usuario);
                pedidoEnCurso.setFecha(new Date());
                pedidoEnCurso.setEstado("En proceso");
                pedidoEnCurso.setPrecio(0.0);

                sPedido.create(pedidoEnCurso);
                session.setAttribute("pedidoEnCurso", pedidoEnCurso);
            }

            // Crear producto personalizado
            ProductoPersonalizado productoPersonalizado = new ProductoPersonalizado();
            productoPersonalizado.setForma(forma);
            productoPersonalizado.setAlergenos(alergenosCompletos);
            productoPersonalizado.setDescripcion(descripcionPersonalizada);
            productoPersonalizado.setPrecio(productoBase.getPrecio());
            productoPersonalizado.setProducto(productoBase);
            productoPersonalizado.setImagen(nombreImagen != null ? nombreImagen : "");
            productoPersonalizado.setPedido(pedidoEnCurso);

            // Guardar producto y actualizar pedido
            spp.create(productoPersonalizado);

            // Añadir producto personalizado a la lista del pedido
            if (pedidoEnCurso.getProductosPersonalizados() == null) {
                pedidoEnCurso.setProductosPersonalizados(new ArrayList<>());
            }
            pedidoEnCurso.getProductosPersonalizados().add(productoPersonalizado);

            // Actualizar precio total del pedido
            pedidoEnCurso.setPrecio(pedidoEnCurso.getPrecio() + productoBase.getPrecio());
            sPedido.edit(pedidoEnCurso);

            if ("finalizar".equals(accion)) {
                response.sendRedirect("ControladorVerResumenPedido?pedidoId=" + pedidoEnCurso.getId());
            } else {
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
