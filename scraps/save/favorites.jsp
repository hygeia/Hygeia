<!--
        Filename: favorites.jsp
        Description: Proccess all requests to add or remove meals from the
		     user's favorite list. The Page should list all the user's
		     favorites.
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
String name = u.getUserName();

Favorites f = new Favorites(u);

if(request.getParameter(removeFromFavorites).equals("removeFromFavorites"))
{
 f.removeMeal(meal[i]);
}

if(request.getParameter("addToFavorite") != null)
{
 f.addMeal(meal[i]);
}

Meal[] meal = f.getFavorites();

// Start form
String s = "<form action=\"favorites.jsp\" method=\"post\">";

// Go through each favorite meal
for(int i = 0; i< meal.length; i++)
{
 String mealName = meal[i].getName();
 s = s + mealName + "</br>";

 int mid = meal[i].getMid();
  s = s + " <input type=\"hidden\" name=\""+ mid + "\">";
        
  s = s + " <input type=\"hidden\" name=\"removeFromFavorites\"" + 
            "value=\"removeFromFavorites\">";
  s = s + "<input type=\"submit\" name = \"Remove\">";

 List<String> food = meal[i].getFoodList }
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

// End Form
s = s + "</form>";
 
%>

<HTML>
<BODY>

<!-- Ask user if they would like to add meal to history -->
<h1>Add favorite</h1>

</br>

<form action="favorites.jsp" method="post">
<input type="hidden" name="mid">
<input type="hidden" name="addToFavorites" value="addToFavorites">
<input type="submit" name="Add">
</form>
</br>

<h1><%= name %>'s Favorite Meals </h1>  
<P><%= s %>

</BODY>
</HTML>

