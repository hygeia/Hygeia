<!--
 Filename: changePassword.jsp
 Description: Change the users password.
 -->

<%@ page import = "hygeia.*" %>
<%

/* Check to see if a session exists */
if (session.getAttribute("uid") == null) {
    /* Send away non-logged in users */
    response.sendRedirect("index.jsp");
    return;
}

Database db = new Database();
int uid = (Integer)session.getAttribute("uid");
User u = new User(db, uid);
db.close();
%>
 
<html>
<head>
<title>Change Password</title>
<link href="main.css" rel="stylesheet" type="text/css">
<!-- <script src="main.js"> -->
</head>
<body>

<FORM METHOD="POST">

<P> Current password: </br>
<INPUT TYPE="TEXT" NAME="password" SIZE="20">

<P> Retype current password: </br>
<INPUT TYPE="TEXT" NAME="pwdCheck" SIZE="20">

<P> New password: </br>
<INPUT TYPE="TEXT" NAME:"newPwd" SIZE="20">

<P> Retype new password: </br>
<INPUT TYPE="TEXT" NAME:"newPwdCheck" SIZE="20">

<P>
<INPUT TYPE="SUBMIT" VALUE="Submit">
<INPUT TYPE="RESET" VALUE="Reset">
</FORM>

<%

boolean pwdFlag= false;

String oldPwd = request.getParameter("password");
String oldPwdCheck = request.getParameter("pwdCheck");
String newPwd = request.getParameter("newPwd");
String newPwdCheck = request.getParameter("newPwdCheck");

if(!(oldPwd.equals("") && oldPwdCheck.equals("") && newPwd.equals("") && 
   newPwdCheck.equals("")))
{
 if(oldPwd.equals(oldPwdCheck))
 {
	pwdFlag = true;
 }
 if(newPwd.equals(newPwdCheck)&& pwdFlag)
 {
  u.resetPassword(oldPwd, newPwd);
  response.sendRedirect("profile.jsp");
  }
 }

%>
</body>
</html>
