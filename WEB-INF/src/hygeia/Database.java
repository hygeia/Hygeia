package hygeia;

import java.sql.*;

/* Class for maintaining connection to database */
public class Database {

    private String address = "localhost";
    private int port = 3306;
    private String username = "hygeiadb";
    private String pwd = "C1rcleofL!fe";
    private String name = "hygeia3";
    
    private Connection con;
    private Statement stmt;
    
    /* Creates a connected database object */
    public Database() {
        this.connect();
    }
    
    /* TEST */
    public static void main(String args[]) {
        Database db = new Database();
        System.out.print(db.isAlive() + "\n");
        
        ResultSet rs = db.execute("select * from users;");
        System.out.print(rs + "\n");
        
        System.out.print(db.close() + "\n");
    }
    
    /* Initiates connection to database */
    public boolean connect() {
        String conString = "jdbc:mysql://" + this.address + ":" + this.port +
            "/" + this.name +"?user=" + this.username + "&password=" + 
            this.pwd;
        try {
            this.con = DriverManager.getConnection(conString);
            if (this.con != null) {
                return true;
            } else {
                return false;
            }
        } catch (SQLException e) {
            System.out.print("Connection exception\n");
            e.printStackTrace();
            return false;
        }
    }
    
    /* Close connection to database */
    public boolean close() {
        if (this.con == null) {
            return true;
        }
        
        try {
            this.con.commit();
            this.con.close();
        } catch (SQLException e) {
            return false;
        }
        this.con = null;
        return true;
    }
    
    /* Free up db resources after analyzing ResultSet. Does not close db. */
    public boolean free() {
        if (this.stmt == null) {
            return false;
        }
        try {
            this.stmt.close();
        } catch (SQLException e) {
            return false;
        }
        return true;
    }
    
    /* Checks if connection exists */
    public boolean isAlive() {
        if (this.con == null) {
            return false;
        }
        return true;
    }
    
    /* Executes a query (select only) and returns results */
    public ResultSet execute(String query) {
        if (query == null) {
            return null;
        }
        if (this.con == null) {
            return null;
        }
        try {
            this.stmt = this.con.createStatement();
            if (this.stmt == null) {
                System.out.print("Couldn't create stmt\n");
                return null;
            }
        } catch (SQLException e) {
            System.out.print("Exception on stmt create\n");
            return null;
        }
        
        
        ResultSet rs;
        
        try {
            rs = this.stmt.executeQuery(query);
        } catch (SQLException e) {
            /* if (this.stmt != null) {
                this.stmt.close();
            } */
            e.printStackTrace();
            System.out.print("Exception on query\n");
            return null;
        }
        return rs;
    }
    
    /* Perform an update, insertion, or deletion */
    public int update(String query) {
        if (query == null) {
            return -4;
        }
        if (this.con == null) {
            return -1;
        } 
        try {
            this.stmt = this.con.createStatement();
            if (this.stmt == null) {
                return -2;
            }
        } catch (SQLException e) {
            return -3;
        }
        
        
        int value;
        
        try {
            value = this.stmt.executeUpdate(query);
        } catch (SQLException e) {
            value = -5; 
        } 
        try {
            if (this.stmt != null) {
                this.stmt.close();
            }
        } catch (SQLException e) {
        
        }
    
        return value;
    }

}
