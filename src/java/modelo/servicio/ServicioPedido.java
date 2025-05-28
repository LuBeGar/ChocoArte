/*
 * ServicioPedido
 */
package modelo.servicio;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.NoResultException;
import javax.persistence.Query;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import modelo.entidades.Pedido;
import modelo.entidades.ProductoPersonalizado;
import modelo.entidades.Usuario;
import modelo.servicio.exceptions.NonexistentEntityException;

/**
 *
 * @author Lu
 */
public class ServicioPedido implements Serializable {

    public ServicioPedido(EntityManagerFactory emf) {
        this.emf = emf;
    }

    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    // Crear pedido
    public void create(Pedido pedido) {
        EntityManager em = getEntityManager();
        try {
            em.getTransaction().begin();

            // Asociar usuario al pedido
            if (pedido.getUsuario() != null) {
                Usuario usuario = em.getReference(Usuario.class, pedido.getUsuario().getId());
                pedido.setUsuario(usuario);
            }

            // Procesar productos personalizados y calcular precio
            double precioTotal = 0;
            if (pedido.getProductosPersonalizados() != null) {
                for (ProductoPersonalizado producto : pedido.getProductosPersonalizados()) {
                    producto.setPedido(pedido);
                    precioTotal += producto.getPrecio();
                    em.persist(producto);
                }
            }

            pedido.setPrecio(precioTotal);
            em.persist(pedido);
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }

    // Editar pedido
    public void edit(Pedido pedido) throws NonexistentEntityException, Exception {
        EntityManager em = getEntityManager();
        try {
            em.getTransaction().begin();

            Pedido persistente = em.find(Pedido.class, pedido.getId());
            if (persistente == null) {
                throw new NonexistentEntityException("El pedido con ID " + pedido.getId() + " ya no existe");
            }

            // Actualizar usuario
            if (pedido.getUsuario() != null) {
                Usuario nuevoUsuario = em.getReference(Usuario.class, pedido.getUsuario().getId());
                pedido.setUsuario(nuevoUsuario);
            }

            // Eliminar productos que ya no están en la lista
            List<ProductoPersonalizado> antiguos = persistente.getProductosPersonalizados();
            List<ProductoPersonalizado> nuevos = pedido.getProductosPersonalizados();
            for (ProductoPersonalizado prod : antiguos) {
                if (!nuevos.contains(prod)) {
                    em.remove(em.contains(prod) ? prod : em.merge(prod));
                }
            }

            // Asociar y guardar nuevos productos o editados
            for (ProductoPersonalizado producto : nuevos) {
                producto.setPedido(pedido);
                em.merge(producto);
            }

            em.merge(pedido);
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }

    // Eliminar pedido
    public void destroy(Long id) throws NonexistentEntityException {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();

            Pedido pedido;
            try {
                // Buscar pedido con sus productos personalizados
                pedido = em.createQuery(
                        "SELECT p FROM Pedido p LEFT JOIN FETCH p.productosPersonalizados WHERE p.id = :id",
                        Pedido.class)
                        .setParameter("id", id)
                        .getSingleResult();
            } catch (NoResultException e) {
                throw new NonexistentEntityException("El pedido con ID " + id + " no existe.");
            }

            // Eliminar productos personalizados asociados al pedido
            List<ProductoPersonalizado> productos = new ArrayList<>(pedido.getProductosPersonalizados());
            for (ProductoPersonalizado producto : productos) {
                producto.setPedido(null);
                em.remove(em.contains(producto) ? producto : em.merge(producto));
            }

            // Eliminar productos el pedido
            pedido.getProductosPersonalizados().clear();

            // Eliminar relación con el usuario
            Usuario usuario = pedido.getUsuario();
            if (usuario != null) {
                usuario.getPedidos().remove(pedido);
                em.merge(usuario);
            }

            // Eliminar el pedido
            em.remove(em.contains(pedido) ? pedido : em.merge(pedido));
            em.getTransaction().commit();

        } catch (Exception ex) {
            if (em != null && em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw new NonexistentEntityException("Error al eliminar el pedido: " + ex.getMessage(), ex);
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    // Obtener todos los pedidos sin paginación
    public List<Pedido> findPedidoEntities() {
        return findPedidoEntities(true, -1, -1);
    }

    // Obtener pedidos con paginación
    public List<Pedido> findPedidoEntities(int maxResults, int firstResult) {
        return findPedidoEntities(false, maxResults, firstResult);
    }

    // Obtener pedidos
    private List<Pedido> findPedidoEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            // Seleccionar todos los pedidos
            CriteriaQuery<Pedido> cq = em.getCriteriaBuilder().createQuery(Pedido.class);
            cq.select(cq.from(Pedido.class));
            Query q = em.createQuery(cq);
            if (!all) {
                q.setMaxResults(maxResults);
                q.setFirstResult(firstResult);
            }
            return q.getResultList();
        } finally {
            em.close();
        }
    }

    // Buscar pedido por id
    public Pedido findPedido(Long id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Pedido.class, id);
        } finally {
            em.close();
        }
    }

    // Cantidad total de pedidos
    public int getPedidoCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery<Long> cq = em.getCriteriaBuilder().createQuery(Long.class);
            Root<Pedido> rt = cq.from(Pedido.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }

    // Recupera un pedido con sus productos personalizados
    public Pedido findPedidoConProductosPersonalizados(Long id) {
        EntityManager em = getEntityManager();
        try {
            return em.createQuery(
                    "SELECT p FROM Pedido p LEFT JOIN FETCH p.productosPersonalizados WHERE p.id = :id", Pedido.class)
                    .setParameter("id", id)
                    .getSingleResult();
        } finally {
            em.close();
        }
    }

    // Marca un pedido como confirmado
    public Pedido confirmarPedido(Long id, String tipoEntrega, String direccion) {
        EntityManager em = getEntityManager();
        try {
            em.getTransaction().begin();
            Pedido pedido = em.find(Pedido.class, id);
            if (pedido != null) {
                pedido.setEstado("Confirmado");
                pedido.setEntrega(tipoEntrega);
                pedido.setDireccionEntrega(direccion);
                pedido.setFecha(new Date());
                pedido = em.merge(pedido);
            }
            em.getTransaction().commit();
            return pedido;
        } finally {
            em.close();
        }
    }

}
