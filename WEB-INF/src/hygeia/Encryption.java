package hygeia;

import java.security.*;

public class Encryption {

public static void main(String args[]) {
    
    System.out.print(MD5("simba") + "\n");
    System.out.print(MD5("root") + "\n");
    System.out.print(MD5("") + "\n");
    System.out.print(MD5("abcdef") + "\n");
    System.out.print(MD5("1234") + "\n");
    System.out.print(MD5("---------------") + "\n");

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
