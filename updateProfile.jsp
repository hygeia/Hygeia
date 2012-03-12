
<!--
   Filename: updateProfile.jsp
   Description: This page will update the users information.
		Including the users name, weight, lean body mass,
		and protein requirement.
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
boolean check = u.getAllInfo();

String name = u.getUsername();
double weight = u.getWeight();
double waist = u.getWaist();
double hips = u.getHips();
//double hips = 38;
double wrist = u.getWrist();
//double wrist = 6.5;
double height = u.getHeight();
//double height = 67;;
double temp =  height/12;
int ft = (int)(height/12);
double inc = (temp-ft)*12;
int in = (int) inc;

String sex = Character.toString(u.getGender());
String f = "";
String m = ""; 
if( sex.equals("f") )
{
 f = "checked";
}

else if( sex.equals("m"))
{
 m = "checked";
}

else
{
 f = "checked";
}

/*
 * This chunk of code is used to set the activity radio button to what the
 * user put in during another session. This is useful to the user in the 
 * way it avoids reduntant annoying input.
 */
 
int activity = u.getActivity();
//int activity = 4;

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
else if(activity == 2)
{
 a2 = "checked";
}
else if(activity == 3)
{
 a3 = "checked";
}
else if(activity == 4)
{
 a4 = "checked";
}
else if(activity == 5)
{
 a5 = "checked";
}
else if(activity == 6)
{
 a6 = "checked";
}
else
{
 a1= "checked";
}

/* Debugging statement 
out.println( Calculator.percentBodyFat("m","180",37.5,37.0,69.0,"7")); 
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

  /* Take average of hip measurement */
  hips = (Double.parseDouble(request.getParameter("hip1")) + 
	  Double.parseDouble(request.getParameter("hip2")) +
	  Double.parseDouble(request.getParameter("hip3")))/3;

  hips = 0.5* Math.round( hips / 0.5 );

  /* Take average of waist measurements */
  waist = (Double.parseDouble(request.getParameter("waist1")) +
           Double.parseDouble(request.getParameter("waist2")) +
           Double.parseDouble(request.getParameter("waist3")))/3;

  waist = 0.5 * Math.round( waist / 0.5 );

  /* Retrieve weight from form and parse it into a double */
  weight = Double.parseDouble(request.getParameter("weight"));
  int blocks = 0;
  /* Update user info according to the form */

  short act= (short)Integer.parseInt(request.getParameter("activity"));
  wrist = Double.parseDouble(request.getParameter("wrist"));
  sex = request.getParameter("sex");
  char gender = sex.charAt(0);

  double lbm = 0; 
  
/* Debugging statements 
  out.println(sex);
  out.println(request.getParameter("weight"));
  out.println(hips);
  out.println(waist);
  out.println(height);
  out.println(request.getParameter("wrist"));
*/

  double perBodFat = Calculator.percentBodyFat(sex, 
			request.getParameter("weight"),hips, waist, height,
			request.getParameter("wrist"));

 /*  Debugging statement
  out.println(perBodFat);
 */

  if(perBodFat < 0)
  {
   /* error flaged*/
    response.sendRedirect("error.jsp");
    return;
  }

  lbm = Calculator.leanBodyMass(weight, perBodFat);
  
  double protein = 
  	Calculator.protein(lbm,Integer.parseInt(request.getParameter("activity")));
  blocks = (int)protein;

  
  u.updateAllInfo(theName, u.getEmail(),gender, act, blocks, height, 
		weight, hips, waist, wrist, lbm);     

  /* Debugging statements 
  out.println(u.getBlocks());
  out.println(u.getLeanBodyMass());
  */

  session.setAttribute( "username", theName );
  db.close(); // close database

  response.sendRedirect("profile.jsp"); // Go back to profile.jsp

}

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
  <head>
    <title>Update Profile | Hygeia</title>
    <script type="text/javascript" src="javascript/jquery-1.7.1.min.js"></script>          
    <script type="text/javascript" src="javascript/jquery.validate.min.js"></script>          
    <script type="text/javascript" src="javascript/validation.js"></script>          
    <style type="text/css">
      label { width:10em; float:left; }
      label.error { color:red; padding-left:.5em; vertical-align:top; }
      p { clear:both; }
      .submit { margin-left:12em }
      em { font-weight:bold; padding-right: 1em; vertical-align:top; }
      .sex-field * {
        vertical-align: middle;
      }
    </style>
  </head>
  <body>

   <FORM METHOD="POST" id="update_profile_form" ACTION="updateProfile.jsp">

     <p> 
     <label for="user_name">Name</label>
     <INPUT TYPE="TEXT" VALUE="<%= name %>" NAME="name" SIZE="20" />
     </p>

     <div class="sex-field"> 
     <label for="user_sex">Gender</label> 
     <INPUT TYPE="RADIO" NAME="sex" VALUE="f" <%= f %> />Female</br>
     <INPUT TYPE="RADIO" NAME="sex" VALUE="m" <%= m %> />Male
     <label for="user_sex" class="error" style="display:none;">Please chose one</label> 
     </div>


     <P> 
     <label for="activity">What best fits you exercise routine?</label>
     <INPUT TYPE="RADIO" NAME="activity" VALUE="1" <%= a1 %> /> Sedentary</br>
     <INPUT TYPE="RADIO" NAME="activity" VALUE="2" <%= a2 %> /> Light (i.e, walking)</br>
     <INPUT TYPE="RADIO" NAME="activity" VALUE="3" <%= a3 %> /> Moderate (30 minutes per day, 3 times per week)</br>
     <INPUT TYPE="RADIO" NAME="activity" VALUE="4" <%= a4 %> /> Active (1 hour per day, 5 times per week)</br> 
     <INPUT TYPE="RADIO" NAME="activity" VALUE="5" <%= a5 %> /> Very active (2 hours per day, 5 times a week)</br>
     <INPUT TYPE="RADIO" NAME="activity" VALUE="6" <%= a6 %> /> Heavy weight training or twice-a-day exercise (5 days per week)</br>
     </p>

     <P> 
     <label for="user_weight">Weight(LBS)</label>
     <INPUT TYPE="TEXT" VALUE= "<%= weight %>" NAME="weight" SIZE="10" />

     <P> Take 3 measurements of your hips </br>
     How to take proper hip measurements: (Must have measuring tape) Take</br>
     measuremet from the widest point from hip to hip.(INCHES)</br>
     Hygeia will find the average of these three measurements</br> 
     </p>
     <P> 
     <label for="hip1">Hip measurement 1</label>
     <INPUT TYPE="TEXT" NAME="hip1" VALUE="<%= hips %>" SIZE="10"/> 
     </p>
     <P> 
     <label for="hip2">Hip measurement 2</label>
     <INPUT TYPE="TEXT" NAME="hip2" VALUE="<%= hips %>" SIZE="10"/>
     </p>
     <P> 
     <label for="hip3">Hip measurement 3</label>
     <INPUT TYPE="TEXT" NAME="hip3" VALUE="<%= hips %>" SIZE="10"/>
     </p>

     <P> (Must have measuring tape) Take 3 measurements of of your waist at</br>
          bellybutton level. (INCHES)</br>
          Hygeia will find the average of these three measurements</br> 
     </p>
     <P> 
     <label for="waist1">Waist measurement 1</label>
     <INPUT TYPE="TEXT" NAME="waist1" VALUE="<%= waist %>" SIZE="10"/>
     </p>
     <P> 
     <label for="waist2">Waist measurement 2</label>
     <INPUT TYPE="TEXT" NAME="waist2" VALUE="<%= waist %>" SIZE="10"/>
     </p>
     <P> 
     <label for="waist3">Waist measurement 3</label>
     <INPUT TYPE="TEXT" NAME="waist3" VALUE="<%= waist %>" SIZE="10"/>
     </p>

     <P> Height(W/O SHOES): 
     <INPUT TYPE="TEXT" VALUE="<%= ft %>" NAME="ft" SIZE="5"/>ft.
     <INPUT TYPE="TEXT" VALUE="<%= in %>" NAME="in" SIZE="5"/>in.
     </p>

     <P> Wrist measurement</br>
         How to take a wrist measurement: (Must have measuring tape) Measure</br>
         your wrist at the space between your dominant hand and your wrist bone,</br>
         at the location where your wrist bends.</br>
     </p>

     <P> 
     <label for="wrist">Wrist measurement(in.)</label>
     <INPUT TYPE="TEXT" VALUE="<%= wrist %>" NAME="wrist" SIZE="10"/>
     </p>

     <P>
     <input type="hidden" name="updateProfile" value="updateProfile" />
     <INPUT TYPE="SUBMIT" VALUE="Submit" />
     </p>
   </body>
 </html>
