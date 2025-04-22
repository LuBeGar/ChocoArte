<%-- 
    Document   : inicioUsuario
    Created on : 20 abr 2025, 18:33:24
    Author     : Lu
--%>

<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Perfil de Usuario - ChocoArte</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="css/estilos.css" type="text/css">
        <!-- Font Awesome para iconos -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    </head>
    <body>
        <!-- Navbar -->
        <nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm position-sticky" style="top: 0; z-index: 1050;">
            <div class="container">
                <a class="navbar-brand" href="principal.jsp">
                    <img src="img/conejo.png" alt="ChocoArte" height="40">
                </a>
            </div>
        </nav>

        <div class="container-fluid">
            <div class="row">
                <!-- Sidebar -->
                <div class="col-md-3 col-lg-2 p-4 panel">
                    <div class="position-sticky" style="top: 90px; z-index: 1040;">
                        <h4 class="mb-4">Perfil de Usuario</h4>
                        <ul class="nav flex-column">
                            <li class="nav-item">
                                <a class="nav-link active" href="#">Mi Perfil</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#pedidos">Mis Pedidos</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#puntos">Mis Puntos</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#reseñas">Mis Reseñas</a>
                            </li>
                        </ul>
                    </div>
                </div>

                <!-- Main Content -->
                <div class="col-md-9 col-lg-10 px-5 p-4">
                    <h1 class="mb-4 custom-text-shadow" style="color:#8B4513">Bienvenido, Juan Pérez</h1>

                    <!-- Puntos -->
                    <h3 class="mt-5" id="puntos">Mis Puntos</h3>
                    <p>Has acumulado un total de 120 puntos. ¡Sigue comprando para obtener más beneficios!</p>

                    <!-- Pedidos -->
                    <h3 class="mt-5" id="pedidos">Mis Pedidos</h3>
                    <table class="table table-striped mt-3">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Producto</th>
                                <th>Precio</th>
                                <th>Estado</th>
                                <th>Fecha</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>1</td>
                                <td>Tarta grande</td>
                                <td>400 €</td>
                                <td>Enviado</td>
                                <td>15/03/2025</td>
                                <td><button class="btn btn-warning btn-sm"><i class="fas fa-edit"></i> Dejar reseña</button></td>
                            </tr>
                            <tr>
                                <td>2</td>
                                <td>Tarta pequeña</td>
                                <td>250 €</td>
                                <td>En proceso</td>
                                <td>17/03/2025</td>
                                <td><button class="btn btn-warning btn-sm"><i class="fas fa-edit"></i> Dejar reseña</button></td>
                            </tr>
                        </tbody>
                    </table>

                    <!-- Reseñas -->
                    <h3 class="mt-5" id="reseñas">Mis Reseñas</h3>
                    <table class="table table-striped mt-3">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Producto</th>
                                <th>Comentario</th>
                                <th>Valoración</th>
                                <th>Fecha</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>1</td>
                                <td>Tarta grande</td>
                                <td>Muy deliciosa, excelente presentación.</td>
                                <td>5/5</td>
                                <td>18/03/2025</td>
                                <td><button class="btn btn-info btn-sm"><i class="fas fa-eye"></i> Ver</button></td>
                            </tr>
                            <tr>
                                <td>2</td>
                                <td>Tarta pequeña</td>
                                <td>Sabrosa, pero me gustaría que fuera más grande.</td>
                                <td>4/5</td>
                                <td>20/03/2025</td>
                                <td><button class="btn btn-info btn-sm"><i class="fas fa-eye"></i> Ver</button></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- Footer -->
        <footer class="text-center text-lg-start ">
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
    </body>
</html> 
