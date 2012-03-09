package hygeia;

import java.sql.*;

public class Favorites {

    private Database db;
    private int uid;
    
    /* create user's favorites object */
    public Favorites(User u) {
		this.db = u.getDb();
		this.uid = u.getUid();
    }
    
    /* Add a meal to the favorites */
    public boolean addMeal(Meal m) {
		db.update("insert into favorites values");
    }
    
    /* Remove a meal from favorites */
    public boolean removeMeal(Meal m) {
    
    }
    
    /* Returns an array of Meal objects in favorites */
    public Meal.List[] getFavorites() {
    
    }
    
    /* Returns an array of meals that are available to the user to add to
       the history or favorites. This just calls the same method in the 
       History class. */
    public Meal.List[] getAvailableMeals() {
        return new History(new User(this.db, this.uid)).getAvailableMeals();
    }

}

