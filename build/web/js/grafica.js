// Para la gráfica

Highcharts.chart('containerProductos', {
    chart: {
        type: 'column',
        options3d: {
            enabled: true,
            alpha: 10,
            beta: 25,
            depth: 70
        }
    },
    title: {
        text: 'Productos más vendidos'
    },
    xAxis: {
        type: 'category',
        labels: {
            skew3d: true,
            style: {
                fontSize: '14px'
            }
        }
    },
    yAxis: {
        title: {
            text: 'Cantidad vendida',
            margin: 20
        }
    },
    tooltip: {
        valueSuffix: ' unidades'
    },
    series: [{
            name: 'Cantidad',
            data: datosProductos
        }]
});
