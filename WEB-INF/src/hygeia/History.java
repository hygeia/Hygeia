package hygeia;

import java.sql.*;

public class History {

    private Database db;
    private int uid;
    
    /* Creates user's history object */
    public History(User u) {
    
    }
    
    /* Returns an array of Meal objects */
    public Meal.List[] getHistory() {
    
    }
    
    /* Returns an array of meals that are available to the user to add to
       the history or favorites. */
    public Meal.List[] getAvailableMeals() {
    
    }
    
    /* Add meal to history */
    public boolean addMeal(Meal m, Timestamp occurrence) {
    
    }
    
    /* Remove meal from history. */
    public boolean removeMeal(Meal m, Timestamp occurrence) {
    
    }

}
