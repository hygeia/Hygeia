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
/* THIS NEEDS WORK
            // retrive the macronutrient info from the database using the fid
            double cal = db.execute("select food.calories where food.fid = " + this.getFid() + ";");
            double carb = db.execute("select food.carbohydrates where food.fid = " + this.getFid() + ";");
            double pro = db.execute("select food.protein where food.fid = " + this.getFid() + ";");
            double fat = db.execute("select food.fat where food.fid = " + this.getFid() + ";");
*/
            // multiply the nutrients of the food by the number of food items in inventory (count)
            cal *= this.getCount();
            carb *= this.getCount();
            pro *= this.getCount();
            fat *= this.getCount();

            // return a newly created Nutriention object with the given macronutrient info
            return ( new Nutrition(cal, carb, pro, fat) ) ;
        
        }
    }
    
    /* Food.Create is used for creating new foods in the database. */
    public static class Create {
        
        private String name;
        private double weight;
        private double count; // needed?
        private double calories, carbohydrates, protein, fat, factor; // wtf is factor?
        
        public Create(String name, double count, double factor, int wt,
            double cal, double carb, double pro, double fat) {

            // instantiate the instance variables
            this.name = name;
            this.count = count;
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
        
        public double getCount() {
            return this.count;
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
    public static int createFood(Database db, Food.Create f) {
/* THIS NEEDS WORK
        /* Insert Food into foods table * /
        if ( db.update("INSERT INTO foods (name, weight, calories, carbohydrates,"+
            " protein, fat, factor) VALUES (" + f.getName() + ", '" + f.getWeight() + "', "
            + ", " + f.getCalories() + ", " + f.getCarbohydrates() +
            ", " + f.getProtein() + ", " + f.getFat() + ", " + f.getFactor() + ");" ) < 0 )
        {
            return ( db.execute("SELECT fid FROM foods WHERE Food.name ='" + f.getName() + "';") );
        } */

        return 0;
    }

}
