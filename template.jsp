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
   Get user id: int uid = session.getAttribute("uid");
   Get username: String username = session.getAttribute("username");
   Connect to the database: Database db = new Database();
   Create a user object: User u = new User(db, uid);
   Close the database: db.close();
   Redirect to another page: response.sendRedirect("url"); return;
 */
 
 %>
 <html>
 <head>
 <title>PAGE TITLE</title>
 <link href="main.css" rel="stylesheet" type="text/css">
 <!-- <script src="main.js"> -->
 </head>
 <body>
 
 <!-- 
      HTML content should go here. Dynamic content can be inserted via JSP tags.
      Form elements must have names to be accessed in Java. Anything that will
      be accessed by Javascript must have an ID. Use classes and IDs to assist
      in styling. 
  -->
 
 
</body>
</html>

