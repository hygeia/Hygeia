/* Refer to Asher Garland for reference. */
package hygeia;

import java.sql.*;
import java.util.ArrayList;

public class Inventory {

    private Database db;
    private int uid;
    
    /* Create user's inventory object */
    public Inventory(User u) {
        if ( u != null )
        {
            this.uid = u.getUid();
            this.db = u.getDb();
        }
    }
    
    /* Returns an array of food objects in the inventory */
    public Food.Update[] getInventory() {

        // check if the database is null
        if (db == null) {
            return null;
        }

        // create an arraylist of Food.Update to be instantiated
        ArrayList<Food.Update> foodInv = new ArrayList<Food.Update>();  

        // query the database by uid, retriving fid of each food       
        ResultSet rs = this.db.execute("SELECT fid, count FROM inventory " 
                       + "WHERE uid = " + this.uid + ";");

        // instantiate each Food.Update by the retrived fid's
        int selectedFid;
        int selectedCount;
        try {
            if (rs == null) {
                return null;
            }
            while (rs.next()) {
                selectedFid   = rs.getInt("fid"); 
                selectedCount = rs.getInt("count");
                foodInv.add( new Food.Update(selectedFid, selectedCount) );
            }
        } catch (SQLException e) {
            return null;
        }

        // Convert the arraylist into an array
        Food.Update [] invArr = new Food.Update[foodInv.size()];
        foodInv.toArray(invArr);
        
        // Return the array of food items from the inventory
        return invArr;
    }
    
    /* Returns an array of Food.List objects for displaying to user. */
    public Food.List[] getInventoryList() { 
        // check if the database is null
        if (db == null) {
            return null;
        }

        // create an arraylist of Food.Update to be instantiated
        ArrayList<Food.List> foodInv = new ArrayList<Food.List>();  

        // query the inventory table by uid, inventory query result set 
        ResultSet rs = this.db.execute("select inventory.fid, " +
            "inventory.count, foods.name from inventory inner join foods on " +
            "inventory.fid=foods.fid where inventory.uid=" + this.uid +
            " and inventory.count > 0 order by name;");
            
        int fid;
        int count;
        String name;
        
        /* Build arraylist of objects */
        try {
            if (rs == null) {
                return null;
            }
            while (rs.next()) {
                fid = rs.getInt("fid");
                count = rs.getInt("count");
                name = rs.getString("name");
                foodInv.add(new Food.List(name, fid, count));
            }
            db.free();
        } catch (SQLException e) {
            return null;
        }
            
        // Convert the arraylist into an array
        Food.List [] invArr = new Food.List[foodInv.size()];
        foodInv.toArray(invArr);
        
        // Return the array of food.list
        return invArr;


    }
    
    /* Returns an array of food items that the user may add to meals or to 
       the inventory. Meaning that these are foods in the system that were
       entered by the user or are system-wide. The user does not actually need
       them in his inventory. */
    public Food.List[] getAvailableFoods() {
    
        ResultSet rs = this.db.execute("select fid, name from foods where " +
            "uid = 0 or uid = " + this.uid + ";");
            
        ArrayList<Food.List> foods = new ArrayList<Food.List>();
        
        try {
            if (rs == null) {
                return null;
            }
            while (rs.next()) {
                foods.add(new Food.List(rs.getString("name"), 
                    rs.getInt("fid"), 0));
            }
        } catch (SQLException e) {
            return null;
        }
        
        return (Food.List[])foods.toArray(new Food.List[1]);  
    }
    
    /* Add food to inventory */
    public boolean addFood(Food.Update f) {
        // null check
        if ( f == null )
        {
            return false;
        }
        
        /* Run the update */
        int r = this.db.update("update inventory set count = count + " +
            f.getCount() + " where uid = " + this.uid + " and fid = " +
            f.getFid() + ";");
        
        /* If food isn't in inventory yet (r == 0) insert it */
        if (r == 0) {
        r = this.db.update("insert into inventory(uid, fid, count) values (" +
            this.uid + ", " + f.getFid() + ", " + f.getCount() + ");");
        }
        
        db.free();
        
        /* failure... */
        if (r < 1) {
            return false;
        }
        
        return true;   
    }
    
    /* Remove an amount of food from inventory. This functions more as an 
       update to the quantity of food that is in the inventory. */
    public boolean removeFood(Food.Update f) {
         // null check
        if ( f == null )
        {
            return false;
        }

        // get the count of the food in the inventory table
        double count;
        int success;
        ResultSet rs = db.execute("SELECT count FROM inventory WHERE uid='" 
                        + this.uid + "' AND fid='" + f.getFid() + "';");
        try {
            // if false then the record doesn't exist so return false
            if (rs == null) {
                return false;
            } 
            else 
            {
                rs.next();
                count = rs.getInt("count");
            }
        } catch (SQLException e) {
            return false;
        }
        // change the count of the food in inventory by the amount in Food.Update f
        count = count - f.getCount();
        if ( count < 0)
        {
            count = 0;
        }

        // Update count record in inventory
        success = db.update("UPDATE inventory set count = " + count + 
            " WHERE uid='" + this.uid + "' AND fid='" + f.getFid() + "';");

        // Return error if something strange happened
        if (success != 1) {
            return false;
        }
        return true;
    }

}

