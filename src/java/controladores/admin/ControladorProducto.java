/*
 * Servlet ControladorProducto
 */
package controladores.admin;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
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
import modelo.entidades.Producto;
import static modelo.entidades.Producto_.imagen;
import modelo.servicio.ServicioProducto;

/**
 *
 * @author Lu
 */
@WebServlet(name = "ControladorProducto", urlPatterns = {"/ControladorProducto"})
@MultipartConfig(maxFileSize = 1000000)
public class ControladorProducto extends HttpServlet {

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
        ServicioProducto sp = new ServicioProducto(emf);
        String vistaParam = request.getParameter("vista");
        String vista = "/admin/gestionProductos.jsp";
        String error = "";

        String eliminar = request.getParameter("eliminar");
        String editar = request.getParameter("editar");
        String crear = request.getParameter("crear");

        // Mostrar formulario de creación
        if (crear != null) {
            vista = "/admin/crearProducto.jsp";
        }
        // Eliminar producto
        else if (eliminar != null && request.getParameter("id") != null) {
            try {
                long id = Long.parseLong(request.getParameter("id"));
                sp.destroy(id);
                emf.close();
                response.sendRedirect("ControladorProducto");
                return;
            } catch (Exception e) {
                error = "No se pudo eliminar el producto: " + e.getMessage();
            }
        }
        // Editar producto
        else if (editar != null && request.getParameter("id") != null) {
            try {
                long id = Long.parseLong(request.getParameter("id"));
                Producto producto = sp.findProducto(id);
                request.setAttribute("id", producto.getId());
                request.setAttribute("tipo", producto.getTipo());
                request.setAttribute("descripcion", producto.getDescripcion());
                request.setAttribute("precio", producto.getPrecio());
                request.setAttribute("imagen", producto.getImagen());
                vista = "/admin/editarProducto.jsp";
            } catch (Exception e) {
                error = "No se pudo cargar el producto: " + e.getMessage();
            }
        }

        // Obtener lista de productos
        List<Producto> productos = sp.findProductoEntities();
        request.setAttribute("productos", productos);

        // Redirigir a vista pública si se solicita
       

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
        ServicioProducto sp = new ServicioProducto(emf);

        String error = "";
        String idStr = request.getParameter("id");
        String tipo = request.getParameter("tipo");
        String descripcion = request.getParameter("descripcion");
        String precioStr = request.getParameter("precio");
        List<String> imagen = new ArrayList<>();

        double precio = 0;
        try {
            precio = Double.parseDouble(precioStr);
        } catch (Exception e) {
            error = "Precio inválido";
        }

        // Procesar imagen si se ha subido
        String nombreImagen = null;
        Part imagenPart = request.getPart("imagen");
        if (imagenPart != null && imagenPart.getSize() > 0) {
            nombreImagen = imagenPart.getSubmittedFileName();
            String path = getServletContext().getRealPath("/imagenes");
            String rutaArchivo = path + "/" + nombreImagen;

            try (InputStream contenido = imagenPart.getInputStream();
                 FileOutputStream fos = new FileOutputStream(rutaArchivo)) {
                byte[] buffer = new byte[8192];
                int bytesLeidos;
                while ((bytesLeidos = contenido.read(buffer)) != -1) {
                    fos.write(buffer, 0, bytesLeidos);
                }
            } catch (IOException e) {
                error = "Error al guardar la imagen: " + e.getMessage();
            }
            imagen.add(nombreImagen);
        }

        if (request.getParameter("editar") != null && idStr != null) {
            try {
                long id = Long.parseLong(idStr);
                Producto producto = sp.findProducto(id);
                if (producto != null) {
                    producto.setTipo(tipo);
                    producto.setDescripcion(descripcion);
                    producto.setPrecio(precio);
                    if (nombreImagen != null) {
                        producto.setImagen(nombreImagen);
                    }
                    sp.edit(producto);
                } else {
                    error = "Producto no encontrado";
                }
            } catch (Exception e) {
                error = "Error al editar el producto: " + e.getMessage();
            }

        } else if (request.getParameter("crear") != null) {
            try {
                Producto producto = new Producto();
                producto.setTipo(tipo);
                producto.setDescripcion(descripcion);
                producto.setPrecio(precio);
                producto.setImagen(nombreImagen != null ? nombreImagen : "");
                sp.create(producto);
            } catch (Exception e) {
                error = "Error al crear el producto: " + e.getMessage();
            }
        }

        if (!error.isEmpty()) {
            request.setAttribute("error", error);
            request.setAttribute("tipo", tipo);
            request.setAttribute("descripcion", descripcion);
            request.setAttribute("precio", precio);
            request.setAttribute("imagen", nombreImagen);

            if (request.getParameter("editar") != null) {
                getServletContext().getRequestDispatcher("/admin/editarProducto.jsp").forward(request, response);
            } else {
                getServletContext().getRequestDispatcher("/admin/crearProducto.jsp").forward(request, response);
            }
        } else {
            emf.close();
            response.sendRedirect("ControladorProducto");
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
