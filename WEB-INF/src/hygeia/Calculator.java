import java.io.BufferedReader;
package hygeia;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.util.Scanner;


public class Calculator {
	
// Declarations
double f = 0.5;

public static double percentBodyFat(String sex, String w, String h1, 
  String h2, String h3, String a1, String a2, String a3, double height, String wr) 
  throws FileNotFoundException
{
 // Declarations
 double hip, weight, hip1, hip2, hip3, abd1, abd2, abd3, abdomen, 
 doubRes;
 double constantA = 0;
 double constantB = 0;
 double constantC = 0;
 double percentBodyFat = 0;
 String result;
 boolean flag =true;
 
 /*
  * If user is female
  */
 if(sex.equals("f"))
 {
  Scanner hipConst = new Scanner(new BufferedReader(
    new FileReader("/home/anne/www/WEB-INF/src/hygeia/femaleTable.txt")));
  Scanner hConst = new Scanner(new BufferedReader(
    new FileReader("/home/anne/www/WEB-INF/src/hygeia/femaleTable.txt")));
  Scanner abdConst = new Scanner(new BufferedReader(
    new FileReader("/home/anne/www/WEB-INF/src/hygeia/femaleTable.txt")));

  weight = Double.parseDouble(w);
  
  /*
   * Get 3 Hip measurements and take the average
   */
  hip1 = Double.parseDouble(h1);
  hip2 = Double.parseDouble(h2);
  hip3 = Double.parseDouble(h3);
  
  hip = (hip1 + hip2 + hip3)/3;
  
  hip = f* Math.round(hip/f);
  System.out.println(hip);
  
  /*
   * Get 3 Abdomen measurements and take the average
   */
  abd1 = Double.parseDouble(a1);
  abd2 = Double.parseDouble(a2);
  abd3 = Double.parseDouble(a3);
  
  abdomen = (abd1 + abd2 + abd3)/3;
  abdomen = f* Math.round(abdomen/f);
  System.out.println(abdomen);
  
  /* 
   * Find values in database
   */
  
  result = hipConst.next();
  
  while(!hipConst.hasNextDouble())
  {
   hipConst.nextLine();
   result = hipConst.next();
  }
  
  while((result != null) && flag)
  {
   doubRes = Double.parseDouble(result);
   
   if(doubRes == hip)
   {
    flag = false;
    result = hipConst.next();
    constantA = Double.parseDouble(result);
    System.out.println("ConstantA: " + constantA);
    
   }
   else
   {
    hipConst.nextLine();
    result = hipConst.next();
  
   } 
  }
  
  flag = true;
  abdConst.next();   
  abdConst.next();
  result = abdConst.next();
  
  while(!abdConst.hasNextDouble())
  {
   abdConst.nextLine();
   abdConst.next();
   abdConst.next();
   result = abdConst.next();
  }
  
  while((result != null) && flag)
  {
   doubRes = Double.parseDouble(result);
   
   if(doubRes == abdomen)
   {
    flag = false;
    result = abdConst.next();
    constantB = Double.parseDouble(result);
    System.out.println("ConstantB: " + constantB);
    
   }
   else
   {
    abdConst.nextLine();
    abdConst.next();   
    abdConst.next();
    result = abdConst.next();
  
   } 
  }
  
  flag = true;
  hConst.next();   
  hConst.next();
  hConst.next();
  hConst.next();
  result = hConst.next();
  
  while(!hConst.hasNextDouble())
  {
   hConst.nextLine();
   hConst.next();
   hConst.next();
   hConst.next();
   hConst.next();
   result = hConst.next();
  }
  
  while((result != null) && flag)
  {
   doubRes = Double.parseDouble(result);
   
   if(doubRes == height)
   {
    flag = false;
    result = hConst.next();
    constantC = Double.parseDouble(result);
    System.out.println("ConstantC: " + constantC);
    
   }
   else
   {
    hConst.nextLine();
    hConst.next();
    hConst.next();
    hConst.next();
    hConst.next();
    result = hConst.next();
  
   } 
  }
  
  /*
   * Calculate percent body fat
   */
  
  percentBodyFat = ((constantA + constantB) - constantC)/100;
  
  
 }
  
 if(sex.equals("m"))
 {
  Scanner table = new Scanner(new BufferedReader(
    new FileReader("/home/anne/www/WEB-INF/src/hygeia/maleTable.txt")));
  double wrist, ww;
  
   weight = Double.parseDouble(w);
  
   /*
    * Get 3 Abdomen measurements and take the average
    */

   abd1 = Double.parseDouble(a1);
   abd2 = Double.parseDouble(a2);
   abd3 = Double.parseDouble(a3);
   
   abdomen = (abd1 + abd2 + abd3)/3;
   abdomen = f* Math.round(abdomen/f);
   System.out.println(abdomen);
   
         // wrist measurement
   wrist = Double.parseDouble(wr);
   System.out.println(wrist);
   
   /*
    * Wrist - Waist value used for table look up 
    */
   
   ww = abdomen - wrist;
   
   /*
    * Find values in table
    */
   
   int col = 1;

   result = table.next();

   while(Double.parseDouble(result) != ww)
   {
    result = table.next(); 
    col++;
   }
   
   System.out.println("Waist - Wrist:  " + result);
   table.nextLine();
   result = table.next();
   
   while(Double.parseDouble(result) != weight)
   {
    table.nextLine();
    result = table.next();
   }
   
   System.out.println("Weight:  " + result);
   
   for(int i = 0; i < col; i++)
   {
    result = table.next();
    percentBodyFat = (Double.parseDouble(result))/100;
   }
   
   System.out.println(percentBodyFat + "% body fat");
   
 }
 return percentBodyFat;
}

public static double leanBodyMass(double weight, double percentBodyFat)
{
  // Declaration
  double leanBodyMass;
  double bodyFat = 0;
  
  /*
   * Calculate Lean Body Mass
   */
  bodyFat = weight * percentBodyFat;
  leanBodyMass = weight - bodyFat;
  leanBodyMass = f* Math.round(leanBodyMass/f);
  System.out.println(leanBodyMass + " is your lean body" +
    " mass.");
 
  return leanBodyMass;
 
}

public static double protein(double leanBodyMass, int activLevel)
{  
	double act = 0;
	double protein;
	
	if(activLevel == 1)
	{
		act = 0.5;
	}
	if(activLevel == 2)
	{
		act = 0.6;
	}
	if(activLevel == 3)
	{
		act = 0.7;
	}
	if(activLevel == 4)
	{
		act = 0.8;
	}
	if(activLevel == 5)
	{
		act = 0.9;
	}
	if(activLevel == 6)
	{
		act = 1.0;
	}
	
  /*
   * Calculate protein requirement
   */
  
  protein = leanBodyMass * act;
  protein = f* Math.round(protein/f);
  
  System.out.println(protein + " is you daily protein requirement.");
  
  return protein;
}

}
