package hygeia;
import java.util.ArrayList;
import java.sql.*;

public class History {

    private Database db;
    private int uid;
    
    /* Creates user's history object */
    public History(User u) {
    	this.db = u.db;
    	this.uid = u.uid;
    }
    
    /* Returns an array of Meal objects */
    public Meal.List[] getHistory() {
    	ResultSet rs1 = db.execute("select * from history where uid = " + this.uid + " order by occurrence desc;");
    	ResultSet rs2;
    	ArrayList<Meal.List> mla = new ArrayList();
    	Meal.List temp = new Meal.List("a", 0, null);
    	String tempName = new String("");
    	int tempMid = 0;
    	Timestamp tempTimestamp = new TimeStamp();
    	ArrayList<int> mlaseed = new ArrayList();
    	while(rs1.next())
    	{
			tempMid = rs1.getInt(0);
			rs2 = db.execute("select * from meals where mid = " + tempMid + ";");
			rs2.next();
			temp = new Meal.List(rs2.getString("name"), rs2.getInt("mid"), rs1.getString("occurrence"));
			mla.add(temp);
    	}
    	
    	mla.add(temp);
    	return mla.toArray();
    }
    
    /* Returns an array of meals that are available to the user to add to
       the history or favorites. */
    public Meal.List[] getAvailableMeals(String s) {
		s = new String(Clean(s));
		ResultSet rs = db.execute("select * from meals where (uid = 0 or uid = " + uid + ") and name like \"%" + s + "%\";");
    	ArrayList<Meal.List> mla = new ArrayList();
    	Meal.List temp = new Meal.List("a", 0, null);
    	String tempName = new String("");
    	int tempMid = 0;
    	Timestamp tempTimestamp = new TimeStamp();
    	while (rs.next())
    	{
			tempName = rs.getString("name");
			tempMid = rs.getInt("mid");
			tempTimestamp = rs.getString("occurrence");
			temp = new Meal.List(tempName, tempMid, tempTimestamp);
			mla.add(temp);
		}
		return mla.toArray();
    }
    
    /* Add meal to history */
    public boolean addMeal(Meal m, Timestamp occurrence) {
    
		db.update("insert into history (mid, uid, occurence) values (" 
			+ m.getMid() + "," + uid + "," + occurrence + ");");
		return true;
    }
    
    /* Remove meal from history. */
    public boolean removeMeal(Meal m, Timestamp occurrence) {
    
		db.update("delete from history where mid = " + m.getMid() 
			+ " and uid = " + uid + " and occurence = \"" + occurrence + "\";");
		return true;
    }

}
