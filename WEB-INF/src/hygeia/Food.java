package hygeia;

import java.sql.*;

/* Classes for handling food items */
public class Food {

    /* Food.Add is used for adding to inventory */
    public static class Update {
        
        private int fid;
        private int count;
        
        public Add(int fid, int count) {
        
        }
        
        public int getFid() {
        
        }
        
        public int getCount() {
        
        }
        
        /* Create a Nutrition object with the values filled in from the db */
        public Nutrition getNutrition(Database db) {
        
        }
    }
    
    /* Food.Remove is for removing items from an inventory. newAmount is to be 
       the new amount of that item in the inventory. So removing items is 
       actually more like updating the item count in the inventory. */
    public static class Remove {
        
        private int iid;
        private int newAmount;
        
        public Remove(int iid, int newAmount) {
        
        }
        
        public int getIid() {
        
        }
        
        public int getNewAmount() {
        
        }
    }
    
    /* Food.Create is used for creating new foods in the database. */
    public static class Create {
        
        private String name;
        private int amount, serving, weight;
        private double calories, carbohydrates, protein, fat;
        
        public Create(String name, int amount, int serv, int wt, double cal, 
            double carb, double pro, double fat) {
        
        }
        
        /* getters for all fields */
    }
    
    /* Food.List is used for producing a list of foods visible to the user. */
    public static class List {
        
        private String name;
        private int fid;
        private int count;
        
        public List(String name, int fid) {
        
        }
        
        public String getName() {
        
        }
        
        public int getFid() {
        
        }
        
        public int getCount() {
        
        }
    }

    /* Create a new food in the database. Returns fid if successful. */
    public static int createFood(Database db, Food.Create f) {
    
    } 

}
