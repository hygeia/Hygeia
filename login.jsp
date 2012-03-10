<%@ page import = "hygeia.*" %>
<%


String loginerr = "";

/* Set if user had incorrect psswd or email */
if (request.getParameter("err") != null) 
  loginerr = "Incorrect email or password";
/* check if sent from a login page */
if (request.getParameter("login") != null) {
    // MAGIC NUMBERS
//    final String INCORRECT_PSSWD = "wrongpassword";

    Database db = new Database();


    /* Call login method to see if credentials are correct. Note: we should
       implement some form or data sanitization and passwords should be hashed.
    */
    int uid = User.login(db, request.getParameter("email"), request.getParameter("password"));
    if (uid < 1) {
        /* Incorrect login: should do more than just redirect to index */
        response.sendRedirect("login.jsp?err=true");
        db.close();
        return;
    }
    
    /* Create user object */
    User u = new User(db, uid);
    String username = u.getUsername();

    /* Username is null, problem with database */
    if (username == null) {
      response.sendRedirect("error.jsp");
      db.close();
      return;
    }
    
    /* Close database: we're done with it */
    db.close();
    
    /* Set session variables */
    session.setAttribute("uid", uid);
    session.setAttribute("username", username);
    response.sendRedirect("home.jsp");
}

%>
<html>
  <head>
    <title>Login | Hygeia</title>
    <link type="text/css" rel="stylesheet" href="style.css" />
  </head>
  <body>
    <img src="images/lightICON6.png"/>
    <div id="page"><div id="content">
    <h3>Login</h3>
    <br>
    Not a member? <a href="signup.jsp" style="color:#87D7A5">Sign up.</a>
    <form method="post" action="login.jsp">
      <table style="margin-left:auto;margin-right:auto;">
        <%= loginerr %>  
      <tr>
          <td> Email: </td> 
          <td><input type="text" name="email" /></td>
      </tr>
      <tr>
          <td>Password: </td> 
          <td><input type="password" name="password" /></td>
      <input type="hidden" name="login" value="login" /><br />
      <tr>
          <td><input type="submit" value="Login!"/></td>
      <tr>
      </table>
    </form>
   <div id="footer"><a href="about.jsp">About Us</a><br />
		Hygeia is a project developed for a Software Engineering class at UCSD.<br />
        Please contact us at hygeia110@gmail.com if you would like to use any of the code found here.
      </div>
  </div></div> <!-- content -->
  </body>
</html>
