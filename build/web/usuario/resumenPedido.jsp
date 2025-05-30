<%-- 
    Document   : resumenPedido
    Created on : 8 may 2025, 14:52:24
    Author     : Lu
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html; charset=ISO-8859-15" pageEncoding="ISO-8859-15" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Resumen del Pedido - ChocoArte</title>
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

        <div class="row d-flex justify-content-center">
            <div class="col-md-9 col-lg-10 px-5 p-4">
                <h1 class="mb-4 custom-text-shadow" style="color:#8B4513">Resumen del Pedido</h1>
                <div class="row mt-4">
                    <!-- Resumen del pedido -->
                    <c:if test="${not empty pedido}">
                        <div class="alert alert-info p-4 rounded-3 shadow-sm mb-4" style="background-color: rgba(0, 0, 0, 0.05)">
                            <h5><i class="fas fa-shopping-cart me-2"></i> Número de pedido para el seguimiento: ${pedido.id}</h5>
                            <p><strong>Total:</strong> ${pedido.precio}¤</p>
                        </div>

                        <h3>Productos del Pedido:</h3>
                        <table class="table table-striped mt-3">
                            <thead>
                                <tr>
                                    <th>Forma</th>
                                    <th>Alérgenos</th>
                                    <th>Descripción</th>
                                    <th>Precio</th>
                                    <th>Acciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="productosPersonalizado" items="${pedido.productosPersonalizados}">
                                    <tr>
                                        <td>${productosPersonalizado.forma}</td>
                                        <td>${productosPersonalizado.alergenos}</td>
                                        <td>${productosPersonalizado.descripcion}</td>
                                        <td>${productosPersonalizado.precio}¤</td>
                                        <td>
                                            <form action="ControladorVerResumenPedido" method="GET" style="display:inline" onsubmit="return confirmarEliminacion(event)">
                                                <input type="hidden" name="productoPersonalizadoId" value="${productosPersonalizado.id}" />
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


                        <form id="formConfirmarPedido" action="ControladorConfirmarPedido" method="GET" class="mt-4" onsubmit="return confirmarPedido(event)">

                            <input type="hidden" name="pedidoId" value="${pedido.id}" />

                            <!-- Formulario de tarjeta -->
                            <div class="mt-5 p-4 rounded-3 shadow-sm" style="background-color: rgba(139, 69, 19, 0.05); border: 1px solid #deb887;">
                                <h4 class="mb-4"><i class="fas fa-credit-card me-2"></i>Datos de la Tarjeta</h4>

                                <div class="row g-3">
                                    <div class="col-md-6">
                                        <label for="nombreTitular" class="form-label">Nombre del titular</label>
                                        <input type="text" class="form-control" id="nombreTitular" name="nombreTitular" required
                                               oninput="validarNombreTitular()">
                                        <span id="errorNombreTitular" class="text-danger small"></span>
                                    </div>

                                    <div class="col-md-6">
                                        <label for="numeroTarjeta" class="form-label">Número de tarjeta</label>
                                        <input type="text" class="form-control" id="numeroTarjeta" name="numeroTarjeta" maxlength="19" placeholder="1234 5678 9012 3456" required
                                               oninput="formatearNumeroTarjeta(); validarNumeroTarjeta();">
                                        <span id="errorNumeroTarjeta" class="text-danger small"></span>
                                    </div>

                                    <div class="col-md-4">
                                        <label for="fechaExpiracion" class="form-label">Fecha de expiración</label>
                                        <input type="text" class="form-control" id="fechaExpiracion" name="fechaExpiracion" placeholder="MM/AA" maxlength="5" required
                                               oninput="formatearFechaExpiracion(); validarFechaExpiracion();">
                                        <span id="errorFechaExpiracion" class="text-danger small"></span>
                                    </div>

                                    <div class="col-md-4">
                                        <label for="cvv" class="form-label">CVV</label>
                                        <input type="text" class="form-control" id="cvv" name="cvv" maxlength="4" required
                                               oninput="validarCVV()" >
                                        <span id="errorCVV" class="text-danger small"></span>
                                    </div>

                                    <div class="col-md-4 d-flex align-items-end">
                                        <img src="img/tarjetas.png" alt="Tarjetas aceptadas" class="img-fluid" style="max-height: 38px;">
                                    </div>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label for="tipoEntrega" class="form-label"><strong>Tipo de entrega:</strong></label>
                                <select name="tipoEntrega" id="tipoEntrega" class="form-select" onchange="mostrarDireccion()" required>
                                    <option value="tienda">Recoger en tienda</option>
                                    <option value="domicilio" >Entrega a domicilio</option>
                                </select>
                            </div>

                            <div id="direccionContainer" class="mb-3" style="display: none;">
                                <label for="direccion" class="form-label"><strong>Dirección de entrega:</strong></label>
                                <input type="text" name="direccion" id="direccion" class="form-control" placeholder="Calle, número, ciudad..." />
                            </div>

                            <button type="submit" class="btn btn-gold btn-lg w-100 mt-3" 
                                    <c:if test="${empty pedido.productosPersonalizados}">
                                        disabled
                                    </c:if>
                                    >
                                <i class="fas fa-check me-2"></i> Confirmar Pedido
                            </button>
                        </form>

                        <form action="ControladorVerResumenPedido" method="GET" class="mt-2">
                            <input type="hidden" name="pedidoId" value="${pedido.id}" />
                        </form>

                    </c:if>

                    <c:if test="${empty pedido}">
                        <div class="alert alert-warning text-center">
                            No se encontró el pedido.
                        </div>
                    </c:if>
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger">${error}</div>
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

        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="js/verCampos.js"></script>
        <script src="js/alertas.js"></script>

    </body>

</html>
