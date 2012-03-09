/* Refer to Asher Garland for reference. */
package hygeia;

import java.sql.*;

public class Inventory {

    private Database db;
    private int uid;
    
    /* Create user's inventory object */
    public Inventory(User u) {
    
    }
    
    /* Returns an array of food objects in the inventory */
    public Food.Update[] getInventory() {
    
    }
    
    /* Returns an array of Food.List objects for displaying to user. */
    public Food.List[] getInventoryList() {
    
    }
    
    /* Returns an array of food items that the user may add to meals or to 
       the inventory. */
    public Food.List[] getAvailableFoods() {
    
    }
    
    /* Add food to inventory */
    public boolean addFood(Food.Update f) {
    
    }
    
    /* Remove an amount of food from inventory. This functions more as an 
       update to the quantity of food that is in the inventory. */
    public boolean removeFood(Food.Update f) {
    
    }

}

