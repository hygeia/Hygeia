<%
/* Delete the session if it exists */
if (request.getSession(false) != null) {
    session.invalidate();
}

/* Send everyone to index page */
response.sendRedirect("index.jsp");
%>
