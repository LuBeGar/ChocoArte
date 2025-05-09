<%-- 
    Document   : resumenPedido
    Created on : 8 may 2025, 14:52:24
    Author     : Lu
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Resumen del Pedido - ChocoArte</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="css/estilos.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
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

        <div class="row d-flex justify-content-center">
            <div class="col-md-9 col-lg-10 px-5 p-4">
                <h1 class="mb-4 custom-text-shadow" style="color:#8B4513">Resumen del Pedido</h1>
                <div class="row mt-4">
                    <!-- Resumen del pedido -->
                    <c:if test="${not empty pedido}">
                        <div class="alert alert-info p-4 rounded-3 shadow-sm mb-4" style="background-color: rgba(0, 0, 0, 0.05)">
                            <h5><i class="fas fa-shopping-cart me-2"></i> Número de pedido:</h5>
                            <p>${pedido.id}</p>
                            <p><strong>Total:</strong> ${pedido.precio}€</p>
                        </div>

                        <h3>Productos del Pedido:</h3>
                        <table class="table table-striped mt-3">
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th>Forma</th>
                                    <th>Alérgenos</th>
                                    <th>Descripción</th>
                                    <th>Precio</th>
                                    <th>Acciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="pp" items="${pedido.productosPersonalizados}">
                                    <tr>
                                        <td>${pp.id}</td>
                                        <td>${pp.forma}</td>
                                        <td>${pp.alergenos}</td>
                                        <td>${pp.descripcion}</td>
                                        <td>${pp.precio}€</td>
                                        <td>
                                            <form action="EliminarProductoPersonalizado" method="POST" style="display:inline">
                                                <input type="hidden" name="productoId" value="${pp.id}" />
                                                <input type="hidden" name="pedidoId" value="${pedido.id}" />
                                                <button type="submit" class="btn btn-danger btn-sm">
                                                    <i class="fas fa-trash-alt"></i> Eliminar
                                                </button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>

                        <form action="ControladorConfirmarPedido" method="GET" class="mt-4">
                            <input type="hidden" name="pedidoId" value="${pedido.id}" />

                            <div class="mb-3">
                                <label for="tipoEntrega" class="form-label"><strong>Tipo de entrega:</strong></label>
                                <select name="tipoEntrega" id="tipoEntrega" class="form-select" onchange="mostrarDireccion()" required>
                                    <option value="tienda">Recoger en tienda</option>
                                    <option value="domicilio">Entrega a domicilio</option>
                                </select>
                            </div>

                            <div id="direccionContainer" class="mb-3" style="display: none;">
                                <label for="direccion" class="form-label"><strong>Dirección de entrega:</strong></label>
                                <input type="text" name="direccion" id="direccion" class="form-control" placeholder="Calle, número, ciudad..." />
                            </div>

                            <button type="submit" class="btn btn-gold btn-lg w-100 mt-3">
                                <i class="fas fa-check me-2"></i> Confirmar Pedido
                            </button>
                        </form>

                    </c:if>

                    <c:if test="${empty pedido}">
                        <div class="alert alert-warning text-center">
                            No se encontró el pedido.
                        </div>
                    </c:if>
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

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="js/verCampos.js"></script>
    </body>

</html>
