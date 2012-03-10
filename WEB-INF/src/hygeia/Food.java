package hygeia;

import java.sql.*;

/* Classes for handling food items */
public class Food {

    /* Food.Update is used for adding to inventory */
    public static class Update {
        
        private int fid;
        private double count;
        
        public Update(int fid, double count) {
            this.setFid ( fid );
            this.setCount ( count );
        }
        
        public int getFid() {
            return this.fid;
        }
        
        public double getCount() {
            return this.count;
        }

        private void setFid( int fid) {
            this.fid = fid;
        }

        private void setCount( double count) {

            // Lower limit of 0, no negative counts;
            if ( count < 0 )
            {
                count = 0;
            }

            this.count = count;
        }
        
        /* Create a Nutrition object with the values filled in from the db */
        public Nutrition getNutrition(Database db) {
            double cal =0, carb= 0, pro=0, fat=0;

            // retrive the macronutrient info from the database using the fid
            ResultSet rs = db.execute("SELECT calories, carbohydrates, " +
                "protein, fat FROM foods WHERE fid = '" + this.fid + "';");
    
            /* Try to get nutrition from result */
            try 
            {
                /* Select first (should be only) record */
                if (rs == null) {
                    return null;
            }
                if (rs.next()) {
                    cal = rs.getDouble("calories");
                    carb = rs.getDouble("carbohydrates");
                    pro = rs.getDouble("protein");
                    fat = rs.getDouble("fat"); 
                }
        
            /* Free db resources */
            db.free();
            } catch (SQLException e) 
            {
               return null;
            }
            
            // multiply the nutrients of the food by the number of food items
            // in inventory (count)
            cal *= this.getCount();
            carb *= this.getCount();
            pro *= this.getCount();
            fat *= this.getCount();

            // return a newly created Nutriention object with the given 
            //macronutrient info
            return ( new Nutrition(cal, carb, pro, fat) ) ;
        
        }
    }
    
    /* Food.Create is used for creating new foods in the database. */
    public static class Create {
        
        private String name;
        private double weight;
        private double calories, carbohydrates, protein, fat, factor; // wtf is factor?
        
        public Create(String name, double factor, int wt,
            double cal, double carb, double pro, double fat) {

            // instantiate the instance variables
            this.name = name;
            this.factor = factor;
            this.weight = wt;
            this.calories = cal;
            this.carbohydrates = carb;
            this.protein = pro;
            this.fat = fat;

        }
        
        /* getters for all fields */
        public String getName() {
            return this.name;
        }
        
        public double getWeight() {
            return this.weight;
        }
        
        public double getFactor() {
            return this.factor;
        }
        
        public double getCalories() {
            return this.calories;
        }
        
        public double getCarbohydrates() {
            return this.carbohydrates;
        }
        
        public double getProtein() {
            return this.protein;
        }
        
        public double getFat() {
            return this.fat;
        }
    }
    
    /* Food.List is used for producing a list of foods visible to the user. */
    public static class List {
        
        private String name;
        private int fid;
        private double count;
        
        public List(String name, int fid, double count) {
            this.name = name;
            this.fid = fid;
            this.count = count;
        }
        
        public String getName() {
            return this.name;
        }
        
        public int getFid() {
            return this.fid;
        }
        
        public double getCount() {
            return this.count;
        }
    }

    /* Create a new food in the database. Returns fid if successful. 0 if unsuccessful */
    public static int createFood(User u, Food.Create f) {
    
        if ((u == null) || (f == null)) {
            return -1;
        }
        
        Database db = u.getDb();
        int uid = u.getUid();
        
        String name = f.getName();
        double wt = f.getWeight();
        double fac = f.getFactor();
        double cal = f.getCalories();
        double carb = f.getCarbohydrates();
        double pro = f.getProtein();
        double fat = f.getFat();
        
        int r = db.update("insert into foods (uid, name, weight, factor, " +
            "calories, carbohydrates, protein, fat) values (" + uid + ", '" +
            name + "', " + wt + ", " + fac + ", " + cal + ", " + carb + ", " +
            pro + ", " + fat + ");");
            
        if (r < 1) {
            return -2;
        }
        
        /* Get fid.. the long way */
        ResultSet rs = db.execute("select fid from foods where name = '" +
            name + "' and uid = " + uid + ";");
            
        int fid = 0;
            
        try {
            if (rs == null) {
                return -3;
            }
            rs.next();
            fid = rs.getInt("fid");
            db.free();
        } catch (SQLException e) {
            return -4;
        }
    
        return fid;
    }

}
