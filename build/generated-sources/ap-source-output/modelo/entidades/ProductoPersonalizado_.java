package modelo.entidades;

import javax.annotation.processing.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;
import modelo.entidades.Pedido;
import modelo.entidades.Producto;
import modelo.entidades.Review;

@Generated(value="org.eclipse.persistence.internal.jpa.modelgen.CanonicalModelProcessor", date="2025-05-29T00:13:43", comments="EclipseLink-2.7.12.v20230209-rNA")
@StaticMetamodel(ProductoPersonalizado.class)
public class ProductoPersonalizado_ { 

    public static volatile SingularAttribute<ProductoPersonalizado, String> descripcion;
    public static volatile SingularAttribute<ProductoPersonalizado, Double> precio;
    public static volatile SingularAttribute<ProductoPersonalizado, Review> review;
    public static volatile SingularAttribute<ProductoPersonalizado, Pedido> pedido;
    public static volatile SingularAttribute<ProductoPersonalizado, String> alergenos;
    public static volatile SingularAttribute<ProductoPersonalizado, String> imagen;
    public static volatile SingularAttribute<ProductoPersonalizado, Long> id;
    public static volatile SingularAttribute<ProductoPersonalizado, Producto> producto;
    public static volatile SingularAttribute<ProductoPersonalizado, String> forma;

}