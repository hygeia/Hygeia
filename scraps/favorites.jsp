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
String username = (String)session.getAttribute("username");
User u = new User(db, uid);

Favorites fav = new Favorites(u);

//Remove from favorite if removeFromFavorite is triggered
if (request.getParameter("removeFromInventory") != null) 
{
    int mid = Integer.parseInt(request.getParameter("mid"));
    Meal meal = new Meal(db, mid);

    boolean r = fav.removeMeal(meal);

    if (r == false) 
    {
        response.sendRedirect("error.jsp?code=2&echo=Could not remove");
        db.close();
        return;
    }
}

// check if user searched for meal
History h = new History(u);
String searchDisp = "";

if (request.getParameter("searchForMeal") != null) 
{
    String term = request.getParameter("nameSearch");
    Meal.List arr[] = h.getAvailableMeals(term);
    if (arr == null) 
    {
        response.sendRedirect("error.jsp?code=1&echo=Could not fetch meals");
        db.close();
        return;
    }
 searchDisp = "<table style='margin:auto auto;'>\n";
 for (Meal.List m : arr) 
 {
        String s = "<tr><form action='favorites.jsp' method='post'>" +
            "<input type='hidden' name='mid' value='" + m.getMid() + "'>" +
            "<td>" + m.getName() + "<input type='hidden' name='addToFavorites'"
	     + " value=1><input type='submit' value='Add!'></td></form></tr>\n";
        searchDisp += s;
 }

searchDisp += "</table>\n";

}

// Add favorite meal
if (request.getParameter("addToFavorites") != null) 
{
    int mid = Integer.parseInt(request.getParameter("mid"));
    Meal meal = new Meal(db, mid);

    boolean r = fav.addMeal(meal);

    if (r == false)
    {
        response.sendRedirect("error.jsp?code=2&echo=Could not add favorite");
        db.close();
        return;
    }

}

// Produce table of meals

Meal.List meals[] = fav.getFavorites();
if (meals == null) {
    response.sendRedirect("error.jsp?code=1&echo=Could not fetch favorites");
    db.close();
    return;
}

String favDisp = "<table style='margin:auto auto;'>\n";
for(Meal.List m : meals)
{
  favDisp += "<tr><form action='favorites.jsp' method='post'>" +
        "<input type='hidden' name='mid' value='" + m.getMid() + "'>" +
        "<td>" + m.getName() + "<input type='hidden' name='" +
        "removeFromFavorites' value=1><input type='submit' value='Remove'>" +
        "</td></form></tr>\n";
}

favDisp += "</table>\n";

db.close();

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
Add to favorites:
<form action="favorites.jsp" method="post">
        <p>Enter part of the meal's name: <input name="nameSearch">
        <input type="hidden" name="searchForMeal" value=1>
        <input type="submit" value="Find it!">
    </form>

<%= favDisp %>

<div id="footer"><a href="about.jsp">About Us</a><br />
                Hygeia is a project developed for a Software Engineering class at UCSD.<br />
        Please contact us at hygeia110@gmail.com if you would like to use any of the code found here.
      </div>
</div>
>>>>>>> 639da075249cec58b72df1485127bb1107b93e19
</BODY>
</HTML>

