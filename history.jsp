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
<BODY>

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

</BODY>
</HTML>
