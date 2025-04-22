/*
 * ServicioUsuario
 */
package modelo.servicio;

import java.io.Serializable;
import javax.persistence.Query;
import javax.persistence.EntityNotFoundException;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import modelo.entidades.Pedido;
import modelo.entidades.Review;
import modelo.entidades.Usuario;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import modelo.servicio.exceptions.NonexistentEntityException;
/**
 *
 * @author Lu
 */

public class ServicioUsuario implements Serializable {

    public ServicioUsuario(EntityManagerFactory emf) {
        this.emf = emf;
    }

    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(Usuario usuario) {
        if (usuario.getPedidos() == null) {
            usuario.setPedidos(new ArrayList<>());
        }
        if (usuario.getReview() == null) {
            usuario.setReview(new ArrayList<>());
        }

        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();

            List<Pedido> attachedPedidos = new ArrayList<>();
            for (Pedido pedido : usuario.getPedidos()) {
                pedido = em.getReference(pedido.getClass(), pedido.getId());
                attachedPedidos.add(pedido);
            }
            usuario.setPedidos(attachedPedidos);

            List<Review> attachedReviews = new ArrayList<>();
            for (Review review : usuario.getReview()) {
                review = em.getReference(review.getClass(), review.getId());
                attachedReviews.add(review);
            }
            usuario.setReview(attachedReviews);

            em.persist(usuario);

            for (Pedido pedido : usuario.getPedidos()) {
                Usuario oldUsuario = pedido.getUsuario();
                pedido.setUsuario(usuario);
                pedido = em.merge(pedido);
                if (oldUsuario != null) {
                    oldUsuario.getPedidos().remove(pedido);
                    em.merge(oldUsuario);
                }
            }

            for (Review review : usuario.getReview()) {
                Usuario oldUsuario = review.getUsuario();
                review.setUsuario(usuario);
                review = em.merge(review);
                if (oldUsuario != null) {
                    oldUsuario.getReview().remove(review);
                    em.merge(oldUsuario);
                }
            }

            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(Usuario usuario) throws NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();

            Usuario persistentUsuario = em.find(Usuario.class, usuario.getId());
            List<Pedido> pedidosOld = persistentUsuario.getPedidos();
            List<Pedido> pedidosNew = usuario.getPedidos();
            List<Review> reviewsOld = persistentUsuario.getReview();
            List<Review> reviewsNew = usuario.getReview();

            List<Pedido> attachedPedidosNew = new ArrayList<>();
            for (Pedido pedido : pedidosNew) {
                pedido = em.getReference(pedido.getClass(), pedido.getId());
                attachedPedidosNew.add(pedido);
            }
            pedidosNew = attachedPedidosNew;
            usuario.setPedidos(pedidosNew);

            List<Review> attachedReviewsNew = new ArrayList<>();
            for (Review review : reviewsNew) {
                review = em.getReference(review.getClass(), review.getId());
                attachedReviewsNew.add(review);
            }
            reviewsNew = attachedReviewsNew;
            usuario.setReview(reviewsNew);

            usuario = em.merge(usuario);

            for (Pedido pedido : pedidosOld) {
                if (!pedidosNew.contains(pedido)) {
                    pedido.setUsuario(null);
                    em.merge(pedido);
                }
            }

            for (Pedido pedido : pedidosNew) {
                if (!pedidosOld.contains(pedido)) {
                    Usuario oldUsuario = pedido.getUsuario();
                    pedido.setUsuario(usuario);
                    pedido = em.merge(pedido);
                    if (oldUsuario != null && !oldUsuario.equals(usuario)) {
                        oldUsuario.getPedidos().remove(pedido);
                        em.merge(oldUsuario);
                    }
                }
            }

            for (Review review : reviewsOld) {
                if (!reviewsNew.contains(review)) {
                    review.setUsuario(null);
                    em.merge(review);
                }
            }

            for (Review review : reviewsNew) {
                if (!reviewsOld.contains(review)) {
                    Usuario oldUsuario = review.getUsuario();
                    review.setUsuario(usuario);
                    review = em.merge(review);
                    if (oldUsuario != null && !oldUsuario.equals(usuario)) {
                        oldUsuario.getReview().remove(review);
                        em.merge(oldUsuario);
                    }
                }
            }

            em.getTransaction().commit();
        } catch (Exception ex) {
            Long id = usuario.getId();
            if (findUsuario(id) == null) {
                throw new NonexistentEntityException("El usuario con ID " + id + " no existe.", ex);
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

            Usuario usuario;
            try {
                usuario = em.getReference(Usuario.class, id);
                usuario.getId();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("El usuario con ID " + id + " no existe.", enfe);
            }

            for (Pedido pedido : usuario.getPedidos()) {
                pedido.setUsuario(null);
                em.merge(pedido);
            }

            for (Review review : usuario.getReview()) {
                review.setUsuario(null);
                em.merge(review);
            }

            em.remove(usuario);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<Usuario> findUsuarioEntities() {
        return findUsuarioEntities(true, -1, -1);
    }

    public List<Usuario> findUsuarioEntities(int maxResults, int firstResult) {
        return findUsuarioEntities(false, maxResults, firstResult);
    }

    private List<Usuario> findUsuarioEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery<Usuario> cq = em.getCriteriaBuilder().createQuery(Usuario.class);
            cq.select(cq.from(Usuario.class));
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

    public Usuario findUsuario(Long id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Usuario.class, id);
        } finally {
            em.close();
        }
    }

    public int getUsuarioCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery<Long> cq = em.getCriteriaBuilder().createQuery(Long.class);
            Root<Usuario> rt = cq.from(Usuario.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }

    public Usuario validarUsuario(String email, String password) {
        List<Usuario> usuarios = findUsuarioEntities();
        for (Usuario u : usuarios) {
            if (u.getEmail().equals(email) && u.getPassword().equals(password)) {
                return u;
            }
        }
        return null;
    }
}
