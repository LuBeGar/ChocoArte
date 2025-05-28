/*
 * Servlet ControladorReview
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
import javax.servlet.http.Part;
import modelo.entidades.ProductoPersonalizado;
import modelo.entidades.Review;
import modelo.entidades.Usuario;
import modelo.servicio.ServicioProductoPersonalizado;
import modelo.servicio.ServicioReview;

/**
 *
 * @author Lu
 */
@WebServlet(name = "ControladorReview", urlPatterns = {"/ControladorReview"})
@MultipartConfig(maxFileSize = 1000000)
public class ControladorReview extends HttpServlet {

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
        ServicioProductoPersonalizado spp = new ServicioProductoPersonalizado(emf);

        String idStr = request.getParameter("idProductoPersonalizado");
        String error = "";
        Usuario usuario = (Usuario) request.getSession().getAttribute("usuario");

        try {
            long id = Long.parseLong(idStr);
            ProductoPersonalizado productoPersonalizado = spp.findProductoPersonalizado(id);

            if (productoPersonalizado == null) {
                error = "Producto no encontrado";
            } else if (productoPersonalizado.getPedido() == null || !"entregado".equalsIgnoreCase(productoPersonalizado.getPedido().getEstado())) {
                error = "Solo puedes dejar una review si el pedido fue entregado";
            } else if (productoPersonalizado.getReview() != null) {
                error = "Ya has dejado una review para este producto";
            } else {
                request.setAttribute("productoPersonalizado", productoPersonalizado);
                request.getRequestDispatcher("/usuario/review.jsp").forward(request, response);
                return;
            }
        } catch (NumberFormatException e) {
            error = "ID de producto inválido";
        } catch (Exception e) {
            error = "Error al cargar el producto: " + e.getMessage();
        } finally {
            emf.close();
        }

        request.setAttribute("error", error);
        request.getRequestDispatcher("/usuario/review.jsp").forward(request, response);
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
        ServicioReview sr = new ServicioReview(emf);
        ServicioProductoPersonalizado spp = new ServicioProductoPersonalizado(emf);

        String comentario = request.getParameter("comentario");
        String valoracionStr = request.getParameter("valoracion");
        String idProductoPersonalizadoStr = request.getParameter("idProductoPersonalizado");
        List<String> imagenes = new ArrayList<>();

        Usuario usuario = (Usuario) request.getSession().getAttribute("usuario");
        String error = "";

        try {
            int valoracion = Integer.parseInt(valoracionStr);
            long idProductoPersonalizado = Long.parseLong(idProductoPersonalizadoStr);

            ProductoPersonalizado productoPersonalizado = spp.findProductoPersonalizado(idProductoPersonalizado);

            if (productoPersonalizado == null) {
                error = "Producto personalizado no encontrado.";
            } else if (productoPersonalizado.getPedido() == null || !"entregado".equalsIgnoreCase(productoPersonalizado.getPedido().getEstado())) {
                error = "No puedes dejar una review hasta que el pedido haya sido entregado.";
            } else if (!productoPersonalizado.getPedido().getUsuario().getId().equals(usuario.getId())) {
                error = "No tienes permiso para dejar una review de este producto.";
            } else if (productoPersonalizado.getReview() != null) {
                error = "Ya has dejado una review para este producto.";
            } else {
                // Crear review
                Review review = new Review();
                review.setComentario(comentario);
                review.setValoracion(valoracion);
                review.setUsuario(usuario);
                review.setFecha(new Date());
                review.setProductoPersonalizado(productoPersonalizado);

                // Procesar múltiples imágenes
                for (Part parte : request.getParts()) {
                    if (parte.getName().equals("imagenes") && parte.getSize() > 0) {
                        String nombreImagen = parte.getSubmittedFileName();
                        String path = getServletContext().getRealPath("/imagenes");
                        String rutaArchivo = path + "/" + nombreImagen;

                        try (InputStream contenido = parte.getInputStream(); 
                                FileOutputStream fos = new FileOutputStream(rutaArchivo)) {
                            byte[] buffer = new byte[8192];
                            int bytesLeidos;
                            while ((bytesLeidos = contenido.read(buffer)) != -1) {
                                fos.write(buffer, 0, bytesLeidos);
                            }
                            imagenes.add(nombreImagen);
                        } catch (IOException e) {
                            error = "Error al guardar la imagen: " + e.getMessage();
                            break;
                        }
                    }
                }
                review.setImagenes(imagenes);
                sr.create(review);
            }

        } catch (NumberFormatException e) {
            error = "Datos de review inválidos";
        } catch (Exception e) {
            error = "Error al guardar la review: " + e.getMessage();
        } finally {
            emf.close();
        }

        if (!error.isEmpty()) {
            request.setAttribute("error", error);
            request.getRequestDispatcher("/usuario/review.jsp").forward(request, response);
        } else {
            response.sendRedirect("ControladorGestionPedidos");
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
