// Función para mostrar el campo de "Otros" alérgenos
function toggleOtros() {
    var alergenosSelect = document.getElementById('alergenos');
    var otrosAlergenosInput = document.getElementById('otrosAlergenos');
    var otrosAlergenosDiv = document.getElementById('otrosAlergenosDiv');

    if (alergenosSelect.value === 'otros') {
        otrosAlergenosDiv.style.display = 'block';
        otrosAlergenosInput.disabled = false;
        otrosAlergenosInput.required = true;
    } else {
        otrosAlergenosDiv.style.display = 'none';
        otrosAlergenosInput.disabled = true;
        otrosAlergenosInput.required = false;
        otrosAlergenosInput.value = '';
    }

    // Validar el campo al cambiar
    validateField(alergenosSelect);
}

// Validación de campos individuales
function validateField(field) {
    if (field.checkValidity()) {
        field.classList.remove('is-invalid');
        field.classList.add('is-valid');
    } else {
        field.classList.remove('is-valid');
        field.classList.add('is-invalid');
    }
}

// Validación de formulario
(function () {
    'use strict';

    // Obtener el formulario
    var form = document.getElementById('formPersonalizacion');

    // Validar campos al perder el foco
    var inputs = form.querySelectorAll('input, select, textarea');
    inputs.forEach(function (input) {
        input.addEventListener('blur', function () {
            validateField(this);
        });
    });

    // Validar al enviar
    form.addEventListener('submit', function (event) {
        if (!form.checkValidity()) {
            event.preventDefault();
            event.stopPropagation();

            // Validar todos los campos para mostrar feedback
            inputs.forEach(function (input) {
                validateField(input);
            });
        }

        form.classList.add('was-validated');
    }, false);

    // Validar el select de alérgenos al cargar
    document.getElementById('alergenos').addEventListener('change', function () {
        validateField(this);
    });
})();

function mostrarDireccion() {
    var tipoEntrega = document.getElementById("tipoEntrega").value;
    var contenedor = document.getElementById("direccionContainer");
    var direccionInput = document.getElementById("direccion");

    if (tipoEntrega === "domicilio") {
        contenedor.style.display = "block";
        direccionInput.required = true;
        direccionInput.disabled = false;
    } else {
        contenedor.style.display = "none";
        direccionInput.required = false;
        direccionInput.disabled = true;
        direccionInput.value = ''; 
    }
}

