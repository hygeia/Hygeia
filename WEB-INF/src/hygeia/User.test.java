package hygeia;
import java.sql.*;

public class User {

    private String username;
    private int uid;
    private Database db;

    public User(Database db, int uid) {
        this.db = db;
        this.uid = uid;
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

}
