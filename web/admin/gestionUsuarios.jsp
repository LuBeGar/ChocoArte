<%-- 
    Document   : gestionUsuarios
    Created on : 6 may 2025, 12:07:00
    Author     : Lu
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page contentType="text/html; charset=ISO-8859-15" pageEncoding="ISO-8859-15" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Usuarios - Admin ChocoArte</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="css/estilos.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    </head>
    <body>
        <!-- Navbar -->
        <nav class="navbar navbar-light bg-white shadow-sm position-sticky" style="top: 0; z-index: 1050;">
            <div class="container d-flex justify-content-between align-items-center">
                <!-- Logo -->
                <a class="navbar-brand" href="index.html">
                    <img src="img/conejo.png" alt="ChocoArte" height="40">
                </a>

                <!-- Menú usuario alineado a la derecha en la misma línea -->
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
                                        <li><a class="dropdown-item" href="ControladorUsuario"><i class="fas fa-box me-1"></i>Menú de administración</a></li>
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
                        <div class="d-flex gap-2">
                            <a href="ControladorLogin" class="btn btn-outline-primary"><i class="fas fa-sign-in-alt me-1"></i> Iniciar sesión</a>
                            <a href="ControladorRegistro" class="btn btn-outline-success"><i class="fas fa-user-plus me-1"></i> Registrarse</a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </nav>

        <div class="row">
            <!-- Sidebar -->
            <div class="col-md-3 col-lg-2 p-4 panel">
                <div class="position-sticky" style="top: 90px; z-index: 1040;">
                    <h4 class="mb-4">Panel de Administración</h4>
                    <ul class="nav flex-column">
                        <li class="nav-item"><a class="nav-link" href="ControladorUsuario" style="color:#b68d40">Gestión de Usuarios</a></li>
                        <li class="nav-item"><a class="nav-link" href="ControladorProducto">Gestión de Productos</a></li>
                        <li class="nav-item"><a class="nav-link" href="ControladorPedido">Gestión de Pedidos</a></li>
                        <li class="nav-item"><a class="nav-link" href="ControladorVentas">Estadísticas de ventas</a></li>
                    </ul>
                </div>
            </div>

            <!-- Main -->
            <div class="col-md-9 col-lg-10 px-5 p-4">
                <h1 class="mb-4 custom-text-shadow" style="color:#8B4513">Panel de Administración</h1>
                <div class="row mt-4">
                    <div class="col-md-4 mb-3">
                        <div class="card shadow-sm">
                            <div class="card-body">
                                <h5 class="card-title">Total Usuarios</h5>
                                <p class="card-text">${fn:length(usuarios)} usuarios</p>
                                <a href="ControladorProducto" class="btn btn-gold">Ver Productos</a>
                                <a href="ControladorPedido" class="btn btn-gold">Ver Pedidos</a>
                            </div>
                        </div>
                    </div>
                </div>

                <h3 class="mt-4">Lista de Usuarios</h3>
                <div class="d-flex justify-content-between mb-3">
                    <a href="ControladorRegistro" class="btn btn-gold">Crear Usuario Nuevo</a>
                </div>
                <c:if test="${not empty error}">
                    <div class="alert alert-danger">${error}</div>
                </c:if>
                <div class="table-responsive">
                    <table class="table table-striped mt-3">
                        <thead>
                            <tr>
                                <th>Nombre</th>
                                <th>Email</th>
                                <th>Dirección</th>
                                <th>Teléfono</th>
                                <th>Fecha Nacimiento</th>
                                <th>Género</th>
                                <th>Sabor Favorito</th>
                                <th>Tipo</th>
                                <th>Comentarios</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="usuario" items="${usuarios}">
                                <tr>
                                    <td>${usuario.nombre}</td>
                                    <td>${usuario.email}</td>
                                    <td>${usuario.direccion}</td>
                                    <td>${usuario.telefono}</td>
                                    <td><fmt:formatDate value="${usuario.fechaNacimiento}" pattern="dd-MM-yyyy"/></td>
                                    <td>${usuario.genero}</td>
                                    <td>${usuario.saborFavorito}</td>
                                    <td>${usuario.tipo}</td>
                                    <td>${usuario.comentarios}</td>
                                    <td>
                                        <a href="ControladorUsuario?id=${usuario.id}&editar=true" class="btn btn-warning btn-sm"><i class="fas fa-edit"></i> Editar</a>
                                        <button type="button" class="btn btn-danger btn-sm" onclick="confirmarEliminacionUsuario(${usuario.id})">
                                            <i class="fas fa-trash-alt"></i> Eliminar
                                        </button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>

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
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
            <script src="js/alertas.js"></script>

    </body>
</html>
