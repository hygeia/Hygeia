/* Refer to Asher Garland for reference. */
package hygeia;

import java.sql.*;

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
        ArrayList<Food.Update> foodInv = new ArrayList();  

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
        ArrayList<Food.List> foodInv = new ArrayList();  

        // query the inventory table by uid, inventory query result set     
        ResultSet inv_rs = this.db.execute("SELECT fid, count FROM inventory " 
                       + "WHERE uid='" + this.uid + "';");
        ResultSet food_rs; //food query result set

        // instantiate each Food.Update by the retrived fid's
        int selectedFid;
        int selectedCount;
        String selectedName;
        try {
            if (inv_rs == null) {
                return null;
            }
            while (inv_rs.next()) {
                // get the fid and count from inventory table
                selectedFid   = inv_rs.getInt("fid"); 
                selectedCount = inv_rs.getInt("count");
                // use the fid to get the name of the food from the foods table
                food_rs = this.db.execute("SELECT name FROM foods WHERE fid='" 
                                        + selectedFid + "';");
                selectedName = food_rs.getString("name");   // ** possible error if the food_rs is null
                // add the item in the array of food.list
                foodInv.add( new Food.List(selectedName, selectedFid, selectedCount) );
            }
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
       the inventory. */
    public Food.List[] getAvailableFoods() {
        int count = 0
        Food.List[] allFoods = getInventoryList();

        for (int i = 0; i < allFoods.length - 1; i++)
        {
            if ( allFoods[i].getCount > 0 )
            {
                count++;
            }
        }

        Food.List[] available = new Food.List[count];

        for (int i = 0, int j = 0; i < allFoods.length - 1; i++)
        {
            if ( allFoods[i].getCount > 0 )
            {
                available[j] = allFoods[i]; 
                j++;
            }
        }

        return available;    
    }
    
    /* Add food to inventory */
    public boolean addFood(Food.Update f) {
        // null check
        if ( f == null )
        {
            return false;
        }

        // get the count of the food in the inventory table
        int count;
        int success;
        ResultSet rs = db.execute("SELECT count FROM inventory WHERE uid='" 
                        + f.getUid() + "' AND fid='" + f.getFid() + "';");
        try {
            if (rs == null) {
                // Insert new food record into inventory
                success = db.update("INSERT INTO inventory (uid, fid, count) VALUES (" 
                    + this.uid + f.getFid() + f.getCount() + ")"); 
                if (success != 1)
                {
                    return false;
                }
                else
                {
                    return true;
                }
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
        count = count + f.getCount();

        // Update count record in inventory
        success = db.update("UPDATE count FROM inventory WHERE uid='" 
                        + f.getUid() + "' AND fid='" + f.getFid() + "' "
                        + "VALUES (" + count +");");

        // Return error if something strange happened
        if (success != 1) {
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
        int count;
        int success;
        ResultSet rs = db.execute("SELECT count FROM inventory WHERE uid='" 
                        + f.getUid() + "' AND fid='" + f.getFid() + "';");
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
        success = db.update("UPDATE count FROM inventory WHERE uid='" 
                        + f.getUid() + "' AND fid='" + f.getFid() + "' "
                        + "VALUES (" + count +");");

        // Return error if something strange happened
        if (success != 1) {
            return false;
        }
        return true;
    }

}

