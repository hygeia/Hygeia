<!--
 Filename: profile.jsp
 Description: The page should process all requests to update a user's
  		profile information about the user. The updateProfile
  		form should be on this page, initially set with the 
 		user's information. The resetPassword form should be on
		this page.
 -->

<%@ page import = "hygeia.*" %>
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
db.close();

boolean load = u.getAllInfo();
if(load == false)
{
 response.sendRedirect("error.jsp");
 db.close();
 return;
}

String name = (String)session.getAttribute("username");

 double weight = u.getWeight();
 double height = u.getHeight();
 double temp =  height/12;
 int ft = (int)(height/12);
 double inc = (temp-ft)*12;
 int in = (int) inc;
 double leanBodyMass =  u.getLeanBodyMass();
 double bodyFat = weight-leanBodyMass;
 int protein = u.getBlocks();
 int block = protein/7;
  
 /*double percentBodyFat = 
	Calculator.percentBodyFat(sex,weight,hip,waist,height, wrist);*/ 

/*
   Retrieve whatever data is needed and do any processing here. Try to do all
   database interactions and processing before any HTML, so that the page 
   can be redirected to an error page if soemthing should go wrong. Remember
   to close the database when you are done with it!
   
   Some common tasks:
   Get user id: int uid = session.getAttribute("uid");
   Get username: String username = session.getAttribute("username");
   Connect to the database: Database db = new Database();
   Create a user object: User u = new User(db, uid);
   Close the database: db.close();
   Redirect to another page: response.sendRedirect("url"); return;
 */ 
 %>
 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
	 "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
 <html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
 <head>
 <title>Profile | Hygeia</title>
 <link type="text/css" rel="stylesheet" href="profile.css" />
 <link rel="shortcut icon" href="favicon.ico" mce_href="favicon.ico"/>  
 </head>
 <body>
     <div id="page">
      <div id="header">
	    <!-- Navigation Bar-->
		<table cellpadding="0" cellspacing="0">
		<tr>
<td> <a href="home.jsp"><img src="images/lightICON1.png"></a></td>
<td> <a href="inventory.jsp"><img src="images/lightICON2.png"></a></td>
<td> <a href="history.jsp"><img src="images/lightICON3.png"></a></td>
<td> <a href="recipes.jsp"><img src="images/lightICON4.png"></a></td>
<td> <a href="profile.jsp"><img src="images/darkICON5.png"></a></td>
<td> <a href="favorites.jsp"><img src="images/lightICON6.png"></a></td>
<td> <img src="images/lightICON7.png"></td>
<td> <a href="logout.jsp"><img src="images/lightICON8.png"></a></td>
</tr>
		</table>
 
      </div>
      <div id="content">
        <div id="update">
 <% 
   if((name == null)||(weight == 0)||(leanBodyMass == 0) || 
      (protein == 0))
   { 
    %>
    <p class="update"> You have not updated your profile. By updating your profile, Hygeia
        will be able to provide information to help you obtain a "Zone"
	favorable diet. <br /></p>
	<A HREF="updateProfile.jsp"><img src="images/updateProfile.png" /></A>
    <%
    }
     else
     {
    %>
	<p class="update">Hello <%= name %>!</br></br>
	Your current weight is <b><%= weight %></b> lbs.</br>
	You are <b><%= ft %> ft <%= in  %> in</b> tall.</br>
	Your current lean body mass is <b><%= leanBodyMass %></b> lbs.</br>
	Your current estimated body fat is <b><%= bodyFat %></b> lbs.</br></br>
	Following a "Zone" favorable diet your daily protein requirement is 
	<b><%= protein %></b> grams. </br></br>
	In order to maintain a "Zone" favorable diet you should have</br>
	a daily amount of: </br></br>
	<b><%= block %></b> protein blocks,<br>
	<b><%= block %></b> carbohydrate blocks,<br>
	<b><%= block %></b> and fat blocks.
	</br>
	</br>
	Try to spread the blocks throughout the day. In order to be in the "Zone",
	you must maintain balance.</br>
	</br>
	</br></p>
	<A HREF="updateProfile.jsp"><img src="images/updateProfile.png" /></A></br>
    <%
     } 
    %>
    </div>
    </div>
    </div>
     <div id="footer"><a href="about.jsp">About Us</a><br />
		Hygeia is a project developed for a Software Engineering class at UCSD.<br />
        Please contact us at hygeia110@gmail.com if you would like to use any of the code found here.
      </div>
 <!-- 
      HTML content should go here. Dynamic content can be inserted via JSP tags.
      Form elements must have names to be accessed in Java. Anything that will
      be accessed by Javascript must have an ID. Use classes and IDs to assist
      in styling. 
  -->
 
 
</body>
</html>
