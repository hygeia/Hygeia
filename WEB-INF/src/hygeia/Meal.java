package hygeia;

import java.sql.*;

public class Meal {

    private Database db;
    private int mid;
    
    /* Create object from meal id */
    public Meal(Database db, int mid) {
    
    }
    
    /* Create a new meal in the database consisting of these foods. Returns meal id. */
    public static int createMeal(Database db, User u, Food.Add f[]) {
    
    }
    
    /* Return array of Food items that make up meal */
    public Food.Add[] getFoods() {
    
    }
    
    /* Returns a nutrition object with info for the whole meal */
    public Nutrition getNutrition() {
    
    }

}

