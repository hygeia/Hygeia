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
Meal.List meals[] = history.getHistory();
String historyForm = "";

if(meals != null)
{
 historyForm += "<form action=\"history.jsp\" method=\"post\">";

 for(int i = 0; i<meals.length; i++)
 {
  String name = meals[i].getName();
  int mid = meals[i].getMid();
  Timestamp  occurrence = meals[i].getOccurrence();

  historyForm += "<input type=\"hidden\" name=\""+ mid +"\">" + name + "- ";
  historyForm += "<input type= \"hidden\" name=\"" + occurrence + "\">"
		+ occurrence + "</br>";
  historyForm += "<input type=\"hidden\" name=\"removeFromHistory\" value=\"removeFromHistory\">";
  historyForm +="<input type=\"submit\" name=\"Remove\">";
 
  historyForm += "</form>";
 
 if(request.getParameter("removeFromHistory")!= null)
 {
  Meal newMeal = new Meal(db, mid );
  history.removeMeal(newMeal, occurrence);
 }
}
}
/*
if(request.getParameter("removeFromHistory")!= null)
{
 Meal newMeal = new Meal(db, Integer.parseInt(request.getParameter("mid")));
 Timestamp  occurrence = request.getParameter("occurrence");
 historyForm += "</form>";
 history.removeMeal(newMeal, occurrence);
}
*/
if(request.getParameter("addToHistory")!= null)
{
 Calendar c = Calendar.getInstance();
		int year = c.get(Calendar.YEAR);
		int month = c.get(Calendar.MONTH);
		int day = c.get(Calendar.DAY_OF_MONTH);
		c.set(year, month, day, 0, 0);
		Timestamp today = new Timestamp(c.getTimeInMillis());
 /*out.println(request.getParameter(monthfield ));*/
/*
 Meal newMeal = new Meal(db, request.getParameter("mid"));
 boolean check = history.addMeal(newMeal,today);

 if(!check)
{
 response.sendRedirect("error.jsp");
 return;
}*/
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

<!-- Ask user if they would like to add meal to history -->
Add to history

<form action="addMeal.jsp" method="post">
<input type="hidden" name="mid">
<input type="hidden" name="addToHistory" value="addToHistory">
<input type="submit" value="Add">
</form>
</br>
<H1> Meal History </H1>
<P>

</div>
<div id="footer"><a href="about.jsp">About Us</a><br />
		Hygeia is a project developed for a Software Engineering class at UCSD.<br />
        Please contact us at hygeia110@gmail.com if you would like to use any of the code found here.
      </div>
</div>
</BODY>
</HTML>
