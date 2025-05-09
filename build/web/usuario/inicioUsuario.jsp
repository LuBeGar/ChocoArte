<%-- 
    Document   : inicioUsuario
    Created on : 20 abr 2025, 18:33:24
    Author     : Lu
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Perfil de Usuario - ChocoArte</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="css/estilos.css" type="text/css">
        <!-- Font Awesome para iconos -->
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

        <div class="container-fluid">
            <div class="row">
                <!-- Sidebar -->
                <div class="col-md-3 col-lg-2 p-4 panel">
                    <div class="position-sticky" style="top: 90px; z-index: 1040;">
                        <h4 class="mb-4">Perfil de Usuario</h4>
                        <ul class="nav flex-column">
                            <li class="nav-item">
                                <a class="nav-link active" href="#">Mi Perfil</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#pedidos">Mis Pedidos</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#puntos">Mis Puntos</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#reseñas">Mis Reseñas</a>
                            </li>
                        </ul>
                    </div>
                </div>

                <!-- Main Content -->
                <div class="col-md-9 col-lg-10 px-5 p-4">
                    <h1 class="mb-4 custom-text-shadow" style="color:#8B4513">Bienvenido, ${sessionScope.usuario.nombre}</h1>

                    <!-- Puntos -->
                    <h3 class="mt-5" id="puntos">Mis Puntos</h3>
                    <p>Has acumulado un total de ${sessionScope.usuario.puntos}  puntos. ¡Sigue comprando para obtener más beneficios!</p>

                    <!-- Pedidos -->
                    <h3 class="mt-5" id="pedidos">Mis Pedidos</h3>
                    <table class="table table-striped mt-3">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Producto</th>
                                <th>Precio</th>
                                <th>Estado</th>
                                <th>Fecha</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>1</td>
                                <td>Tarta grande</td>
                                <td>400 €</td>
                                <td>Enviado</td>
                                <td>15/03/2025</td>
                                <td><button class="btn btn-warning btn-sm"><i class="fas fa-edit"></i> Dejar reseña</button></td>
                            </tr>
                            <tr>
                                <td>2</td>
                                <td>Tarta pequeña</td>
                                <td>250 €</td>
                                <td>En proceso</td>
                                <td>17/03/2025</td>
                                <td><button class="btn btn-warning btn-sm"><i class="fas fa-edit"></i> Dejar reseña</button></td>
                            </tr>
                        </tbody>
                    </table>

                    <!-- Reseñas -->
                    <h3 class="mt-5" id="reseñas">Mis Reseñas</h3>
                    <table class="table table-striped mt-3">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Producto</th>
                                <th>Comentario</th>
                                <th>Valoración</th>
                                <th>Fecha</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>1</td>
                                <td>Tarta grande</td>
                                <td>Muy deliciosa, excelente presentación.</td>
                                <td>5/5</td>
                                <td>18/03/2025</td>
                                <td><button class="btn btn-info btn-sm"><i class="fas fa-eye"></i> Ver</button></td>
                            </tr>
                            <tr>
                                <td>2</td>
                                <td>Tarta pequeña</td>
                                <td>Sabrosa, pero me gustaría que fuera más grande.</td>
                                <td>4/5</td>
                                <td>20/03/2025</td>
                                <td><button class="btn btn-info btn-sm"><i class="fas fa-eye"></i> Ver</button></td>
                            </tr>
                        </tbody>
                    </table>
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
    </body>
</html> 
