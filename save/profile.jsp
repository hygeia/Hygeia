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

 String name = (String)session.getAttribute("username");

 double weight = u.getWeight();
 out.println(weight);
 double height = u.getHeight();
 double temp =  height/12;
 int ft = (int)(height/12);
 double inc = (temp-ft)*12;
 int in = (int) inc;
 double leanBodyMass = 120; //User.getLeanBodyMass();
 double bodyFat = weight-leanBodyMass;
 double protein = 80;//User.getProtein();
 int block = (int)protein/7;
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
 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
 <html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
 <head>
 <title>Hygeia</title>
 <link type="text/css" rel="stylesheet" href="style.css" />
 <link rel="shortcut icon" href="favicon.ico" mce_href="favicon.ico"/>  
 </head>
 <body>
     <div id="page">
      <div id="header">
	    <!-- Navigation Bar-->
		<table cellpadding="0" cellspacing="0">
		<tr>
		<td> <a href="favorites.html"><img src="images/favoritesICON.png"></a> </td>
		<td> <a href="inventory.html"><img src="images/inventoryICON.png"></a> </td>
		<td> <a href="meals.html"><img src="images/mealsICON.png"></a> </td>
		<td> <a href="history.html"><img src="images/historyICON.png"></a> </td>
		<td> <a href="recipes.html"><img src="images/recipes2ICON.png"></a> </td>
		<td> <img src="images/inventoryBAR.png"> </td>
		</tr>
		</table>
 
      </div>
      <div id="content">
 <% 
   if((name == null)&&(weight == 0)&& (leanBodyMass == 0) && 
      (protein == 0))
   { 
    %>
    <P> You have not updated your profile. By updating your profile, Hygeia</br>
        will be able to provide information to help you obtain a "Zone" </br>
	favorable diet. </br>
	<A HREF="updateProfile.jsp">Update Profile</A>
    <%
    }
     else
     {
    %>
	Hello <%= name %>!</br></br>
	Your current weight is <%= weight %>lbs.</br>
	You are <%= ft %> ft <%= in  %> in tall.</br>
	Your current lean body mass is <%= leanBodyMass %>lbs.</br>
	Your current estimated body fat is <%= bodyFat %>lbs.</br>
	Following a "Zone" favorable diet your daily protein requirement is 
	<%= protein %>grams. </br></br>
	In order to maintain a "Zone" favorable diet you should have:</br>
	<%= block %> protein blocks, carbohydrate blocks, and fat blocks a day.
	</br>
	</br>
	Try to spread the blocks throughout the day. In order to be in the "Zone"</br>
	you must maintain balance.</br>
	</br>
	</br>
	<A HREF="updateProfile.jsp">Update Profile</A></br>
    <%
     } 
    %>
    </div>
     <div id="footer">Hygeia is a project developed for a Software Engineering class at UCSD.<br />
        Please contact us at hygeia@gmail.com if you would like to use any of the code found here.
      </div>
    </div>
 <!-- 
      HTML content should go here. Dynamic content can be inserted via JSP tags.
      Form elements must have names to be accessed in Java. Anything that will
      be accessed by Javascript must have an ID. Use classes and IDs to assist
      in styling. 
  -->
 
 
</body>
</html>
