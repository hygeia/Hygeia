<%@ page import = "hygeia.*" %>
<%
/* Check to see if a session exists */
if (session.getAttribute("uid") != null) {
    response.sendRedirect("home.jsp");
    return;
}

/* Check to see if user came here from the signup form */
if (request.getParameter("signup") != null) {

    String username = (String)request.getParameter("username");
    String password = (String)request.getParameter("password");
    String email = (String)request.getParameter("email");
    
    Database db = new Database();
    
    /* Create user */
    int uid = User.createUser(db, username, password, email, 0, 0);
    
    /* Close database */
    db.close();
        
    /* Basic error handling */
    if (uid < 1) {
        response.sendRedirect("index.jsp");
    }
    
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
<h3>Signup Page</h3>
<br>
<form method="post" action="signup.jsp">
<p>Name: <input name="username"></p>
<p>Email: <input name="email"></p>
<p>Password: <input name="password"></p>
<input type="hidden" name="signup" value="signup">
<p><input type="submit"></p>
</form>
</body>
</html>
