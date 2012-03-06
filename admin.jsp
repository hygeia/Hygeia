/* The admin page is the administrative login page. It should process login
 * requests and grant access to administrative features. Non-logged in users
 * should be redirected to the index page, and logged in users should be 
 * redirected to the home page. 
 */

<%@ page import = "hygeia.*" %>

<%
/* Check to see if a session exists */
if (session.getAttribute("uid") == null) {
    /* Send away non-logged in users */
    response.sendRedirect("index.jsp");
    return;
}
else {
    response.sendRedirect("home.jsp");
    return;
}

integer aid- The aid field is the admin id and it is the key for this table.
text email - the email field is the email address for the admin user
text hpwd - the hpwd field is the hashed password for the admin user


%>
