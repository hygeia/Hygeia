<%@ page import = "hygeia.*" %>
<%
/* Check to see if a session exists */
if (session.getAttribute("uid") == null) {
    /* Send away non-logged in users */
    response.sendRedirect("index.jsp");
    return;
}

/*
   Retrieve whatever data is needed and do any processing here. Try to do all
   database interactions and processing before any HTML, so that the page 
   can be redirected to an error page if soemthing should go wrong. Remember
   to close the database when you are done with it!
   
   Some common tasks:
   Get user id: int uid = (Integer)session.getAttribute("uid");
   Get username: String username = (String)session.getAttribute("username");
   Connect to the database: Database db = new Database();
   Create a user object: User u = new User(db, uid);
   Close the database: db.close();
   Redirect to another page: response.sendRedirect("url"); return;
 */
 

Database db = new Database();
int uid = (Integer)session.getAttribute("uid");
String username = (String)session.getAttribute("username");
User u = new User(db, uid);
Inventory inv = new Inventory(u);

String searchDisp = "";

if (request.getParameter("removeFromInventory") != null) {
    int fid = Integer.parseInt(request.getParameter("fid"));
    double count=Double.parseDouble(request.getParameter("count"));
    boolean r = inv.updateFood(new Food.Update(fid, count));
    if (r == false) {
        response.sendRedirect("error.jsp?code=2&echo=Could not update" +
            " inventory");
        db.close();
        return;
    }
}

if (request.getParameter("searchForFood") != null) {
    String term = request.getParameter("nameSearch");
    Food.List avail[] = inv.getAvailableFoods(term);
    if (avail == null) {
        response.sendRedirect("error.jsp?code=1&echo=Could not fetch foods");
        db.close();
        return;
    }
    searchDisp = "<table style='margin:auto auto;'>\n";
    for (Food.List f : avail) {
		if( f == null ){
		    continue;
			/* response.sendRedirect("error.jsp?code=1&echo=Error finding foods with name " + term);
			db.close();
			return; */
		}
        String s = "<tr><form action='inventory.jsp' method='post'>" +
            "<input type='hidden' name='fid' value=" + f.getFid() + ">" +
            "<td>" + f.getName() + "</td><td>Amount (g) to Add: </td><td> <input name='count'" +
            "><input type='hidden' name='addToInventory' value=1><input type='image'" +
            " src='images/plus.png' width='25' height='25'></td></form></tr>\n";
        searchDisp += s;
    }
    searchDisp += "</table>\n<h3>If you can't find your food, create it!</h3><table>\n" +
        "<p>Enter the name of the food, the weight of a serving in grams, the" +
        " number of calories in a serving, and the amount of carbohydrates, " +
        "protein, and fat in grams per serving.</p>" +
        "<form action='inventory.jsp' method='post'><tr><td>Food Name: <input name='name'></td>" +
        "<td>Serving Size: <input name='serving'></td></tr>" +
        "<tr><td>Calories: <input name='calories'></td><td>Carbohydrates: <input " +
        "name='carbohydrates'></td><td>Protein: <input name='protein'></td></tr><tr><td>Fat: " +
        "<input name='fat'></td><td><input type='hidden' name='addFoodToDatabase' value=1>" +
        "<input type='submit' value='Create Food!'></td></tr></form></table>\n";
}

if (request.getParameter("addToInventory") != null) {
    int fid = Integer.parseInt(request.getParameter("fid"));
    double count = Double.parseDouble(request.getParameter("count"));
    boolean r = inv.addFood(new Food.Update(fid, count));
    if (r == false) {
        response.sendRedirect("error.jsp?code=2&echo=Could not update inventory");
        db.close();
        return;
    }
}

if (request.getParameter("addFoodToDatabase") != null) {
    String name = (String)request.getParameter("name");
    double serving = Double.parseDouble(request.getParameter("serving"));
    double calories = Double.parseDouble(request.getParameter("calories"));
    double carbohydrates = Double.parseDouble(request.getParameter("carbohydrates"));
    double protein = Double.parseDouble(request.getParameter("protein"));
    double fat = Double.parseDouble(request.getParameter("fat"));
    double factor = 1/serving;
    
    Food.Create cf = new Food.Create(name, factor, serving, calories, 
        carbohydrates, protein, fat);
        
    Food.createFood(u, cf);
}

Food.List[] arr = inv.getInventoryList();
if (arr == null) {
    response.sendRedirect("error.jsp?code=1&echo=Could not fetch inventory");
    db.close();
    return;
}

/* Produce table of foods, with remove forms */
String invDispPics = "<table>";
for (int i = 0; i < arr.length; i++) {
	Food.List f = arr[i];
	if( f == null ){
		response.sendRedirect("error.jsp?code=1&echo=Error diplaying food");
		db.close();
		return;
	}
	if(i%4==0) {invDispPics += "<tr>";}
	String d = "<td><div id='image'><div id='image'><div class='text' style='text-align:left'>" +
		"<br /><br /><br /><br /><br /><br /><br /><br /><br />" + f.getName() + "<br />" +
		"quantity: " + f.getCount() + "g</div><div class='trans'></div></div>" +
		"<form action='inventory.jsp' method='post'>" +
        "<input type='hidden' name='fid' value=" + f.getFid() + ">" +
        "Amount: <input name='count' size=2 " +
        "value=" + f.getCount() + "><input type='hidden' name='" +
        "removeFromInventory' value=1><input type='submit' value='Update'>" +
        "</form>\n</td>";
	invDispPics += d;
	if(i%4==3) {invDispPics += "</tr>";}
}
invDispPics += "</table>";

db.close();

 
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">

<head>
	<title>Inventory | Hygeia</title>
    <link type="text/css" rel="stylesheet" href="style.css" />
    <link rel="shortcut icon" href="favicon.ico" mce_href="favicon.ico"/> 

	<style type="text/css">
#image {
background-image: url('images/DEFAULTPIC.png');
width: 190px;
height: 190px;
margin: 0;
position: relative;
z-index: 10;
margin-right: 10px;
margin-top: 30px;
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
width: 190px;
height: 50px;
padding: 10px;
font-family: Verdana, Arial, Helvetica, sans-serif;
font-size: 12px;
font-weight: bold;
margin-top: 10px;
}
	</style>

</head>
<body>
    <div id="page">
	      <div id="header">

<!-- Navigation Bar -->

<table cellpadding="0" cellspacing="0">
<tr>
<td> <a href="home.jsp"><img src="images/lightICON1.png"></a></td>
<td> <a href="inventory.jsp"><img src="images/darkICON2.png"></a></td>
<td> <a href="history.jsp"><img src="images/lightICON3.png"></a></td>
<td> <a href="recipes.jsp"><img src="images/lightICON4.png"></a></td>
<td> <a href="profile.jsp"><img src="images/lightICON5.png"></a></td>
<td> <a href="favorites.jsp"><img src="images/lightICON6.png"></a></td>
<td> <img src="images/lightICON7.png"></td>
<td> <a href="logout.jsp"><img src="images/lightICON8.png"></a></td>
</tr>
</table>
	</div>
	<div id="content">

<br />

<h1><%= username %>'s Inventory</h1>

<div id="pics">
<%= invDispPics %>
</div>

<br><br>

<p class="addFood">Add a Food to Your Inventory</p>
<form action="inventory.jsp" method="post">
  <p>Enter part of the food's name: <input name="nameSearch" />
  <input type="hidden" name="searchForFood" value=1 />
  <input type="submit" value="Find It!"/>
</form>

<div id="textWrapperInventory"><%= searchDisp %></div>
</div>
</div>
<div id="footer"><a href="about.jsp">About Us</a><br />
		Hygeia is a project developed for a Software Engineering class at UCSD.<br />
        Please contact us at hygeia110@gmail.com if you would like to use any of the code found here.
      </div>

</body>
</html>
