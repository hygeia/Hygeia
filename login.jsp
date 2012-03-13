<%@ page import = "hygeia.*" %>
<%


String loginerr = "";

/* Set if user had incorrect psswd or email */
if (request.getParameter("err") != null) 
  loginerr = "<p style=\"color:red\">Incorrect email or password</p>";
/* check if sent from a login page */
if (request.getParameter("login") != null) {
    // MAGIC NUMBERS
//    final String INCORRECT_PSSWD = "wrongpassword";

    Database db = new Database();


    /* Call login method to see if credentials are correct. Note: we should
       implement some form or data sanitization and passwords should be hashed.
    */
    int uid = User.login(db, request.getParameter("email"), request.getParameter("password"));
    if (uid < 1) {
        /* Incorrect login: should do more than just redirect to index */
        response.sendRedirect("login.jsp?err=true");
        db.close();
        return;
    }
    
    /* Create user object */
    User u = new User(db, uid);
    String username = u.getUsername();

    /* Username is null, problem with database */
    if (username == null) {
      response.sendRedirect("error.jsp");
      db.close();
      return;
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
  <head>
    <title>Login | Hygeia</title>
    <link type="text/css" rel="stylesheet" href="loginStyle.css" />    
    <link rel="shortcut icon" href="favicon.ico" mce_href="favicon.ico"/>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
	<script type="text/javascript">
	  if (navigator.userAgent.toLowerCase().indexOf("chrome") >= 0) {
    $(window).load(function(){
        $('input:-webkit-autofill').each(function(){
            var text = $(this).val();
            var name = $(this).attr('name');
            $(this).after(this.outerHTML).remove();
            $('input[name=' + name + ']').val(text);
        });
    });
}
</script>
  </head>
  <body>
    <a href="signup.jsp"><img src="images/getStartedGreen.png" width=200px height=66px align="right"></a>
    <div id="page"><div id="content">
<div id="leaf"><img src="images/HomepageLogo2.png"></div>
    <form method="post" action="login.jsp">
      <table style="margin-left:auto;margin-right:auto;">
        <%= loginerr %>
      <tr>
          <td><input type="text" name="email" class="email"/></td> 
          <td><input type="password" name="password" class="password" /></td>
      <input type="hidden" name="login" value="login" />
      <td><input type="image" src="images/LoginButton.png" value="Login!"/></td>
      </tr>
      </table>
    </form>
<img src="images/aNewWayToEat.png">
</div>
</div>
   <div id="footer"><a href="about.jsp">About Us</a><br />
		Hygeia is a project developed for a Software Engineering class at UCSD.<br />
        Please contact us at hygeia110@gmail.com if you would like to use any of the code found here.
      </div>
  </body>
</html>
