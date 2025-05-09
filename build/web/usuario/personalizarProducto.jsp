<%-- 
    Document   : personalizarProducto
    Created on : 7 may 2025, 23:05:04
    Author     : Lu
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Personalizar ${tipoProducto} - ChocoArte</title>
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

        <!-- Main Content -->
        <div class="container my-5 flex-grow-1">
            <div class="row">
                <!-- Imagen del Producto -->
                <div class="col-md-6 text-center">
                    <img src="${pageContext.request.contextPath}/imagenes/${productoBase.imagen}" class="product-image">
                </div>

                <!-- Formulario de Personalización -->
                <div class="col-md-6">
                    <h2 class="text-center mb-4 custom-text-shadow" style="color:#8B4513">Personalizar ${productoBase.tipo}</h2>

                    <c:if test="${not empty pedido}">
                        <div class="alert alert-info p-4 rounded-3 shadow-sm mb-4" style="background-color: rgba(0, 0, 0, 0.05)">
                            <h5><i class="fas fa-shopping-cart me-2"></i> Pedido en curso</h5>
                            <p>Tienes un pedido con ${empty pedido.productosPersonalizados ? 0 : pedido.productosPersonalizados.size()} productos</p>
                            <p><strong>Total acumulado:</strong> ${pedido.precio}€</p>
                        </div>
                    </c:if>

                    <form id="formPersonalizacion" action="ControladorProductoPersonalizado" method="POST" class="needs-validation" novalidate>
                        <input type="hidden" name="idProducto" value="${productoBase.id}">

                        <!-- Forma del producto -->
                        <div class="mb-4">
                            <label for="forma" class="form-label"><strong>Forma del producto *</strong></label>
                            <input type="text" class="form-control shadow" id="forma" name="forma" 
                                   value="${param.forma}" 
                                   placeholder="Ej: Redonda, corazón, personalizada..." required>
                            <div class="invalid-feedback">
                                Por favor, indica la forma del producto.
                            </div>
                        </div>

                        <!-- Alérgenos -->
                        <div class="mb-4">
                            <label for="alergenos" class="form-label"><strong>Alérgenos *</strong></label>
                            <select class="form-select shadow" id="alergenos" name="alergenos" onchange="toggleOtros()" required>
                                <option value="" disabled ${empty param.alergenos ? 'selected' : ''}>-- Seleccione una opción --</option>
                                <option value="sin-alergenos" ${param.alergenos == 'sin-alergenos' ? 'selected' : ''}>Sin alérgenos</option>
                                <option value="sin-lactosa" ${param.alergenos == 'sin-lactosa' ? 'selected' : ''}>Sin lactosa</option>
                                <option value="sin-gluten" ${param.alergenos == 'sin-gluten' ? 'selected' : ''}>Sin gluten</option>
                                <option value="sin-huevo" ${param.alergenos == 'sin-huevo' ? 'selected' : ''}>Sin huevo</option>
                                <option value="otros" ${param.alergenos == 'otros' ? 'selected' : ''}>Otros</option>
                            </select>
                            <div class="invalid-feedback">
                                Por favor, seleccione una opción de alérgenos.
                            </div>
                        </div>

                        <div class="mb-4" id="otrosAlergenosDiv" style="display:${param.alergenos == 'otros' ? 'block' : 'none'};">
                            <label for="otrosAlergenos" class="form-label"><strong>Especifica otros alérgenos *</strong></label>
                            <input type="text" class="form-control shadow" id="otrosAlergenos" 
                                   name="otrosAlergenos" value="${param.otrosAlergenos}" 
                                   placeholder="Ej: Frutos secos, soja..." 
                                   ${param.alergenos == 'otros' ? '' : 'disabled'} 
                                   ${param.alergenos == 'otros' ? 'required' : ''}>
                            <div class="invalid-feedback">
                                Por favor, especifica los alérgenos.
                            </div>
                        </div>

                        <!-- Descripción personalizada -->
                        <div class="mb-4">
                            <label for="descripcionPersonalizada" class="form-label"><strong>Descripción personalizada *</strong></label>
                            <textarea class="form-control shadow" id="descripcionPersonalizada" 
                                      name="descripcionPersonalizada" rows="3" 
                                      placeholder="Ej: 'Quiero que diga Feliz Cumpleaños María'" required>${param.descripcionPersonalizada}</textarea>
                            <div class="invalid-feedback">
                                Por favor, añade una descripción personalizada.
                            </div>
                        </div>


                        <!-- Precio -->
                        <div class="mb-4 p-3 bg-light rounded">
                            <h5><strong>Precio:</strong> ${productoBase.precio}€</h5>
                        </div>
                        <c:if test="${not empty error}">
                            <div class="error">${error}</div>
                        </c:if>
                        <!-- Botones -->
                        <div class="d-grid gap-2 d-md-flex justify-content-center mt-4">
                            <a href="ControladorProducto?id=${productoBase.id}" class="btn btn-secondary btn-lg m-2 btn-back">
                                <i class="fas fa-arrow-left me-1"></i> Volver
                            </a>

                            <button type="submit" name="accion" value="continuar" class="btn btn-gold btn-lg m-2">
                                <i class="fas fa-plus me-1"></i> Añadir y seguir
                            </button>

                            <button type="submit" name="accion" value="finalizar" class="btn btn-success btn-lg m-2">
                                <i class="fas fa-check me-1"></i> Finalizar pedido
                            </button>
                        </div>
                    </form>
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
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="js/verCampos.js"></script>
</body>
</html>
