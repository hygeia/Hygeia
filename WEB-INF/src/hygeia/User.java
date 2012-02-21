package hygeia;

import java.sql.*;

/* User class used for getting user information and creating users */
public class User {
    
    private Database db;
    private int uid;
    private String username;
    private String email;
    private double height;
    private double weight;
    
    /*Use this to create User object in a page after the user has started a session */
    public User(Database db, int uid) {
        this.db = db;
        this.uid = uid;
    }
    
    /* Returns user id if login is successful, zero otherwise */
    public static int login(Database db, String email, String pwd) {
        if ((db == null) || (email == null) || (pwd == null)) {
            return -1;
       }
       ResultSet rs = db.execute("select uid from users where email = '" +
              email + "' and hpwd = '" + pwd + "';");
      
      int uid = 0;
    
         /* Try to get uid from result */
         try {
            /* Select first (should be only) record */
            if (rs.next()) {
                uid = rs.getInt("uid");
            }
        
            /* Free db resources */
            db.free();
        } catch (SQLException e) {
            /* I don't know what to do here */
        }
    
        return uid;
    }

    
    /* Get database object for other classes. Returns the actual object--not a
       clone! */
    public Database getDb() {
        return this.db;
    }
    
    /* Create a new user. Returns uid; zero if unsuccessful  */
    public static int createUser(Database db, String uname, String pwd, 
        String email, double ht, double wt) {
        
        if ((db == null) || (uname == null) || (pwd == null) || (email == null))
            {
            return -1;
        }
        
        /* Insert new record */
        int success = db.update("insert into users (username, hpwd, email, " +
            "height, weight) values ('" + uname + "', '" + pwd + "', '" +
            email + "', " + ht + ", " + wt +");");
        /* Return error if somethign strange happened */
        if (success != 1) {
            return -2;
        }
        
        /* Now get the uid.. there might be a better way of doing this */
        int uid = User.login(db, email, pwd);
        
        /* If there was an error from User.login, return an error code */
        if (uid < 1) {
            return -3;
        }
        
        return uid;
    }

    
    /* Delete user. */
    public static boolean deleteUser(Database db, int uid) {
    
    }
    
    /* Sets instance variables for all properties from the database */
    public boolean getAllInfo() {
    
    }
    
    public String getUsername() {
        /* Return pre-loaded copy, if available */
        if (this.username != null) {
            return this.username;
        }
    
        /* Check that the db is accessable */
        if (this.db == null) {
            return null;
        }
    
        /* Get it */
        System.out.print(this.db.isAlive() + "\n");
        ResultSet rs = this.db.execute("select username from users where uid = "
            + this.uid + ";");
        
        String username;
    
        /* Try to find it */
        try {
            if (rs.next()) {
                username = rs.getString("username");
                this.username = username;
            }
        
            /* Free db resources */
            this.db.free();
        } catch (SQLException e) {
            /* Some kind of error reporting */
        }
    
        return this.username;    
    }

    
    public String getEmail() {
    
    }
    
    /* Do not access db. Use instance variable */
    public int getUid() {
    
    }
    
    public double getHeight() {
    
    }
    
    public double getWeight() {
    
    }
    
    /* Updates the database and instance variables with new information */
    public boolean updateAllInfo(String username, String email, double ht, double wt) {
    
    }
    
    public boolean updateUsername(String uname) {
    
    }
    
    public boolean updatePwd(String pwd) {
    
    }
    
    public boolean updateEmail(String email) {
    
    }
    
    public boolean updateHeight(double height) {
    
    }
    
    public boolean updateWeight(double weight) {
    
    }
    
    /* Changes the user's password provided that old is the user's old 
       password. */
    public boolean resetPassword(String old, String pwd) {
    
    }
    
}
