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
    if (uid == 0) {
        /* Incorrect login: should do more than just redirect to index */
        response.sendRedirect("index.jsp");
        return;
    }
    
    /* Create user object */
    User u = new User(db, uid);
    String username = u.getUsername();
    if (username == null) {
        username = "ERROR";
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
<head><title>Hygeia</title></head>
<body>
<h1>Hygeia</h1>
<h2>Version 0.8</h2>
<h3>Login Page</h3>
<br>
<form method="post" action="login.jsp">
<p>Email: <input name="email"></p>
<p>Password: <input name="password"></p>
<input type="hidden" name="login" value="login">
<p><input type="submit"></p>
</form>
</body>
</html>
