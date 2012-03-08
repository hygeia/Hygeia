package hygeia;

import java.sql.*;

/* Admins log in through a special page which uses these methods. Once logged in
admins have access to most other features, but create food and meals for
system-wide use. Admins do not have their own inventories, histories, or
favorites. */
public class Admin {

    Database db = new Database ();

    /* Performs a login but uses admins table instead of users. Should return
zero on success. */
    public static int login(String email, String pwd) {
    	if ( email == null || pwd == null )
    	{
    		return -1;
    	}

    	/* Clean inputs */
        email = Algorithm.Clean(email);
        pwd = Algorithm.MD5(Algorithm.Clean(pwd));
       
        ResultSet rs = db.execute("SELECT aid FROM Admin WHERE email = '" +
              email + "' AND hpwd = '" + pwd + "';");
      
      	int aid = 0;
    
        /* Try to get aid from result */
        try 
        {
            /* Select first (should be only) record */
            if (rs == null) {
                return -2;
            }
            if (rs.next()) {
                aid = rs.getInt("aid");
            }
        
            /* Free db resources */
            db.free();
        } catch (SQLException e) 
        {
            /* I don't know what to do here */
            e.printStackTrace();
        }
        /* System.out.print(aid); */
        return aid;
    	
    }
    
    /* Creates a new admin in the admins table. */
    public static int createAdmin(String email, String pwd) {
    
        if ( email == null || pwd == null ) {
            return -1;
        }
        
        /* Clean */
        email = Algorithm.Clean(email);
        pwd = Algorithm.Clean(pwd);
        String hpwd = Algorithm.MD5(pwd);
        
        /* check if the account already exists. */
        if (User.accountExists(db, email)) {
            return -4;
        }
        
        /* Insert new record */
        int success = db.update("INSERT into Admin (email, hpwd)" + 
                      " values ('" + email + "', '" + hpwd + "');");
        /* Return error if somethign strange happened */
        if (success != 1) {
            return -2;
        }
        
        /* Now get the aid */
        int aid = Admin.login(db, email, pwd);
        
        /* If there was an error from User.login, return an error code */
        if (uid < 1) {
            return -3;
        }
        
        return aid;
    }
    
    
    /* Deletes an admin fromt he admins table. Returns the true if successful*/
    public static boolean deleteAdmin(String email) {
        if ( email == null)
        {
        	return false;
        }

        ResultSet rs = db.execute("DELETE aid FROM Admin WHERE email = '" +
              email + "';");

        if (rs == null) {
        	return false;
        }
        
        return true;
    }

}