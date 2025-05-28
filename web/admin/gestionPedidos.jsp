<%-- 
    Document   : gestionPedidos
    Created on : 6 may 2025, 12:07:33
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
        <title>Pedidos - Admin ChocoArte</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="css/estilos.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    </head>
    <body>
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
                        <li class="nav-item"><a class="nav-link" href="ControladorProducto">Gestión de Productos</a></li>
                        <li class="nav-item"><a class="nav-link" href="ControladorUsuario">Gestión de Usuarios</a></li>
                        <li class="nav-item"><a class="nav-link" href="ControladorPedido">Gestión de Pedidos</a></li>
                        <li class="nav-item"><a class="nav-link" href="ControladorVentas">Estadísticas de ventas</a></li>
                    </ul>
                </div>
            </div>

            <!-- Main -->
            <div class="col-md-9 col-lg-10 px-5 p-4">
                <h1 class="mb-4 custom-text-shadow" style="color:#8B4513">Gestión de Pedidos</h1>

                <!-- Tarjeta resumen -->
                <div class="row mt-4">
                    <div class="col-md-4 mb-3">
                        <div class="card shadow-sm">
                            <div class="card-body">
                                <h5 class="card-title">Total Pedidos</h5>
                                <p class="card-text">${fn:length(pedidos)} pedidos</p>
                                <a href="ControladorUsuario" class="btn btn-gold">Ver Usuarios</a>
                                <a href="ControladorProducto" class="btn btn-gold">Ver Productos</a>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Tabla de pedidos -->
                <h3 class="mt-4">Lista de Pedidos</h3>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger">${error}</div>
                </c:if>
                <div class="table-responsive">
                    <table class="table table-striped mt-3">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Fecha</th>
                                <th>Estado</th>
                                <th>Precio</th>
                                <th>Entrega</th>
                                <th>Dirección</th>
                                <th>Usuario</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="pedido" items="${pedidos}">
                                <tr>
                                    <td>${pedido.id}</td>
                                    <td><fmt:formatDate value="${pedido.fecha}" pattern="dd-MM-yyyy"/></td>
                                    <td>
                                        <form action="ControladorPedido" method="post" class="d-flex align-items-center">
                                            <input type="hidden" name="id" value="${pedido.id}" />
                                            <input type="hidden" name="actualizar" value="estado" />
                                            <select name="estado" class="form-select form-select-sm me-1">
                                                <option ${pedido.estado == 'pendiente' ? 'selected' : ''}>pendiente</option>
                                                <option ${pedido.estado == 'en proceso' ? 'selected' : ''}>en proceso</option>
                                                <option ${pedido.estado == 'para recoger' ? 'selected' : ''}>para recoger</option>
                                                <option ${pedido.estado == 'enviado' ? 'selected' : ''}>enviado</option>
                                                <option ${pedido.estado == 'entregado' ? 'selected' : ''}>entregado</option>
                                                <option ${pedido.estado == 'cancelado' ? 'selected' : ''}>cancelado</option>
                                            </select>
                                            <button type="submit" class="btn btn-sm btn-success">
                                                <i class="fas fa-save"></i>
                                            </button>
                                        </form>
                                    </td>
                                    <td>${pedido.precio} ¤</td>
                                    <td>${pedido.entrega}</td>
                                    <td>${pedido.direccionEntrega}</td>
                                    <td>${pedido.usuario.nombre}</td>
                                    <td>
                                        <button class="btn btn-info btn-sm" type="button" data-bs-toggle="collapse" data-bs-target="#productos-${pedido.id}" aria-expanded="false" aria-controls="productos-${pedido.id}">
                                            <i class="fas fa-eye"></i> Ver
                                        </button>
                                        <button type="button" class="btn btn-danger btn-sm" onclick="confirmarEliminacionPedido(${pedido.id})">
                                            <i class="fas fa-trash-alt"></i> Eliminar
                                        </button>

                                    </td>
                                </tr>

                                <!-- Subtabla colapsable -->
                                <tr class="collapse" id="productos-${pedido.id}">
                                    <td colspan="7">
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
                                                        </tr>
                                                    </c:forEach>
                                                </tbody>
                                            </table>
                                        </c:if>
                                        <c:if test="${empty pedido.productosPersonalizados}">
                                            <div class="text-muted">Este pedido no tiene productos personalizados.</div>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
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
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script src="js/alertas.js"></script>

    </body>
</html>
