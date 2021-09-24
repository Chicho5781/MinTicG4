/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package persistencia;

/*import java.sql.Connection;*/
import java.sql.*;          /* Trae todo lo que tiene la librería */
import java.util.logging.Level;
import java.util.logging.Logger;

/*
  * @author lalza
 */
public class ConexionBD {
    private String DBDriver ="";
    private String url = "";            // URL para acceder a MySQL: concatena datos    
    private String db = "";             // Esquema base de datos                        
    private String host = "";           // Base de datos local: sería localhost         
    private String username = "root";   // Usuario                                      
    private String password = "ACLS";   // Password asignado en la instalación          
    public Connection conexion = null;  
    private ResultSet rs = null;        //atributo que retorne la consulta de la DB
    private Statement stmt = null;      //para ejecutar queries (sentencias)

public ConexionBD() {
        host = "localhost:3306"; //BD local
        db = "bdecommerce";
        url = "jdbc:mysql://" + host + "/" + db;
        username = "root";
        password = "ACLS";
        
        DBDriver = "com.mysql.jdbc.Driver";
        //Siempreo que se realice algo en la BD se hace en un bloque try/catch
        try {
            Class.forName(DBDriver); //Se asigna el driver
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ConexionBD.class.getName()).log(Level.SEVERE, null, ex);
            System.out.println("Error al asignar driver");
        }
        
        //Conectar a la BD
        try {
            conexion = DriverManager.getConnection(url,username,password); 
            System.out.println("Conexion exitosa");
                  
        } catch (SQLException ex) {
            Logger.getLogger(ConexionBD.class.getName()).log(Level.SEVERE, null, ex);
            System.out.println("Error al conectar la BD");
        }

    }
    
    // Retornar conexión a BD
    public Connection getConnection(){
        return conexion;
    }
    
    //Cierra conexión a BD
    public void closeConnection(){
        if(conexion != null){ //se valida si hay una conexión, si es nulo da un null pointer exception
            try {
                conexion.close();
            } catch (SQLException ex) {
                Logger.getLogger(ConexionBD.class.getName()).log(Level.SEVERE, null, ex);
                System.out.println("Error al cerra la conexion");
            }
        }
    }
    
    //Vamos a hacer un CRUD, se necesita un método para C/u de estos
    //Consultar datos en BD
    public ResultSet consultarBD(String sentencia){
        //en sentencia se envia el codigo SQL
        try {
            stmt = conexion.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY); 
            rs = stmt.executeQuery(sentencia);
        } catch (SQLException | RuntimeException ex) {
            Logger.getLogger(ConexionBD.class.getName()).log(Level.SEVERE, null, ex);
            System.out.println("Error al hacer una consulta");
        }
        return rs;
    }
    
    //Insertar
    public boolean insertarBD(String sentencia){
        try {
            stmt = conexion.createStatement();
            stmt.execute(sentencia);
            return true;
        } catch (SQLException | RuntimeException ex) {
            Logger.getLogger(ConexionBD.class.getName()).log(Level.SEVERE, null, ex);
            System.out.println("Error al insertar en la BD");
            return false;
        }
    }
    
    //Borrar
    public boolean borrarBD(String sentencia){
        try {
            stmt = conexion.createStatement();
            stmt.execute(sentencia);
            return true;
        } catch (SQLException | RuntimeException ex) {
            Logger.getLogger(ConexionBD.class.getName()).log(Level.SEVERE, null, ex);
            System.out.println("Error al borrar en la BD");
            return false;
        }
    }
    
    //Actualizar
    public boolean actualizarBD(String sentencia){
            try {
            stmt = conexion.createStatement();
            stmt.execute(sentencia);
            return true;
        } catch (SQLException | RuntimeException ex) {
            Logger.getLogger(ConexionBD.class.getName()).log(Level.SEVERE, null, ex);
            System.out.println("Error al actualizar en la BD");
            return false;
        }
}
    
    public boolean setAutoCommitBD(boolean commit){
        try {
            conexion.setAutoCommit(commit);
            return true;
        } catch (SQLException | RuntimeException ex) {
            System.out.println("Error en set Autocommit");
            return false;
        }
    }
    
    public boolean commitBD(){
        try {
            conexion.commit();
            return true;
        } catch (SQLException | RuntimeException ex) {
            System.out.println("Error en commit a la BD");
            return false;
        }
    }
    
    public boolean rollbackBD(){
            try {
            conexion.rollback();
            return true;
        } catch (SQLException | RuntimeException ex) {
            System.out.println("Error en rollback a la BD");
           return false;
        }
    }
}