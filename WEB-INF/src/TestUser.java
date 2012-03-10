import hygeia.*;

public class TestUser {

    public static void main(String args[]) {
    
        /* Create db */
        Database db = new Database();
        if (db.isAlive() == false) {
            System.out.print("db is not alive\n");
            return;
        }
        /*int t = User.login(db, "tg@h", "simba");
        User t1 = new User(db, t);
        t1.resetPassword("simba", "simba2"); */
        /* Create user */
        int uid = User.createUser(db, "testguy", "simba", "tg@h", 120, 120);
        if (uid < 1) {
            System.out.print("createUser invalid uid: " + uid + "\n");
            return;
        }
        
        /* Check duplicates */
        uid = User.createUser(db, "testguy2", "jarjar", "tg@h", 120, 120);
        if (uid > 0) {
            System.out.print("createUser invalid duplicate uid: " + uid + "\n");
            return;
        }
        
        /* Check if account exists */
        boolean exists = User.accountExists(db, "tg@h");
        boolean exists2 = User.accountExists(db, "mtc@provo");
        if ((exists == false) || (exists2 == true)) {
            System.out.print("duplicate account: " + exists + exists2 + "\n");
            return;
        }
        
        /* login user */
        uid = User.login(db, "tg@h", "simba");
        if (uid < 1) {
            System.out.print("login invalid uid: " + uid + "\n");
            return;
        }
        
        /* Create user object */
        User u = new User(db, uid);
        
        /* Get all info */
        if (u.getAllInfo() == false) {
            System.out.print("getAllInfo false\n");
            return;
        }
        
        if (!u.getUsername().equals("testguy")) {
            System.out.print("wrong username\n");
        }
        
        if (!u.getEmail().equals("tg@h")) {
            System.out.print("wrong email\n");
        }
        
        if (u.getHeight() != 120) {
            System.out.print("wrong heigt\n");
        }
        
        if (u.getWeight() != 120) {
            System.out.print("wrong weight\n");
        }
        
       
        /* check updates. */
        User.createUser(db, "testguy2", "simba", "tg@h2", 120, 120);
        if (u.updateAllInfo("testguy3", "tg@h2", 140, 140)) {
            System.out.print("updateAllInfo does not check dups\n");
            return;
        }
        
        if (!u.updateAllInfo("testguy3", "tg@h3", 140, 140)) {
            System.out.print("updateAllInfo false\n");
            return;
        }
        
        /* check reset password */
        if (!u.resetPassword("simba", "simba2")) {
            System.out.print("resetPassword false\n");
        }
        
        uid = User.login(db, "tg@h3", "simba2");
        if (uid < 1) {
            System.out.print("newpassword login failed uid: " + uid + "\n");
        }
        
        System.out.print("Ran 14 tests\n");
    }

}
