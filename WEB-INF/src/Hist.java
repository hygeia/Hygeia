import hygeia.*;

import java.sql.*;

public class Hist {

    public static void main(String args[]) {
    
    Database db = new Database();
    User u = new User(db, 1);
    
    History h = new History(u);
    
    Meal.List ml[] = h.getHistory();
    
    for (Meal.List m : ml) {
        System.out.println("List " + m.getName() + " " + m.getMid() + " " + 
            m.getOccurrence());
    } 
    
    ml = h.getAvailableMeals("st");   
    
    for (Meal.List m : ml) {
        System.out.println("Avail " + m.getName() + " " + m.getMid() + " " + 
            m.getOccurrence());
    } 
    
    Timestamp t = new Timestamp(777890);
    
    System.out.println(h.addMeal(new Meal(db, 2), new Timestamp(777890)));
    
    ml = h.getHistory();
    
    for (Meal.List m : ml) {
        System.out.println("List " + m.getName() + " " + m.getMid() + " " + 
            m.getOccurrence());
    } 
    
    h.removeMeal(new Meal(db, 2), t);
    
    ml = h.getHistory();
    
    for (Meal.List m : ml) {
        System.out.println("List " + m.getName() + " " + m.getMid() + " " + 
            m.getOccurrence());
    } 
    
    }


}
