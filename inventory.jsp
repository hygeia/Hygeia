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
    boolean r = inv.removeFood(new Food.Update(fid, count));
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
        String s = "<tr><form action='inventory.jsp' method='post'>" +
            "<input type='hidden' name='fid' value=" + f.getFid() + ">" +
            "<td>" + f.getName() + "</td><td>Amount to Add: </td><td> <input name='count'" +
            "><input type='hidden' name='addToInventory' value=1><input type='submit'" +
            " value='Add!'></td></form></tr>\n";
        searchDisp += s;
    }
    searchDisp += "</table>\n";
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

Food.List[] arr = inv.getInventoryList();
if (arr == null) {
    response.sendRedirect("error.jsp?code=1&echo=Could not fetch inventory");
    db.close();
    return;
}

/* Produce table of foods, with remove forms */
String invDisp = "<table style='margin:auto auto;'>\n";
for (Food.List f : arr) {
    String s = "<tr><form action='inventory.jsp' method='post'>" +
        "<input type='hidden' name='fid' value=" + f.getFid() + ">" +
        "<td>" + f.getName() + "</td><td>Amount: <input name='count' " +
        "value=" + f.getCount() + "><input type='hidden' name='" +
        "removeFromInventory' value=1><input type='submit' value='Remove'>" +
        "</td></form></tr>\n";
    invDisp += s;
}
invDisp += "</table>\n";

db.close();

 
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">

<head>
    <link type="text/css" rel="stylesheet" href="style.css" />

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

</head>
<body>
    <div id="page">
	      <div id="header">

<!-- Navigation Bar -->

<table cellpadding="0" cellspacing="0">
<tr>
<td> <a href="index.jsp"><img src="images/lightICON1.png" style="margin-right: 10px;"></a></td>
<td> <a href="inventory.jsp"><img src="images/darkICON2.png" style="margin-left: -10px; margin-right:8px" href="index.jsp"></a></td>
<td> <a href="favorites.jsp"><img src="images/lightICON3.png" style="margin-left: -10px;"></a></td>
<td> <a href="history.jsp"><img src="images/lightICON4.png" style="margin-left: -10px;"></a></td>
<td> <a href="recipes.jsp"><img src="images/lightICON5.png" style="margin-left: -10px;"></a></td>
<td> <img src="images/lightICON6.png" style="margin-left: -10px;"></td>
</tr>
</table>

<br />

<h1><%= username %>'s Inventory</h1>

<%= invDisp %>

<br><br>

<h2>Add a Food to Your Inventory</h2>
<form action="inventory.jsp" method="post">
  <p>Enter part of the food's name: <input name="nameSearch" />
  <input type="hidden" name="searchForFood" value=1 />
  <input type="submit" value="Find It!"/>
</form>

<%= searchDisp %>

<!--
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
-->
</div>
</div>

</body>
</html>
