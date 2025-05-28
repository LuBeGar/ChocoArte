<%-- 
    Document   : inicioUsuario
    Created on : 20 abr 2025, 18:33:24
    Author     : Lu
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page contentType="text/html; charset=ISO-8859-15" pageEncoding="ISO-8859-15" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Perfil de Usuario - ChocoArte</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="css/estilos.css" type="text/css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    </head>
    <body>
        <!-- Navbar -->
        <nav class="navbar navbar-light bg-white shadow-sm position-sticky" style="top: 0; z-index: 1050;">
            <div class="container d-flex justify-content-between align-items-center">

                <!-- Logo -->
                <a class="navbar-brand" href="index.html">
                    <img src="img/conejo.png" alt="ChocoArte" height="40">
                </a>

                <!-- Menú dependiendo del estado de sesión -->
                <c:choose>
                    <c:when test="${not empty sessionScope.usuario}">
                        <div class="dropdown">
                            <button class="btn btn-outline-secondary dropdown-toggle" type="button" id="userDropdown"
                                    data-bs-toggle="dropdown" aria-expanded="false">
                                Hola, ${sessionScope.usuario.nombre}
                            </button>
                            <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="userDropdown">
                                <c:choose>
                                    <c:when test="${sessionScope.usuario.tipo == 'admin'}">
                                        <li><a class="dropdown-item" href="ControladorUsuario"><i class="fas fa-box me-1"></i> Menú de administración</a></li>
                                        </c:when>
                                        <c:otherwise>
                                        <li><a class="dropdown-item" href="ControladorGestionPedidos"><i class="fas fa-user me-1"></i> Mi perfil</a></li>
                                            <c:if test="${not empty pedidoEnCurso}">
                                            <li><a class="dropdown-item" href="ControladorVerResumenPedido?pedidoId=${pedidoEnCurso.id}"><i class="fas fa-box me-1"></i> Mis pedidos</a></li>
                                            </c:if>
                                        </c:otherwise>
                                    </c:choose>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item text-danger" href="ControladorCerrarSesion"><i class="fas fa-sign-out-alt me-1"></i> Cerrar sesión</a></li>
                            </ul>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <!-- Botón hamburguesa -->
                        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                            <span class="navbar-toggler-icon"></span>
                        </button>

                        <!-- Contenedor colapsable con login y registro -->
                        <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
                            <div class="d-flex flex-column flex-lg-row">
                                <a href="ControladorLogin" class="btn btn-outline-primary mb-2 mb-lg-0 ms-lg-3">
                                    <i class="fas fa-sign-in-alt me-1"></i> Iniciar sesión
                                </a>
                                <a href="ControladorRegistro" class="btn btn-outline-success mb-2 mb-lg-0 ms-lg-3">
                                    <i class="fas fa-user-plus me-1"></i> Registrarse
                                </a>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </nav>

        <div class="container-fluid">
            <div class="row">
                <!-- Sidebar -->
                <div class="col-md-3 col-lg-2 p-4 panel">
                    <div class="position-sticky" style="top: 90px; z-index: 1040; ">
                        <h4 class="mb-4">Perfil de Usuario</h4>
                        <ul class="nav flex-column">
                            <li class="nav-item">
                                <a class="nav-link" href="#pedidos">Mis Pedidos</a>
                            </li>
                        </ul>
                    </div>
                </div>

                <!-- Main Content -->
                <div class="col-md-9 col-lg-10 px-5 p-4 table-responsive">
                    <h1 class="mb-4 custom-text-shadow" style="color:#8B4513">Bienvenido, ${sessionScope.usuario.nombre}</h1>

                    <!-- Pedidos -->
                    <h3 class="mt-5" id="pedidos">Mis Pedidos</h3>

                    <c:if test="${empty pedidos}">
                        <p>No tienes pedidos registrados aún.</p>
                    </c:if>

                    <c:if test="${not empty pedidos}">

                        <table class="table table-striped mt-3">
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th>Fecha</th>
                                    <th>Precio</th>
                                    <th>Estado</th>
                                    <th>Acciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="pedido" items="${pedidos}" varStatus="status">
                                    <tr>
                                        <td>${status.index + 1}</td>
                                        <td><fmt:formatDate value="${pedido.fecha}" pattern="dd/MM/yyyy"/></td>
                                        <td>${pedido.precio} ¤</td>
                                        <td>${pedido.estado}</td>
                                        <td>
                                            <button class="btn btn-info btn-sm" type="button" data-bs-toggle="collapse"
                                                    data-bs-target="#productos-${pedido.id}" aria-expanded="false" aria-controls="productos-${pedido.id}">
                                                <i class="fas fa-eye"></i> Ver
                                            </button>

                                            <c:if test="${pedido.estado == 'pendiente' || pedido.estado == 'en proceso' || pedido.estado == 'Confirmado'}">
                                                <form action="ControladorGestionPedidos" method="post" style="display:inline;">
                                                    <input type="hidden" name="id" value="${pedido.id}" />
                                                    <input type="hidden" name="accion" value="cancelar" />
                                                    <button type="button" class="btn btn-danger btn-sm" onclick="confirmarCancelacion(this.form)">
                                                        <i class="fas fa-times"></i> Cancelar
                                                    </button>
                                                </form>
                                            </c:if>
                                        </td>
                                    </tr>

                                    <!-- Tabla con productos -->
                                    <tr class="collapse" id="productos-${pedido.id}">
                                        <td colspan="5">
                                            <strong>Productos Personalizados:</strong>
                                            <c:if test="${not empty pedido.productosPersonalizados}">
                                                <table class="table table-bordered mt-2">
                                                    <thead class="table-light">
                                                        <tr>
                                                            <th>Tipo</th>
                                                            <th>Descripción</th>
                                                            <th>Precio</th>
                                                            <th>Alérgenos</th>
                                                            <th>Forma</th>
                                                            <th>Imagen</th>
                                                            <th>Acciones</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <c:forEach var="productoPersonalizado" items="${pedido.productosPersonalizados}">
                                                            <tr>
                                                                <td>${productoPersonalizado.producto.tipo}</td>
                                                                <td>${productoPersonalizado.descripcion}</td>
                                                                <td>${productoPersonalizado.precio} ¤</td>
                                                                <td>${productoPersonalizado.alergenos}</td>
                                                                <td>${productoPersonalizado.forma}</td>
                                                                <td>
                                                                    <c:choose>
                                                                        <c:when test="${not empty productoPersonalizado.imagen}">
                                                                            <img src="${pageContext.request.contextPath}/imagenes/${productoPersonalizado.imagen}" style="width:200px" />
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            No hay imagen
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </td>
                                                                <td>
                                                                    <c:if test="${pedido.estado == 'entregado'}">
                                                                        <form action="ControladorReview" method="get">
                                                                            <input type="hidden" name="idProductoPersonalizado" value="${productoPersonalizado.id}" />
                                                                            <button type="submit" class="btn btn-sm btn-warning">
                                                                                <i class="fas fa-pen"></i> Dejar review
                                                                            </button>
                                                                        </form>
                                                                    </c:if>
                                                                </td>
                                                            </tr>
                                                        </c:forEach>
                                                    </tbody>
                                                </table>
                                            </c:if>
                                            <c:if test="${empty pedido.productosPersonalizados}">
                                                <div class="text-muted">Este pedido no tiene productos personalizados</div>
                                            </c:if>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:if>

                    <c:if test="${not empty error}">
                        <div class="error">${error}</div>
                    </c:if>
                </div>
            </div>
        </div>

        <!-- Footer -->
        <footer class="text-center text-lg-start ">
            <section class="d-flex justify-content-center p-4 border-top">
                <div>
                    <a href="#" class="me-4 text-reset"><i class="fab fa-facebook-f"></i></a>
                    <a href="#" class="me-4 text-reset"><i class="fab fa-twitter"></i></a>
                    <a href="#" class="me-4 text-reset"><i class="fab fa-instagram"></i></a>
                    <a href="#" class="me-4 text-reset"><i class="fab fa-linkedin"></i></a>
                </div>
            </section>
            <div class="text-center p-4" style="background-color: rgba(0, 0, 0, 0.05);">
                © 2025 ChocoArte. Todos los derechos reservados.
            </div>
        </footer>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script src="js/alertas.js"></script>

    </body>
</html> 
