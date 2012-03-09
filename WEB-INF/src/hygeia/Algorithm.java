package hygeia;

import java.sql.*;
import java.security.*;
import java.util.StringTokenizer;
import java.util.ArrayList;

public class Algorithm {

    private Database db;
    private int uid;
    private final double SAME = 0.1; //used as a margin of error for relatively balanced meals

    public Algorithm(Database db, User u) {
		this.uid = u.getUid();
		this.db = u.getDb();
    }

    /* Main algorithm. types: 1 breakfast, 2 lunch, 3 dinner, 4 snack */
    public Meal suggestMeal(User u, int type) {
		//pulls all meals from the universal meal list and the user's personal meals
        ResultSet rs = db.execute("select mid from meals where uid = " + u.uid + " or uid = 0;");
        //arraylist of meal IDs that come from the database
        ArrayList<int> results = new ArrayList();
		while(rs.next())
		{
			results.add(rs.getInt("mid"));
		}
		//retrieves a list of food in the inventory
		Food.Update[] fu = Inventory.getInventory();
		//random generator to select a meal at random from available MIDs
		Random r = new Random(results.size());
		//if the inventorymatchcount variable equals the number of ingredients in a recipe, all necessary ingredients are available
		int inventorymatchcount = 0;
		//Meal m is the variable used to store meals as they are accessed for comparison to ingredients
		Meal m = new Meal(db, 0);
		//while loop runs while a suitable meal isn't found yet
		while (results.size() > 0)
		{
			inventorymatchcount = 0;
			m = new Meal(db, results.get(r.nextInt()));
			for (int i = 0; i < m.getMeal().getCount(); i++)
			{
				for (int j = 0; j < fu.getCount(); j++)
				{
					if (m.getMeal()[i] == fu[j])
						inventorymatchcount += 1;
				}
			}
			if (inventorymatchcount == m.getCount())
			{
				//currently not calorie budget based. Functionality will be added if budget is accessible.
				//begins balanced suggestion based on the 40:30:30 ideal,
				//+ and - 10% (defined as constant SAME, Suggest A Meal Error) to find relatively balanced meals
				Nutrition n = new Nutrition(m.getNutrition()); //makes a nutrition object holding the meal's total nutrition
				double totalGrams = n.getCarbohydrates() + n.getProtein() + n.getFat();
				if (n.getCarbohydrates() / totalGrams > 0.4 - SAME 
						&& n.getCarbohydrates() / totalGrams < 0.4 + SAME)
				{
					if (n.getProtein() / totalGrams > 0.3 - SAME 
							&& n.getProtein() / totalGrams < 0.3 + SAME)
					{
						if (n.getFat() / totalGrams > 0.3 - SAME 
								&& n.getFat() / totalGrams < 0.3 + SAME)
						{
							return m;
						}
					}
				}
			}
			else
			{
				//if the contents of the inventory don't satisfy the recipe, remove that recipe
				//from the ArrayList of meals so it won't accidentally be compared again
				results.remove(m.getMid());
				r = new Random(results.size());
			}

		}
		//if no meal matches the SAME margin of error for balancedness, return null
        return null;
    }
    
    /* Sanitizes a String for use. */
    public static String Clean(String s) {
    	StringTokenizer toke = new StringTokenizer(s, "*/\\\"\':;-()=+[]");
    	String r = new String("");
    	while(toke.hasMoreTokens())
    	{
    		r = new String(r + toke.nextToken());
    	}
        return r;
    }
    
    /* Should return MD5 hashes.. but may be platform dependent. And this was 
       written by some anonymous author. FYI.  */
    public static String MD5(String md5) {
        try {
            java.security.MessageDigest md = java.security.MessageDigest.getInstance("MD5");
            byte[] array = md.digest(md5.getBytes());
            StringBuffer sb = new StringBuffer();
            for (int i = 0; i < array.length; ++i) {
                sb.append(Integer.toHexString((array[i] & 0xFF) | 0x100).substring(1,3));
            }
            return sb.toString();
        } catch (java.security.NoSuchAlgorithmException e) {
        }
        return null;
    }
}
