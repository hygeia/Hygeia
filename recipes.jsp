<%@ page import = "hygeia.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">

<head>
    <title>Recipes | Hygeia</title>
    <link type="text/css" rel="stylesheet" href="style.css" />
    <link rel="shortcut icon" href="favicon.ico" mce_href="favicon.ico"/> 

    <style type="text/css">
      #image {
        background-image: url('images/DEFAULTPIC.png');
        width: 190px;
        height: 190px;
        margin: 0 auto;
        position: relative;
        z-index: 10;
        margin-right: 10px;
      }

      .trans {
        opacity:.50;filter:
        alpha(opacity=50);
        -moz-opacity: 0.50;
        width: 190px;
        height: 60px;
        background: #000000;
        float: none;
        margin-top: 60px;
        position: relative;
        z-index: 50;
        }

        .text {
        float: none;
        display: block;
        position: relative;
        z-index: 90;
        color: #ffffff;
        width: 280px;
        height: 50px;
        padding: 10px;
        font-family: Verdana, Arial, Helvetica, sans-serif;
        font-size: 12px;
        font-weight: bold;
        margin-top: 10px;
      }
</style>
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
String s = "";
/* Form addRecipeToDatabase */

if(request.getParameter("removeRecipesFromDatabase") != null) {
        User u = new User(db, uid);
        History hist = new History(u);
        Meal.List arr[] = hist.getAvailableMeals("");
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
        Meal.List arr[] = hist.getAvailableMeals("");
       
        for (int i = 0; i < arr.length; i++) {
                s = "<form action=\"recipes.jsp\" method=\"post\">";
	    		 s += arr[i].getName();
                s += " <input type=\"hidden\"name=\"mid\" value=" + 
				arr[i].getMid() + ">";
                s+= "<input type=\"hidden\" name=\"addRecipesToDatabase\" value=\"addRecipesToDatabase\"> <input type=\"submit\">  </form>";
        }
}
%>
<!-- ======= -->

</head>
<body>
    <div id="page">
       <div id="content">
	      <div id="header">

<%
/* Display Navigation Bar */
%>

<!-- Navigation Bar -->

<table cellpadding="0" cellspacing="0">
<tr>
<td> <a href="home.jsp"><img src="images/lightICON1.png"></a></td>
<td> <a href="inventory.jsp"><img src="images/lightICON2.png"></a></td>
<td> <a href="history.jsp"><img src="images/lightICON3.png"></a></td>
<td> <a href="recipes.jsp"><img src="images/darkICON4.png"></a></td>
<td> <a href="profile.jsp"><img src="images/lightICON5.png"></a></td>
<td> <a href="favorites.jsp"><img src="images/lightICON6.png"></a></td>
<td> <img src="images/lightICON7.png"></td>
<td> <a href="logout.jsp"><img src="images/lightICON8.png"></a></td>
</tr>
</table>

<br />

<div align="center">
<table>
<tr>
<td>
<div id="image">
<div id="image">
<div class="text" style="text-align:left">
<br/><br/><br/><br/><br/><br/><br/><br/>
white eggs<br/>
quantity: 
</div>
<div class="trans">
</div>
</div>
</td>

<td>
<div id="image">
<div id="image">
<div class="text" style="text-align:left">
<br/><br/><br/><br/><br/><br/><br/><br/>
white eggs<br/>
quantity: 
</div>
<div class="trans">
</div>
</div>
</td>

<td>
<div id="image">
<div id="image">
<div class="text" style="text-align:left">
<br/><br/><br/><br/><br/><br/><br/><br/>
white eggs<br/>
quantity: 
</div>
<div class="trans">
</div>
</div>
</td>

<td>
<div id="image">
<div id="image">
<div class="text" style="text-align:left">
<br/><br/><br/><br/><br/><br/><br/><br/>
white eggs<br/>
quantity: 
</div>
<div class="trans">
</div>
</div>
</td>
</tr>



<tr>
<td>
<div id="image">
<div id="image">
<div class="text" style="text-align:left">
<br/><br/><br/><br/><br/><br/><br/><br/>
white eggs<br/>
quantity: 
</div>
<div class="trans">
</div>
</div>
</td>

<td>
<div id="image">
<div id="image">
<div class="text" style="text-align:left">
<br/><br/><br/><br/><br/><br/><br/><br/>
white eggs<br/>
quantity: 
</div>
<div class="trans">
</div>
</div>
</td>

<td>
<div id="image">
<div id="image">
<div class="text" style="text-align:left">
<br/><br/><br/><br/><br/><br/><br/><br/>
white eggs<br/>
quantity: 
</div>
<div class="trans">
</div>
</div>
</td>

<td>
<img src="images/addItemLARGEICON.png" style="margin-top:10px;">
</td>
</tr>

</table>
</div>

</div>
</div>
<div id="footer"><a href="about.jsp">About Us</a><br />
		Hygeia is a project developed for a Software Engineering class at UCSD.<br />
        Please contact us at hygeia110@gmail.com if you would like to use any of the code found here.
      </div>
</body>
</html>

<!-- Not sure what this is, commenting out for now --Link --
<html>
<head><title>Recipes | Hygeia</title></head>
<body>
<%= s %>
</body>
</html>

</body>
</html>
