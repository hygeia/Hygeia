<%@ page import = "hygeia.*" %>
<%
/* check if sent from a login page */
if (request.getParameter("login") != null) {
    Database db = new Database();
    
    /* Call login method to see if credentials are correct. Note: we should
       implement some form or data sanitization and passwords should be hashed.
    */
    int uid = User.login(db, request.getParameter("email"), 
        request.getParameter("password"));
    if (uid < 1) {
        /* Incorrect login: should do more than just redirect to index */
        response.sendRedirect("error.jsp?code=badlogin");
        db.close();
        return;
    }
    
    /* Create user object */
    User u = new User(db, uid);
    String username = u.getUsername();
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
  </head>
  <body>
    <h1>Hygeia</h1>
    <h2>Version 0.8</h2>
    <h3>Login Page</h3>
    <br>
    <form method="post" action="login.jsp">
      Email: <input name="email" /><br />
      Password: <input name="password" /><br />
      <input type="hidden" name="login" value="login" /><br />
      <input type="submit" />
    </form>
  </body>
</html>
