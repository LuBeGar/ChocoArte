package modelo.entidades;

import java.util.Date;
import javax.annotation.processing.Generated;
import javax.persistence.metamodel.ListAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;
import modelo.entidades.ProductoPersonalizado;
import modelo.entidades.Usuario;

@Generated(value="org.eclipse.persistence.internal.jpa.modelgen.CanonicalModelProcessor", date="2025-05-30T16:51:05", comments="EclipseLink-2.7.12.v20230209-rNA")
@StaticMetamodel(Review.class)
public class Review_ { 

    public static volatile SingularAttribute<Review, Date> fecha;
    public static volatile ListAttribute<Review, String> imagenes;
    public static volatile SingularAttribute<Review, ProductoPersonalizado> productoPersonalizado;
    public static volatile SingularAttribute<Review, Integer> valoracion;
    public static volatile SingularAttribute<Review, Usuario> usuario;
    public static volatile SingularAttribute<Review, Long> id;
    public static volatile SingularAttribute<Review, String> comentario;

}