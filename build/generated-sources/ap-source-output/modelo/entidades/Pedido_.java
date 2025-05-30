package modelo.entidades;

import java.util.Date;
import javax.annotation.processing.Generated;
import javax.persistence.metamodel.ListAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;
import modelo.entidades.ProductoPersonalizado;
import modelo.entidades.Usuario;

@Generated(value="org.eclipse.persistence.internal.jpa.modelgen.CanonicalModelProcessor", date="2025-05-30T16:51:05", comments="EclipseLink-2.7.12.v20230209-rNA")
@StaticMetamodel(Pedido.class)
public class Pedido_ { 

    public static volatile SingularAttribute<Pedido, Date> fecha;
    public static volatile SingularAttribute<Pedido, String> estado;
    public static volatile SingularAttribute<Pedido, Double> precio;
    public static volatile SingularAttribute<Pedido, String> direccionEntrega;
    public static volatile ListAttribute<Pedido, ProductoPersonalizado> productosPersonalizados;
    public static volatile SingularAttribute<Pedido, String> entrega;
    public static volatile SingularAttribute<Pedido, Usuario> usuario;
    public static volatile SingularAttribute<Pedido, Long> id;

}