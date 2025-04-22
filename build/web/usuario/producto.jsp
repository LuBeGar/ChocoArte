<%-- 
    Document   : producto
    Created on : 20 abr 2025, 18:38:24
    Author     : Lu
--%>

<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html> 
    <head>
        <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Detalles del Producto</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/estilos.css" type="text/css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    </head>
   
<body class="d-flex flex-column min-vh-100">

    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-light sticky-top bg-white shadow-sm">
        <div class="container">
            <!-- Logo y menú  -->
            <div class="dropdown">
                <button class="btn dropdown-toggle" type="button" id="dropdownMenu2" data-bs-toggle="dropdown"
                    aria-expanded="false">
                    <img src="img/conejo.png" alt="ChocoArte" height="40">
                </button>
                <ul class="dropdown-menu" aria-labelledby="dropdownMenu2">
                    <li><a class="dropdown-item" href="#nosotros"><i class="fa-solid fa-info me-1"></i> Sobre
                            nosotros</a></li>
                    <li><a class="dropdown-item" href="#productos"><i class="fas fa-gift me-1"></i> Nuestros
                            productos</a></li>
                    <li><a class="dropdown-item" href="#testimonios"><i class="fas fa-heart me-1"></i> Lo que dicen
                            nuestros clientes</a></li>
                    <li><a class="dropdown-item" href="#contacto"><i class="fa-solid fa-address-card me-1"></i>
                            Contáctanos</a></li>
                </ul>
            </div>

            <!-- Botón hamburguesa -->
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <!-- Menú colapsable -->
            <div class="collapse navbar-collapse ms-auto justify-content-end" id="navbarNav">
                <!-- Formulario de búsqueda -->
                <div>
                    <form class="d-flex mb-3 mb-lg-0 ml-3">
                        <input class="form-control me-2" type="search" placeholder="Buscar" aria-label="Buscar">
                        <button class="btn btn-outline-secondary" type="submit"><i class="fas fa-search"></i></button>
                    </form>
                </div>

                <!-- Botones de iniciar sesión y registrarse -->
                <div class="d-flex flex-column flex-lg-row ">
                    <button class="btn btn-outline-primary mb-2 mb-lg-0 ms-lg-3" data-bs-toggle="modal"
                        data-bs-target="#loginModal"><i class="fas fa-sign-in-alt me-1"></i> Iniciar sesión</button>
                    <button class="btn btn-outline-success mb-2 mb-lg-0 ms-lg-3 " data-bs-toggle="modal"
                        data-bs-target="#registerModal"><i class="fas fa-user-plus me-1"></i> Registrarse</button>
                </div>
            </div>
        </div>
    </nav>

    
    <!-- Modales de inicio de sesión y registro -->
    <div class="modal fade" id="loginModal" tabindex="-1" aria-labelledby="loginModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="loginModalLabel">Iniciar Sesión</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <label for="email1">Correo electrónico</label>
                    <input type="email" class="form-control mb-2" placeholder="Correo electrónico" id="email1">
                    <label for="password1">Contraseña</label>
                    <input type="password" class="form-control mb-2" placeholder="Contraseña" id="password1">
                </div>
                <div class="modal-footer">
                    <a type="button" class="btn btn-primary" href="administracion.html">Iniciar</a>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="registerModal" tabindex="-1" aria-labelledby="registerModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="registerModalLabel">Registrarse</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <label for="nombre">Nombre</label>
                    <input type="text" class="form-control mb-2" placeholder="Nombre Completo" id="nombre">
                    <label for="email2">Email</label>
                    <input type="email" class="form-control mb-2" placeholder="Correo electrónico" id="email2">
                    <label for="password2">Contraseña</label>
                    <input type="password" class="form-control mb-2" placeholder="Contraseña" id="password2">
                </div>
                <div class="modal-footer">
                    <a type="button" class="btn btn-success" href="principal.html">Registrarse</a>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Main Content -->
    <div class="container my-5 flex-grow-1">
        <div class="row">
            <!-- Imagen del Producto -->
            <div class="col-md-6 text-center">
                <img src="img/flor.jpg" alt="Imagen del Producto" class="product-image">
            </div>
            <!-- Detalles del Producto -->
            <div class="col-md-6">
                <h2 class="text-center mb-4 custom-text-shadow" style="color:#8B4513">Tarta pequeña</h2>
                <p><strong>Precio:</strong> 250 €</p>
                <p><strong>Descripción:</strong> Una deliciosa tarta hecha a mano con los mejores ingredientes, ideal para celebraciones y eventos especiales.</p>

                <a href="pedido.html" class="btn btn-gold btn-lg m-4">Hacer Pedido</button>
                <a href="index.html" class="btn btn-secondary btn-lg m-4 btn-back">Volver al listado</a>
            </div>
        </div>

<!-- Comentarios de los Clientes -->
<div class="container my-5">
    <div class="comments-section p-4 rounded-3 shadow-sm" style="background-color: rgba(0, 0, 0, 0.05)">
        <h4 class="text-center mb-4 custom-text-shadow" style="color:#8B4513">Comentarios de Clientes</h4>
        <div class="list-group">
            <div class="list-group-item border-0 p-3 mb-3 bg-white shadow-sm rounded-3">
                <p class="fw-bold text-dark mb-1">Juan Pérez</p>
                <p class="text-muted mb-1"><strong>Fecha:</strong> 25 de marzo de 2025</p>
                <p class="text-muted mb-1"><strong>Valoración:</strong> ★★★★☆ (4/5)</p>
                <p class="text-muted mb-0">¡Increíble sabor! La tarta es muy suave y deliciosa. La volveré a comprar.</p>
            </div>
            <div class="list-group-item border-0 p-3 mb-3 bg-white shadow-sm rounded-3">
                <p class="fw-bold text-dark mb-1">Ana López</p>
                <p class="text-muted mb-1"><strong>Fecha:</strong> 20 de marzo de 2025</p>
                <p class="text-muted mb-1"><strong>Valoración:</strong> ★★★☆☆ (3/5)</p>
                <p class="text-muted mb-0">Me encantó, aunque me gustaría que fuera un poco más grande.</p>
            </div>
            <div class="list-group-item border-0 p-3 mb-3 bg-white shadow-sm rounded-3">
                <p class="fw-bold text-dark mb-1">Carlos Gómez</p>
                <p class="text-muted mb-1"><strong>Fecha:</strong> 15 de marzo de 2025</p>
                <p class="text-muted mb-1"><strong>Valoración:</strong> ★★★★★ (5/5)</p>
                <p class="text-muted mb-0">Perfecta para el cumpleaños de mi hija, todos los invitados quedaron encantados.</p>
            </div>
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
</body>
</html>
