import hygeia.*;

public class Ml {

    public static void main(String args[]) {
    
        Database db = new Database();
        User u = new User(db, 1);
        
        Food.Update fu[] = {new Food.Update(1, 3), new Food.Update(2, 4)};
        
        //Meal.createMeal(db, u, fu, "Apple-Banana Bam+");
        
        Meal m2 = new Meal(db, 3);
        m2.removeMeal();
        
        Meal m = new Meal(db, 2);
        
        System.out.println(m.getName() + " " + m.getMid());
        
        fu = m.getMeal();
        
        for (Food.Update f : fu) {
            System.out.println("Update " + f.getFid() + " by " + f.getCount());
        }
        
        Food.List fl[] = m.getFoodList();
        
        for (Food.List f : fl) {
            System.out.println("List " + f.getName() + " " + f.getFid() + " by " +
             f.getCount());
        }
        
        Nutrition n = m.getNutrition();
        
        System.out.println("nuts " + n.getCalories() + n.getCarbohydrates() +
            n.getProtein() + n.getFat());
        
        db.close();
    
    }

}
