<%@ page import = "hygeia.*" %>
<%
/* check if sent from a login page */
String errorcode = "";
String errorstring = "";

if (request.getParameter("code") != null) {

	/* for now just prints out the code and description until we figure out
	exactly what each code means */

	errorcode = request.getParameter("code");
	errorstring = "undefined";
	if(request.getParameter("echo") != null){
		errorstring = request.getParameter("echo");
	}

}
else{
	response.sendRedirect("login.jsp");
}
%>
<html>
  <head>
    <title>Error | Hygeia</title>
  </head>
  <body>
    <h1>Hygeia</h1>
    <h2>Version 0.8</h2>
    <h3>Error Page</h3>
    <br>
    <br>Error occurred! Error code is <%= errorcode %>
	<br>Error description is <%= errorstring %>
  </body>
</html>