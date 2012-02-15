<%@ page import = "hygeia.*" %>
<%
/* Check to see if a session exists */
if (session.getAttribute("uid") == null) {
    /* Send away non-logged in users */
    response.sendRedirect("index.jsp");
    return;
}

String username = (String)session.getAttribute("username");

%>
<html>
<head><title>Hygeia</title></head>
<body>
<h1>Hygeia</h1>
<h2>Version 0.8</h2>
<br>
<p>Hello, <%= username %> !</p>
<form method="post" action="logout.jsp">
<input type="hidden" name="logout" type="logout">
<p>Logout: <input type="submit"></p>
</form>
</body>
</html>
