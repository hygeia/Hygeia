<%@ page import = "hygeia.*" %>

<%
/* Check to see if a session exists */
if (session.getAttribute("uid") == null) {
    /* Send away non-logged in users */
    response.sendRedirect("index.jsp");
    return;
}

String username = (String)session.getAttribute("username");
Database db = new Database(); 
int uid =  (Integer)session.getAttribute("uid"); 

/*if(request.getParameter("removeRecipesFromDatabase") != null) {
        User u = new User(db, uid);
        History hist = new History(u);
        MealList arr[] = hist.getAvailableMeals();
        String s = "";
       
        for (int i = 0; i < arr.length; i++) {
                s = "<form action=\"recipes.jsp\" method=\"post\">";
	   	 	 s += arr[i].getName();
                s += " <input type=\"hidden\"name=\"mid\" value=" + 
				arr[i].getMid() + ">";
                s+= "<input type=\"hidden\" name=\"removeRecipesFromDatabase\"" + 
            	value=\"removeRecipesFromDatabase\"> + 
			<input type=\"submit\"> + 
   		 	</form>";
        }
} */

if(request.getParameter("removeRecipesFromDatabase") != null) {
        User u = new User(db, uid);
        History hist = new History(u);
        MealList arr[] = hist.getAvailableMeals();
        String s = "";
       
        for (int i = 0; i < arr.length; i++) {
                s = "<form action=\"recipes.jsp\" method=\"post\">";
                s += arr[i].getName();
                s += "<input type=\"hidden\" name=\"mid\" value="+ arr[i].getMid() + ">";
		s+= "<input type=\"hidden\" name=\"removeRecipesFromDatabase\" " +
			" value=\"removeRecipesFromDatabase\">" +
			" <input type=\"submit\">" +
			" </form>";               
      }
}


/* Display Navigation Bar */

%>

<html>
<head><title>Hygeia</title></head>
<body>
<h1>Hygeia</h1>
<h2>Version 0.8</h2>
<br>
<p><%= username %>'s Recipes: </p>
<!-- <form method="post" action="recipes.jsp"/> -->
<form method="post" action="logout.jsp">
<input type="hidden" name="logout" type="logout" />
<p>Logout: <input type="submit"></p>
</form>
</body>
</html>

