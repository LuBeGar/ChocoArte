var errores = [];

function validarUsuario() {
    var usuario = document.getElementById("nombre").value.trim();
    let mensaje = "El nombre de usuario solo puede contener letras";
    if (!/^[a-zA-ZáéíóúÁÉÍÓÚüÜñÑ]+$/.test(usuario)) {
        document.getElementById("errorUsuario").textContent = mensaje;
        if (!errores.includes(mensaje)) {
            errores.push(mensaje);
        }
    } else {
        let indice = errores.indexOf(mensaje);
        if (indice !== -1) {
            errores.splice(indice, 1);
        }
        document.getElementById("errorUsuario").textContent = "";
    }
}

function validarEmail() {
    var email = document.getElementById("email").value.trim();
    let mensaje = "El correo electrónico no tiene un formato válido";
    if (!email.match(/^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$/)) {
        document.getElementById("errorEmail").textContent = mensaje;
        if (!errores.includes(mensaje)) {
            errores.push(mensaje);
        }
    } else {
        let indice = errores.indexOf(mensaje);
        if (indice !== -1) {
            errores.splice(indice, 1);
        }
        document.getElementById("errorEmail").textContent = "";
    }
}

function validarPass() {
    var password = document.getElementById("password").value.trim();
    let mensaje = "La contraseña debe tener entre 8 y 16 caracteres y contener al menos una mayúscula, minúscula, número y carácter especial";
    if (password.length < 8 || password.length > 16 || !password.match(/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[-@_!#$%&])[A-Za-z\d@!#$%&-]{8,}$/)) {
        document.getElementById("errorPass").textContent = mensaje;
        if (!errores.includes(mensaje)) {
            errores.push(mensaje);
        }
    } else {
        let indice = errores.indexOf(mensaje);
        if (indice !== -1) {
            errores.splice(indice, 1);
        }
        document.getElementById("errorPass").textContent = "";
    }
}

function validarConfirmar() {
    var confirmarPassword = document.getElementById("confirmarPassword").value.trim();
    var password = document.getElementById("password").value.trim();
    let mensaje = "Las contraseñas no coinciden";
    if (password !== confirmarPassword) {
        document.getElementById("errorConfirmar").textContent = mensaje;
        if (!errores.includes(mensaje)) {
            errores.push(mensaje);
        }
    } else {
        let indice = errores.indexOf(mensaje);
        if (indice !== -1) {
            errores.splice(indice, 1);
        }
        document.getElementById("errorConfirmar").textContent = "";
    }
}

function validarTelefono() {
    var telefono = document.getElementById("telefono").value.trim();
    let mensaje = "El teléfono debe contener exactamente 9 números";
    if (!telefono.match(/^\d{9}$/)) {
        document.getElementById("errorTelefono").textContent = mensaje;
        if (!errores.includes(mensaje)) {
            errores.push(mensaje);
        }
    } else {
        let indice = errores.indexOf(mensaje);
        if (indice !== -1) {
            errores.splice(indice, 1);
        }
        document.getElementById("errorTelefono").textContent = "";
    }
}

function validarFecha() {
    var fecha = document.getElementById("fechaNacimiento").value;
    let mensajeError1 = "Debe seleccionar una fecha de nacimiento válida";
    let mensajeError2 = "La fecha de nacimiento debe ser anterior a la fecha actual";
    var errorFecha = document.getElementById("errorFecha");
    var errorFecha2 = document.getElementById("errorFecha2");
    if (!fecha) {
        errorFecha.textContent = mensajeError1;
        if (!errores.includes(mensajeError1)) {
            errores.push(mensajeError1);
        }
    } else {
        let indice = errores.indexOf(mensajeError1);
        if (indice !== -1) {
            errores.splice(indice, 1);
        }
        document.getElementById("errorFecha").textContent = "";
    }

    var fechaNacimiento = new Date(fecha);
    var hoy = new Date();
    if (fechaNacimiento >= hoy) {
        errorFecha2.textContent = mensajeError2;
        if (!errores.includes(mensajeError2)) {
            errores.push(mensajeError2);
        }
    } else {
        let indice2 = errores.indexOf(mensajeError2);
        if (indice2 !== -1) {
            errores.splice(indice2, 1);
        }
        document.getElementById("errorFecha2").textContent = "";
    }
}

function validarGenero() {
    var genero = document.querySelector("input[name='genero']:checked");
    let mensaje = "Debe seleccionar un género";
    if (!genero) {
        document.getElementById("errorGenero").textContent = mensaje;
        if (!errores.includes(mensaje)) {
            errores.push(mensaje);
        }
    } else {
        let indice = errores.indexOf(mensaje);
        if (indice !== -1) {
            errores.splice(indice, 1);
        }
        document.getElementById("errorGenero").textContent = "";
    }
}

function validarSabor() {
    var sabor = document.getElementById("sabor").value;
    let mensaje = "Debe seleccionar un sabor";
    if (!sabor) {
        document.getElementById("errorSabor").textContent = mensaje;
        if (!errores.includes(mensaje)) {
            errores.push(mensaje);
        }
    } else {
        let indice = errores.indexOf(mensaje);
        if (indice !== -1) {
            errores.splice(indice, 1);
        }
        document.getElementById("errorSabor").textContent = "";
    }
}

function validarTerminos() {
    var terminos = document.getElementById("terminos");
    let mensaje = "Debe aceptar los términos y condiciones";
    if (!terminos.checked) {
        document.getElementById("errorTerminos").textContent = mensaje;
        if (!errores.includes(mensaje)) {
            errores.push(mensaje);
        }
    } else {
        let indice = errores.indexOf(mensaje);
        if (indice !== -1) {
            errores.splice(indice, 1);
        }
        document.getElementById("errorTerminos").textContent = "";
    }
}

document.getElementById("leerTerminos").addEventListener("click", function (e) {
    e.preventDefault();
    Swal.fire({
        title: 'Términos y Condiciones',
        html: `<div style="text-align:left; max-height:300px; overflow-y:auto; padding: 0 10px;">

    <p>Al realizar un pedido con <strong>ChocoArte</strong>, el cliente acepta los siguientes Términos y Condiciones. Es responsabilidad del cliente leer y entender este documento antes de confirmar una compra.</p>

    <h4>1. Productos Personalizados</h4>
    <ul>
        <li>Todas nuestras tartas son hechas a mano y personalizadas según los requisitos proporcionados por el cliente.</li>
        <li>El diseño final puede variar ligeramente.</li>
        <li>En caso de alergias o restricciones alimentarias, el cliente debe informarnos al realizar el pedido. En caso contrario, no nos haremos responsables por reacciones alérgicas.</li>
        <li>Todos los pedidos deben realizarse con al menos <strong>10</strong> días de antelación.</li>
    </ul>

    <h4>2. Cancelaciones y Reembolsos</h4>
    <ul>
        <li>No se aceptan devoluciones por productos personalizados ya entregados.</li>
        <li>En caso de error por parte de la empresa, se ofrecerá una solución razonable (reembolso parcial o repetición del producto).</li>
    </ul>

    <h4>3. Entregas y Recogidas</h4>
    <ul>
        <li>No nos responsabilizamos por retrasos debido a factores externos (clima, tráfico, etc.).</li>
        <li>Una vez entregado el producto o recogido por el cliente, no nos responsabilizamos por daños causados por manipulación incorrecta o transporte.</li>
    </ul>

    <h4>4. Derechos de Imagen</h4>
    <p>Podemos tomar fotografías de los productos realizados para su uso en nuestras redes sociales, sitio web u otros fines publicitarios. </p>

    <h4>5. Contacto</h4>
    <p>Para cualquier duda, sugerencia o reclamo, puedes contactarnos en:</p>
    <ul>
        <li><strong>Email:</strong> info@chocoarte.com</a></li>
        <li><strong>Teléfono:</strong> +34 900 123 456</li>
    </ul>
               </div>`,
        icon: 'info',
        confirmButtonText: 'Cerrar',
        width: '600px'
    });
});

var formulario = document.getElementById("formRegistro");
formulario.addEventListener('submit', function (event) {
    event.preventDefault();

    errores = [];

    validarUsuario();
    validarEmail();
    validarPass();
    validarConfirmar();
    validarTelefono();
    validarFecha();
    validarGenero();
    validarSabor();
    validarTerminos();

    if (errores.length > 0) {
        Swal.fire({
            icon: 'error',
            title: 'Errores en el formulario',
            html: errores.map(e => `<p>${e}</p>`).join(''),
            confirmButtonText: 'Revisar'
        });
    } else {
        Swal.fire({
            icon: 'success',
            title: 'Formulario enviado con éxito',
            confirmButtonText: 'Aceptar'
        }).then(() => formulario.submit());
    }
});