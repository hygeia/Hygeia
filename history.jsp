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
  String s = "<tr><form action='history.jsp' method='post'>" +
	"<input type='hidden' name='mid' value='" + m.getMid() + "'>" +
	"<td>" + m.getName() + "</td><td> Occurrence(MM-dd hh:mm):"+
 	"(<input type='text' name='occurrence'> <input type='hidden'"+
	" name='addToHistory' value=1><input type='submit' value='Add!'></td> "
	+ "</form></tr>\n"; 
  searchDisp += s;
 } 
 
}

// display history
Meal.List meals[] = history.getHistory();
if( meals == null )
{
 response.sendRedirect("error.jsp?code=1&echo=Could not fetch history");
 db.close();
 return;
}

String histDisp = "<table style='margin:auto auto;'>\n";

 for(Meal.List m : meals)
 {
  String name = m.getName();
  int mid = m.getMid();
  Timestamp  occurrence = m.getOccurrence();

  histDisp += "<form action='history.jsp' method='post'>" +
  	 "<input type='hidden' name='"+ mid +"'>" + name + " Date: " +
  	 "<input type= 'hidden' name='" + occurrence + "'>" +
	 occurrence + "</br> <input type='hidden' name='removeFromHistory'" +
	" value='removeFromHistory'> <input type='submit' value='Remove'>"+
  	"<form action='history.jsp' method='post'> </form>\n";
 }
 
 histDisp += "</table>\n";

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

<form action="history.jsp" method="post">
<p>Enter part of meal name:<input name="nameSearch">
<input type="hidden" name="searchForFood" value=1>
<input type="submit" value="Find It!">
</form>
</br>
<H1> Meal History </H1>
<P>

<<<<<<< HEAD
<%= searchDisp %>

<br>
<%= histDisp %>
=======
</div>
<div id="footer"><a href="about.jsp">About Us</a><br />
		Hygeia is a project developed for a Software Engineering class at UCSD.<br />
        Please contact us at hygeia110@gmail.com if you would like to use any of the code found here.
      </div>
</div>
>>>>>>> 639da075249cec58b72df1485127bb1107b93e19
</BODY>
</HTML>
