<%@ page import = "hygeia.*,java.lang.*" %>
<%
/* Check to see if a session exists */
/*if (session.getAttribute("uid") == null) {*/
    /* Send away non-logged in users */
/*    response.sendRedirect("index.jsp");
    return;
}*/

/*
   Retrieve whatever data is needed and do any processing here. Try to do all
   database interactions and processing before any HTML, so that the page 
   can be redirected to an error page if soemthing should go wrong. Remember
   to close the database when you are done with it!
   
   Some common tasks:
   Get user id: int uid = session.getAttribute("uid");
   Get username: String username = session.getAttribute("username");
   Connect to the database: Database db = new Database();
   Create a user object: User u = new User(db, uid);
   Close the database: db.close();
   Redirect to another page: response.sendRedirect("url"); return;
 */

int[] pct1 = {30, 40, 32}; //today
int[] pct2 = {30, 40, 42};
int[] pct3 = {30, 40, 37};
int[] pct4 = {30, 40, 32};

int[] block1 = {20, 30, 10}; //today
int[] block2 = {20, 30, 10};
int[] block3 = {20, 30, 10};
int[] block4 = {20, 30, 10};

String day1 = "March 1, 2012";
String day2 = "February 29, 2012";
String day3 = "February 28, 2012";
String day4 = "February 27, 2012";

String[] meals = {"Breakfast", "Lunch"};
String[][] mealFoods = new String[2][3];
mealFoods[0][0] = "Eggs"; mealFoods[0][1] = "Bacon"; mealFoods[0][2] = "Sausage";
mealFoods[1][0] = "Hamburger"; mealFoods[1][1] = "Fries"; mealFoods[1][2] = "Coke";
String[][] mealNuts = new String[2][3];
mealNuts[0][0] = "7"; mealNuts[0][1] = "12"; mealNuts[0][2] = "13";
mealNuts[1][0] = "17"; mealNuts[1][1] = "14"; mealNuts[1][2] = "19";

 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
  <head>
    <title>Hygeia</title>
    <link type="text/css" rel="stylesheet" href="style.css" />
    <link rel="shortcut icon" href="favicon.ico" mce_href="favicon.ico"/> 
	<script type="text/javascript" src="https://www.google.com/jsapi"></script>
    <script type="text/javascript">
      google.load("visualization", "1", {packages:["corechart"]});
      google.setOnLoadCallback(drawChart);
      function drawChart() {
        var data1 = new google.visualization.DataTable(); 
        var data2 = new google.visualization.DataTable();
        var data3 = new google.visualization.DataTable();
        var data4 = new google.visualization.DataTable();
	data1.addColumn('string', 'Nutrient');
        data1.addColumn('number', 'Grams');
        data1.addRows([
          ['Carbs',    <%= pct1[0] %>],
          ['Fat',     <%= pct1[1] %>],
          ['Protein',  <%= pct1[2] %>],
	]);
	data2.addColumn('string', 'Nutrient');
        data2.addColumn('number', 'Grams');
        data2.addRows([
          ['Carbs',    <%= pct2[0] %>],
          ['Fat',     <%= pct2[1] %>],
          ['Protein',  <%= pct2[2] %>],
	]);
	data3.addColumn('string', 'Nutrient');
        data3.addColumn('number', 'Grams');
        data3.addRows([
          ['Carbs',    <%= pct3[0] %>],
          ['Fat',     <%= pct3[1] %>],
          ['Protein',  <%= pct3[2] %>],
	]);
	data4.addColumn('string', 'Nutrient');
        data4.addColumn('number', 'Grams');
        data4.addRows([
          ['Carbs',    <%= pct4[0] %>],
          ['Fat',     <%= pct4[1] %>],
          ['Protein',  <%= pct4[2] %>],
        ]);

        var optionsToday = {
          width: 220, height: 200,
          backgroundColor: '#c3e2da',
		  legend: {
		    position:'top',
		  }
        };

	var optionsOday = {
          width: 84, height: 84,
          backgroundColor:'#8b9A70',
		  legend: {
		    position:'none',
		  },
		chartArea:{width:"98%",height:"98%"},
	pieSliceText:'none'
        };


        var chart1 = new google.visualization.PieChart(document.getElementById('today_pie'));
        chart1.draw(data1, optionsToday);
	var chart2 = new google.visualization.PieChart(document.getElementById('yesterday_pie'));
        chart2.draw(data2, optionsOday);
	var chart3 = new google.visualization.PieChart(document.getElementById('twoday_pie'));
        chart3.draw(data3, optionsOday);
	var chart4 = new google.visualization.PieChart(document.getElementById('threeday_pie'));
        chart4.draw(data4, optionsOday);

      }
    </script>
	<script type="text/javascript">
      google.load("visualization", "1", {packages:["corechart"]});
      google.setOnLoadCallback(drawChart);
      function drawChart() {
        var data1 = new google.visualization.DataTable();
	var data2 = new google.visualization.DataTable();
	var data3 = new google.visualization.DataTable();
	var data4 = new google.visualization.DataTable();	
        data1.addColumn('string', 'Year');
        data1.addColumn('number', 'Carbs');
        data1.addColumn('number', 'Fat');
	data1.addColumn('number', 'Protein');
        data1.addRows([
          ['<%= day1 %>', <%= block1[0] %>, <%= block1[1] %>, <%= block1[2] %>]
        ]);
	data2.addColumn('string', 'Year');
        data2.addColumn('number', 'Carbs');
        data2.addColumn('number', 'Fat');
	data2.addColumn('number', 'Protein');
        data2.addRows([
          ['<%= day2 %>', <%= block2[0] %>, <%= block2[1] %>, <%= block2[2] %>]
        ]);
	data3.addColumn('string', 'Year');
        data3.addColumn('number', 'Carbs');
        data3.addColumn('number', 'Fat');
	data3.addColumn('number', 'Protein');
        data3.addRows([
          ['<%= day3 %>', <%= block3[0] %>, <%= block3[1] %>, <%= block3[2] %>]
        ]);
	data4.addColumn('string', 'Year');
        data4.addColumn('number', 'Carbs');
        data4.addColumn('number', 'Fat');
	data4.addColumn('number', 'Protein');
        data4.addRows([
          ['<%= day4 %>', <%= block4[0] %>, <%= block4[1] %>, <%= block4[2] %>]
        ]);

	

        var optionsToday = {
          width: 220, height: 200,
		  backgroundColor: '#c3e2da',
		  vAxis: {
		    baselineColor:'#c3e2da',
			gridlines: {
			  count:4,
			  color:'#c3e2da',
			},
		  },
		  title:'Block Level',
		  legend: {
		    position:'none'
		  }
        };

	var optionsOday = {
          width: 84, height: 84,
		  backgroundColor: '#8b9A70',
		  vAxis: {
		    baselineColor:'#8b9A70',
			gridlines: {
			  count:4,
			  color:'#8b9A70',
			},
		  },
		  chartArea:{width:"100%",height:"100%"},
		  legend: {
		    position:'none'
		  },	
        };


        var chart1 = new google.visualization.ColumnChart(document.getElementById('today_bar'));
        chart1.draw(data1, optionsToday);
	var chart2 = new google.visualization.ColumnChart(document.getElementById('yesterday_bar'));
        chart2.draw(data2, optionsOday);
	var chart3 = new google.visualization.ColumnChart(document.getElementById('twoday_bar'));
        chart3.draw(data3, optionsOday);
	var chart4 = new google.visualization.ColumnChart(document.getElementById('threeday_bar'));
        chart4.draw(data4, optionsOday);

      }
    </script>
  </head>
  <body>
    <div id="page">
      <div id="header">
        <img src="h1.png"><a href="Profile.html"><img src="h2.png"></a><img src="h3.png"><a href="Logout.html"><img src="h4.png"></a><img src="h5.png">
      </div>
      <div id="content">
      <div id="oday" class="shadowBox"><%= day4 %><br /><br />
        <div id="chartwrapperOday">
          <div id="threeday_pie">
          </div>
          <div id="threeday_bar">
          </div>
        </div>
        Carbs/Protein/Fat Ratio and Block Levels for 3 days ago
      </div>
      <div id="oday" class="shadowBox"><%= day3 %><br /><br />
        <div id="chartwrapperOday">
          <div id="twoday_pie">
          </div>
          <div id="twoday_bar">
          </div>
        </div>
        <br />Carbs/Protein/Fat Ratio and Block Levels for 2 days ago
      </div>
      <div id="oday" class="shadowBox"><%= day2 %><br /><br />
        <div id="chartwrapperOday">
          <div id="yesterday_pie">
          </div>
          <div id="yesterday_bar">
          </div>
        </div>
        <br />Carbs/Protein/Fat Ratio and Block Levels for yesterday
      </div>
      <div id="today" class="shadowBox"><h1><%= day1 %></h1>
        <div id="chartwrapperToday">
          <div id="today_pie">
          </div>
          <div id="today_bar">
          </div>
        </div>
        <p class="food">
<%
	String ret = "";
	for(int i=0; i < meals.length; i++){
		ret += "<h2>" + meals[i] + "</h2>";
		for(int j=0; j < mealFoods[i].length; j++){
			ret += (mealFoods[i][j] + "<br />");
		}
		ret += "<p class=\"total\">Protein: " + mealNuts[i][0] + "g ";
		ret += "Fat: " + mealNuts[i][1] + "g Carbs: " + mealNuts[i][2] + "g</p>";
	}
	out.print(ret);
%>
        </p>
      </div>
    </div>
      <div id="footer">Hygeia is a project developed for a Software Engineering class at UCSD.<br />
        Please contact us at hygeia@gmail.com if you would like to use any of the code found here.
      </div>
    </div>
  </body>
</html>

