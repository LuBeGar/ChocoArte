// Validación del formulario de personalización
document.addEventListener('DOMContentLoaded', function () {
    const form = document.getElementById('formPersonalizacion');
    const alergenosSelect = document.getElementById('alergenos');
    const otrosDiv = document.getElementById('otrosAlergenosDiv');
    const otrosInput = document.getElementById('otrosAlergenos');

    // Manejo dinámico de alérgenos
    alergenosSelect.addEventListener('change', function () {
        if (this.value === 'otros') {
            otrosDiv.style.display = 'block';
            otrosInput.removeAttribute('disabled');
            otrosInput.setAttribute('required', 'required');
        } else {
            otrosDiv.style.display = 'none';
            otrosInput.value = '';
            otrosInput.setAttribute('disabled', 'disabled');
            otrosInput.removeAttribute('required');
            otrosInput.classList.remove('is-invalid');
        }
    });

    // Validación del formulario
    form.addEventListener('submit', function (event) {
        // Validación Bootstrap
        if (!form.checkValidity()) {
            event.preventDefault();
            event.stopPropagation();
        }

        form.classList.add('was-validated');
    });
});

