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


String theName = request.getParameter("name");
if(theName != null) 
{
  int tempft = Integer.parseInt(request.getParameter("ft"));
  int feetToInch = tempft*12;
  int tempin = Integer.parseInt(request.getParameter("in"));
  height = feetToInch + tempin;
  weight = Double.parseDouble(request.getParameter("weight")); 
  u.updateUsername(theName);
  out.println(weight);
  u.updateAllInfo(theName, u.getEmail(), height, weight);          
  session.setAttribute( "username", theName );
  db.close();
  response.sendRedirect("profile.jsp");

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

 <P> Wrist measurement(INCHES): <INPUT TYPE="TEXT" VALUE="<%= wrist %>" NAME="wrist" SIZE="10">

 <P>
 <INPUT TYPE="SUBMIT" VALUE="Submit">
 </FORM> 
<%
   /*
	char gender;
	String act;
	String hip1, hip2, hip3;
	String waist1, waist2, waist3;
	String wrist;
	boolean nFlag= false;
        boolean gFlag= false;
        boolean wFlag= false;
        boolean aFlag= false;
        boolean weFlag= false;
        boolean hpFlag= false; 
        boolean hFlag= false;
        boolean waFlag= false;

        if(request.getParameter("name") == null
            || request.getParameter("name").equals("")) 
	{
            out.println("<html><font color=red>Please enter your name.</font></html></br>");
        }
	else
	{
	 u.updateUsername(request.getParameter("name"));
	 nFlag = true;
	}
	if(request.getParameter("sex") != null) 
	{
           if(request.getParameter("sex").equals("female")) 
	    {
                    gender ='f';
                    gFlag= true;
	    }
           
           if(request.getParameter("sex").equals("male")) 
	    {
		    gender ='m';
                    gFlag= true;

	    }
        }
	else
	{
	 out.println("<html><font color=red>Please select a gender.</font></html></br>");
	}
	
	if(request.getParameter("activity") != null)
	{
	 if(request.getParameter("activity").equals("1"))
	 {
		act = "0.5";
                aFlag= true;

	 }
	 if(request.getParameter("activity").equals("2"))
	 {
		act = "0.6";
                aFlag= true;

 	 }
	 if(request.getParameter("activity").equals("3"))
         {
                act = "0.7";
                aFlag= true;

         }
         if(request.getParameter("activity").equals("4"))
         {
                act = "0.8";
                aFlag= true;

         }
         if(request.getParameter("activity").equals("5"))
         {
                act = "0.9";
                aFlag= true;

         }
         if(request.getParameter("activity").equals("6"))
         {
                act = "1.0";
		aFlag= true;
         }
	}
	else
        {
         out.println("<html><font color=red>Please enter your activity level."+
			"</font></html></br>");
        }
        
	if(request.getParameter("weight") == null
            || request.getParameter("weight").equals(""))
        {
         out.println("<html><font color=red>Please enter your weight."+
			"</font></html></br>");
        }
        else
        {
         u.updateWeight(Double.parseDouble(request.getParameter("weight")));
         weFlag= true;
        }

        if(request.getParameter("hip1") == null
            || request.getParameter("hip1").equals(""))
        {
            out.println("<html><font color=red>Please enter all 3 hip measurements.</font></html></br>");
        }
        else
        {
            hip1 =request.getParameter("hip1");
            hpFlag= true;

        }

       if(request.getParameter("hip2") == null
            || request.getParameter("hip2").equals(""))
        {
            out.println("<html><font color=red>Please enter all 3 hip measurements.</font></html></br>");
        }
        else
        {
            hip2 =request.getParameter("hip2");
            hpFlag= true;
        
	}

       if(request.getParameter("hip3") == null
            || request.getParameter("hip3").equals(""))
        {
            out.println("<html><font color=red>Please enter all 3 hip measurements.</font></html></br>");
        }
        else
        {
            hip3 =request.getParameter("hip3");
            hpFlag= true;

	}

       if(request.getParameter("waist1") == null
            || request.getParameter("waist1").equals(""))
        {
            out.println("<html><font color=red>Please enter all 3 waist measurements.</font></html></br>");
        }
        else
        {
            waist1 =request.getParameter("waist1");
            waFlag= true;
        }

       if(request.getParameter("waist2") == null
            || request.getParameter("waist2").equals(""))
        {
            out.println("<html><font color=red>Please enter all 3 waist measurements.</font></html></br>");
        }
        else
        {
            waist2 =request.getParameter("waist2");
            waFlag= true;

	}

       if(request.getParameter("waist3") == null
            || request.getParameter("waist3").equals(""))
        {
            out.println("<html><font color=red>Please enter all 3 waist measurements.</font></html></br>");
        }
        else
        {
            waist3 =request.getParameter("waist3");
	    waFlag= true;
        }

        if(request.getParameter("height") == null
            || request.getParameter("height").equals(""))
        {
            out.println("<html><font color=red>Please enter your height.</font></html></br>");
        }
        else
        {
	 u.updateHeight(77.0);   
	 hFlag= true;
        }

       if(request.getParameter("wrist") == null
            || request.getParameter("wrist").equals(""))
        {
            out.println("<html><font color=red>Please enter your wrist measurement.</font></html></br>");
        }
        else
        {
            wrist =request.getParameter("wrist");
            wFlag= true;
	}
	String theName = request.getParameter("name");
	if (theName != null) 
	{
	   u.updateAllInfo(theName,u.getEmail(),
				Double.parseDouble(request.getParameter("weight")),
				Double.parseDouble(request.getParameter("height")));
    	   u.updateUsername(theName);
	   
	   session.setAttribute( "username", theName );
	   response.sendRedirect("profile.jsp");
    	   return;
	}*/ 
%>
 </body>
 </html>


