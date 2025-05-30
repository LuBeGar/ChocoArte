/*
 * EnviarEmail
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
import modelo.entidades.Pedido;
import modelo.entidades.Usuario;
import modelo.servicio.ServicioPedido;
import utilidades.Email;
import utilidades.Utilidades;

/**
 *
 * @author Lu
 */
@WebServlet(name = "EnviarEmail", urlPatterns = {"/EnviarEmail"})
public class EnviarEmail extends HttpServlet {

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
        String nuevoEstado = request.getParameter("estado");
        String error = "";

        if (idStr != null && nuevoEstado != null) {
            try {
                long id = Long.parseLong(idStr);

                EntityManagerFactory emf = Persistence.createEntityManagerFactory("ChocoartePU");
                ServicioPedido sp = new ServicioPedido(emf);
                // Buscar pedido por id
                Pedido pedido = sp.findPedido(id);

                if (pedido != null) {
                    Usuario usuario = pedido.getUsuario();

                    // Solo enviar el correo si no es "en proceso"
                    if (!"en proceso".equalsIgnoreCase(nuevoEstado)) {
                        String subject;
                        String text;

                        if ("cancelado".equalsIgnoreCase(nuevoEstado)) {
                            subject = "Tu pedido ha sido cancelado";
                            text = "Hola " + usuario.getNombre() + ",\n\n"
                                    + "Lamentamos informarte que tu pedido con el número " + pedido.getId()
                                    + " ha sido cancelado.\n\n"
                                    + "Si tienes alguna duda, puedes contactar con nuestro equipo de soporte.\n\n"
                                    + "Un saludo,\nEl equipo de ChocoArte";
                        } else {
                            subject = "Actualización del estado de tu pedido";
                            text = "Hola " + usuario.getNombre() + ",\n\n"
                                    + "Te informamos que el estado de tu pedido con número " + pedido.getId()
                                    + " ha sido actualizado a: " + nuevoEstado + ".\n\n"
                                    + "Gracias por confiar en ChocoArte.\n\n"
                                    + "Un saludo,\nEl equipo de ChocoArte";
                        }

                        // Preparar y enviar el correo
                        Email email = new Email();
                        email.setTo(usuario.getEmail());
                        email.setSubject(subject);
                        email.setText(text);
                        email.setFrom("berro.garcia.lucia@iescamas.es");

                        Utilidades u = new Utilidades();
                        u.enviarEmail(email, "efim hvkj pkys kzsu");
                    }
                } else {
                    error = "Pedido no encontrado.";
                }

                emf.close();
            } catch (Exception e) {
                error = "Error al enviar el correo: " + e.getMessage();
            }
        } else {
            error = "Faltan parámetros: id y estado.";
        }

        if (!error.isEmpty()) {
            request.setAttribute("error", error);
        }
        request.getRequestDispatcher("/ControladorPedido").forward(request, response);

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
