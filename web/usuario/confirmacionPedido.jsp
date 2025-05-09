<%-- 
    Document   : confirmacionPedido
    Created on : 7 may 2025, 23:13:11
    Author     : Lu
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Pedido Confirmado - ChocoArte</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="css/estilos.css" type="text/css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    </head>
    <body>
        <!-- Navbar -->
        <nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm position-sticky" style="top: 0; z-index: 1050;">
            <div class="container">
                <!-- Logo como enlace directo -->
                <a class="navbar-brand" href="index.html">
                    <img src="img/conejo.png" alt="ChocoArte" height="40">
                </a>

                <!-- Botón hamburguesa -->
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                        aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <!-- Contenido colapsable -->
                <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
                    <!-- Formulario de búsqueda -->
                    <form class="d-flex mb-3 mb-lg-0 me-lg-3">
                        <input class="form-control me-2" type="search" placeholder="Buscar" aria-label="Buscar">
                        <button class="btn btn-outline-secondary" type="submit"><i class="fas fa-search"></i></button>
                    </form>

                    <!-- Menú según estado del usuario -->
                    <c:choose>
                        <c:when test="${not empty sessionScope.usuario}">
                            <!-- Usuario logueado -->
                            <div class="dropdown mb-2 mb-lg-0">
                                <button class="btn btn-outline-secondary dropdown-toggle" type="button" id="userDropdown"
                                        data-bs-toggle="dropdown" aria-expanded="false">
                                    Hola, ${sessionScope.usuario.nombre}
                                </button>
                                <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="userDropdown">
                                    <c:choose>
                                        <c:when test="${sessionScope.usuario.tipo == 'admin'}">
                                            <li><a class="dropdown-item" href="ControladorUsuario"><i class="fas fa-cogs me-1"></i> Administración</a></li>
                                            <li><a class="dropdown-item" href="ControladorPedidosAdmin"><i class="fas fa-list me-1"></i> Todos los pedidos</a></li>
                                            </c:when>
                                            <c:otherwise>
                                            <li><a class="dropdown-item" href="ControladorInicio"><i class="fas fa-user me-1"></i> Mi perfil</a></li>
                                            <li><a class="dropdown-item" href="ControladorMisPedidos"><i class="fas fa-box me-1"></i> Mis pedidos</a></li>
                                            </c:otherwise>
                                        </c:choose>
                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item text-danger" href="ControladorCerrarSesion"><i class="fas fa-sign-out-alt me-1"></i> Cerrar sesión</a></li>
                                </ul>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <!-- Usuario no logueado -->
                            <div class="d-flex flex-column flex-lg-row">
                                <a href="ControladorLogin" class="btn btn-outline-primary mb-2 mb-lg-0 me-lg-2"><i class="fas fa-sign-in-alt me-1"></i> Iniciar sesión</a>
                                <a href="ControladorRegistro" class="btn btn-outline-success mb-2 mb-lg-0"><i class="fas fa-user-plus me-1"></i> Registrarse</a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
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
                                <p class="lead">Tu pedido #${param.pedidoId} ha sido registrado correctamente.</p>
                            </div>

                            <div class="alert alert-info">
                                <h5>Detalles del pedido</h5>
                                <p>Recibirás un correo electrónico con los detalles de tu pedido.</p>
                                <p>Puedes ver el estado de tu pedido en cualquier momento desde tu perfil.</p>
                            </div>

                            <div class="d-grid gap-2 d-md-flex justify-content-md-center mt-4">
                                <a href="ControladorPrincipal" class="btn btn-primary me-md-2">
                                    <i class="fas fa-arrow-left me-1"></i> Volver a la tienda
                                </a>
                                <a href="ControladorInicio" class="btn btn-outline-success">
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
