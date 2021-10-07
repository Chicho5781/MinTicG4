<%-- 
    Document   : peticionesProducto
    Created on : 22/09/2021, 06:14:07 PM
    Author     : lalza
--%>

<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.List"%>
<%@page import="logica.Producto"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<% 
String respuesta = "{";
String proceso = request.getParameter("proceso"); //request HTTP  
//a los request se les puede pasar parámetros
//se va a validar el tipo de proceso
Producto c = new Producto(); //se piden los parámetros del contacto que se quiere guardar
switch(proceso){
    case "RegistrarProducto":
        System.out.println("Guardar Producto");
        c.setCodigo(request.getParameter("Codigo"));
        c.setDescripcion(request.getParameter("Descripcion"));
        c.setEstado(request.getParameter("Estado"));
        c.setCantidad(Integer.parseInt(request.getParameter("Cantidad")));          //Convertirlo de entero a string
        c.setValorcompra(Float.parseFloat(request.getParameter("ValorCompra")));    //Convertirlo de float a string
        c.setValorventa(Float.parseFloat(request.getParameter("ValorVenta")));      //Convertirlo de float a string
        if(c.RegistrarProducto()){
            //si guarda bien el contacto, se concatena otros datos para el json
            respuesta += "\"" + proceso + "\": true";  // el \ se usa para concatenar en json indicando que se hizo el proceso (true)
        } else{
            respuesta += "\"" + proceso + "\": false";  // el \ se usa para concatenar en json indicando que NO se hizo el proceso (false)
        }
        break;
        
    case "ActualizarProducto":
        System.out.println("Actualizar Producto");
        c.setIdProducto(Integer.parseInt(request.getParameter("idProducto")));
        c.setCodigo(request.getParameter("Codigo"));
        c.setDescripcion(request.getParameter("Descripcion"));
        c.setEstado(request.getParameter("Estado"));
        c.setCantidad(Integer.parseInt(request.getParameter("Cantidad")));          //Convertirlo de entero a string
        c.setValorcompra(Float.parseFloat(request.getParameter("ValorCompra")));    //Convertirlo de float a string
        c.setValorventa(Float.parseFloat(request.getParameter("ValorVenta")));      //Convertirlo de float a string

        if(c.ActualizarProducto()){
            //si guarda bien el contacto, se concatena otros datos para el json
            respuesta += "\"" + proceso + "\": true";  // el \ se usa para concatenar en json indicando que se hizo el proceso (true)
        } else{
            respuesta += "\"" + proceso + "\": false";  // el \ se usa para concatenar en json indicando que NO se hizo el proceso (false)
        }
        break;

    case "EliminarProducto":
        System.out.println("Eliminar Producto");
        int idproducto = Integer.parseInt(request.getParameter("idProducto"));
        if(c.EliminarProducto(idproducto)){
            respuesta += "\"" + proceso + "\": true";  // el \ se usa para concatenar en json indicando que se hizo el proceso (true)
        } else{
            respuesta += "\"" + proceso + "\": false";  // el \ se usa para concatenar en json indicando que NO se hizo el proceso (false)
        }
        
        break;

    case "ConsultarProductos":
        System.out.println("Consultar Productos");
        List<Producto> listaProductos = c.ConsultarProductos();
        if(listaProductos.isEmpty()){
            respuesta += "\"" + proceso + "\": false,\"Productos\":[]"; //genera una lista vacía en el json
        } else{
            respuesta += "\"" + proceso + "\": true,\"Productos\":" + new Gson().toJson(listaProductos); //guarda la lista en el json
        }
        break;

    case "SeleccionarProducto":
        System.out.println("Seleccionar Productos");
        break;
        
    default:
        respuesta += "\"ok\": false,";
        respuesta += "\"error\": \"INVALID\",";
        respuesta += "\"errorMsg\": \"Lo sentimos, los datos que ha enviado,"
                + " son inválidos. Corrijalos y vuelva a intentar por favor.\"";
}
// cierra la respuesta
respuesta += "}";
response.setContentType("application/json;charset=iso-8859-1");
out.print(respuesta);
        

%>

