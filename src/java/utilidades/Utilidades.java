/*
 * Clase Utilidades (enviar email)
 */
package utilidades;

import java.util.Properties;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/**
 *
 * @author Lu
 */
public class Utilidades {

    public void enviarEmail(Email email, String password) throws MessagingException {
        Properties p = new Properties();
        // Servidor smtp de correo
        p.setProperty("mail.smtp.host", "smtp.gmail.com");
        // Usar TLS
        p.setProperty("mail.smtp.starttls.enable", "true");
        // puerto del servidor smtp
        p.setProperty("mail.smtp.port", "587");
        // Usuario smtp
        p.setProperty("mail.smtp.user", "berro.garcia.lucia@iescamas.es");
        // Autenticación requerida
        p.setProperty("mail.smtp.auth", "true");
        // Obtenemos la sesión
        Session sesion = Session.getDefaultInstance(p);
        sesion.setDebug(false);
        // Creamos el mensaje
        MimeMessage mensaje = new MimeMessage(sesion);
        // Y establecemos sus propiedades
        //try {
        mensaje.setFrom(new InternetAddress("berro.garcia.lucia@iescamas.es"));
        mensaje.addRecipient(Message.RecipientType.TO, new InternetAddress(email.getTo()));
        mensaje.setSubject(email.getSubject());
        mensaje.setText(email.getText());
        // Enviamos el mensaje
        Transport t = sesion.getTransport("smtp");
        // Para conectarnos usamos usuario y password
        t.connect("berro.garcia.lucia@iescamas.es", "efim hvkj pkys kzsu");
        t.sendMessage(mensaje, mensaje.getAllRecipients());
        //} catch (MessagingException e) {
        //emailError = e.getMessage();

    }
}
