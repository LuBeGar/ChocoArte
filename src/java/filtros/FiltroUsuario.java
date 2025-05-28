/*
 * FiltroUsuario
 * 
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
@WebFilter(filterName = "FiltroUsuario", urlPatterns = {"/usuario/*"}, dispatcherTypes = {DispatcherType.REQUEST, DispatcherType.FORWARD, DispatcherType.INCLUDE, DispatcherType.ERROR})
public class FiltroUsuario implements Filter {

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession sesion = req.getSession();
        Usuario usuario = (Usuario) sesion.getAttribute("usuario");
        // Si no hay usuario o no es normal
        if (usuario == null || !usuario.getTipo().equals("normal")) {
            res.sendRedirect(req.getServletContext().getContextPath() + "/ControladorLogin");
            return;
        }

        chain.doFilter(request, response);
    }
}
