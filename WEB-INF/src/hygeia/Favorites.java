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
		//this needs to be fixed to auto-increment the fid field
		db.update("insert into favorites values (" + m.getMid() + ", " + uid + ";");
		return true;
    }
    
    /* Remove a meal from favorites */
    public boolean removeMeal(Meal m) {
		ResultSet rs = db.execute("select fid from favorites where uid = " + uid + " and mid = " + m.getMid() + ";");
		if (rs == null)
			return false;
		else
		{
			db.update("delete from favorites where uid = " + uid + " and mid = " + m.getMid() + ";");
			return true;
		}
	}
    
    /* Returns an array of Meal objects in favorites */
    public Meal.List[] getFavorites() {
		ArrayList<Meal.List> ml = new ArrayList();
		ArrayList<Integer> il = new ArrayList();
		ResultSet rs1 = db.execute("select mid from favorites where uid = " + uid + ";");
		while(rs1.next())
		{
			il.add(rs1.getInt(mid));
		}
		String s = new String("");
		for (int i = 0; i < il.size() - 1; i++)
		{
			s += il.get(i) + ", ";
		}
		s += il.get(il.size() - 1);
		ResultSet rs2 = db.execute("select * from meals where mid = " + s + ";");
		while(rs2.next())
		{
			ml.add(new Meal.List(rs2.getString(name), rs2.getInt(mid), "");
		}
		return ml.toArray();
    }
    
    /* Returns an array of meals that are available to the user to add to
       the history or favorites. This just calls the same method in the 
       History class. */
    public Meal.List[] getAvailableMeals() {
        return new History(new User(this.db, this.uid)).getAvailableMeals();
    }

}

