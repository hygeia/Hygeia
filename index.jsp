<%
/* Check to see if a session exists */
if (session.getAttribute("uid") != null) {
    response.sendRedirect("home.jsp");
    return;
}
%>
<html>
  <head>
    <title>Hygeia</title>
  </head>
<body>
  <h1>Hygeia</h1>
  <h2>Version 0.8</h2>
<br />
<p>Login or <a href="signup.jsp">Signup</a></p>
<form method="post" action="login.jsp">
  Email: <input type="text" name="email" /><br />
  Password: <input type="password" name="password" /><br />
<input type="hidden" name="login" value="login" />
<input type="submit" />
</form>
</body>
</html>
