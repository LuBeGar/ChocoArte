<%-- 
    Document   : pedido
    Created on : 20 abr 2025, 18:32:06
    Author     : Lu
--%>

<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Formulario de pedido - ChocoArte</title>

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
                    <!-- Si el usuario está logueado, muestra su nombre -->
                    <div class="d-flex flex-column flex-lg-row ">
                        <span class="btn btn-outline-secondary mb-2 mb-lg-0 ms-lg-3">
                            Hola, ${sessionScope.usuario.nombre} 
                        </span>
                    </div>
                </div>
            </div>
        </nav>

        <!-- Formulario -->
        <section class="my-3 py-5">
            <div class="container">
                <h2 class="text-center mb-4 custom-text-shadow" style="color:#8B4513">Formulario de pedido</h2>
                <form>
                    <!-- Tipo de Producto -->
                    <div class="mb-3">
                        <label for="tipo" class="form-label">Tipo</label>
                        <select class="form-select shadow" id="tipo">
                            <option value="tartas-xxl">Tarta XXL</option>
                            <option value="tartas-grande">Tarta Grande</option>
                            <option value="tartas-mediano">Tarta Mediana</option>
                            <option value="tartas-pequeño">Tarta Pequeña</option>
                            <option value="bombones">Bombones</option>
                            <option value="galletas">Galletas</option>
                            <option value="cupcakes">Cupcakes</option>
                        </select>
                    </div>
                    <!-- Forma -->
                    <div class="mb-3">
                        <label for="forma" class="form-label">Forma</label>
                        <input type="text" class="form-control shadow" id="forma" placeholder="Escribe la forma">
                    </div>
                    <!-- Alérgenos -->
                    <div class="mb-3">
                        <label for="alergenos" class="form-label">Alérgenos</label>
                        <select class="form-select shadow" id="alergenos" onchange="toggleOtherAllergen()">
                            <option value="sin-alergenos">Sin alérgenos</option>
                            <option value="sin-lactosa">Sin lactosa</option>
                            <option value="sin-gluten">Sin gluten</option>
                            <option value="sin-huevo">Sin huevo</option>
                            <option value="otros">Otros</option>
                        </select>
                    </div>
                    <!-- Otros Alérgenos -->
                    <div class="mb-3" id="otros-alergenos" style="display: none;">
                        <label for="otros" class="form-label">Especifica los alérgenos</label>
                        <input type="text" class="form-control shadow" id="otros" placeholder="Especifica los alérgenos">
                    </div>
                    <!-- Descripción -->
                    <div class="mb-3">
                        <label for="descripcion" class="form-label">Descripción</label>
                        <textarea class="form-control shadow" id="descripcion" rows="4" placeholder="Escribe una descripción"></textarea>
                    </div>
                    <!-- Enviar -->
                    <button type="submit" class="btn btn-gold shadow">Enviar formulario</button>
                </form>
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
            // Función para mostrar el campo de "Otros" alérgenos solo si se selecciona la opción correspondiente
            function toggleOtherAllergen() {
                var allergenSelect = document.getElementById('alergenos');
                var otherAllergenInput = document.getElementById('otros-alergenos');
                if (allergenSelect.value === 'otros') {
                    otherAllergenInput.style.display = 'block';
                } else {
                    otherAllergenInput.style.display = 'none';
                }
            }
        </script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
