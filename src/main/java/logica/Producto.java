/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package logica;

import java.util.ArrayList;
import java.util.List;
import persistencia.ConexionBD;
import java.sql.ResultSet;
import java.sql.SQLException;
/**
 *
 * @author lalza
 */
public class Producto {
    private int idProducto;
    private String codigo;
    private String descripcion;
    private String estado;
    private int cantidad;
    private float valorcompra;
    private float valorventa;

    public int getIdProducto() {
        return idProducto;
    }

    public void setIdProducto(int idProducto) {
        this.idProducto = idProducto;
    }

    public String getCodigo() {
        return codigo;
    }

    public void setCodigo(String codigo) {
        this.codigo = codigo;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public String isEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }

    public float getValorcompra() {
        return valorcompra;
    }

    public void setValorcompra(float valorcompra) {
        this.valorcompra = valorcompra;
    }

    public float getValorventa() {
        return valorventa;
    }

    public void setValorventa(float valorventa) {
        this.valorventa = valorventa;
    }
    
    public Producto() {
    }
    
    public boolean RegistrarProducto()
    {
        // El campo Cantidad no se graba debido a que este campo se actualiza en el movimiento de productos
        ConexionBD conexion = new ConexionBD();
        //String sentencia = "INSERT INTO productos(Codigo, Descripcion, Estado)"
        //        + " VALUES ( '" + this.codigo + "','" + this.descripcion + "'" + this.cantidad + "');  ";

        String sentencia = "INSERT INTO productos(Codigo, Descripcion, Estado, Cantidad, ValorCompra, ValorVenta)"
               + " VALUES ( '" + this.codigo + "','" + this.descripcion + "',"
               + "'" + this.estado + "','" + this.cantidad + "','" + this.valorcompra + "','" + this.valorventa +  "');  ";

        //Se configura el setAutocommit de la conexionBD a falso
        if(conexion.setAutoCommitBD(false)){
            if(conexion.insertarBD(sentencia)){
                conexion.commitBD();
                conexion.closeConnection();
                return true;
            } else{ //si no logro insertar en la BD
                conexion.rollbackBD();
                conexion.closeConnection();
                return false;
            }
        } else{
            conexion.closeConnection();
            return false;
        }
    }

    public boolean EliminarProducto(int idProducto)
    {
        ConexionBD conexion = new ConexionBD();
        String sentencia = "DELETE FROM productos WHERE idproducto = '" + idProducto + "'";
        if(conexion.setAutoCommitBD(false)){
            if(conexion.borrarBD(sentencia)){
                conexion.commitBD();
                conexion.closeConnection();
                return true;
            } else{
                conexion.rollbackBD();
                conexion.closeConnection();
                return false;
            }
        } else {
            conexion.closeConnection();
            return false;
        }
    }

    public boolean ActualizarProducto()
    {
        ConexionBD conexion = new ConexionBD();
        String sentencia = "UPDATE `productos` SET Codigo='" + this.codigo + "',Descripcion='" + this.descripcion + "',Estado='" + this.estado
                + "',Cantidad='" + this.cantidad + "',ValorCompra='" + this.valorcompra + "',ValorVenta='" + this.valorventa 
                +  "' WHERE idProducto=" + this.idProducto + ";";

        if(conexion.setAutoCommitBD(false)){
            if(conexion.actualizarBD(sentencia)){
                conexion.commitBD();
                conexion.closeConnection();
                return true;
            } else{
                conexion.rollbackBD();
                conexion.closeConnection();
                return false;
            }
           
        } else{
            conexion.closeConnection();
            return false;
        }
    }

    public List<Producto> ConsultarProductos() throws SQLException
    {
        ConexionBD conexion = new ConexionBD();
        String sentencia = "SELECT * FROM productos ORDER BY descripcion ASC;";
        List<Producto> listaProductos = new ArrayList<>();
        ResultSet datos = conexion.consultarBD(sentencia);
        
        Producto producto;
        while (datos.next()) {
            producto = new Producto();
            producto.setIdProducto(datos.getInt("idProducto"));
            producto.setCodigo(datos.getString("Codigo"));
            producto.setDescripcion(datos.getString("Descripcion"));
            producto.setEstado(datos.getString("Estado"));
            producto.setCantidad(datos.getInt("Cantidad"));
            producto.setValorcompra(datos.getFloat("ValorCompra"));
            producto.setValorventa(datos.getFloat("ValorVenta"));
            listaProductos.add(producto);
            
        }
        conexion.closeConnection();
        return listaProductos;
    }

    public Producto SeleccionarProducto(int idProducto) throws SQLException
    {
        ConexionBD conexion = new ConexionBD();
        String sentencia = "SELECT * FROM producto WHERE idProducto = '" + idProducto + "';";
        ResultSet datos = conexion.consultarBD(sentencia);
        if(datos.next()){
            Producto producto = new Producto();
            producto.setIdProducto(datos.getInt("idProducto"));
            producto.setCodigo(datos.getString("Codigo"));
            producto.setDescripcion(datos.getString("Descripcion"));
            producto.setEstado(datos.getString("Estado"));
            producto.setCantidad(datos.getInt("Cantidad"));
            producto.setValorcompra(datos.getFloat("ValorCompra"));
            producto.setValorventa(datos.getFloat("ValorVenta"));
            return producto;
        } else{
            conexion.closeConnection();
            return null; //no había contacto
        }
    }
}

