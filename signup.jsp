<%@ page import = "hygeia.*" 
%>
<%
/* Check to see if a session exists */
if (session.getAttribute("uid") != null) {
    response.sendRedirect("home.jsp");
    return;
}

/* Check to see if user came here from the signup form */
if (request.getParameter("signup") != null) {

    String username = request.getParameter("username");
    String password = request.getParameter("user_password");
    String email = request.getParameter("user_email");
    String height = request.getParameter("user_height");
    String weight = request.getParameter("user_weight");
    char sex = request.getParameter("user_sex");
    
    Database db = new Database();
    
    /* Create user */
    int uid = User.createUser(db, username, password, email, 1, 1);
    
    /* Close database */
    db.close();
        
    /* Basic error handling */
    if (uid < 1) {
        response.sendRedirect("index.jsp?error=badcreate&uid=" + uid);
        return;
    }
    
    /* Set session variables */
    session.setAttribute("uid", uid);
    session.setAttribute("username", username);
    response.sendRedirect("home.jsp");  
}
%>
<html>
  <head>
    <script type="text/javascript" src="javascript/jquery-1.7.1.min.js"></script>          
    <script type="text/javascript" src="javascript/jquery.validate.min.js"></script>          
    <script type="text/javascript" src="javascript/signup_validation.js"></script>          
    <title>Hygeia</title>
  </head>
  <body>
    <h1>Hygeia</h1>
    <h2>Version 0.8</h2>
    <h3>Signup Page</h3>
    <br>
    <form id="signupform" method="post" action="signup.jsp">
      <label for="username">Name:</label>
      <input type="text" name="username" /><br />

      <label for="email">Email:</label>
      <input type="text" name="user_email" /><br />

      <label for="email">Email:</label>
      <input type="text" name="reenter_email" /><br />

      <label for="password">Password:</label>
      <input type="password" id="user_password" name="user_password" /><br />

      <label for="retype_password">Retype Password:</label>
      <input type="password" id= "reenter_password" name="reenter_password" /><br />

      <input type="radio" name="user_sex" value="male" /> Male<br />
      <input type="radio" name="user_sex" value="female" /> Female<br />

      <input type="hidden" name="signup" value="signup" />
      <input type="submit" />

    </form>
  </body>
</html>
