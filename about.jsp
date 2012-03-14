<%
/* Author: Mana Jammalamadaka
 * Date: 02/28/12
 * Filename: about.jsp
 * Description: The about page should give the purpose of the site and what it
 * does. It should also list all the developers of the site. There will be no
 * Java on this page. It is pure HTML describing the project and team. 
 *   
 */
 
 String nav = "";
 /* if the user is not logged in, don't show the navigation bar */
if (session.getAttribute("uid") == null){ 
	nav = "<div id=\"button\">" + 
    "<a href=\"profile.jsp\"><img src=\"images/getStarted.png\" width=150px height=50px></a>" +
    "</div>" +
	"<h1 class=\"new\"><font face=\"helvetica neue\" color=\"green\">" +
	"about hygeia" +
	"</h1>";
}
else{ //show the navigation bar
	nav = "<div id=\"header\">" +
        "<table cellpadding=\"0\" cellspacing=\"0\">" +
"<tr>" +
"<td> <a href=\"home.jsp\"><img src=\"images/lightICON1.png\"></a></td>" +
"<td> <a href=\"inventory.jsp\"><img src=\"images/lightICON2.png\"></a></td>" +
"<td> <a href=\"history.jsp\"><img src=\"images/lightICON3.png\"></a></td>" +
"<td> <a href=\"recipes.jsp\"><img src=\"images/lightICON4.png\"></a></td>" +
"<td> <a href=\"profile.jsp\"><img src=\"images/lightICON5.png\"></a></td>" +
"<td> <a href=\"favorites.jsp\"><img src=\"images/lightICON6.png\"></a></td>" +
"<td> <img src=\"images/lightICON7.png\"></td>" +
"<td> <a href=\"logout.jsp\"><img src=\"images/lightICON8.png\"></a></td>" +
"</tr>" +
"</table>" +
"</div>" +
"<h1>about hygeia</h1>";
}

%>

<html>
<head><title>About | Hygeia</title></head>
<link type="text/css" rel="stylesheet" href="aboutStyle.css" />
<link rel="shortcut icon" href="favicon.ico" mce_href="favicon.ico"/> 
<body>

<!-- If user is logged in, display typical header.  Else, display Sign Up Button.  -->

<div id="page">
  <%= nav %>
  <div id="content">
    <div id="about">
      <p class="about">
      Hygeia is a website devoted to providing you with the best possible experience to start, change, 
      and track your diet process. Our team offers the feature to update your online fridge so we can provide
      you with meal choices that will meet your Zone Diet needs.</p>
    </div>

  <h2>
  <font face="helvetica neue" color="#7b840d"><center>
  meet the team
  </center></font>
  </h2>

<div id="team">
  <div id="left">
    <img src="images/adam.png" width=320px height=320px>
    <p class="name">Adam William Kuipers</p>
    <p class="description">Project Manager - enjoys fur hats and tasteful blazers</p><br />
	<img src="images/asher.png" width=320px height=320px>
     <p class="name">Asher McCall Garland</p>
    <p class="description"> Database Specialist - enjoys cinnamon Whiskey and coding on the beach</p><br />
	 <img src="images/kenney.png" width=320px height=320px>
     <p class="name">Kenney Cheung</p>
    <p class="description"> Software Development Lead - fascinated with the city of Los Angeles</p><br />
  </div>
  <div id="center">
     <img src="images/alex.png" width=320px height=320px>
     <p class="name">Alex Morris</p>
     <p class="description">Database Specialist - Eagle Scout who laughs manically at the death of Steve Jobs</p><br />
	 <img src="images/brian.png" width=320px height=320px>
     <p class="name">Brian Ta</p>
    <p class="description"> Graphic Designer - either pro or terrible at longboarding depending on the day</p><br />
	 <img src="images/link.png" width=320px height=320px>
    <p class="name">Lincoln J Race</p>
    <p class="description">Algorithm Specialaist/User Interface - basically the coolest person ever and in no way the one who wrote this page</p>
	 <img src="images/sara.png" width=320px height=320px>
	 <p class="name">Sara Millar</p>
     <p class="description">Quality Assurance Specialist - always has to tell people she's not a vegetarian</p><br />
   </div>
   <div id="right">
   <img src="images/anne.png" width=320px height=320px>
    <p class="name">Anne Brookes</p>
    <p class="description">Software Architect - avid runner and explorer of places far and wide</p><br />
	<img src="images/corbin.png" width=320px height=320px>
     <p class="name">Corbin Lewis</p>
     <p class="description">Software Development Lead - random fact extraordinaire with a keen sense of pants color</p><br /> 
	 <img src="images/mana.png" width=320px height=320px>
     <p class="name">Mana Jammalamadaka</p>
     <p class="description">Senior System Analyst - staunchly vegetarian but not vegan</p><br />
    </div>
</div>
  </div>
  <div id="footer"><a href="about.jsp">About Us</a><br />
		Hygeia is a project developed for a Software Engineering class at UCSD.<br />
        Please contact us at hygeia110@gmail.com if you would like to use any of the code found here.
  </div>
</body>
</html>
