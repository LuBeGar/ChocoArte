<%-- 
    Document   : login
    Created on : 20 abr 2025, 19:04:04
    Author     : Lu
--%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Iniciar Sesión - ChocoArte</title>

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

    <!-- Formulario de Inicio de Sesión -->
    <div class="container my-5">
        <div class="p-4 rounded-3 shadow-sm" style="background-color: rgba(0, 0, 0, 0.05)">
            <h4 class="text-center mb-4 custom-text-shadow" style="color:#8B4513">Iniciar Sesión</h4>
            <form id="formLogin" method="POST">

                <!-- email -->
                <div class="mb-3">
                    <label for="email" class="form-label text-dark">Email</label>
                    <input type="text" class="form-control" id="email" name="email" required>
                    <span id="errorEmail" class="text-danger"></span>
                </div>

                <!-- Contraseña -->
                <div class="mb-3">
                    <label for="password" class="form-label text-dark">Contraseña</label>
                    <input type="password" class="form-control" id="password" name="password" required>
                    <span id="errorPass" class="text-danger"></span>
                </div>

                <!-- Recordar sesión -->
                <div class="mb-3 form-check">
                    <input type="checkbox" class="form-check-input" id="recordarSesion" name="recordarSesion">
                    <label class="form-check-label text-dark" for="recordarSesion">Recordar sesión</label>
                </div>

                <!-- Botón de Iniciar Sesión -->
                <div class="text-center">
                    <input type="submit" value="Iniciar Sesión" class="btn btn-gold w-100">
                </div>

                <!-- Enlace a Registro -->
                <div class="mt-3 text-center">
                    <p>¿No tienes una cuenta? <a href="ControladorRegistro">Regístrate aquí</a></p>
                </div>
            </form>
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

    <script src="validacionLogin.js"></script>
</body>
</html>
