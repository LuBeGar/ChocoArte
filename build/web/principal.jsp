<%-- 
    Document   : principal
    Created on : 20 abr 2025, 18:29:57
    Author     : Lu
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=ISO-8859-15" pageEncoding="ISO-8859-15" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Inicio - ChocoArte</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="css/estilos.css" type="text/css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    </head>

    <body>
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
                        <li><a class="dropdown-item" href="recetas.jsp"><i class="fas fa-utensils"></i> Recetas</a></li>
                    </ul>
                </div>

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

        <div class="d-sm-flex w-100 carousel-color d-none">
            <!-- Slider -->
            <div id="carouselExample" class="carousel slide custom-carousel " data-bs-ride="carousel">
                <div class="carousel-inner d-flex w-100 h-100 ">
                    <!-- Imagen 1 -->
                    <div class="carousel-item active " data-bs-interval="3000">
                        <img src="img/mariposa-chocolate-sobre-fondo-blanco_410516-25757.jpg" class="w-100 h-100 d-block"
                             alt="Chocolate">
                        <div class="carousel-caption d-none d-md-block">
                            <h1 class="text-warning custom-text-border custom-text-shadow">ChocoArte</h1>
                            <p class="custom-text-border custom-text-shadow">Las tartas de tus sueños</p>
                        </div>
                    </div>

                    <!-- Imagen 2 -->
                    <div class="carousel-item" data-bs-interval="3000">
                        <img src="img/dragonawa5.jpg" class="d-block w-100 h-100 " alt="Tarta dragon">
                        <div class="carousel-caption d-none d-md-block">
                            <h1 class="text-warning custom-text-border custom-text-shadow">ChocoArte</h1>
                            <p class="custom-text-border custom-text-shadow">Las tartas de tus sueños</p>
                        </div>
                    </div>

                    <!-- Imagen 3 -->
                    <div class="carousel-item" data-bs-interval="3000">
                        <img src="img/cupos3.jpg" class="d-block w-100 h-100 " alt="cupcakes ositos">
                        <div class="carousel-caption d-none d-md-block">
                            <h1 class="text-warning custom-text-border custom-text-shadow">ChocoArte</h1>
                            <p class="custom-text-border custom-text-shadow">Las tartas de tus sueños</p>
                        </div>
                    </div>
                </div>

                <!-- Controles del carrusel -->
                <button class="carousel-control-prev" type="button" data-bs-target="#carouselExample" data-bs-slide="prev">
                    <span class="carousel-control-prev-icon"></span>
                </button>
                <button class="carousel-control-next" type="button" data-bs-target="#carouselExample" data-bs-slide="next">
                    <span class="carousel-control-next-icon"></span>
                </button>
            </div>
        </div>

        <!-- Sección de Información sobre ChocoArte -->
        <section id="nosotros" class="py-5 ">
            <div class="container">
                <div class="row">
                    <!-- Columna de texto -->
                    <div class="col-md-6">
                        <h2 class="text-center mb-4 custom-text-shadow text-chocoarte">Sobre ChocoArte</h2>
                        <p class="lead">ChocoArte es una tienda especializada en la creación de tartas personalizadas,
                            ideales para cualquier tipo de celebración. Nos apasiona el arte de la repostería, combinando la
                            creatividad y el sabor en cada uno de nuestros productos. Nuestro objetivo es hacer que cada
                            evento sea aún más especial con un toque dulce y único.</p>
                        <p class="lead">Con años de experiencia en el sector de la pastelería, nuestro equipo de expertos se
                            dedica a ofrecer productos frescos, de la más alta calidad y diseñados a medida según las
                            preferencias de cada cliente. Ya sea para un cumpleaños, boda, fiesta o evento corporativo,
                            estamos aquí para crear la tarta perfecta para ti.</p>
                        <p class="lead">Nos enorgullece utilizar solo los mejores ingredientes para garantizar un sabor
                            delicioso en cada bocado. Además, nos aseguramos de que cada tarta sea una obra de arte,
                            cuidando cada detalle en su decoración. ¡Haz tu evento aún más memorable con ChocoArte!</p>
                    </div>
                    <!-- Imagen -->
                    <div class="col-md-6 d-flex justify-content-center align-items-center">
                        <img src="img/logoblanco__1_-removebg-preview.png" alt="Tarta personalizada de ChocoArte"
                             class="img-fluid rounded">
                    </div>
                </div>
            </div>
        </section>
        <hr>

        <!-- Filtros y Productos -->
        <div class="container my-5 ">
            <div class="row">
                <!-- Filtro -->
                <div class="col-md-3 mt-5">
                    <form action="ControladorFiltrarProductos#productos" method="get" class="accordion shadow p-3 rounded" id="filtro">
                        <!-- Buscar por texto -->
                        <div class="mb-3">
                            <label for="filtro" class="form-label">Buscar producto</label>
                            <input type="text" class="form-control" id="textofiltro" name="filtro" placeholder="Tipo o descripción">
                        </div>

                        <!-- Rango de precio -->
                        <div class="mb-3">
                            <label for="precioMin" class="form-label">Precio mínimo (¤)</label>
                            <input type="number" class="form-control" id="precioMin" name="precioMin" step="0.01" min="0">
                        </div>
                        <div class="mb-3">
                            <label for="precioMax" class="form-label">Precio máximo (¤)</label>
                            <input type="number" class="form-control" id="precioMax" name="precioMax" step="0.01" min="0">
                        </div>

                        <button type="submit" class="btn btn-gold w-100 mt-2">
                            <i class="fas fa-filter me-1"></i> Filtrar
                        </button>
                    </form>
                </div>

                <!-- Productos -->
                <div class="col-md-9" id="productos">
                    <h1 class="text-center mb-4 custom-text-shadow text-chocoarte">Nuestros productos</h1>
                    <div class="row">
                        <c:forEach var="producto" items="${productos}">
                            <div class="col-md-4">
                                <div class="card producto mb-3 shadow">
                                    <c:if test="${not empty producto.imagen}">
                                        <img src="${pageContext.request.contextPath}/imagenes/${producto.imagen}">
                                    </c:if>
                                    <div class="card-body text-center">
                                        <h5 class="card-title">${producto.tipo}</h5>
                                        <p class="card-text">${producto.precio} ¤</p>
                                        <p class="card-text">${producto.descripcion}</p>
                                        <a href="ControladorDetalleProducto?id=${producto.id}" class="btn btn-gold">
                                            <i class="fas fa-shopping-cart me-1"></i> Hacer un pedido
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>

        <hr>
        <!-- Sección de Testimonios -->
        <section id="testimonios" class=" py-5">
            <div class="container">
                <h2 class="text-center mb-4 custom-text-shadow text-chocoarte">Lo que nuestros clientes dicen</h2>
                <div class="row">
                    <!-- Testimonio 1 -->
                    <div class="col-md-4 mb-3">
                        <div class="card shadow">
                            <div class="card-body">
                                <p class="card-text">"Las tartas de ChocoArte son una verdadera obra de arte. No solo son
                                    deliciosas, sino que también se ven increíbles. ¡Mi cumpleaños fue un éxito gracias a
                                    ellos!"</p>
                                <h5 class="card-title">Laura González</h5>
                                <p class="text-muted">Cliente satisfecha</p>
                            </div>
                        </div>
                    </div>

                    <!-- Testimonio 2 -->
                    <div class="col-md-4 mb-3">
                        <div class="card shadow">
                            <div class="card-body">
                                <p class="card-text ">"No puedo recomendar lo suficiente a ChocoArte. Hicieron una tarta de
                                    bodas que dejó a todos sin palabras. El sabor era espectacular y la decoración
                                    perfecta."</p>
                                <h5 class="card-title">Carlos y Ana</h5>
                                <p class="text-muted">Pareja feliz</p>
                            </div>
                        </div>
                    </div>

                    <!-- Testimonio 3 -->
                    <div class="col-md-4 mb-3">
                        <div class="card shadow">
                            <div class="card-body">
                                <p class="card-text">"Cada vez que ordeno con ChocoArte, quedo impresionado. Son rápidos,
                                    amables, y sobre todo, sus productos son deliciosos. ¡Siempre los recomiendo!"</p>
                                <h5 class="card-title">Pedro Martínez</h5>
                                <p class="text-muted">Cliente recurrente</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <hr>
        <!-- Formulario de Contacto -->
        <section id="contacto" class="my-3 py-5">
            <div class="container">
                <h2 class="text-center mb-4 custom-text-shadow text-chocoarte">Contáctanos</h2>
                <div class="row justify-content-center">
                    <div class="col-md-8">
                        <div class="card shadow-lg border-0 rounded-4" style="background-color: rgba(0, 0, 0, 0.05)">
                            <div class="card-body p-4">
                                <form action="ControladorContacto" method="post">
                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label for="nombre" class="form-label">Nombre</label>
                                            <input type="text" class="form-control shadow-sm" id="nombre" name="nombre" placeholder="Tu nombre">
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label for="email" class="form-label">Correo electrónico</label>
                                            <input type="email" class="form-control shadow-sm" id="email" name="email" placeholder="Tu correo electrónico">
                                        </div>
                                    </div>
                                    <div class="mb-3">
                                        <label for="mensaje" class="form-label">Mensaje</label>
                                        <textarea class="form-control shadow-sm" id="mensaje" name="mensaje" rows="4" placeholder="Escribe tu mensaje"></textarea>
                                    </div>
                                    <div class="d-grid">
                                        <button type="submit" class="btn btn-gold shadow">Enviar mensaje</button>
                                    </div>
                                </form>

                                <!-- Mensajes de éxito o error -->
                                <c:if test="${not empty mensajeExito}">
                                    <div class="alert alert-success alert-dismissible fade show mt-3" role="alert">
                                        ${mensajeExito}
                                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Cerrar"></button>
                                    </div>
                                </c:if>
                                <c:if test="${not empty error}">
                                    <div class="alert alert-danger alert-dismissible fade show mt-3" role="alert">
                                        ${error}
                                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Cerrar"></button>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <hr>
        <!-- Sección del video -->
        <section class="text-white text-center py-5" >
            <div class="container">
                <h2 class="text-center mb-4 custom-text-shadow text-chocoarte" >Así hacemos nuestras tartas</h2>
                <div class="embed-responsive embed-responsive-16by9">
                    <video controls width="250" height="auto">
                        <source src="video/videoplayback.mp4" type="video/mp4">
                        Tu navegador no soporta la reproducción de video
                    </video>
                </div>
                <a href="recetas.jsp" class="btn btn-gold shadow">Haz click aquí para ver algunas recetas de postre</a>
            </div>
        </section>

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
