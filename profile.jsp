<%@ page import = "hygeia.*" %>
<%

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
    <title>Hygeia</title>
    <link type="text/css" rel="stylesheet" href="style.css" />
    <link rel="shortcut icon" href="favicon.ico" mce_href="favicon.ico"/> 
  </head>
  <body>
    <div id="page">
      <div id="header">
  if (session.getAttribute("uid") != null) {
    /* Don't show Navigation Bar if user not logged in */
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
}  
      </div>
      <div id="content">
      </div>
      <div id="footer">Hygeia is a project developed for a Software Engineering class at UCSD.<br />
        Please contact us at hygeia@gmail.com if you would like to use any of the code found here.
      </div>
    </div>
  </body>
</html>

