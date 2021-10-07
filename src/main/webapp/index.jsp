<%-- 
    Document   : index.jsp
    Created on : 17/09/2021, 07:21:12 PM
    Author     : lalza
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous"/>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-/bQdsTh/da6pkI1MST/rWKFNjaCP5gBSY4sEBT38Q/9RBh9AH40zEOg7Hlq2THRZ" crossorigin="anonymous"></script>
        <script src = "http://ajax.googleapis.com/ajax/libs/angularjs/1.2.15/angular.min.js"></script>  
        <title>Producto</title>
    </head>
    <body>
        <div class="container-fluid" ng-app="ecommerce" ng-controller="productosControlador">
            <nav class="navbar navbar-expand-lg navbar-light bg-light">
                <div class="container-fluid">
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="navbarNav">
                        <ul class="navbar-nav">
                            <li class="nav-item">
                                <a class="nav-link active" aria-current="page" href="#">Inicio</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#" ng-click="mostrarFormulario()">Guardar productos</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#" ng-click="listarProducto()">Listar productos</a>
                            </li>
                        </ul>
                    </div>
                </div>
            </nav>
            <div class="container-fluid" ng-show="!mostrarListaProductos">
                <div class="row d-flex justify-content-center">
                    <div class="col-6" style="text-align: center" ng-show="!actualizar"><h1>Formulario de Productos</h1></div>
                    <div class="col-6" style="text-align: center" ng-show="actualizar"><h1>Actualizar Producto</h1></div>
                </div>
                <div class="row d-flex justify-content-center">
                    <div class="col-6">
                        <div class="mb-3">
                            <label for="exampleFormControlInput1" class="form-label">Código</label>
                            <input type="text" class="form-control" placeholder="Escriba el código" ng-model="codigo">
                        </div>
                        <div class="mb-3">
                            <label for="exampleFormControlInput1" class="form-label">Descripción</label>
                            <input type="text" class="form-control" placeholder="Escriba la descripción" ng-model="descripcion">
                        </div>
                        <label class="form-label">Estado</label>
                        <select class="form-select" aria-label="Default select example" ng-model="estado">
                            <option selected>Activo</option>
                            <option>Inactivo</option>
                        </select><br/>

                        <div class="mb-3">
                            <label for="exampleFormControlInput1" class="form-label">Cantidad</label>
                            <input type="text" class="form-control" placeholder="Escriba la cantidad" ng-model="cantidad">
                        </div>

                        <div class="mb-3">
                            <label for="exampleFormControlInput1" class="form-label">Valor compra</label>
                            <input type="text" class="form-control" placeholder="Escriba el valor de compra" ng-model="vlrCompra">
                        </div>
                        <div class="mb-3">
                            <label for="exampleFormControlInput1" class="form-label">Valor venta</label>
                            <input type="text" class="form-control" placeholder="Escriba el valor de vento" ng-model="vlrVenta">
                        </div>
                        <button type="button" class="btn btn-success" ng-show="!actualizar" ng-click="guardarProducto()">Guardar</button>
                        <button type="button" class="btn btn-success" ng-show="actualizar" ng-click="actualizarProducto()">Actualizar</button>
                    </div>
                </div>
            </div>
            <div class="container-fluid" ng-show="mostrarListaProductos">
                <div class="row d-flex justify-content-center">
                    <div class="col-6" style="text-align: center"><h1>Lista de productos</h1></div>
                </div>
                <table class="table">
                    <thead>
                        <tr>
                            <th scope="col">Código</th>
                            <th scope="col">Descripción</th>
                            <th scope="col">Estado</th>
                            <th scope="col">Cantidad</th>
                            <th scope="col">Valor Compra</th>
                            <th scope="col">Valor Venta</th>
                            <th scope="col">Actualizar</th>
                            <th scope="col">Borrar</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr ng-repeat="producto in productos">
                            <th scope="row">{{producto.codigo}}</th>
                            <td>{{producto.descripcion}}</td>
                            <td>{{producto.estado}}</td>
                            <td>{{producto.cantidad}}</td>
                            <td>{{producto.valorcompra}}</td>
                            <td>{{producto.valorventa}}</td>
                            <td style="cursor: pointer" ng-click="mostrarFormularioActualizar(producto)">Actualizar</td>
                            <td style="cursor: pointer" ng-click="abrirModal(producto.idProducto)">Borrar</td>  
                        </tr>
                    </tbody>
                </table>

                <!-- Modal -->
                <div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="staticBackdropLabel">Borrar producto</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                Está seguro que desea eliminar el producto?
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                                <button type="button" class="btn btn-primary" data-bs-dismiss="modal" ng-click="borrarProducto()">Eliminar</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
    <script src="productosCtrler.js"></script>
</html>
