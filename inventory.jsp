<%@ page import = "hygeia.*" %>
<%
/* Check to see if a session exists */
/*if (session.getAttribute("uid") == null) {*/
    /* Send away non-logged in users */
/*    response.sendRedirect("index.jsp");
    return;
}*/

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
 
 
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">

<head>
    <link type="text/css" rel="stylesheet" href="style.css" />

	<style type="text/css">
	.image {
		position:relative;
		float:left;
		
	}
	
	.image .text {
	    position:absolute;

		bottom:0px;
		right:10px;
		height:60px;
		width:190px;
		font-weight:bold;
		font-color:#d4c79b;
	}
	img:transparent{
	  opacity:0.3;
          filter:alpha(opacity=30);
	  background-color:#66614d;<!--#ffffff;-->
	}
	
	</style>

</head>
<body>
    <div id="page">
	      <div id="header">

<!-- Navigation Bar -->

<table cellpadding="0" cellspacing="0">
<tr>
<td> <a href="index.jsp"><img src="images/lightICON1.png"></a></td>
<td> <a href="inventory.jsp"><img src="images/lightICON2.png" style="margin-left: -10px;" href="index.jsp"></a></td>
<td> <a href="favorites.jsp"><img src="images/lightICON3.png" style="margin-left: -5px;"></a></td>
<td> <a href="history.jsp"><img src="images/lightICON4.png" style="margin-left: -10px;"></a></td>
<td> <a href="recipes.jsp"><img src="images/lightICON5.png" style="margin-left: -10px;"></a></td>
<td> <img src="images/lightICON6.png" style="margin-left: -10px;"></td>
</tr>
</table>

<br />


<body>

<br />

<div class="image">
<img src="images/DEFAULTPIC.png" style="margin-left: 60px; margin-right:10px; margin-top:10px">
<div class="text">
    <p>eggs<br />
	quantity: 4</p>
</div>
</div>

<div class="image">
<img src="images/DEFAULTPIC.png" style="margin-left: 20px; margin-right:10px; margin-top:10px">
<div class="text">
	<p>eggs<br />
	quantity: 4</p>
</div>
</div>

<div class="image">
<img src="images/DEFAULTPIC.png" style="margin-left: 20px; margin-right:10px; margin-top:10px">
<div class="text">
	<p>eggs<br />
	quantity: 4</p>
</div>
</div>

<div class="image">
<img src="images/DEFAULTPIC.png" style="margin-left: 20px; margin-right:10px; margin-top:10px">
<div class="text">
	<p>eggs<br />
	quantity: 4</p>
</div>
</div>

<br />	
<br />


<br />

<div class="image">
<img src="images/DEFAULTPIC.png" style="margin-left: 60px; margin-right:10px; margin-top:20px;">
<div class="text">
	<p>eggs<br />
	quantity: 4</p>
</div>
</div>

<div class="image">
<img src="images/DEFAULTPIC.png" style="margin-left: 20px; margin-right:10px; margin-top:20px;">
<div class="text">
	<p>eggs<br />
	quantity: 4</p>
</div>
</div>

<div class="image">
<img src="images/DEFAULTPIC.png" style="margin-left: 20px; margin-right:10px; margin-top:20px;">
<div class="text">
	<p>eggs<br />
	quantity: 4</p>
</div>
</div>



<div class="image">
<img src="images/addItemLARGEICON.png" style="margin-left: 20px; margin-right:10px; margin-top:20px;">
</div>

<br />
<br />


</div>
</div>

</body>
</html>
