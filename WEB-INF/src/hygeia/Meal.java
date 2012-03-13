package hygeia;

import java.sql.*;
import java.util.ArrayList;

public class Meal {

    private Database db;
    private int mid;
    
    /* Create object from meal id */
    public Meal(Database db, int mid) {
        this.db = db;
        this.mid = mid;
    }
    
    /* Remove the meal from the database. Positive if successful. */
    public int removeMeal() {
        int r = this.db.update("delete from meals where mid=" + this.mid + ";");
        return r;
    }
    
    /* Create a new meal in the database consisting of these foods. Returns meal
       id. */
    public static int createMeal(Database db, User u, Food.Update f[], 
        String name, int type) {
        if ((db == null) || (u == null) || (f == null) || 
            (name == null) || (type < 0)) {
            return -1;
        }
        
        name = Algorithm.Clean(name);
        
        int uid = u.getUid();
        
        /* Ensure each item in f is not null. */
        /* Create Food.Update objects to get Nutrition. */
        Nutrition sum = new Nutrition(0, 0, 0, 0);
        for (int i = 0; i < f.length; i++) {
            if (f[i] == null) {
                return -2;
            }
            sum.addNutrition(f[i].getNutrition(db));
        }
        
        /* Create meal record in database */
        int r = db.update("insert into meals (uid, name, type, calories, " +
            "carbohydrates, protein, fat) values (" + uid + ", '" + name + "', "
            + type + ", " + sum.getCalories() + ", " + sum.getCarbohydrates() + 
            ", " + sum.getProtein() + ", " + sum.getFat() + ");");
        
        /* Check to see if it went correctly. */
        if (r != 1) {
            return -3;
        }
        
        /* Now get the mid.. probably not the best way. */
        int mid = 0;
        ResultSet rs = db.execute("select mid from meals where uid = " + uid +
            " and name = '" + name + "';");
        try {
            if (rs == null) {
                return -4;
            } else {
                rs.next();
                mid = rs.getInt("mid");
            }
        } catch (SQLException e) {
            return -5;
        }
        
        /* Not optimal but works to add components to database. */
        for (Food.Update i : f) {
            r = db.update("insert into components(mid, fid, count) values (" +
                mid + ", " + i.getFid() + ", " + i.getCount() + ");");
            if (r != 1) {
                /* This is an unclean exit but this shouldn't happen. */
                return -6;
            }
        }
        return mid;
    }
    
    /* Return meal id. */
    public int getMid() {
        return this.mid;
    }
    
    /* Return timestamp. */
    public Timestamp getOccurrence() {
        ResultSet rs = this.db.execute("select occurrence from history where " +
            "mid = " + this.mid + ";");
        
        Timestamp t;
            
        try {
            if (rs == null) {
                return null;
            }
            rs.next();
            t = rs.getTimestamp("occurrence");
            db.free();
        } catch (SQLException e) {
            return null;
        }   
        
        return t;     
    }
    
    /* Fetches and then returns name from database. */
    public String getName() {
        if (this.db == null) {
            return null;
        }
        
        ResultSet rs = this.db.execute("select name from meals where mid = " +
            this.mid + ";");
            
        try {
            if (rs == null) {
                return null;
            }
            if (rs.next()) {
                return rs.getString("name");
            }
            return null;
        } catch (SQLException e) {
            return null;
        }
    }
    
    /* Return the type of meal */
    public int getType() {
        ResultSet rs = this.db.execute("select type from meals where mid=" +
            this.mid + ";");
        
        try {
            if (rs == null) {
                return 0x10000000;
            }
            rs.next();
            int type = rs.getInt("type");
            db.free();
            return type;
        } catch (SQLException e) {
            db.free();
            return 0x10000001;
        }
    }
    
    /* Return array of Food items that make up meal */
    public Food.Update[] getMeal() {
        ResultSet rs = this.db.execute("select fid, count from components where"
            + " mid = " + this.mid + ";");
        
        ArrayList<Food.Update> list = new ArrayList<Food.Update>();
        
        try {
            if (rs == null) {
                return null;
            } else {
                while(rs.next()) {
                    int fid = rs.getInt("fid");
                    double count = rs.getDouble("count");
                    list.add(new Food.Update(fid, count));
                }
            }
        } catch (SQLException e) {
            if (list.isEmpty()) {
                return null;
            }
        }
        
        return (Food.Update[])list.toArray(new Food.Update[1]);
    }
    
    /* Return array of Food.List items that make up meal to display to user. */
    public Food.List[] getFoodList() {
        ResultSet rs = this.db.execute("select foods.fid, foods.name, " +
             "components.count from components inner join foods on " +
             "components.fid=foods.fid where components.mid = " + this.mid + 
             " order by foods.name;");
        
        ArrayList<Food.List> list = new ArrayList<Food.List>();
        
        try {
            if (rs == null) {
                return null;
            } else {
                while(rs.next()) {
                    int fid = rs.getInt("fid");
                    String name = rs.getString("name");
                    double count = rs.getDouble("count");
                    list.add(new Food.List(name, fid, count));
                }
            }
        } catch (SQLException e) {
            if (list.isEmpty()) {
                return null;
            }
        }
        
        return (Food.List[])list.toArray(new Food.List[1]);
    }
    
    /* Returns a nutrition object with info for the whole meal */
    public Nutrition getNutrition() {
        
        if (db == null) {
            return null;
        }
        
        ResultSet rs = this.db.execute("select calories, carbohydrates, fat, " +
            "protein from meals where mid = " + this.mid + ";");
            
        try {
            if (rs == null) {
                return null;
            }
            if (rs.next()) {
                double cals = rs.getDouble("calories");
                double carbs = rs.getDouble("carbohydrates");
                double fat = rs.getDouble("fat");
                double pro = rs.getDouble("protein");
                return new Nutrition(cals, carbs, pro, fat);
            }
            return null;
        } catch (SQLException e) {
            return null;
        }
    
    }
    
    /* Meal.List is used for listing meals to the user. */
    public static class List {
    
        private String name;
        private int mid;
        private Timestamp occurrence;
        
        public List(String name, int mid, Timestamp occurrence) {
            this.name = name;
            this.mid = mid;
            this.occurrence = occurrence;
        }
        
        public String getName() {
            return this.name;
        }
        
        public int getMid() {
            return this.mid;
        }
        
        public Timestamp getOccurrence() {
            return this.occurrence;
        }
        
        public Meal toMealAdapter(Database db) {
            return new Meal(db, this.mid);
        }
    
    }
    

}

