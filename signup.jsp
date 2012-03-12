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
    double height = Double.parseDouble(request.getParameter("user_height"));
    double weight = Double.parseDouble(request.getParameter("user_weight"));
    char sex = request.getParameter("user_sex").charAt(0);   
 
    Database db = new Database();
    
    /* Create user */
    int uid = User.createUser(db, username, password, email, height, weight, sex);
    
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
    <script type="text/javascript" src="javascript/validation.js"></script>          
    <title>Sign Up | Hygeia</title>
    <style type="text/css">
      label { width: 10em; float: left; }
      label.error { float: none; color: red; padding-left: .5em; vertical-align:top; }
      p { clear: both; }
      .submit { margin-left: 12em }
      em { font-weight: bold; padding-right: 1em; vertical-align: top; }
    </style>
  </head>
  <body>
    <h1>Hygeia</h1>
    <h2>Version 0.8</h2>
    <h3>Signup Page</h3>
    <br>
    <form id="signupform" method="post" action="signup.jsp">
      <p>
        <label for="username">Name</label>
        <input type="text" name="username" />
      </p>

      <p>
        <label for="email">Email</label>
        <input type="text" id="user_email" name="user_email" /><br />
      </p>

      <p>
        <label for="email">Reenter Email</label>
        <input type="text" name="reenter_email" /><br />
      </p>

      <p>
        <label for="password">Password</label>
        <input type="password" id="user_password" name="user_password" /><br />
      </p>

      <p>
      <label for="retype_password">Reenter Password</label>
      <input type="password" id= "reenter_password" name="reenter_password" /><br />
      </p>

      <p>
      <input type="radio" name="user_sex" value="male" />Male<br />
      <input type="radio" name="user_sex" value="female" />Female
      <label for="user_sex" class="error" style="display:none;">Please chose one</label>
      </p>

      <p>
      <label for="height">Height</label>
      <input name="user_height" />
      </p>

      <p>
      <label for="weight">Weight</label>
      <input name="user_weight" />
      </p>

      <p>
      <input type="hidden" name="signup" value="signup" />
      <input type="submit" />
      </p>

    </form>
  </body>
</html>
