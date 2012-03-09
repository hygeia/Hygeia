<!--
	Filename: history.jsp
	Description: display the meals that the use has eatten.
		     User should be able to add and remove items from
		     their history as desired.
-->

<%@ page import = "hygeia.*" %>
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
History h = new History(u);

if(request.getParameter(removeFromHistory).equals("removeFromHistory"))
{
 h.removeMeal(meal[i], occur);
}

if(request.getParameter("addMeal") != null)
{
 h.addMeal(meal, occur);
}

Meal[] meal = h.getHistory();

// Start form
String s = " <form action=\"history.jsp\" method=\"post\">";

// Go through each meal
for(int i = 0; i<meal.length; i++)
{
 int mid = meal[i].getMid();
 s = s + "<input type=\"hidden\" name=\""+ mid +"\">";

 String mealName = meal[i].getName();
 s = s + mealName + "</br>";

 String occurrence = meal[i].getOccurrence().toString();
 s = s + "<input type= \"hidden\" name=\"" + occurrence + "\">";
 s = s + occurence + "</br>";

 s = s + "<input type=\"hidden\" name=\"removeFromHistory\" value=\"removeFromHistory\">";
 s = s + "<input type=\"submit\" name=\"Remove\">";
 s = s + "</form>";

 List<String> food = meal[i].getFoodList();
 Iterator<String> it = food.iterator();

 while(it.hasNext())
 {
  String item = (String)it.next();
  s = s + "<br>" + item + "</br>";
 }

 Nutrition nut = meal[i].getNutrition();
 s = s + "Calories: " + nut.cals + " Carbohydrates: " + nut.carbs + 
	" Fat: " + nut.fat + " Protein: " + nut.pro + "</br>"; 
}

// End form
s = s + "</form>";


%>     

<HTML>
<BODY>

<!-- Ask user if they would like to add meal to history -->
<h1>Add to history</h1>

<form action="history.jsp" method="post">
<input type="hidden" name="mid">
<input name="occurrence">
<input type="hidden" name="addToHistory" value="addToHistory">
<input type="submit" name:"Add">
</form>
</br>
<H1> Meal History </H1>
<P><%= s %>

</BODY>
</HTML>
