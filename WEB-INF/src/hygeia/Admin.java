package hygeia;

import java.sql.*;

/* Admins log in through a special page with uses these methods. Once logged in
   admins have access to most other features, but create food and meals for
   system-wide use. Admins do not have their own inventories, histories, or
   favorites. */
public class Admin {

    /* Performs a login but uses admins table instead of users. Should return
       zero on success. */
    public static int login(String email, String pwd) {
    
    }
    
    /* Creates a new admin in the admins table. */
    public static int createAdmin(String email, String pwd) {
    
    }
    
    
    /* Deletes an admin fromt he admins table. */
    public static int deleteAdmin(String email) {
    
    }

}
