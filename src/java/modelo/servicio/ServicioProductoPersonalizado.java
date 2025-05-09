/*
 * Servicio ProductoPersonalizado
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
import modelo.entidades.ProductoPersonalizado;
import modelo.servicio.exceptions.NonexistentEntityException;

/**
 *
 * @author Lu
 */
public class ServicioProductoPersonalizado implements Serializable {

    private EntityManagerFactory emf;

    public ServicioProductoPersonalizado(EntityManagerFactory emf) {
        this.emf = emf;
    }

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(ProductoPersonalizado personalizado) {
        EntityManager em = getEntityManager();
        try {
            em.getTransaction().begin();

            // Referenciar producto si está presente
            if (personalizado.getProducto() != null) {
                Producto productoRef = em.getReference(Producto.class, personalizado.getProducto().getId());
                personalizado.setProducto(productoRef);
            }

            // Referenciar pedido si está presente
            if (personalizado.getPedido() != null) {
                Pedido pedidoRef = em.getReference(Pedido.class, personalizado.getPedido().getId());
                personalizado.setPedido(pedidoRef);
            }

            em.persist(personalizado);
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }

    public void edit(ProductoPersonalizado personalizado) throws NonexistentEntityException, Exception {
        EntityManager em = getEntityManager();
        try {
            em.getTransaction().begin();

            ProductoPersonalizado persistente = em.find(ProductoPersonalizado.class, personalizado.getId());

            // Relación con producto
            if (personalizado.getProducto() != null) {
                Producto productoRef = em.getReference(Producto.class, personalizado.getProducto().getId());
                personalizado.setProducto(productoRef);
            }

            // Relación con pedido
            if (personalizado.getPedido() != null) {
                Pedido pedidoRef = em.getReference(Pedido.class, personalizado.getPedido().getId());
                personalizado.setPedido(pedidoRef);
            }

            em.merge(personalizado);
            em.getTransaction().commit();
        } catch (Exception ex) {
            Long id = personalizado.getId();
            if (findProductoPersonalizado(id) == null) {
                throw new NonexistentEntityException("El producto personalizado con ID " + id + " ya no existe.");
            }
            throw ex;
        } finally {
            em.close();
        }
    }

    public void destroy(Long id) throws NonexistentEntityException {
        EntityManager em = getEntityManager();
        try {
            em.getTransaction().begin();
            ProductoPersonalizado personalizado;
            try {
                personalizado = em.getReference(ProductoPersonalizado.class, id);
                personalizado.getId();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("El producto personalizado con ID " + id + " ya no existe.", enfe);
            }

            em.remove(personalizado);
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }

    public List<ProductoPersonalizado> findProductoPersonalizadoEntities() {
        return findProductoPersonalizadoEntities(true, -1, -1);
    }

    public List<ProductoPersonalizado> findProductoPersonalizadoEntities(int maxResults, int firstResult) {
        return findProductoPersonalizadoEntities(false, maxResults, firstResult);
    }

    private List<ProductoPersonalizado> findProductoPersonalizadoEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery<ProductoPersonalizado> cq = em.getCriteriaBuilder().createQuery(ProductoPersonalizado.class);
            cq.select(cq.from(ProductoPersonalizado.class));
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

    public ProductoPersonalizado findProductoPersonalizado(Long id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(ProductoPersonalizado.class, id);
        } finally {
            em.close();
        }
    }

    public int getProductoPersonalizadoCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery<Long> cq = em.getCriteriaBuilder().createQuery(Long.class);
            Root<ProductoPersonalizado> rt = cq.from(ProductoPersonalizado.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
}
