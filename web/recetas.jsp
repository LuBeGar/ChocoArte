<%-- 
    Document   : recetas
    Created on : 27 may 2025, 17:22:27
    Author     : Lu
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Recetas - ChocoArte</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="css/estilos.css" type="text/css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
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

        <section class="py-5 ">
            <div class="container">
                <h2 class="text-center mb-4 custom-text-shadow text-chocoarte">Recetas de Tartas</h2>
                <div id="recipes-container" class="row g-4 justify-content-center"></div>
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
        <script>
            fetch('https://www.themealdb.com/api/json/v1/1/search.php?s=cake')
                    .then(response => response.json())
                    .then(data => {
                        const recipesContainer = document.getElementById('recipes-container');
                        if (!data.meals) {
                            recipesContainer.innerHTML = '<p class="text-center text-danger">No se encontraron recetas</p>';
                            return;
                        }
                        data.meals.forEach(meal => {
                            const col = document.createElement('div');
                            col.className = 'col-md-4';

                            const card = document.createElement('div');
                            card.className = 'card h-100 shadow-sm';

                            const img = document.createElement('img');
                            img.src = meal.strMealThumb;
                            img.alt = meal.strMeal;
                            img.className = 'card-img-top';

                            const cardBody = document.createElement('div');
                            cardBody.className = 'card-body d-flex flex-column';

                            const title = document.createElement('h5');
                            title.className = 'card-title text-center';
                            title.textContent = meal.strMeal;

                            const instructions = document.createElement('p');
                            instructions.className = 'card-text instructions';

                            // Texto completo y texto corto
                            const fullText = meal.strInstructions;
                            const shortText = fullText.length > 120 ? fullText.slice(0, 120) + "..." : fullText;

                            instructions.textContent = shortText;

                            // Solo si el texto es largo, añadimos el botón "Ver más"
                            if (fullText.length > 120) {
                                const btnVerMas = document.createElement('button');
                                btnVerMas.className = 'btn-vermas mt-auto align-self-start';
                                btnVerMas.textContent = 'Ver más';

                                btnVerMas.addEventListener('click', () => {
                                    if (btnVerMas.textContent === 'Ver más') {
                                        instructions.textContent = fullText;
                                        btnVerMas.textContent = 'Ver menos';
                                    } else {
                                        instructions.textContent = shortText;
                                        btnVerMas.textContent = 'Ver más';
                                    }
                                });

                                cardBody.appendChild(title);
                                cardBody.appendChild(instructions);
                                cardBody.appendChild(btnVerMas);
                            } else {
                                cardBody.appendChild(title);
                                cardBody.appendChild(instructions);
                            }

                            card.appendChild(img);
                            card.appendChild(cardBody);
                            col.appendChild(card);
                            recipesContainer.appendChild(col);
                        });
                    })
                    .catch(error => {
                        console.error('Error al obtener las recetas:', error);
                        document.getElementById('recipes-container').innerHTML = '<p class="text-center text-danger">No se pudieron cargar las recetas</p>';
                    });
        </script>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>