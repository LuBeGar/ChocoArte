/*
 * ServicioPedido
 */
package modelo.servicio;

import java.io.Serializable;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityNotFoundException;
import javax.persistence.Query;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import modelo.entidades.Pedido;
import modelo.entidades.Producto;
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

    public void create(Pedido pedido) {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();

            // Relación con Usuario
            Usuario usuario = pedido.getUsuario();
            if (usuario != null) {
                usuario = em.getReference(usuario.getClass(), usuario.getId());
                pedido.setUsuario(usuario);
            }

            // Relación con productos
            if (pedido.getProductos() != null) {
                for (Producto producto : pedido.getProductos()) {
                    producto.setPedido(pedido); // relación bidireccional
                    em.persist(producto);
                }
            }

            em.persist(pedido);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(Pedido pedido) throws NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();

            Pedido persistentPedido = em.find(Pedido.class, pedido.getId());
            Usuario usuarioOld = persistentPedido.getUsuario();
            Usuario usuarioNew = pedido.getUsuario();

            // Actualizar relación con Usuario
            if (usuarioNew != null) {
                usuarioNew = em.getReference(usuarioNew.getClass(), usuarioNew.getId());
                pedido.setUsuario(usuarioNew);
            }

            // Eliminar productos anteriores si ya no están
            List<Producto> oldProductos = persistentPedido.getProductos();
            List<Producto> newProductos = pedido.getProductos();
            for (Producto prod : oldProductos) {
                if (!newProductos.contains(prod)) {
                    em.remove(em.contains(prod) ? prod : em.merge(prod));
                }
            }

            // Agregar o actualizar productos nuevos
            for (Producto producto : newProductos) {
                producto.setPedido(pedido);
                em.merge(producto);
            }

            pedido = em.merge(pedido);
            em.getTransaction().commit();
        } catch (Exception ex) {
            Long id = pedido.getId();
            if (findPedido(id) == null) {
                throw new NonexistentEntityException("El pedido con ID " + id + " ya no existe.");
            }
            throw ex;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void destroy(Long id) throws NonexistentEntityException {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Pedido pedido;
            try {
                pedido = em.getReference(Pedido.class, id);
                pedido.getId();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("El pedido con ID " + id + " ya no existe.", enfe);
            }

            // Eliminar productos asociados
            for (Producto producto : pedido.getProductos()) {
                em.remove(em.contains(producto) ? producto : em.merge(producto));
            }

            // Eliminar relación con usuario
            Usuario usuario = pedido.getUsuario();
            if (usuario != null) {
                usuario = em.merge(usuario);
                usuario.getPedidos().remove(pedido); 
            }

            em.remove(pedido);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<Pedido> findPedidoEntities() {
        return findPedidoEntities(true, -1, -1);
    }

    public List<Pedido> findPedidoEntities(int maxResults, int firstResult) {
        return findPedidoEntities(false, maxResults, firstResult);
    }

    private List<Pedido> findPedidoEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
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

    public Pedido findPedido(Long id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Pedido.class, id);
        } finally {
            em.close();
        }
    }

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
}

