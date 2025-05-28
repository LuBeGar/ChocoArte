let errores = [];

// Función para formatear el número de tarjeta de crédito en bloques de 4 dígitos separados por espacios
function formatearNumeroTarjeta() {
    const input = document.getElementById("numeroTarjeta");
    // Eliminar todos los espacios existentes
    let valor = input.value.replace(/\s+/g, '');
    // Insertar un espacio después de cada grupo de 4 dígitos, excepto al final
    valor = valor.replace(/(\d{4})(?=\d)/g, '$1 ');
    // Limitar la longitud total a 19 caracteres (16 dígitos + 3 espacios)
    input.value = valor.substring(0, 19);
}

// Función para formatear la fecha de expiración en formato MM/AA
function formatearFechaExpiracion() {
    const input = document.getElementById("fechaExpiracion");
    // Eliminar todo lo que no sean números
    let valor = input.value.replace(/\D/g, '');
    // Si hay más de dos dígitos, insertar una barra '/' después del mes
    if (valor.length > 2) {
        valor = valor.substring(0, 2) + '/' + valor.substring(2, 4);
    }
    // Limitar longitud a 5 caracteres (MM/AA)
    input.value = valor.substring(0, 5);
}

// Validar el nombre del titular: solo letras y espacios, mínimo 3 caracteres
function validarNombreTitular() {
    const input = document.getElementById("nombreTitular");
    const mensaje = "Nombre del titular inválido (solo letras y espacios)";
    const valor = input.value.trim();
    const errorElement = document.getElementById("errorNombreTitular");
    const esValido = /^[a-zA-ZáéíóúÁÉÍÓÚüÜñÑ\s]{3,}$/.test(valor);
    actualizarEstadoValidacion(input, errorElement, mensaje, esValido);
    return esValido;
}

// Validar número de tarjeta: debe contener exactamente 16 dígitos (sin espacios)
function validarNumeroTarjeta() {
    const input = document.getElementById("numeroTarjeta");
    const mensaje = "El número de tarjeta debe tener 16 dígitos";
    const valor = input.value.replace(/\s+/g, ''); // eliminar espacios
    const errorElement = document.getElementById("errorNumeroTarjeta");
    const esValido = /^\d{16}$/.test(valor);
    actualizarEstadoValidacion(input, errorElement, mensaje, esValido);
    return esValido;
}

// Validar fecha de expiración: formato MM/AA y que no esté expirada (fecha actual o posterior)
function validarFechaExpiracion() {
    const input = document.getElementById("fechaExpiracion");
    const mensaje = "Fecha inválida (formato MM/AA y no expirada)";
    const valor = input.value.trim();
    const errorElement = document.getElementById("errorFechaExpiracion");

    // Validar formato MM/AA
    let esValido = /^(0[1-9]|1[0-2])\/\d{2}$/.test(valor);

    if (esValido) {
        // Separar mes y año en dos variables (mes y anio) usando '/' como separador
        const [mes, anio] = valor.split('/');
        // Crear fecha con año 20XX y mes - 1 (mes empieza en 0)
        const fechaIngresada = new Date(`20${anio}`, mes - 1);
        const hoy = new Date();
        // Ajustar hoy al primer día del mes actual para comparación
        hoy.setHours(0, 0, 0, 0);
        hoy.setDate(1);

        // Validar que la fecha ingresada no sea anterior al mes actual
        esValido = fechaIngresada >= hoy;
    }

    actualizarEstadoValidacion(input, errorElement, mensaje, esValido);
    return esValido;
}

// Validar CVV: debe tener 3 o 4 dígitos numéricos
function validarCVV() {
    const input = document.getElementById("cvv");
    const mensaje = "El CVV debe tener 3 o 4 dígitos";
    const valor = input.value.trim();
    const errorElement = document.getElementById("errorCVV");

    const esValido = /^\d{3,4}$/.test(valor);
    actualizarEstadoValidacion(input, errorElement, mensaje, esValido);
    return esValido;
}

// Validar dirección solo si el tipo de entrega es "domicilio"
function validarDireccion() {
    if (document.getElementById("tipoEntrega").value !== "domicilio")
        return true;

    const input = document.getElementById("direccion");
    const mensaje = "La dirección es obligatoria para entrega a domicilio";
    const valor = input.value.trim();
    const errorElement = document.getElementById("errorDireccion");

    // Validar que la dirección tenga más de 5 caracteres
    const esValido = valor.length > 5;
    actualizarEstadoValidacion(input, errorElement, mensaje, esValido);
    return esValido;
}

// Función que actualiza el estado visual y mensajes de validación de un input y su mensaje de error
function actualizarEstadoValidacion(input, errorElement, mensaje, esValido) {
    if (esValido) {
        input.classList.remove("is-invalid");
        input.classList.add("is-valid");
        errorElement.textContent = "";
        // Quitar mensaje de error del array si ya es válido
        errores = errores.filter(e => e !== mensaje);
    } else {
        // Si no es válido 
        input.classList.remove("is-valid");
        input.classList.add("is-invalid");
        errorElement.textContent = mensaje;
        // Agregar mensaje al array si no está repetido
        if (!errores.includes(mensaje))
            errores.push(mensaje);
    }
}

// Mostrar u ocultar el campo de dirección dependiendo del tipo de entrega seleccionado
function mostrarDireccion() {
    const tipoEntrega = document.getElementById("tipoEntrega").value;
    const contenedor = document.getElementById("direccionContainer");
    const direccionInput = document.getElementById("direccion");

    if (tipoEntrega === "domicilio") {
        contenedor.style.display = "block";
        direccionInput.required = true;
        direccionInput.disabled = false;
        // Si es en tienda
    } else {
        contenedor.style.display = "none";
        direccionInput.required = false;
        direccionInput.disabled = true;
        direccionInput.value = '';
    }
}

// Validar todo el formulario, llamando a cada función de validación, y limpiar el array de errores
function validarFormularioCompleto() {
    errores = [];

    const camposValidos = [
        validarNombreTitular(),
        validarNumeroTarjeta(),
        validarFechaExpiracion(),
        validarCVV(),
        validarDireccion()
    ];

    // Devuelve true solo si todos los campos son válidos
    return camposValidos.every(Boolean);
}

// Maneja el evento de envío del formulario de confirmación de pedido
function manejarEnvioFormulario(e) {
    e.preventDefault();

    if (validarFormularioCompleto()) {
        // Verificar que haya productos en la tabla del pedido
        const tablaProductos = document.querySelector("table tbody");
        if (!tablaProductos || tablaProductos.rows.length === 0) {
            alert("No hay productos en el pedido. Agrega al menos un producto antes de confirmar");
            return;
        }
    } else {
        alert("Por favor corrige los siguientes errores:\n\n" + errores.join("\n"));
    }
}

