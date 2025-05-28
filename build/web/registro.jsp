<%-- 
    Document   : registro
    Created on : 20 abr 2025, 18:39:43
    Author     : Lu
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=ISO-8859-15" pageEncoding="ISO-8859-15" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Registro - ChocoArte</title>
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

        <!-- Formulario -->
        <div class="container my-5">
            <div class="p-4 rounded-3 shadow-sm" style="background-color: rgba(0, 0, 0, 0.05)">
                <h4 class="text-center mb-4 custom-text-shadow" style="color:#8B4513">Registro de Usuario</h4>
                <form id="formRegistro" method="POST" novalidate>

                    <input type="hidden" name="id" value="${id}">

                    <!-- Nombre de Usuario -->
                    <div class="mb-3">
                        <label for="nombre" class="form-label text-dark">Nombre de Usuario</label>
                        <input type="text" class="form-control" id="nombre" name="nombre" value="${nombre}" onchange="validarUsuario()"
                               required>
                        <span id="errorUsuario" class="text-danger"></span>
                    </div>

                    <!-- Correo Electrónico -->
                    <div class="mb-3">
                        <label for="email" class="form-label text-dark">Correo Electrónico</label>
                        <input type="email" class="form-control" id="email" name="email" value="${email}" onchange="validarEmail()" required>
                        <span id="errorEmail" class="text-danger"></span>
                    </div>

                    <!-- Contraseña -->
                    <div class="mb-3">
                        <label for="password" class="form-label text-dark">Contraseña</label>
                        <input type="password" class="form-control" id="password" name="password"
                               onchange="validarPass()" required>
                        <span id="errorPass" class="text-danger"></span>
                    </div>

                    <!-- Confirmar Contraseña -->
                    <div class="mb-3">
                        <label for="confirmarPassword" class="form-label text-dark">Confirmar Contraseña</label>
                        <input type="password" class="form-control" id="confirmarPassword" name="confirmarPassword"
                               onchange="validarConfirmar()" required>
                        <span id="errorConfirmar" class="text-danger"></span>
                    </div>

                    <!-- Teléfono -->
                    <div class="mb-3">
                        <label for="telefono" class="form-label text-dark">Teléfono</label>
                        <input type="tel" class="form-control" id="telefono" name="telefono" value="${telefono}" onchange="validarTelefono()"
                               required>
                        <span id="errorTelefono" class="text-danger"></span>
                    </div>

                    <!-- Dirección -->
                    <div class="mb-3">
                        <label for="direccion" class="form-label text-dark">Dirección</label>
                        <input type="text" class="form-control" id="direccion" name="direccion" value="${direccion}" required>
                        <span id="errorDireccion" class="text-danger"></span>
                    </div>


                    <!-- Fecha de Nacimiento -->
                    <div class="mb-3">
                        <label for="fechaNacimiento" class="form-label text-dark">Fecha de Nacimiento</label>
                        <input type="date" class="form-control" id="fechaNacimiento" name="fechaNacimiento" value="${fechaNacimiento}" onchange="validarFecha()" required>
                        <span id="errorFecha" class="text-danger"></span>
                        <span id="errorFecha2" class="text-danger"></span>
                    </div>

                    <!-- Género -->
                    <div class="mb-3">
                        <label class="form-label text-dark">Género</label><br>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="genero" id="masculino" value="masculino"
                                   onchange="validarGenero()">
                            <label class="form-check-label" for="masculino">Masculino</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="genero" id="femenino" value="femenino"
                                   onchange="validarGenero()">
                            <label class="form-check-label" for="femenino">Femenino</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="genero" id="otro" value="otro"
                                   onchange="validarGenero()">
                            <label class="form-check-label" for="otro">Otro</label>
                        </div>
                        <br>
                        <span id="errorGenero" class="text-danger"></span>
                    </div>

                    <!-- Sabor Favorito -->
                    <div class="mb-3">
                        <label for="sabor" class="form-label text-dark">Sabor Favorito</label>
                        <select class="form-select" id="sabor" name="sabor" onchange="validarSabor()" required>
                            <option value="">--Seleccione--</option>
                            <option value="Negro">Chocolate negro</option>
                            <option value="Leche">Chocolate con leche</option>
                            <option value="Blanco">Chocolate blanco</option>
                        </select>
                        <span id="errorSabor" class="text-danger"></span>
                    </div>

                    <!-- Comentarios -->
                    <div class="mb-3">
                        <label for="comentarios" class="form-label text-dark">Comentarios (opcional)</label>
                        <textarea class="form-control" id="comentarios" name="comentarios" rows="3"
                                  placeholder="¿Algo que quieras compartir con nosotros?"></textarea>
                    </div>

                    <!-- Términos y Condiciones -->
                    <div class="mb-3">
                        <input type="checkbox" id="terminos" name="terminos" onchange="validarTerminos()" required>
                        <label for="terminos">He leído y acepto los <a href="" id="leerTerminos">términos y
                                condiciones</a></label><br>
                        <span id="errorTerminos" class="text-danger"></span>
                    </div>

                    <!-- Botón de Enviar -->
                    <div class="text-center">
                        <input type="submit" name="crear" value="Registrarse" class="btn btn-gold w-100">
                    </div>
                </form>

                <!-- Modal -->
                <dialog id="modalTerminos">
                    <form method="dialog">
                        <p>Estos son los términos y condiciones...</p>
                        <br />
                        <button id="cerrarTerminos" class="btn btn-secondary">Cerrar</button>
                    </form>
                </dialog>
            </div>
        </div>

        <c:if test="${not empty error}">
            <c:if test="${not empty error}">
                <script>
                    document.addEventListener("DOMContentLoaded", function () {
                        Swal.fire({
                            icon: 'error',
                            title: 'Error en el registro',
                            text: '${error}',
                            confirmButtonText: 'Aceptar'
                        });
                    });
                </script>
            </c:if>
        </c:if>
        <a href="index.html" class="btn btn-gold m-5">Volver a inicio</a>

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

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="js/validacion.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    </body>

</html>
