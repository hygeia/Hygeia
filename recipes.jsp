<%@ page import = "hygeia.*" %>

<%
/* Check to see if a session exists */
if (session.getAttribute("uid") == null) {
    /* Send away non-logged in users */
    response.sendRedirect("index.jsp");
    return;
}

String username = (String)session.getAttribute("username");
int uid = (Integer)session.getAttribute("uid");
Database db = new Database();

/* Form addRecipeToDatabase */

if(request.getParameter("removeRecipesFromDatabase") != null) {
        User u = new User(db, uid);
        History hist = new History(u);
        MealList arr[] = hist.getAvailableMeals();
        String s = "";
       
        for (int i = 0; i < arr.length; i++) {
                s = "<form action=\"recipes.jsp\" method=\"post\">";
	   	 	 s += arr[i].getName();
                s += " <input type=\"hidden\"name=\"mid\" value=" + 
				arr[i].getMid() + ">";
                s+= "<input type=\"hidden\" name=\"removeRecipesFromDatabase\" value=\"removeRecipesFromDatabase\"> <input type=\"submit\">  </form>";
        }
}

if(request.getParameter("addRecipeToDatabase") != null) {
        User u = new User(db, uid);
        History hist = new History(u);
        MealList arr[] = hist.getAvailableMeals();
        String s = "";
       
        for (int i = 0; i < arr.length; i++) {
                s = "<form action=\"recipes.jsp\" method=\"post\">";
	    		 s += arr[i].getName();
                s += " <input type=\"hidden\"name=\"mid\" value=" + 
				arr[i].getMid() + ">";
                s+= "<input type=\"hidden\" name=\"addRecipesToDatabase\" value=\"addRecipesToDatabase\"> <input type=\"submit\">  </form>";
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
<%= s %>
</form>
</body>
</html>!-- <form method="post" action="recipes.jsp"/> -->
