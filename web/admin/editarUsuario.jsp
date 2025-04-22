<%-- 
    Document   : editarUsuario
    Created on : 22 abr 2025, 22:27:43
    Author     : Lu
--%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Editar Usuario - ChocoArte</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="css/estilos.css" type="text/css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    </head>

    <body>

        <!-- Navbar -->
        <nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm sticky-top">
            <div class="container">
                <a class="navbar-brand" href="index.html">
                    <img src="img/conejo.png" alt="ChocoArte" height="40">
                </a>
            </div>
        </nav>

        <!-- Formulario -->
        <div class="container my-5">
            <div class="p-4 rounded-3 shadow-sm" style="background-color: rgba(0, 0, 0, 0.05)">
                <h4 class="text-center mb-4 custom-text-shadow" style="color:#8B4513">Editar Usuario</h4>
                <form id="formEditar" action="ControladorUsuario" method="POST" novalidate>

                    <input type="hidden" name="id" value="${id}">
                    
                    <!-- Nombre de Usuario -->
                    <div class="mb-3">
                        <label for="nombre" class="form-label text-dark">Nombre de Usuario</label>
                        <input type="text" class="form-control" id="nombre" name="nombre" value="${nombre}" required>
                    </div>

                    <!-- Correo Electrónico -->
                    <div class="mb-3">
                        <label for="email" class="form-label text-dark">Correo Electrónico</label>
                        <input type="email" class="form-control" id="email" name="email" value="${email}" required>
                    </div>

                    <!-- Contraseña (opcional para cambiar) -->
                    <div class="mb-3">
                        <label for="password" class="form-label text-dark">Nueva Contraseña (dejar en blanco para no cambiar)</label>
                        <input type="password" class="form-control" id="password" name="password">
                    </div>

                    <!-- Confirmar Contraseña -->
                    <div class="mb-3">
                        <label for="repetirPassword" class="form-label text-dark">Confirmar Nueva Contraseña</label>
                        <input type="password" class="form-control" id="repetirPassword" name="repetirPassword">
                    </div>

                    <!-- Teléfono -->
                    <div class="mb-3">
                        <label for="telefono" class="form-label text-dark">Teléfono</label>
                        <input type="tel" class="form-control" id="telefono" name="telefono" value="${telefono}" required>
                    </div>

                    <!-- Dirección -->
                    <div class="mb-3">
                        <label for="direccion" class="form-label text-dark">Dirección</label>
                        <input type="text" class="form-control" id="direccion" name="direccion" value="${direccion}" required>
                    </div>

                    <!-- Fecha de Nacimiento -->
                    <div class="mb-3">
                        <label for="fechaNacimiento" class="form-label text-dark">Fecha de Nacimiento</label>
                        <input type="date" class="form-control" id="fechaNacimiento" name="fechaNacimiento" value="${fechaNacimiento}" required>
                    </div>

                    <!-- Género -->
                    <div class="mb-3">
                        <label class="form-label text-dark">Género</label><br>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="genero" id="masculino" value="masculino" ${genero == 'masculino' ? 'checked' : ''}>
                            <label class="form-check-label" for="masculino">Masculino</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="genero" id="femenino" value="femenino" ${genero == 'femenino' ? 'checked' : ''}>
                            <label class="form-check-label" for="femenino">Femenino</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="genero" id="otro" value="otro" ${genero == 'otro' ? 'checked' : ''}>
                            <label class="form-check-label" for="otro">Otro</label>
                        </div>
                    </div>

                    <!-- Sabor Favorito -->
                    <div class="mb-3">
                        <label for="saborFavorito" class="form-label text-dark">Sabor Favorito</label>
                        <select class="form-select" id="saborFavorito" name="saborFavorito" required>
                            <option value="Negro" ${saborFavorito == 'Negro' ? 'selected' : ''}>Chocolate negro</option>
                            <option value="Leche" ${saborFavorito == 'Leche' ? 'selected' : ''}>Chocolate con leche</option>
                            <option value="Blanco" ${saborFavorito == 'Blanco' ? 'selected' : ''}>Chocolate blanco</option>
                        </select>
                    </div>

                    <!-- Tipo de Usuario -->
                    <div class="mb-3">
                        <label for="tipo" class="form-label text-dark">Tipo de Usuario</label>
                        <select class="form-select" id="tipo" name="tipo" required>
                            <option value="normal" ${tipo == 'normal' ? 'selected' : ''}>Usuario Normal</option>
                            <option value="admin" ${tipo == 'admin' ? 'selected' : ''}>Administrador</option>
                        </select>
                    </div>

                    <!-- Comentarios -->
                    <div class="mb-3">
                        <label for="comentarios" class="form-label text-dark">Comentarios</label>
                        <textarea class="form-control" id="comentarios" name="comentarios" rows="3">${comentarios}</textarea>
                    </div>

                    <!-- Botones -->
                    <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                        <a href="ControladorUsuario" class="btn btn-secondary me-md-2">Cancelar</a>
                        <input type="submit" name="editar" value="Guardar Cambios" class="btn btn-gold">
                    </div>
                </form>
            </div>
        </div>

        <!-- Mensaje de error -->
        <c:if test="${not empty error}">
            <div class="container">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    ${error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </div>
        </c:if>

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

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="js/validacion.js"></script>
    </body>
</html>