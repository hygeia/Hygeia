<%@ page import = "hygeia.*" %>
<%
/* Check to see if a session exists */
if (session.getAttribute("uid") == null) {
    /* Send away non-logged in users */
    response.sendRedirect("index.jsp");
    return;
}

/*
   Retrieve whatever data is needed and do any processing here. Try to do all
   database interactions and processing before any HTML, so that the page 
   can be redirected to an error page if soemthing should go wrong. Remember
   to close the database when you are done with it!
   
   Some common tasks:
   Get user id: int uid = (Integer)session.getAttribute("uid");
   Get username: String username = (String)session.getAttribute("username");
   Connect to the database: Database db = new Database();
   Create a user object: User u = new User(db, uid);
   Close the database: db.close();
   Redirect to another page: response.sendRedirect("url"); return;
 */
 
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
          ['Carbs',    30],
          ['Fat',     40],
          ['Protein',  32],
	]);
	data2.addColumn('string', 'Nutrient');
        data2.addColumn('number', 'Grams');
        data2.addRows([
          ['Carbs',    30],
          ['Fat',     40],
          ['Protein',  42],
	]);
	data3.addColumn('string', 'Nutrient');
        data3.addColumn('number', 'Grams');
        data3.addRows([
          ['Carbs',    30],
          ['Fat',     40],
          ['Protein',  37],
	]);
	data4.addColumn('string', 'Nutrient');
        data4.addColumn('number', 'Grams');
        data4.addRows([
          ['Carbs',    30],
          ['Fat',     40],
          ['Protein',  32],
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
          ['Today', 20, 30, 10]
        ]);
	data2.addColumn('string', 'Year');
        data2.addColumn('number', 'Carbs');
        data2.addColumn('number', 'Fat');
	data2.addColumn('number', 'Protein');
        data2.addRows([
          ['Yesterday', 20, 30, 10]
        ]);
	data3.addColumn('string', 'Year');
        data3.addColumn('number', 'Carbs');
        data3.addColumn('number', 'Fat');
	data3.addColumn('number', 'Protein');
        data3.addRows([
          ['2 days ago', 20, 30, 10]
        ]);
	data4.addColumn('string', 'Year');
        data4.addColumn('number', 'Carbs');
        data4.addColumn('number', 'Fat');
	data4.addColumn('number', 'Protein');
        data4.addRows([
          ['3 days ago', 20, 30, 10]
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
      <div id="oday" class="shadowBox">3 Days Ago<br /><br />
        <div id="chartwrapperOday">
          <div id="threeday_pie">
          </div>
          <div id="threeday_bar">
          </div>
        </div>
        Carbs/Protein/Fat Ratio and Block Levels for 3 days ago
      </div>
      <div id="oday" class="shadowBox">2 Days Ago<br /><br />
        <div id="chartwrapperOday">
          <div id="twoday_pie">
          </div>
          <div id="twoday_bar">
          </div>
        </div>
        <br />Carbs/Protein/Fat Ratio and Block Levels for 2 days ago
      </div>
      <div id="oday" class="shadowBox">Yesterday<br /><br />
        <div id="chartwrapperOday">
          <div id="yesterday_pie">
          </div>
          <div id="yesterday_bar">
          </div>
        </div>
        <br />Carbs/Protein/Fat Ratio and Block Levels for yesterday
      </div>
      <div id="today" class="shadowBox"><h1>Today</h1>
        <div id="chartwrapperToday">
          <div id="today_pie">
          </div>
          <div id="today_bar">
          </div>
        </div>
        <p class="food">
          <h2>Breakfast</h2>
          Eggs<br />
          Bacon<br />
          Sausage<br />
	  <p class="total">Protein: 7g Fat: 12g Carbs: 13g</p>
          <h2>Lunch</h2>
          Hamburger<br />
          Fries<br />
	  Coke<br />
          <p class="total">Protein: 17g Fat: 14g Carbs: 19g</p>
        </p>
      </div>
    </div>
      <div id="footer">Hygeia is a project developed for a Software Engineering class at UCSD.<br />
        Please contact us at hygeia@gmail.com if you would like to use any of the code found here.
      </div>
    </div>
  </body>
</html>

