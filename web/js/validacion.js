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


// Mostrar y aceptar términos y condiciones
const leerTerminos = document.getElementById("leerTerminos");
const cerrarTerminos = document.getElementById("cerrarTerminos");

// Mostrar modal de términos y condiciones
leerTerminos.addEventListener('click', (e) => {
    e.preventDefault();
    // Muestra el modal de términos y condiciones
    modalTerminos.showModal();
});

// Cerrar modal
cerrarTerminos.addEventListener('click', () => {
    modalTerminos.close(); // Cierra el modal de términos y condiciones
});

// Event listener para el submit
var formulario = document.getElementById("formRegistro");
formulario.addEventListener('submit', (event) => {
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
        alert("Errores en el formulario:\n" + errores.join("\n"));
    } else {
        alert("Formulario enviado con éxito");
        formulario.submit();
    }
});
