package hygeia;

import java.sql.*;

public class Meal {

    private Database db;
    private int mid;
    
    /* Create object from meal id */
    public Meal(Database db, int mid) {
        this.db = db;
        this.mid = mid;
    }
    
    /* Create a new meal in the database consisting of these foods. Returns meal id. */
    public static int createMeal(Database db, User u, Food.Update f[]) {
        if ((this.db == null) || (this.u == null) || f == null)) {
            return -1;
        }
        
        int fids[] = new int[f.length];
        double counts[] = new double[f.length];
        
        /* Ensure each item in f is not null. */
        for (int i = 0; i < f.length; i++) {
            if (f[i] == null) {
                return null;
            }
            fids[i] = f[i].fid;
            counts[i] = f[i].count;
        }
        
        
    }
    
    /* Return meal id. */
    public int getMid() {
        return this.mid;
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
    
    /* Return array of Food items that make up meal */
    public Food.Update[] getMeal() {
    
    }
    
    /* Return array of Food.List items that make up meal to display to user. */
    public Food.List[] getFoodList() {
    
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
                return new Nutrition(cal, carbs, pro, fat);
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
            return this.occcurrence;
        }
    
    }
    

}

