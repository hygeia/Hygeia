package hygeia;

import java.sql.*;

public class Meal {

    private Database db;
    private int mid;
    
    /* Create object from meal id */
    public Meal(Database db, int mid) {
    
    }
    
    /* Used to initialize the database for this class */
    public static boolean setDb(Database db) {
    
    }
    
    /* Create a new meal in the database consisting of these foods. Returns meal id. */
    public static int createMeal(Food f[], User u) {
    
    }
    
    /* Return array of Food */
    public Food[] getFoods() {
    
    }
    
    /* Returns a nutrition object with info for the whole meal */
    public Nutrition getNutrition() {
    
    }

}

