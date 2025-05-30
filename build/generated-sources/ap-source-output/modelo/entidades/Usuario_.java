package modelo.entidades;

import java.util.Date;
import javax.annotation.processing.Generated;
import javax.persistence.metamodel.ListAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;
import modelo.entidades.Pedido;
import modelo.entidades.Review;

@Generated(value="org.eclipse.persistence.internal.jpa.modelgen.CanonicalModelProcessor", date="2025-05-30T16:51:05", comments="EclipseLink-2.7.12.v20230209-rNA")
@StaticMetamodel(Usuario.class)
public class Usuario_ { 

    public static volatile SingularAttribute<Usuario, String> tipo;
    public static volatile SingularAttribute<Usuario, Date> fechaNacimiento;
    public static volatile SingularAttribute<Usuario, String> direccion;
    public static volatile ListAttribute<Usuario, Pedido> pedidos;
    public static volatile SingularAttribute<Usuario, String> nombre;
    public static volatile SingularAttribute<Usuario, String> password;
    public static volatile ListAttribute<Usuario, Review> review;
    public static volatile SingularAttribute<Usuario, String> genero;
    public static volatile SingularAttribute<Usuario, String> saborFavorito;
    public static volatile SingularAttribute<Usuario, Long> id;
    public static volatile SingularAttribute<Usuario, String> telefono;
    public static volatile SingularAttribute<Usuario, String> comentarios;
    public static volatile SingularAttribute<Usuario, String> email;

}