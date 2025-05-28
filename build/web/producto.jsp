<%-- 
    Document   : producto
    Created on : 20 abr 2025, 18:38:24
    Author     : Lu
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=ISO-8859-15" pageEncoding="ISO-8859-15" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Detalles del producto - ChocoArte</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="css/estilos.css" type="text/css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    </head>

    <body>
        <!-- Navbar -->
        <nav class="navbar navbar-light bg-white shadow-sm position-sticky navbar-expand-lg" style="top: 0; z-index: 1050;">
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

        <!-- Main Content -->
        <div class="container my-5 flex-grow-1">
            <div class="row pt-5 rounded-3 shadow-sm" style="background-color: rgba(0, 0, 0, 0.05)">
                <div class="col-md-5 text-center">
                    <img src="${pageContext.request.contextPath}/imagenes/${producto.imagen}" class="product-image">
                </div>
                <div class="col-md-6">
                    <h2 class="text-center mb-4 custom-text-shadow" style="color:#8B4513">${producto.tipo}</h2>
                    <div class="p-4 mx-4 rounded bg-light">
                        <p><strong>Descripción:</strong> ${producto.descripcion}</p>
                        <p><strong>Precio:</strong> ${producto.precio} ¤</p>
                    </div>
                    <a href="ControladorProductoPersonalizado?idProducto=${producto.id}&tipo=${producto.tipo}" class="btn btn-gold btn-lg m-4">Hacer Pedido</a>
                    <a href="index.html" class="btn btn-secondary btn-lg m-4 btn-back">Volver al listado</a>
                </div>
            </div>

            <!-- Comentarios de los Clientes -->
            <div class="container my-5">
                <div class="comments-section p-4 rounded-3 shadow-sm" style="background-color: rgba(0, 0, 0, 0.05)">
                    <h4 class="text-center mb-4 custom-text-shadow" style="color:#8B4513">Comentarios de Clientes</h4>
                    <div class="list-group">
                        <c:choose>
                            <c:when test="${not empty listaReviews}">
                                <c:forEach var="review" items="${listaReviews}">
                                    <div class="list-group-item border-0 p-3 mb-3 bg-white shadow-sm rounded-3">
                                        <p class="fw-bold text-dark mb-1">${review.usuario.nombre}</p>
                                        <p class="text-muted mb-1"><strong>Fecha:</strong> <fmt:formatDate value="${review.fecha}" pattern="dd 'de' MMMM 'de' yyyy" /></p>
                                        <p class="text-muted mb-1">
                                            <strong>Valoración:</strong>
                                            <c:forEach var="i" begin="1" end="5">
                                                <i class="fas fa-star <c:if test='${i <= review.valoracion}'>text-warning</c:if>'"></i>
                                            </c:forEach>
                                            (${review.valoracion}/5)
                                        </p>
                                        <p class="text-muted mb-0">${review.comentario}</p>
                                        <c:if test="${not empty review.imagenes}">
                                            <div class="mt-3">
                                                <strong>Imágenes:</strong>
                                                <div class="d-flex flex-wrap gap-2 mt-2">
                                                    <c:forEach var="imagen" items="${review.imagenes}">
                                                        <img src="${pageContext.request.contextPath}/imagenes/${imagen}"
                                                             alt="Imagen de la review"
                                                             class="img-thumbnail review-img"
                                                             style="width: 120px; height: auto;" />
                                                    </c:forEach>
                                                </div>
                                            </div>
                                        </c:if>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <p class="text-center text-muted">Este producto aún no tiene reseñas</p>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>

        <!-- Footer -->
        <footer class="text-center text-lg-start text-white">
            <section class="d-flex justify-content-center p-4 border-bottom">
                <div class="me-5 d-none d-lg-block">
                    <span class="m-8">Conéctate con nosotros en redes sociales:</span>
                </div>
                <div>
                    <a href="#" class="me-4 text-reset"><i class="fab fa-facebook-f"></i></a>
                    <a href="#" class="me-4 text-reset"><i class="fab fa-twitter"></i></a>
                    <a href="#" class="me-4 text-reset"><i class="fab fa-instagram"></i></a>
                    <a href="#" class="me-4 text-reset"><i class="fab fa-linkedin"></i></a>
                </div>
            </section>

            <div class="container text-center text-md-start mt-5">
                <div class="row mt-3">
                    <div class="col-md-3 col-lg-4 col-xl-3 mx-auto mb-4">
                        <h6 class="text-uppercase fw-bold mb-4">
                            <i class="fas fa-gem me-3"></i> ChocoArte
                        </h6>
                        <p>Deléitate con la experiencia de chocolate más refinada y cremosa</p>
                    </div>

                    <div class="col-md-2 col-lg-2 col-xl-2 mx-auto mb-4">
                        <h6 class="text-uppercase fw-bold mb-4">Productos</h6>
                        <p><a href="#" class="text-reset">Tartas</a></p>
                        <p><a href="#" class="text-reset">Cupcakes</a></p>
                        <p><a href="#" class="text-reset">Bombones</a></p>
                        <p><a href="#" class="text-reset">Galletas</a></p>
                    </div>

                    <div class="col-md-3 col-lg-2 col-xl-2 mx-auto mb-4">
                        <h6 class="text-uppercase fw-bold mb-4">Enlaces útiles</h6>
                        <p><a href="#" class="text-reset">Términos y condiciones</a></p>
                        <p><a href="#" class="text-reset">Política de privacidad</a></p>
                        <p><a href="#" class="text-reset">Ayuda</a></p>
                        <p><a href="#" class="text-reset">Contacto</a></p>
                    </div>

                    <div class="col-md-4 col-lg-3 col-xl-3 mx-auto mb-md-0 mb-4">
                        <h6 class="text-uppercase fw-bold mb-4">Contacto</h6>
                        <p><i class="fas fa-home me-3"></i> Sevilla, España</p>
                        <p><i class="fas fa-envelope me-3"></i> info@chocoarte.com</p>
                        <p><i class="fas fa-phone me-3"></i> +34 900 123 456</p>
                        <p><i class="fas fa-print me-3"></i> +34 900 123 457</p>
                    </div>
                </div>
            </div>

            <div class="text-center p-4" style="background-color: rgba(0, 0, 0, 0.05);">
                © 2025 ChocoArte. Todos los derechos reservados.
            </div>
        </footer>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
