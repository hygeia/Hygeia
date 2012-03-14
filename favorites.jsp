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
String username = (String)session.getAttribute("username");
User u = new User(db, uid);
Favorites favs = new Favorites(u);

if (request.getParameter("removeFromFavorites") != null) {
    int mid = Integer.parseInt(request.getParameter("mid"));
    Meal m = new Meal(db, mid);
    favs.removeMeal(m);
}

if (request.getParameter("addToFavorites") != null) {
    int mid = Integer.parseInt(request.getParameter("mid"));
    Meal m = new Meal(db, mid);
    favs.addMeal(m);
}


Meal.List meals[] = favs.getFavorites();
if (meals == null) {
    response.sendRedirect("error.jsp?code=1&echo=Could not fetch favorites");
    db.close();
    return;
}

/* Produce table of meals */
String favDisp = "<table style='margin:auto auto;'>\n";
String noFavs="";
for (Meal.List m : meals) {
    if (m == null) {
        noFavs = "You currently have no meals saved in your favorites";
	db.close();
        break;
    }
    String s = "<form action='favorites.jsp' method='post'><tr><td>" + 
        m.getName() + "<input type='hidden' name='mid' value=" + m.getMid() +
        "><input type='hidden' name='removeFromFavorites' value=1></td><td>" +
        "<input type='image' src='images/X.png' width='25' height='25'></td></tr></form>\n";
    favDisp += s;
}
favDisp += "</table>\n";


%>

<%
int[] pct1 = {30, 32, 40}; 
int[] block1 = {20, 10, 30};
String meal = "MEAL NAME HERE";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">

<head>
<title>Favorites | Hygeia</title>
<link type="text/css" rel="stylesheet" href="style.css" />
    <link rel="shortcut icon" href="favicon.ico" mce_href="favicon.ico"/> 
<link rel="stylesheet" href="colorbox.css" />
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
		<script src="javascript/jquery.colorbox.js"></script>
		<script>
			$(document).ready(function(){
				//Examples of how to assign the ColorBox event to elements
				$(".ajax").colorbox({innerWidth:"925px", innerHeight:"600px", iframe:true, onClosed:function(){ window.location="home.jsp" }});
			});
		</script>
	<script type="text/javascript" src="https://www.google.com/jsapi"></script>
    <script type="text/javascript">
      google.load("visualization", "1", {packages:["corechart"]});
      google.setOnLoadCallback(drawChart);
      function drawChart() {
        var data1 = new google.visualization.DataTable(); 
	data1.addColumn('string', 'Nutrient');
        data1.addColumn('number', 'Grams');
        data1.addRows([
          ['Carbs',    <%= pct1[0] %>],
          ['Protein',     <%= pct1[1] %>],
          ['Fat',  <%= pct1[2] %>],
	]);

        var optionsToday = {
          width: 220, height: 200,
          backgroundColor: '#fbffcc',
		  legend: {
		    position:'top',
		  }
        };

        var chart1 = new google.visualization.PieChart(document.getElementById('today_pie'));
        chart1.draw(data1, optionsToday);
      }
    </script>
	<script type="text/javascript">
      google.load("visualization", "1", {packages:["corechart"]});
      google.setOnLoadCallback(drawChart);
      function drawChart() {
        var data1 = new google.visualization.DataTable();	
        data1.addColumn('string', 'Meal');
        data1.addColumn('number', 'Carbs');
        data1.addColumn('number', 'Protein');
	data1.addColumn('number', 'Fat');
        data1.addRows([
          ['<%= meal %>', <%= block1[0] %>, <%= block1[1] %>, <%= block1[2] %>]
        ]);
	

	

        var optionsToday = {
          width: 220, height: 200,
		  backgroundColor: '#fbffcc',
		  vAxis: {
		    baselineColor:'#fbffcc',
			gridlines: {
			  count:4,
			  color:'#fbffcc',
			},
		  },
		  title:'Block Level',
		  legend: {
		    position:'none'
		  }
        };


        var chart1 = new google.visualization.ColumnChart(document.getElementById('today_bar'));
        chart1.draw(data1, optionsToday);
      }
    </script>

<style type="text/css">
body{background-color: fbffcc}
li{color:black; font-family:arial;}
}
</style>
</head>
<div id="page">
  <div id="header">
<!-- Navigation Bar -->


<table cellpadding="0" cellspacing="0">
<tr>
<td> <a href="home.jsp"><img src="images/lightICON1.png"></a></td>
<td> <a href="inventory.jsp"><img src="images/lightICON2.png"></a></td>
<td> <a href="history.jsp"><img src="images/lightICON3.png"></a></td>
<td> <a href="recipes.jsp"><img src="images/lightICON4.png"></a></td>
<td> <a href="profile.jsp"><img src="images/lightICON5.png"></a></td>
<td> <a href="favorites.jsp"><img src="images/darkICON6.png"></a></td>
<td> <img src="images/lightICON7.png"></td>
<td> <a href="logout.jsp"><img src="images/lightICON8.png"></a></td>
</tr>
</table>
</div>
  <div id="content">
<br />
<div id="green">
<h1><%= username %>'s Favorites</h1>
</div>
<br>
<div id="green">
<p class="leftalignText">
<%= favDisp %>
<%= noFavs %>
</div></p>
<!--


<h2 style="text-align:right; font-family: verdana; background-color: #77850c; color:#fbff90; font-color: black; margin-right:700px; border-color:353b00; border-radius:7px; color=black; padding-right: 0.5cm"> Meal 1 </h2>

<ul>
<li> steak </li><br/>
<li> brocolli </li><br/>
<li> carrots </li><br/>
<li> mashed potatoes </li>
</ul>

<h2 style="text-align:right; font-family: verdana; background-color: #77850c; color:#fbff90; font-color: black; margin-right:700px; border-color:353b00; border-radius:7px; color=black; padding-right: 0.5cm"> Meal 2 </h2>

<ul>
<li> salad </li><br/>
<li> spinach </li><br/>
<li> tofu </li><br/>
<li> gravy </li>
</ul>


<div id="right">
  <div id="today_pie"></div>
  <div id="today_bar"></div>
</div>

-->

<div style="float:right; margin-top:50px;"><a class='ajax' href="addtoFaves.jsp"><img src="images/addFaves.png"></a></div>

</div>
</div>


<div id="footer"><a href="about.jsp">About Us</a><br />
		Hygeia is a project developed for a Software Engineering class at UCSD.<br />
        Please contact us at hygeia110@gmail.com if you would like to use any of the code found here.
      </div>
</body>
</html>
