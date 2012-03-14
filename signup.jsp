<%@ page import = "hygeia.*" %>
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
    double height = Double.parseDouble(request.getParameter("user_height_ft")) * 12 
                    +  Double.parseDouble(request.getParameter("user_height_in"));
    double weight = Double.parseDouble(request.getParameter("user_weight"));
    String sex = request.getParameter("user_sex");
 
    Database db = new Database();
    /* User hips */  


    /* Create user */
    int uid = User.createUser(db, username, password, email, height, weight, sex.charAt(0));
    
    /* Basic error handling */
    if (uid < 1) {
        response.sendRedirect("index.jsp?error=badcreate&uid=" + uid);
        return;
    }

    /* Set session variables */
    session.setAttribute("uid", uid);
    session.setAttribute("username", username);

    /* Make user object */
    User u = new User( db, uid );
    /* User attributes */
    /* Take average of hip measurement */
    double hips = (Double.parseDouble(request.getParameter("hip1")) + 
	  Double.parseDouble(request.getParameter("hip2")) +
	  Double.parseDouble(request.getParameter("hip3")))/3;
    hips = 0.5 * Math.round( hips / 0.5 );

    /* Take average of waist measurements */
    double waist = (Double.parseDouble(request.getParameter("waist1")) +
             Double.parseDouble(request.getParameter("waist2")) +
             Double.parseDouble(request.getParameter("waist3")))/3;
    waist = 0.5 * Math.round( waist / 0.5 );

    short act= (short)Integer.parseInt(request.getParameter("activity"));
    double wrist = Double.parseDouble(request.getParameter("wrist"));

    double lbm = 0; 

    double perBodFat = Calculator.percentBodyFat(sex, 
                        Double.toString(weight),hips, waist, height,
                        Double.toString(wrist));

    /* Can't have negative body fat */
    if(perBodFat < 0) {
     /* error flaged*/
      response.sendRedirect("error.jsp");
      return;
    }

    lbm = Calculator.leanBodyMass(weight, perBodFat);
    
    double protein = Calculator.protein(lbm,Integer.parseInt(request.getParameter("activity")));
    int blocks = (int)protein;

    
    u.updateAllInfo(username, u.getEmail(),sex.charAt(0), act, blocks, height, 
      weight, hips, waist, wrist, lbm);     


    /* Close database */
    db.close();
        
    
    /* Set session variables */
    session.setAttribute("uid", uid);
    session.setAttribute("username", username);
    response.sendRedirect("home.jsp");  
}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
  <head>
    <title>Sign Up | Hygeia</title>
    <script type="text/javascript" src="javascript/jquery-1.7.1.min.js"></script>          
    <script type="text/javascript" src="javascript/jquery.validate.min.js"></script>          
    <script type="text/javascript" src="javascript/validation.js"></script>          
    <link type="text/css" rel="stylesheet" href="forms.css" /> 
    <link type="text/css" rel="stylesheet" href="profile.css" /> 
  </head>
  <body>
	
    <div id="page">
      
      <div id="content">
	  <img src="images/signup.png" style="float:left;" />

        <form id="signupform" method="post" action="signup.jsp">
          <p>
            <label for="username">Name</label>
            <input type="text" name="username" size='20' />
          </p>

          <p>
            <label for="email">Email</label>
            <input type="text" id="user_email" name="user_email" size='20'/><br />
          </p>

          <p>
            <label for="email">Re-enter Email</label>
            <input type="text" name="reenter_email" size='20'/><br />
          </p>

          <p>
            <label for="password">Password</label>
            <input type="password" id="user_password" name="user_password" size='20'/><br />
          </p>

          <p>
          <label for="reenter_password">Re-enter Password</label>
          <input type="password" id= "reenter_password" name="reenter_password" size='20'/><br />
          </p>

          <hr />
          <br />

          <div class="sex-field"> 
          <label for="user_sex">Gender</label> 
          <INPUT TYPE="RADIO" NAME="user_sex" VALUE="f" />Female
          <INPUT TYPE="RADIO" NAME="user_sex" VALUE="m"  />Male
          <label for="user_sex" class="error" style="display:none;">Please choose one</label> 
          </div>

          <P> 
          <label for="activity"><center>What best fits you exercise routine?</center></label><br /><br />
          <dt class="radio"><label for="activity">Sedentary</label></dt>
          <dd class="radio"><INPUT TYPE="radio" NAME="activity" VALUE="1" /></dd>
          <br />
          <dt class="radio"><label for="activity">Light (i.e, walking)</label></dt>
          <dd class="radio"><INPUT TYPE="radio" NAME="activity" VALUE="2" /></dd>
          <br />
          <dt class="radio"><label for="activity">Moderate (30 minutes per day, 3 times per week)</label></dt>
          <dd class="radio"><INPUT TYPE="radio" NAME="activity" VALUE="3" /></dd>
          <br />

          <dt class="radio"><label for="activity">Active (1 hour per day, 5 times per week)</label></dt>
          <dd class="radio"><INPUT TYPE="radio" NAME="activity" VALUE="4" /> </dd>
          <br />
          <br />
          <dt class="radio"><label for="activity">Very active (2 hours per day, 5 times a week)</label></dt>
          <dd class="radio"><INPUT TYPE="radio" NAME="activity" VALUE="5" /></dd>
          <br />
          <br />
          <br />
          <dt class="radio"><label for="activity">Heavy weight training or twice-a-day exercise (5 days per week)</label></dt>
          <dd class="radio"><INPUT TYPE="radio" NAME="activity" VALUE="6" /></dd>
          </p>
         
          <br />

          <p>
          <label for="user_weight">Weight</label>
          <input type="text" name="user_weight" />
          </p>

          <p>
          <label for="user_height_ft">Height (w/o shoes)</label>
          <input type="text" name="user_height_ft" id="user_height" size="5"/>ft.
          <input type="text" name="user_height_in" id="user_height" size="5"/>in.
          <label for="user_height" class="error" style="display:none;">Please enter your height</label>
          </p>

          <br />
          <hr />
           <P> Take 3 measurements of your hips </br>
           How to take proper hip measurements: (Must have measuring tape) Take</br>
           measurement from the widest point from hip to hip. Measure in inches.</br>
           Hygeia will find the average of these three measurements.</br> 
           </p>
           <P> 
           <label for="hip1">Hip measurement 1 (inches)</label>
           <INPUT TYPE="TEXT" NAME="hip1" SIZE="10"/> 
           </p>
           <P> 
           <label for="hip2">Hip measurement 2 (inches)</label>
           <INPUT TYPE="TEXT" NAME="hip2" SIZE="10"/>
           </p>
           <P> 
           <label for="hip3">Hip measurement 3 (inches)</label>
           <INPUT TYPE="TEXT" NAME="hip3" SIZE="10"/>
           </p>
        
        
          <br />
          <hr />
           <P> (Must have measuring tape) Take 3 measurements of of your waist at</br>
                bellybutton level. Measure in inches.</br>
                Hygeia will find the average of these three measurement.</br> 
           </p>
           <P> 
           <label for="waist1">Waist measurement 1 (inches)</label>
           <INPUT TYPE="TEXT" NAME="waist1" SIZE="10"/>
           </p>
           <P> 
           <label for="waist2">Waist measurement 2 (inches)</label>
           <INPUT TYPE="TEXT" NAME="waist2" SIZE="10"/>
           </p>
           <P> 
           <label for="waist3">Waist measurement 3 (inches)</label>
           <INPUT TYPE="TEXT" NAME="waist3" SIZE="10"/>
           </p>

          <br />
          <hr />
           <P> Wrist measurement</br>
               How to take a wrist measurement: (Must have measuring tape) Measure</br>
               your wrist at the space between your dominant hand and your wrist bone,</br>
               at the location where your wrist bends.</br>
           </p>

           <P> 
           <label for="wrist">Wrist measurement (inches)</label>
           <INPUT TYPE="TEXT" NAME="wrist" SIZE="10"/>
           </p>

           <p>
           <input type="hidden" name="signup" value="signup" />
           <div align="right" style="margin-right:60px;"><input TYPE="image" src="images/submit.png" VALUE="submit" /></div>
           </p>
         </div>
       </div>
    </form>
  </body>
</html>
