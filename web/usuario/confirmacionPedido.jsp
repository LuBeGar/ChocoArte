<%-- 
    Document   : confirmacionPedido
    Created on : 7 may 2025, 23:13:11
    Author     : Lu
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=ISO-8859-15" pageEncoding="ISO-8859-15" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Pedido Confirmado - ChocoArte</title>
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

        <div class="container my-5">
            <div class="row justify-content-center">
                <div class="col-md-8 text-center">
                    <div class="card shadow">
                        <div class="card-header bg-success text-white">
                            <h2><i class="fas fa-check-circle me-2"></i> Pedido Confirmado</h2>
                        </div>
                        <div class="card-body">
                            <div class="mb-4">
                                <i class="fas fa-box-open fa-5x text-success mb-3"></i>
                                <h3>¡Gracias por tu pedido!</h3>
                                <p class="lead">Tu pedido #${param.pedidoId} ha sido registrado correctamente</p>
                            </div>

                            <div class="alert alert-info">
                                <h5>Detalles del pedido</h5>
                                <p>Recibirás un correo electrónico cada vez que cambie el estado de tu pedido</p>
                                <p>Puedes ver los detalles de tu pedido en cualquier momento desde tu perfil</p>
                            </div>

                            <div class="d-grid gap-2 d-md-flex justify-content-md-center mt-4">
                                <a href="ControladorPrincipal" class="btn btn-primary me-md-2">
                                    <i class="fas fa-arrow-left me-1"></i> Volver a la tienda
                                </a>
                                <a href="ControladorGestionPedidos" class="btn btn-outline-success">
                                    <i class="fas fa-user me-1"></i> Ver mi perfil
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Footer -->
        <footer class="text-center text-lg-start">
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

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
