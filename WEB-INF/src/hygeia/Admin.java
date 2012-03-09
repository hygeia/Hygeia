/* Refer to Asher Garland fo reference. */
package hygeia;

import java.sql.*;

/* Admins log in through a special page which uses these methods. Once logged in
admins have access to most other features, but create food and meals for
system-wide use. Admins do not have their own inventories, histories, or
favorites. */
public class Admin {

    /* Performs a login but uses admins table instead of users. Should return
zero on success. */
    public static int login(Database db, String email, String pwd) {
        if ( email == null || pwd == null )
    	{
    		return -1;
    	}

    	/* Clean inputs */
        email = Algorithm.Clean(email);
        pwd = Algorithm.MD5(Algorithm.Clean(pwd));
       
        ResultSet rs = db.execute("SELECT aid FROM admins WHERE email = '" +
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
    public static int createAdmin(Database db, String email, String pwd) {
    
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
        int success = db.update("INSERT into admins (email, hpwd)" + 
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
    public static boolean deleteAdmin(Database db, String email) {
        if ( email == null)
        {
        	return false;
        }

        /* Clean */
        email = Algorithm.Clean(email);

        ResultSet rs = db.execute("DELETE * FROM admins WHERE email = '" +
              email + "';");

        if (rs < 1) {
        	return false;
        }
        
        return true;
    }


    /* Deletes a User from the User table; returns true if successful */
    public boolean deleteUser(Databse db, User selected)
    {
    	if ( User.accountExists(db, selected.getEmail()) )
    		{
    			return ( User.deleteUser( db, selected.getUid() ) );
    		}
    	return false;    	
    }

    /* Creates a User and inserts in the User table; returns true if successfil */
    public static boolean createUser(Database db, String uname, String pwd, String email, 
    							double ht, double wt)
    {
    	try
    	{
    		// create the user, User.createUser inserts the info into the user table and return uid
    		User newUser = new User(db, User.createUser(Database db, String uname, String pwd,
        		String email, double ht, double wt) );

        	if ( newUser == null )
        	{
        		return false;
        	}
        	return true;
        }
        // if any exception is thrown then something broke up so delete that entered data and return false
        catch ( Exception e)
        {
        	this.deleteUser( newUser );
        	return false;
        }
    	
    	return false;
    }

    /* Create a new Food item; return true if successful */
    public static boolean createFood(String name, double count, double factor, int wt,
            double cal, double carb, double pro, double fat)
    {
    	Food newFood = new Food.Create(name, count, factor, wt, cal, carb, pro, fat);
    	if (newFood == null)
    	{
    		return false;
    	}

    	return true;
    }

    /* Delete a new Food item; return true if successful */
    public static boolean deleteFood()
    {
    	return false;
    }
}