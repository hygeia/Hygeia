package hygeia;

import java.sql.*;
import java.util.ArrayList;

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
        if (m == null) {
            return false;
        }
        //adds the meal to the favorites table
		int r = db.update("insert into favorites (mid, uid) values (" + 
		    m.getMid() + ", " + uid + ");");
		if (r < 1) {
		    return false;
		}
		return true;
    }
    
    /* Remove a meal from favorites */
    public boolean removeMeal(Meal m) {
		
		if (m == null) {
		    return false;
		}
		
		int r = db.update("delete from favorites where uid = " + uid + 
		    " and mid = " + m.getMid() + ";");
		if (r < 1) {
		    return false;
		}
		return true;
	}
    
    /* Returns an array of Meal objects in favorites */
    public Meal.List[] getFavorites() {
    
        ArrayList<Meal.List> ml = new ArrayList<Meal.List>();
        
        ResultSet rs = this.db.execute("select favorites.mid, meals.name from" +
            " favorites inner join meals on favorites.mid=meals.mid where " +
            "favorites.uid = " + this.uid + ";");
        
        try {
            if (rs == null) {
                return null;
            }
            
            while (rs.next()) {
                String name = rs.getString("name");
                int mid = rs.getInt("mid");
                ml.add(new Meal.List(name, mid, null));
            }
            db.free();
            return (Meal.List[])ml.toArray(new Meal.List[1]);
        } catch (SQLException e) {
            return null;
        }
    }
    
    /* Returns an array of meals that are available to the user to add to
       the history or favorites. This just calls the same method in the 
       History class. */
    public Meal.List[] getAvailableMeals() {
        return new History(new User(this.db, this.uid)).getAvailableMeals("");
    }

}

