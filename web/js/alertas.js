// Alertas de SweetAlert

function confirmarEliminacion(event) {
    event.preventDefault();

    Swal.fire({
        title: '¿Estás seguro?',
        text: '¡Este producto será eliminado permanentemente!',
        icon: 'warning',
        showCancelButton: true,
        confirmButtonText: 'Sí, eliminar',
        cancelButtonText: 'Cancelar',
        confirmButtonColor: '#d33',
        cancelButtonColor: '#3085d6'
    }).then((result) => {
        if (result.isConfirmed) {
            event.target.submit();
        }
    });
}

function confirmarPedido(event) {
    event.preventDefault();

    Swal.fire({
        title: '¿Estás seguro?',
        text: '¡Estás a punto de confirmar el pedido!',
        icon: 'question',
        showCancelButton: true,
        confirmButtonText: 'Sí, confirmar',
        cancelButtonText: 'Cancelar',
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33'
    }).then((result) => {
        if (result.isConfirmed) {
            event.target.submit();
        }
    });
    return false;
}

function confirmarCancelacion(formulario) {
    Swal.fire({
        title: '¿Cancelar pedido?',
        text: "Esta acción no se puede deshacer.",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#d33',
        cancelButtonColor: '#3085d6',
        confirmButtonText: 'Sí, cancelar',
        cancelButtonText: 'No, mantener'
    }).then((result) => {
        if (result.isConfirmed) {
            formulario.submit();
        }
    });
}


function confirmarEliminacionUsuario(idUsuario) {
    Swal.fire({
        title: '¿Eliminar usuario?',
        text: "Esta acción no se puede deshacer.",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#d33',
        cancelButtonColor: '#3085d6',
        confirmButtonText: 'Sí, eliminar',
        cancelButtonText: 'Cancelar'
    }).then((result) => {
        if (result.isConfirmed) {
            // Redireccionar 
            window.location.href = `ControladorUsuario?id=` + idUsuario + `&eliminar=true`;
        }
    });
}


function confirmarEliminacionProducto(idProducto) {
    Swal.fire({
        title: '¿Eliminar producto?',
        text: "Esta acción no se puede deshacer.",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#d33',
        cancelButtonColor: '#3085d6',
        confirmButtonText: 'Sí, eliminar',
        cancelButtonText: 'Cancelar'
    }).then((result) => {
        if (result.isConfirmed) {
            window.location.href = 'ControladorProducto?id=' + idProducto + '&eliminar=true';
        }
    });
}

function confirmarEliminacionPedido(idPedido) {
    Swal.fire({
        title: '¿Eliminar pedido?',
        text: "Esta acción no se puede deshacer.",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#d33',
        cancelButtonColor: '#3085d6',
        confirmButtonText: 'Sí, eliminar',
        cancelButtonText: 'Cancelar'
    }).then((result) => {
        if (result.isConfirmed) {
            // Redirigir al controlador con el parámetro para eliminar
            window.location.href = `ControladorPedido?id=` + idPedido + `&eliminar=true`;
        }
    });
}



