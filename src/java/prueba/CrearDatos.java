/*
 * Datos de prueba
 */
package prueba;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
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
import modelo.entidades.Review;
import modelo.entidades.Usuario;
import modelo.servicio.ServicioPedido;
import modelo.servicio.ServicioProducto;
import modelo.servicio.ServicioProductoPersonalizado;
import modelo.servicio.ServicioReview;
import modelo.servicio.ServicioUsuario;

/**
 *
 * @author Lu
 */
@WebServlet(name = "CrearDatos", urlPatterns = {"/CrearDatos"})
public class CrearDatos extends HttpServlet {

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

        EntityManagerFactory emf = Persistence.createEntityManagerFactory("ChocoartePU");
        ServicioUsuario su = new ServicioUsuario(emf);
        ServicioPedido sp = new ServicioPedido(emf);
        ServicioReview sr = new ServicioReview(emf);
        ServicioProducto sprod = new ServicioProducto(emf);
        ServicioProductoPersonalizado spp = new ServicioProductoPersonalizado(emf);

        // ---------- Crear Usuario ----------
        Usuario usuario = new Usuario();
        usuario.setNombre("Lucía");
        usuario.setEmail("lucia@correo.com");
        usuario.setPassword("Contrasena123@");
        usuario.setDireccion("Calle Chocolate 123");
        usuario.setTipo("normal");
        usuario.setPuntos(0);
        usuario.setTelefono("123456789");
        try {
            usuario.setFechaNacimiento(new SimpleDateFormat("yyyy-MM-dd").parse("1997-04-24"));
        } catch (Exception e) {
            e.printStackTrace();
        }
        usuario.setGenero("Femenino");
        usuario.setSaborFavorito("Negro");
        usuario.setComentarios("Usuario de prueba creado automáticamente");

        try {
            su.create(usuario);
        } catch (Exception e) {
            e.printStackTrace();
        }

        // ---------- Crear Productos base ----------
        Producto producto1 = new Producto();
        producto1.setTipo("Tarta Mediana");
        producto1.setDescripcion("Una deliciosa tarta hecha a mano con los mejores ingredientes");
        producto1.setPrecio(25.50);
        producto1.setImagen("tarta_corazon.jpg");

        Producto producto2 = new Producto();
        producto2.setTipo("Tarta Pequeña");
        producto2.setDescripcion("Tarta más pequeña pero igualmente deliciosa.");
        producto2.setPrecio(15.00);
        producto2.setImagen("tarta_pequena.jpg");

        try {
            sprod.create(producto1);
            sprod.create(producto2);
        } catch (Exception e) {
            e.printStackTrace();
        }

        // ---------- Crear Pedido ----------
        Pedido pedido = new Pedido();
        pedido.setFecha(new Date());
        pedido.setEstado("pendiente");
        pedido.setEntrega("Envío a domicilio");
        pedido.setUsuario(usuario);

        // ---------- Crear Productos Personalizados ----------
        ProductoPersonalizado pp1 = new ProductoPersonalizado();
        pp1.setForma("Corazón");
        pp1.setAlergenos("Sin gluten");
        pp1.setDescripcion("Tarta personalizada sin gluten en forma de corazón");
        pp1.setPrecio(30.00); 
        pp1.setPedido(pedido);
        pp1.setProducto(producto1);

        ProductoPersonalizado pp2 = new ProductoPersonalizado();
        pp2.setForma("Estrella");
        pp2.setAlergenos("Contiene frutos secos");
        pp2.setDescripcion("Tarta pequeña personalizada con decoración especial");
        pp2.setPrecio(18.00);
        pp2.setPedido(pedido);
        pp2.setProducto(producto2);

        List<ProductoPersonalizado> personalizados = new ArrayList<>();
        personalizados.add(pp1);
        personalizados.add(pp2);
        pedido.setProductosPersonalizados(personalizados);

        try {
            sp.create(pedido); 
        } catch (Exception e) {
            e.printStackTrace();
        }

        // ---------- Crear Review ----------
        Review review = new Review();
        review.setValoracion(5);
        review.setComentario("¡La tarta estaba deliciosa y llegó a tiempo!");
        review.setImagenes("review1.jpg,review2.jpg");
        review.setUsuario(usuario);

        try {
            sr.create(review);
        } catch (Exception e) {
            e.printStackTrace();
        }

        emf.close();

        // Mostrar respuesta en HTML
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Crear Usuario de Prueba</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Usuario de prueba creado con éxito</h1>");
            out.println("<p>Email: " + usuario.getEmail() + "</p>");
            out.println("<p>Nombre: " + usuario.getNombre() + "</p>");
            out.println("</body>");
            out.println("</html>");
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
