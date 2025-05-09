/*
 * ServicioProducto
 */
package modelo.servicio;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.*;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import modelo.entidades.Producto;
import modelo.entidades.ProductoPersonalizado;
import modelo.servicio.exceptions.NonexistentEntityException;

/**
 *
 * @author Lu
 */
public class ServicioProducto implements Serializable {

    private EntityManagerFactory emf;

    public ServicioProducto(EntityManagerFactory emf) {
        this.emf = emf;
    }

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(Producto producto) {
        if (producto.getProductosPersonalizados() == null) {
            producto.setProductosPersonalizados(new ArrayList<>());
        }

        EntityManager em = getEntityManager();
        try {
            em.getTransaction().begin();

            // Establecer relación inversa
            for (ProductoPersonalizado personalizado : producto.getProductosPersonalizados()) {
                personalizado.setProducto(producto);
            }

            em.persist(producto);
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }

    public void edit(Producto producto) throws NonexistentEntityException, Exception {
        EntityManager em = getEntityManager();
        try {
            em.getTransaction().begin();

            Producto productoPersistente = em.find(Producto.class, producto.getId());

            // Obtener productos personalizados actuales y nuevos
            List<ProductoPersonalizado> productosAntiguos = productoPersistente.getProductosPersonalizados();
            List<ProductoPersonalizado> productosNuevos = producto.getProductosPersonalizados();

            // Eliminar referencias que ya no existen
            for (ProductoPersonalizado antiguo : productosAntiguos) {
                if (!productosNuevos.contains(antiguo)) {
                    antiguo.setProducto(null);
                    em.merge(antiguo);
                }
            }

            // Establecer la relación con el producto actualizado
            for (ProductoPersonalizado nuevo : productosNuevos) {
                nuevo.setProducto(producto);
            }

            producto = em.merge(producto);
            em.getTransaction().commit();
        } catch (Exception ex) {
            Long id = producto.getId();
            if (findProducto(id) == null) {
                throw new NonexistentEntityException("El producto con ID " + id + " ya no existe.");
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
            Producto producto;

            try {
                producto = em.getReference(Producto.class, id);
                producto.getId();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("El producto con ID " + id + " ya no existe.", enfe);
            }

            // Romper relación con personalizados sin eliminarlos
            List<ProductoPersonalizado> personalizados = producto.getProductosPersonalizados();
            for (ProductoPersonalizado personalizado : personalizados) {
                personalizado.setProducto(null);
                em.merge(personalizado);
            }

            em.remove(producto);
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }

    public List<Producto> findProductoEntities() {
        return findProductoEntities(true, -1, -1);
    }

    public List<Producto> findProductoEntities(int maxResults, int firstResult) {
        return findProductoEntities(false, maxResults, firstResult);
    }

    private List<Producto> findProductoEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery<Producto> cq = em.getCriteriaBuilder().createQuery(Producto.class);
            cq.select(cq.from(Producto.class));
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

    public Producto findProducto(Long id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Producto.class, id);
        } finally {
            em.close();
        }
    }

    public int getProductoCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery<Long> cq = em.getCriteriaBuilder().createQuery(Long.class);
            Root<Producto> rt = cq.from(Producto.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
}
