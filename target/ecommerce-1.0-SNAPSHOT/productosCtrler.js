var app = angular.module('ecommerce', []);
app.controller('productosControlador', function($scope, $http){
    
    $scope.guardarProducto = function(){
        console.log('Entra guardar producto');
        let regexNumber = /^[0-9]*\d$/;
        if($scope.codigo === undefined || $scope.descripcion === undefined || $scope.estado === undefined || $scope.cantidad === undefined || $scope.vlrCompra === undefined || $scope.vlrVenta === undefined){
            alert("Todos los campos son obligatorios");
        }
        else if (regexNumber.test($scope.cantidad) === false) {
            alert("La cantidad debe ser numérico ");
        }
        else if (!regexNumber.test($scope.vlrCompra)) {
            alert("El valor de compra debe ser numérico ");
        }
        else if (!regexNumber.test($scope.vlrVenta)) {
            alert("El valor de venta debe ser numérico ");
        }        
        else{
            let producto = {
                proceso: 'RegistrarProducto',
                Codigo: $scope.codigo,
                Descripcion: $scope.descripcion,
                Estado: $scope.estado, 
                Cantidad: $scope.cantidad,
                ValorCompra: $scope.vlrCompra,
                ValorVenta: $scope.vlrVenta
            };

            $http({
                method: 'POST',
                url: 'peticionesProducto.jsp',
                params: producto
            }).then(function(respuesta){
                console.log(respuesta);
                alert("Guardado con éxito");
            });
        }
    };
    $scope.listarProducto = function(){
        $scope.mostrarListaProductos = true;
        let params = {
            proceso: 'ConsultarProductos'
        };
        $http({
                method: 'GET',
                url: 'peticionesProducto.jsp',
                params: params
            }).then(function(respuesta){
                //console.log(respuesta);
                $scope.productos = respuesta.data.Productos;
                console.log($scope.productos);
            });
    };
    
    $scope.borrarProducto = function () {
        let params = {
            proceso: 'EliminarProducto',
            idProducto: $scope.idParaEliminar
        }
        console.log(params);

        $http({
            method: 'GET',
            url: 'peticionesProducto.jsp',
            params: params
        }).then(function (respuesta) {
            console.log(respuesta);
            if (respuesta.data.borrarProducto) {
                alert("Borrado éxito");
                $scope.listarContactos();
            } else {
                alert("Falló al borrar contacto");
            }
        });
    };
    
    $scope.actualizarProducto = function () {
        let params = {
            proceso: 'ActualizarProducto',
                idProducto: $scope.idProducto,
                Codigo: $scope.codigo,
                Descripcion: $scope.descripcion,
                Estado: $scope.estado, 
                Cantidad: $scope.cantidad,
                ValorCompra: $scope.vlrCompra,
                ValorVenta: $scope.vlrVenta
        };
        console.log(params);
        $http({
            method: 'GET',
            url: 'peticionesProducto.jsp',
            params: params
        }).then(function (respuesta) {
            if (respuesta.data.ActualizarProducto) {
                alert("Producto actualizado exitosamente");
                $scope.listarProducto();
            } else {
                alert("Falló al actualizar producto");
            }
        });
    };
    
    $scope.mostrarFormulario = function () {
        $scope.mostrarListaProductos = false;
        $scope.actualizar = false;
        $scope.codigo = undefined;
        $scope.descripcion = undefined;
        $scope.estado = undefined;
        $scope.cantidad = undefined;
        $scope.vlrCompra = undefined;
        $scope.vlrVenta = undefined;
    };
    
    $scope.mostrarFormularioActualizar = function (producto) {
        $scope.mostrarListaProductos = false;
        $scope.actualizar = true;
        $scope.idProducto = producto.idProducto;
        $scope.codigo = producto.codigo;
        $scope.descripcion = producto.descripcion;
        $scope.estado = producto.estado;
        $scope.cantidad = producto.cantidad;
        $scope.vlrCompra = producto.valorcompra;
        $scope.vlrVenta = producto.valorventa;
    };
   
    
     $scope.abrirModal = function (idProducto) {
        $scope.idParaEliminar = idProducto;
        console.log(idProducto);
        var myModal = new bootstrap.Modal(document.getElementById('staticBackdrop'), {
            keyboard: false
        });
        myModal.show();
    }
    
});


