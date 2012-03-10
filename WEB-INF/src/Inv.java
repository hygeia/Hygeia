import hygeia.*;

public class Inv {

    public static void main(String args[]) {
        
        Database db = new Database();
        
        User u = new User(db, 1);
        
        Inventory inv = new Inventory(u);
        
        Food.Update[] fu = inv.getInventory();
        
        for (Food.Update f : fu) {
            System.out.println("Update " + f.getFid() + " by " + f.getCount());
        }
        
        Food.List[] fl = inv.getInventoryList();
        
        for (Food.List f : fl) {
            System.out.println("List " + f.getName() + " " + f.getFid() + " by " +
             f.getCount());
        }
        
        fl = inv.getAvailableFoods();
        
        for (Food.List f : fl) {
            System.out.println("Avail " + f.getName() + " " + f.getFid() + " by " +
             f.getCount());
        }
        
        
        inv.addFood(new Food.Update(2, 4));
        inv.addFood(new Food.Update(1, 3));
        
        fl = inv.getInventoryList();
        
        for (Food.List f : fl) {
            System.out.println("Add " + f.getName() + " " + f.getFid() + " by " +
             f.getCount());
        }
        
        inv.removeFood(new Food.Update(2, 1));
        inv.removeFood(new Food.Update(1, 2));
        
        fl = inv.getInventoryList();
        
        for (Food.List f : fl) {
            System.out.println("Rem " + f.getName() + " " + f.getFid() + " by " +
             f.getCount());
        }
        
        Food.Create cf = new Food.Create("orange", 999, 1, 100, 35, 35, 35, 35);
        System.out.println("Created food " + Food.createFood(u, cf));

        fl = inv.getAvailableFoods();

        for (Food.List f : fl) {
            System.out.println("Crea " + f.getName() + " " + f.getFid() + " by " +
             f.getCount());
        }
 
                db.close();
    }
    

}
