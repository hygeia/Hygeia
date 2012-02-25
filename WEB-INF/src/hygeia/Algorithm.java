package hygeia;

import java.sql.*;
import java.security.*;

public class Algorithm {

    private Database db;
    private int uid;

    public Algorithm(Database db, User u) {
    
    }

    /* Main algorithm. types: 1 breakfast, 2 lunch, 3 dinner, 4 snack */
    public Meal suggestMeal(User u, int type) {
        return null;
    }
    
    /* Sanitizes a String for use. */
    public static String Clean(String s) {
        return s;
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
