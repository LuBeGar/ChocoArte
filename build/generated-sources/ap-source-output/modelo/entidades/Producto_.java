package modelo.entidades;

import javax.annotation.processing.Generated;
import javax.persistence.metamodel.ListAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;
import modelo.entidades.ProductoPersonalizado;

@Generated(value="org.eclipse.persistence.internal.jpa.modelgen.CanonicalModelProcessor", date="2025-05-29T00:13:43", comments="EclipseLink-2.7.12.v20230209-rNA")
@StaticMetamodel(Producto.class)
public class Producto_ { 

    public static volatile SingularAttribute<Producto, String> descripcion;
    public static volatile SingularAttribute<Producto, String> tipo;
    public static volatile SingularAttribute<Producto, Double> precio;
    public static volatile ListAttribute<Producto, ProductoPersonalizado> productosPersonalizados;
    public static volatile SingularAttribute<Producto, String> imagen;
    public static volatile SingularAttribute<Producto, Long> id;

}