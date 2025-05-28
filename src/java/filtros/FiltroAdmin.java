/*
 * FiltroAdmin
 * Controla el acceso a todos los recursos de administrador
 */
package filtros;

import java.io.IOException;
import javax.servlet.DispatcherType;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import modelo.entidades.Usuario;

/**
 *
 * @author Lu
 */
@WebFilter(filterName = "FiltroAdmin", urlPatterns = {"/admin/*"}, dispatcherTypes = {DispatcherType.REQUEST, DispatcherType.FORWARD, DispatcherType.ERROR, DispatcherType.INCLUDE})
public class FiltroAdmin implements Filter {

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession sesion = req.getSession();
        Usuario usuario = (Usuario) sesion.getAttribute("usuario");
        //Si no hay usuario registrado o no es admin
        if (usuario == null || !usuario.getTipo().equals("admin")) {
            res.sendRedirect(req.getServletContext().getContextPath() + "/ControladorLogin");
            return;
        }
        chain.doFilter(request, response);
    }

}
