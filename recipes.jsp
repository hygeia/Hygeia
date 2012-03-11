<<<<<<< HEAD
<%@ page import = "hygeia.*" %>
=======
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">

<head>
    <link type="text/css" rel="stylesheet" href="style.css" />
>>>>>>> f6ca7a8af3c6087e83c7c1d72317fe743dc47143

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

<<<<<<< HEAD
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
=======
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
>>>>>>> f6ca7a8af3c6087e83c7c1d72317fe743dc47143
}
</style>

</head>
<body>
    <div id="page">
	      <div id="header">

<<<<<<< HEAD
/* Display Navigation Bar */
=======
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
>>>>>>> f6ca7a8af3c6087e83c7c1d72317fe743dc47143

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

<<<<<<< HEAD
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
=======
</body>
</html>
>>>>>>> f6ca7a8af3c6087e83c7c1d72317fe743dc47143
