<!--
	Filename: history.jsp
	Description: display the meals that the use has eatten.
		     User should be able to add and remove items from
		     their history as desired.
-->
<%@ page import = "hygeia.*,java.util.*,java.sql.Timestamp,java.text.*" %>
<%
 /* Check to see if a session exists */
if (session.getAttribute("uid") == null) {
    /* Send away non-logged in users */
    response.sendRedirect("index.jsp");
    return;
}

Database db = new Database();
int uid = (Integer)session.getAttribute("uid");
User u = new User(db, uid);
History history = new History(u);
//Meal.List meals[] = history.getHistory();

String historyForm = "";
String searchDisp = "";

if(request.getParameter("removeFromHistory")!= null)
{
 int mid = Integer.parseInt(request.getParameter("mid"));
 String o = request.getParameter("occurrence"); 
 SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss.SSS");
 java.util.Date parsedDate = dateFormat.parse(o);
 java.sql.Timestamp occur = new java.sql.Timestamp(parsedDate.getTime()); 
 
 Meal meal = new Meal(db, mid);
 boolean check = history.removeMeal(meal, occur);
 
 searchDisp = "";

 if(check == false)
 {
  response.sendRedirect("error.jsp?code=2&echo=Could not remove");
  db.close();
  return;
 }
}
/*
if(request.getParameter("addToHistory") != null)
{
 int mid = Integer.parseInt(request.getParameter("mid"));
 String o = request.getParameter("occurrence");
 SimpleDateFormat dateFormat = new SimpleDateFormat("MM-dd hh:mm");
 //yyyy-MM-dd hh:mm:ss.SSS");
 java.util.Date parsedDate = dateFormat.parse(o);
 java.sql.Timestamp occur = new java.sql.Timestamp(parsedDate.getTime());    
   
 Meal meal = new Meal(db, mid);
 boolean check = history.addMeal(meal, occur);

 if(check == false)
 {
  response.sendRedirect("error.jsp?code=2&echo=Could not add meal");
  db.close();
  return;
  }
 }

if(request.getParameter("searchForMeal") != null)
{
 String term = request.getParameter("nameSearch");
 Meal.List meal[] = history.getAvailableMeals(term);
 
 if (meal == null) 
 {
   response.sendRedirect("error.jsp?code=1&echo=Could not fetch meal");
   db.close();
   return;
 }
 
 searchDisp = "<table style='margin:auto auto;'>\n";

 for(Meal.List m : meal)
 {
  if(m == null){
	response.sendRedirect("error.jsp?code=1&echo=Could not fetch meal");
    db.close();
    return;
  }
  String s = "<tr><form action='history.jsp' method='post'>" +
	"<input type='hidden' name='mid' value='" + m.getMid() + "'>" +
	"<td>" + m.getName() + "</td><td> Occurrence(MM-dd hh:mm):"+
 	"(<input type='text' name='occurrence'> <input type='hidden'"+
	" name='addToHistory' value=1><input type='submit' value='Add!'></td> "
	+ "</form></tr>\n"; 
  searchDisp += s;
 } 
 
}
*/
// String to display when not history exists
String noHistory = "";

// display history
Meal.List[] meals = history.getHistory();
if( meals == null )
{
 noHistory = "So far you have no meals in your history.";
}

String histDisp = "<table style='margin:auto auto;'>\n";

if( meals != null )
{
 for(Meal.List m : meals)
 {
  if( m == null){
   noHistory = "So far you have no meals in your history.";
   break; 
  }
  String name = m.getName();
  int mid = m.getMid();
  Timestamp  occurrence = m.getOccurrence();
  
  histDisp += "<form action='history.jsp' method='post'>" +
  	 "<input type='hidden' name='mid' value='"+ mid +"'>" + name + " Date: " +
  	 "<input type='hidden' name='occurrence' value='" + occurrence + "'>" + occurrence + 
	 "<input type='hidden' name='removeFromHistory'" +
	" value='1'> <input type='submit' value='Remove'>"+
  	"<form action='history.jsp' method='post'> </br></form>\n"; 
	
 }
 
 histDisp += "</table>\n";

ArrayList<Meal> todayarr = new ArrayList<Meal>();
ArrayList<Meal> onedayarr = new ArrayList<Meal>();
ArrayList<Meal> twodayarr = new ArrayList<Meal>();
ArrayList<Meal> threedayarr = new ArrayList<Meal>();
ArrayList<Meal> fourdayarr = new ArrayList<Meal>();
ArrayList<Meal> fivedayarr = new ArrayList<Meal>();
ArrayList<Meal> sixdayarr = new ArrayList<Meal>();

for(int i=0; i<meals.length; i++){
	switch(findDay(meals[i])){
		case 0:
			todayarr.add(new Meal(db, meals[i].getMid()));
			break;
		case 1:
			onedayarr.add(new Meal(db, meals[i].getMid()));
			break;
		case 2:
			twodayarr.add(new Meal(db, meals[i].getMid()));
			break;
		case 3:
			threedayarr.add(new Meal(db, meals[i].getMid()));
			break;
		case 4:
			fourdayarr.add(new Meal(db, meals[i].getMid()));
			break;
		case 5:
			fivedayarr.add(new Meal(db, meals[i].getMid()));
			break;
		case 6: 
			sixdayarr.add(new Meal(db, meals[i].getMid()));
			break;
		}
	}

// declaration of variables
double tempc = 0; // temp carb count 
double tempp = 0; // temp protein count
double tempf = 0; // temp fat count

//blocks in this order [protein,carbs,fat] 
double[] block1 = {0, 0, 0}; // today
double[] block2 = {0, 0, 0}; // 1 day ago
double[] block3 = {0, 0, 0}; // 2 days ago
double[] block4 = {0, 0, 0}; // 3 days ago
double[] block5 = {0, 0, 0}; // 4 day ago
double[] block6 = {0, 0, 0}; // 5 days ago
double[] block7 = {0, 0, 0}; // 6 days ago

for(int i=0; i<todayarr.size(); i++){
	Nutrition nuts = todayarr.get(i).getNutrition();
	tempc += nuts.getCarbohydrates();
	tempp += nuts.getProtein();
	tempf += nuts.getFat();
}
block1[0]= tempp / 7;
block1[1]= tempc / 9;
block1[2]= tempf / 1.5;

// Reset temp values to 0
tempc = 0;
tempp = 0;
tempf = 0;

for(int i=0; i<onedayarr.size(); i++){
	Nutrition nuts = onedayarr.get(i).getNutrition();
	tempc += nuts.getCarbohydrates();
	tempp += nuts.getProtein();
	tempf += nuts.getFat();
}
block2[0]= tempp / 7;
block2[1]= tempc / 9;
block2[2]= tempf / 1.5;

// Reset temp values to 0
tempc = 0;
tempp = 0;
tempf = 0;

for(int i=0; i<twodayarr.size(); i++){
	Nutrition nuts = twodayarr.get(i).getNutrition();
	tempc += nuts.getCarbohydrates();
	tempp += nuts.getProtein();
	tempf += nuts.getFat();
}
block3[0]= tempp / 7;
block3[1]= tempc / 9;
block3[2]= tempf / 1.5;

// Reset temp values to 0
tempc = 0;
tempp = 0;
tempf = 0;

for(int i=0; i<threedayarr.size(); i++){
	Nutrition nuts = threedayarr.get(i).getNutrition();
	tempc += nuts.getCarbohydrates();
	tempp += nuts.getProtein();
	tempf += nuts.getFat();
}
block4[0]= tempp / 7;
block4[1]= tempc / 9;
block4[2]= tempf / 1.5;

// Reset temp values to 0
tempc = 0;
tempp = 0;
tempf = 0;

for(int i=0; i<fourdayarr.size(); i++){
	Nutrition nuts = fourdayarr.get(i).getNutrition();
	tempc += nuts.getCarbohydrates();
	tempp += nuts.getProtein();
	tempf += nuts.getFat();
}
block5[0]= tempp / 7;
block5[1]= tempc / 9;
block5[2]= tempf / 1.5;

// Reset temp values to 0
tempc = 0;
tempp = 0;
tempf = 0;

for(int i=0; i<fivedayarr.size(); i++){
	Nutrition nuts = fivedayarr.get(i).getNutrition();
	tempc += nuts.getCarbohydrates();
	tempp += nuts.getProtein();
	tempf += nuts.getFat();
}
block6[0]= tempp / 7;
block6[1]= tempc / 9;
block6[2]= tempf / 1.5;

// Reset temp values to 0
tempc = 0;
tempp = 0;
tempf = 0;

for(int i=0; i<sixdayarr.size(); i++){
	Nutrition nuts = sixdayarr.get(i).getNutrition();
	tempc += nuts.getCarbohydrates();
	tempp += nuts.getProtein();
	tempf += nuts.getFat();
}
block7[0]= tempp / 7;
block7[1]= tempc / 9;
block7[2]= tempf / 1.5;

// Reset temp values to 0
tempc = 0;
tempp = 0;
tempf = 0;

/* debugging statements 
out.println("Today: p" +block1[0]);
out.println("c"+block1[0]);
out.println("f" +block1[0]);

out.println("1 day b4: p"+block2[0]);
out.println("c"+block2[1]);
out.println("f"+block2[2]);

out.println("2 day b4: p"+block3[0]);
out.println("c"+block3[1]);
out.println("f"+block3[2]);

out.println("3 day b4: p"+block4[0]);
out.println("c"+block4[1]);
out.println("f"+block4[2]);

out.println("4 day b4: p"+block5[0]);
out.println("c"+block5[1]);
out.println("f"+block5[2]);

out.println("5 day b4: p"+block6[0]);
out.println("c"+block6[1]);
out.println("f"+block6[2]);

out.println("6 day b4: p"+block7[0]);
out.println("c"+block7[1]);
out.println("f"+block7[2]);
*/

}
%>
<%!
	/* 0 = today, 1 = yesterday, 2 = two days ago, 3 = three days ago, 4 = more than three days ago -1 = future*/
	int findDay(Meal.List m){
		Calendar c = Calendar.getInstance(TimeZone.getTimeZone("America/Los_Angeles"));
		/*int year = c.get(Calendar.YEAR);
 * 		int month = c.get(Calendar.MONTH);
 * 				int day = c.get(Calendar.DAY_OF_MONTH);
 * 						c.set(year, month, day, 0, 0);*/
		c.set(Calendar.HOUR_OF_DAY, 0);
		c.set(Calendar.MINUTE, 0);
		c.set(Calendar.SECOND, 0);
		Timestamp tomorrow = new Timestamp(c.getTimeInMillis() + 86400000);
		Timestamp today = new Timestamp(c.getTimeInMillis());
		Timestamp yesterday = new Timestamp(c.getTimeInMillis() - 86400000);
		Timestamp twoday = new Timestamp(c.getTimeInMillis() - (86400000 * 2));
		Timestamp threeday = new Timestamp(c.getTimeInMillis() - (86400000 * 3));
		Timestamp fourday = new Timestamp(c.getTimeInMillis() - (86400000 * 4));
		Timestamp fiveday = new Timestamp(c.getTimeInMillis() - (86400000 * 5));
		Timestamp sixday = new Timestamp(c.getTimeInMillis() - (86400000 * 6));

		if(m == null){
			return -1;
		}else if(m.getOccurrence().after(tomorrow)){
			return -1;
		}else if(m.getOccurrence().after(today)){
			return 0;
		}else if(m.getOccurrence().after(yesterday)){
			return 1;
		}else if(m.getOccurrence().after(twoday)){
			return 2;
		}else if(m.getOccurrence().after(threeday)){
			return 3;
                }else if(m.getOccurrence().after(fourday)){
                        return 4;
		}else if(m.getOccurrence().after(fiveday)){
                        return 5;
                }else if(m.getOccurrence().after(sixday)){
                        return 6;
		}else{
			return 7;
		}
	}


 %>
<HTML>
<head>
  <title>History | Hygeia</title>
  <link type="text/css" rel="stylesheet" href="style.css" />
    <link rel="shortcut icon" href="favicon.ico" mce_href="favicon.ico"/> 
</head>
<BODY>
    <div id="page">
	<div id="content">
      <div id="header">
        <table cellpadding="0" cellspacing="0">
<tr>
<td> <a href="home.jsp"><img src="images/lightICON1.png"></a></td>
<td> <a href="inventory.jsp"><img src="images/lightICON2.png"></a></td>
<td> <a href="history.jsp"><img src="images/lightICON3.png"></a></td>
<td> <a href="recipes.jsp"><img src="images/lightICON4.png"></a></td>
<td> <a href="profile.jsp"><img src="images/lightICON5.png"></a></td>
<td> <a href="favorites.jsp"><img src="images/lightICON6.png"></a></td>
<td> <img src="images/lightICON7.png"></td>
<td> <a href="logout.jsp"><img src="images/lightICON8.png"></a></td>
</tr>
</table>
</div>

<!-- Ask user if they would like to add meal to history
Add to history

<form action="history.jsp" method="post">
<p>Enter part of meal name:<input name="nameSearch">
<input type="hidden" name="searchForFood" value=1>
<input type="submit" value="Find It!">
</form>
-->
</br>
<H1> Meal History </H1>
<P>

<%= searchDisp %>

<br>
<%= histDisp %>
<%= noHistory %>
</br>
</br>
<FORM METHOD="POST" id="add_meal" ACTION="addMeal.jsp">
<INPUT TYPE="image" src="images/addMeal.png" VALUE="Submit" />
</div>
</div>
<div id="footer"><a href="about.jsp">About Us</a><br />
		Hygeia is a project developed for a Software Engineering class at UCSD.<br />
        Please contact us at hygeia110@gmail.com if you would like to use any of the code found here.
      </div>
</div>
</BODY>
</HTML>
