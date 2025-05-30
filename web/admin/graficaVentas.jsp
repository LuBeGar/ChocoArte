<%-- 
    Document   : graficaVentas
    Created on : 25 may 2025, 0:58:47
    Author     : Lu
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html; charset=ISO-8859-15" pageEncoding="ISO-8859-15" %>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Productos más vendidos - Admin ChocoArte</title>

<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="css/estilos.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

<script>
    // Datos para la gráfica de productos más vendidos
    datosProductos = [
    <c:forEach var="entry" items="${productosMasVendidos}" varStatus="status">
    ['${entry.key}', ${entry.value}]${status.last ? "" : ","}
    </c:forEach>
    ];
</script>

<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/highcharts-3d.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<script src="https://code.highcharts.com/modules/export-data.js"></script>
<script src="https://code.highcharts.com/modules/accessibility.js"></script>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-light bg-white shadow-sm position-sticky" style="top: 0; z-index: 1050;">
        <div class="container d-flex justify-content-between align-items-center">
            <!-- Logo -->
            <a class="navbar-brand" href="index.html">
                <img src="img/conejo.png" alt="ChocoArte" height="40">
            </a>

            <!-- Menú usuario -->
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
                                    <li><a class="dropdown-item" href="ControladorUsuario"><i class="fas fa-box me-1"></i>Menú de administración</a></li>
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
                    <div class="d-flex gap-2">
                        <a href="ControladorLogin" class="btn btn-outline-primary"><i class="fas fa-sign-in-alt me-1"></i> Iniciar sesión</a>
                        <a href="ControladorRegistro" class="btn btn-outline-success"><i class="fas fa-user-plus me-1"></i> Registrarse</a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </nav>

    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <div class="col-md-3 col-lg-2 p-4 panel">
                <div class="position-sticky" style="top: 90px; z-index: 1040;">
                    <h4 class="mb-4">Panel de Administración</h4>
                    <ul class="nav flex-column">
                        <li class="nav-item"><a class="nav-link" href="ControladorUsuario">Gestión de Usuarios</a></li>
                        <li class="nav-item"><a class="nav-link" href="ControladorProducto">Gestión de Productos</a></li>
                        <li class="nav-item"><a class="nav-link" href="ControladorPedido">Gestión de Pedidos</a></li>
                        <li class="nav-item"><a class="nav-link" href="ControladorVentas" style="color:#b68d40">Estadísticas de ventas</a></li>
                    </ul>
                </div>
            </div>

            <!-- Contenido principal -->
            <div class="col-md-9 col-lg-10 p-4">
                <h1 class="my-4 custom-text-shadow" style="color:#8B4513">Productos Más Vendidos</h1>
                <form method="GET" action="${pageContext.request.contextPath}/ControladorVentas" class="row g-3 mb-4 align-items-end">
                    <div class="col-md-4">
                        <label for="fechaInicio" class="form-label">Fecha Inicio:</label>
                        <input type="date" id="fechaInicio" name="fechaInicio" value="${param.fechaInicio}" class="form-control">
                    </div>
                    <div class="col-md-4">
                        <label for="fechaFin" class="form-label">Fecha Fin:</label>
                        <input type="date" id="fechaFin" name="fechaFin" value="${param.fechaFin}" class="form-control">
                    </div>
                    <div class="col-md-4">
                        <button type="submit" class="btn btn-gold w-100"><i class="fas fa-filter me-1"></i> Filtrar</button>
                    </div>
                </form>

                <figure class="highcharts-figure mb-5">
                    <div id="containerProductos" style="height: 400px;"></div>
                </figure>

                <h2>Listado de Productos Vendidos</h2>

                <table class="table table-striped table-bordered mt-3">
                    <thead class="table-gold">
                        <tr>
                            <th>Producto</th>
                            <th>Cantidad Vendida</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="producto" items="${productosMasVendidos}">
                            <tr>
                                <td>${producto.key}</td>
                                <td>${producto.value}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

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
    <script src="js/grafica.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>