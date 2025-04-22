<%-- 
    Document   : administracion
    Created on : 20 abr 2025, 18:58:28
    Author     : Lu
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin - ChocoArte</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="css/estilos.css" type="text/css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    </head>
    <body>
        <!-- Navbar -->
        <nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm position-sticky" style="top: 0; z-index: 1050;">
            <div class="container">
                <a class="navbar-brand" href="index.html">
                    <img src="img/conejo.png" alt="ChocoArte" height="40">
                </a>
            </div>
        </nav>

        <div class="container-fluid">
            <div class="row">
                <!-- Sidebar -->
                <div class="col-md-3 col-lg-2 p-4 panel ">
                    <div class="position-sticky" style="top: 90px; z-index: 1040;">
                        <h4 class="mb-4 ">Panel de Administración</h4>
                        <ul class="nav flex-column">
                            <li class="nav-item">
                                <a class="nav-link active" href="#">Dashboard</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#productos">Gestión de Productos</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#usuarios">Gestión de Usuarios</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#pedidos">Gestión de Pedidos</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#configuraciones">Configuraciones</a>
                            </li>
                        </ul>
                    </div>
                </div>

                <!-- Main Content -->
                <div class="col-md-9 col-lg-10 px-5 p-4">
                    <h1 class=" mb-4 custom-text-shadow" style="color:#8B4513">Panel de Administración</h1>
                    <div class="row mt-4">
                        <!-- Cards Section -->
                        <div class="col-md-4 mb-3">
                            <div class="card shadow-sm">
                                <div class="card-body">
                                    <h5 class="card-title">Total Productos</h5>
                                    <p class="card-text">5 productos</p>
                                    <a href="#" class="btn btn-gold">Ver Productos</a>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4 mb-3">
                            <div class="card shadow-sm">
                                <div class="card-body">
                                    <h5 class="card-title">Total Usuarios</h5>
                                    <p class="card-text">2 usuarios</p>
                                    <a href="#" class="btn btn-gold">Ver Usuarios</a>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4 mb-3">
                            <div class="card shadow-sm">
                                <div class="card-body">
                                    <h5 class="card-title">Pedidos pendientes</h5>
                                    <p class="card-text">3 pedidos</p>
                                    <a href="#" class="btn btn-gold">Ver pedidos</a>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Productos -->
                    <h3 class="mt-5" id="productos">Lista de Productos</h3>
                    <table class="table table-striped mt-3">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Nombre</th>
                                <th>Precio</th>
                                <th>Cantidad</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>1</td>
                                <td>Tarta grande</td>
                                <td>400 €</td>
                                <td>10</td>
                                <td>
                                    <button class="btn btn-warning btn-sm"><i class="fas fa-edit"></i> Editar</button>
                                    <button class="btn btn-danger btn-sm"><i class="fas fa-trash-alt"></i> Eliminar</button>
                                </td>
                            </tr>
                            <tr>
                                <td>2</td>
                                <td>Tarta pequeña</td>
                                <td>250 €</td>
                                <td>15</td>
                                <td>
                                    <button class="btn btn-warning btn-sm"><i class="fas fa-edit"></i> Editar</button>
                                    <button class="btn btn-danger btn-sm"><i class="fas fa-trash-alt"></i> Eliminar</button>
                                </td>
                            </tr>
                            <tr>
                                <td>3</td>
                                <td>Tarta mediana</td>
                                <td>350 €</td>
                                <td>5</td>
                                <td>
                                    <button class="btn btn-warning btn-sm"><i class="fas fa-edit"></i> Editar</button>
                                    <button class="btn btn-danger btn-sm"><i class="fas fa-trash-alt"></i> Eliminar</button>
                                </td>
                            </tr>
                        </tbody>
                    </table>

                    <!-- Usuarios -->
                    <h3 class="mb-4 mt-5" id="usuarios">Gestión de Usuarios</h3>
                    <div class="d-flex justify-content-between mb-3">
                       
                        <a href="ControladorRegistro" name="crear" class="btn btn-gold">Crear Usuario Nuevo</a>
                        
                    </div>

                    <c:if test="${not empty error}">
                        <div class="alert alert-danger">${error}</div>
                    </c:if>

                    <table class="table table-striped mt-3">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Nombre</th>
                                <th>Email</th>
                                <th>Dirección</th>
                                <th>Teléfono</th>
                                <th>Fecha Nacimiento</th>
                                <th>Género</th>
                                <th>Sabor Favorito</th>
                                <th>Puntos</th>
                                <th>Tipo</th>
                                <th>Comentarios</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="usuario" items="${usuarios}" varStatus="status">
                                <tr>
                                    <td>${usuario.id}</td>
                                    <td>${usuario.nombre}</td>
                                    <td>${usuario.email}</td>
                                    <td>${usuario.direccion}</td>
                                    <td>${usuario.telefono}</td>
                                    <td><fmt:formatDate value="${usuario.fechaNacimiento}" pattern="yyyy-MM-dd"/></td>
                                    <td>${usuario.genero}</td>
                                    <td>${usuario.saborFavorito}</td>
                                    <td>${usuario.puntos}</td>
                                    <td>${usuario.tipo}</td>
                                    <td>${usuario.comentarios}</td>
                                    <td>
                                        <a href="ControladorUsuario?id=${usuario.id}&editar=true" name="editar" class="btn btn-warning btn-sm mb-1">
                                            <i class="fas fa-edit"></i> Editar
                                        </a>
                                        <a href="ControladorUsuario?id=${usuario.id}&eliminar=true" name="eliminar" class="btn btn-danger btn-sm">
                                            <i class="fas fa-trash-alt"></i> Eliminar
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>

            <!-- Pedidos -->
            <h3 class="mt-5" id="pedidos">Lista de Pedidos</h3>
            <table class="table table-striped mt-3">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Tipo</th>
                        <th>Precio</th>
                        <th>Forma</th>
                        <th>Alérgenos</th>
                        <th>Usuario</th>
                        <th>Estado</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>1</td>
                        <td>Tarta grande</td>
                        <td>400 €</td>
                        <td>Dinosaurio</td>
                        <td>Sin lactosa</td>
                        <td>2</td>
                        <td>En proceso</td>
                        <td>
                            <button class="btn btn-info btn-sm"><i class="fas fa-eye"></i> Ver</button>
                            <button class="btn btn-warning btn-sm"><i class="fas fa-edit"></i> Editar</button>
                            <button class="btn btn-danger btn-sm"><i class="fas fa-trash-alt"></i> Eliminar</button>
                        </td>
                    </tr>
                    <tr>
                        <td>2</td>
                        <td>Tarta pequeña</td>
                        <td>250 €</td>
                        <td>Cohete</td>
                        <td>Sin alérgenos</td>
                        <td>2</td>
                        <td>Enviado</td>
                        <td>
                            <button class="btn btn-info btn-sm"><i class="fas fa-eye"></i> Ver</button>
                            <button class="btn btn-warning btn-sm"><i class="fas fa-edit"></i> Editar</button>
                            <button class="btn btn-danger btn-sm"><i class="fas fa-trash-alt"></i> Eliminar</button>
                        </td>
                    </tr>
                    <tr>
                        <td>3</td>
                        <td>Tarta mediana</td>
                        <td>350 €</td>
                        <td>Mariposa</td>
                        <td>Sin gluten</td>
                        <td>1</td>
                        <td>Finalizado</td>
                        <td>
                            <button class="btn btn-info btn-sm"><i class="fas fa-eye"></i> Ver</button>
                            <button class="btn btn-warning btn-sm"><i class="fas fa-edit"></i> Editar</button>
                            <button class="btn btn-danger btn-sm"><i class="fas fa-trash-alt"></i> Eliminar</button>
                        </td>
                    </tr>
                </tbody>
            </table>




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

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
