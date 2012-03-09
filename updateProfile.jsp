
<!--
   Filename: updateProfile.jsp
   Description: This page will update the users information.
		Including the users name, weight, lean body mass,
		and protein requirement.
-->

<%@ page import = "hygeia.*" %>
<%@ page import = "java.io.FileNotFoundException" %>
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
String name = u.getUsername();
//double weight = u.getWeight();
double weight = 145;
//double waist = u.getWaist();
double waist = 29;
// double hips = u.getHips();
double hips = 38;
// souble wrist = u.getWrist();
double wrist = 6.5;
//double height = u.getHeight();
double height = 67;;
double temp =  height/12;
int ft = (int)(height/12);
double inc = (temp-ft)*12;
int in = (int) inc;
//String sex = u.getSex();
String sex = "f";
String f= "";
String m= ""; 
if( sex.equals("f") )
{
 f = "checked";
}
if( sex.equals("m"))
{
 m = "checked";
}

/*
 * This chunk of code is used to set the activity radio button to what the
 * user put in during another session. This is useful to the user in the 
 * way it avoids reduntant annoying input.
 */
 
// int activity = u.getActivity();
int activity = 4;

String a1 ="";
String a2 ="";
String a3 ="";
String a4 ="";
String a5 ="";
String a6 ="";

if(activity == 1)
{
 a1 = "checked";
}
if(activity == 2)
{
 a2 = "checked";
}
if(activity == 3)
{
 a3 = "checked";
}
if(activity == 4)
{
 a4 = "checked";
}
if(activity == 5)
{
 a5 = "checked";
}
if(activity == 6)
{
 a6 = "checked";
}

/*
out.println(Calculator.percentBodyFat("f","145","38","38","38","27","27","27",67.0,"6.5")); 
*/

/* retrieve input from form */
String theName = request.getParameter("name");

/* Check if the inputed name is valid */
if(theName != null) 
{
  /* Convert the height into inches for Calculator use */
  int tempft = Integer.parseInt(request.getParameter("ft"));
  int feetToInch = tempft*12;
  int tempin = Integer.parseInt(request.getParameter("in"));
  height = feetToInch + tempin;
 
  /* Retrieve weight from form and parse it into a double */
  weight = Double.parseDouble(request.getParameter("weight"));

  /* Update user info according to the form */
  u.updateAllInfo(theName, u.getEmail(), height, weight);          
  
  session.setAttribute( "username", theName );
  db.close(); // close database
  response.sendRedirect("profile.jsp"); // Go back to profile.jsp

}

%>
 <html>
 <title>Update Profile</title>
 <link href="main.css" rel="stylesheet" type="text/css">
 <!-- <script src="main.js"> -->
 </head>
 <body>

 <FORM METHOD="POST" ACTION="updateProfile.jsp">

 <P> Name </br>
 <INPUT TYPE="TEXT" VALUE="<%= name %>" NAME="name" SIZE="20">

 <P> Gender </br>
 <INPUT TYPE="RADIO" NAME="sex" VALUE="female" <%= f %> >Female
 <INPUT TYPE="RADIO" NAME="sex" VALUE="male" <%= m %> >Male

 <P> What best fits you exercise routine? </br>
 <INPUT TYPE="RADIO" NAME="activity" VALUE="1" <%= a1 %> >
  Sedentary</br>
 <INPUT TYPE="RADIO" NAME="activity" VALUE="2" <%= a2 %> >
  Light (i.e, walking)</br>
 <INPUT TYPE="RADIO" NAME="activity" VALUE="3" <%= a3 %> >
  Moderate (30 minutes per day, 3 times per week)</br>
 <INPUT TYPE="RADIO" NAME="activity" VALUE="4" <%= a4 %> >
  Active (1 hour per day, 5 times per week)</br> 
 <INPUT TYPE="RADIO" NAME="activity" VALUE="5" <%= a5 %> >
  Very active (2 hours per day, 5 times a week)</br>
 <INPUT TYPE="RADIO" NAME="activity" VALUE="6" <%= a6 %> >
  Heavy weight training or twice-a-day exercise (5 days per week)</br>

 <P> Weight(LBS):
 <INPUT TYPE="TEXT" VALUE= "<%= weight %>" NAME="weight" SIZE="10">

 <P> Take 3 measurements of your hips </br>
 How to take proper hip measurements: (Must have measuring tape) Take</br>
 measuremet from the widest point from hip to hip.(INCHES)</br>
 Hygeia will find the average of these three measurements</br> 
 <P> Hip measurement 1:<INPUT TYPE="TEXT" NAME="hip1" VALUE="<%= hips %>" SIZE="10"> 
 <P> Hip measurement 2:<INPUT TYPE="TEXT" NAME="hip2" VALUE="<%= hips %>" SIZE="10">
 <P> Hip measurement 3:<INPUT TYPE="TEXT" NAME="hip3" VALUE="<%= hips %>" SIZE="10">

 <P> (Must have measuring tape) Take 3 measurements of of your waist at</br>
      bellybutton level. (INCHES)</br>
Hygeia will find the average of these three measurements</br> 
 <P> Waist measurement 1:<INPUT TYPE="TEXT" NAME="waist1" VALUE="<%= waist %>" SIZE="10">
 <P> Waist measurement 2:<INPUT TYPE="TEXT" NAME="waist2" VALUE="<%= waist %>" SIZE="10">
 <P> Waist measurement 3:<INPUT TYPE="TEXT" NAME="waist3" VALUE="<%= waist %>" SIZE="10">

 <P> Height(W/O SHOES): 
 <INPUT TYPE="TEXT" VALUE="<%= ft %>" NAME="ft" SIZE="5">ft.
 <INPUT TYPE="TEXT" VALUE="<%= in %>" NAME="in" SIZE="5">in.

 <P> Wrist measurement</br>
     How to take a wrist measurement: (Must have measuring tape) Measure</br>
     your wrist at the space between your dominant hand and your wrist bone,</br>
     at the location where your wrist bends.</br>

 <P> Wrist measurement(INCHES):
 <INPUT TYPE="TEXT" VALUE="<%= wrist %>" NAME="wrist" SIZE="10">

 <P>
 <INPUT TYPE="SUBMIT" VALUE="Submit">
 </FORM> 
 </body>
 </html>


