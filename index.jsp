<%

    /* Check to see if a session exists */
    if (session.getAttribute("uid") != null) {
        response.sendRedirect("home.jsp");
        return;
    }
    /* Else redirect to login page */
    response.sendRedirect("login.jsp");

%>
