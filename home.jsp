<%@ page import = "hygeia.*,java.util.*,java.sql.Timestamp,java.text.*" %>
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

 /* this is all temporary because the java files are not yet complete */
int[] pct1 = {30, 32, 40}; //today
int[] pct2 = {30, 42, 40};
int[] pct3 = {30, 37, 40};
int[] pct4 = {30, 32, 40};

int[] block1 = {20, 10, 30}; //today
int[] block2 = {20, 10, 30};
int[] block3 = {20, 10, 30};
int[] block4 = {20, 10, 30};

DateFormat df = DateFormat.getDateInstance(DateFormat.LONG);
Date todaysdate = new Date();
String day1 = df.format(todaysdate);
String day2 = df.format(new Date(todaysdate.getTime() - 86400000));
String day3 = df.format(new Date(todaysdate.getTime() - (86400000 * 2)));
String day4 = df.format(new Date(todaysdate.getTime() - (86400000 * 3)));

/* this will be replaced with the java code below when it works */
String[] meals = {"Breakfast", "Lunch"};
String[][] mealFoods = new String[2][3];
mealFoods[0][0] = "Eggs"; mealFoods[0][1] = "Bacon"; mealFoods[0][2] = "Sausage";
mealFoods[1][0] = "Hamburger"; mealFoods[1][1] = "Fries"; mealFoods[1][2] = "Coke";
String[][] mealNuts = new String[2][3];
mealNuts[0][0] = "13"; mealNuts[0][1] = "7"; mealNuts[0][2] = "12";
mealNuts[1][0] = "19"; mealNuts[1][1] = "17"; mealNuts[1][2] = "14";

/* This is what code will actually be called
Database db = new Database();
int uid = session.getAttribute("uid");
User u = new User(db, uid);
History hist = new History(u);
Meal.List arr[] = hist.getHistory();
ArrayList<Meal> todayarr = new ArrayList<Meal.List>();
ArrayList<Meal> yesterdayarr = new ArrayList<Meal.List>();
ArrayList<Meal> twodayarr = new ArrayList<Meal.List>();
ArrayList<Meal> threedayarr = new ArrayList<Meal.List>();
for(int i=0; i<meals.length; i++){
	switch(findDay(arr[i])){
		case 0:
			todayarr.add(new Meal(arr[i].getMid(), db));
			break;
		case 1:
			yesterdayarr.add(new Meal(arr[i].getMid(), db));
			break;
		case 2:
			twodayarr.add(new Meal(arr[i].getMid(), db));
			break;
		case 3:
			threedayarr.add(new Meal(arr[i].getMid(), db));
			break;
	}
}

// calculate percentage of carbs, protein, and fat for the pie charts
int tempc = 0;
int tempp = 0;
int tempf = 0;
for(int i=0; i<todayarr.size(); i++){
	Nutrition nuts = todayarr.get(i).getNutrition();
	tempc += nuts.getCarbohydrates();
	tempp += nuts.getProtein();
	tempf += nuts.getFat();
}
int[] pct1 = {tempc/todayarr.size(), tempf/todayarr.size(), tempp/todayarr.size()};
for(int i=0; i<yesterdayarr.size(); i++){
	Nutrition nuts = yesterdayarr.get(i).getNutrition();
	tempc += nuts.getCarbohydrates();
	tempp += nuts.getProtein();
	tempf += nuts.getFat();
}
int[] pct2 = {tempc/yesterdayarr.size(), tempf/yesterdayarr.size(), tempp/yesterdayarr.size()};
for(int i=0; i<twodayarr.size(); i++){
	Nutrition nuts = twodayarr.get(i).getNutrition();
	tempc += nuts.getCarbohydrates();
	tempp += nuts.getProtein();
	tempf += nuts.getFat();
}
int[] pct3 = {tempc/twodayarr.size(), tempf/twodayarr.size(), tempp/twodayarr.size()};
for(int i=0; i<threedayarr.size(); i++){
	Nutrition nuts = threedayarr.get(i).getNutrition();
	tempc += nuts.getCarbohydrates();
	tempp += nuts.getProtein();
	tempf += nuts.getFat();
}
int[] pct4 = {tempc/threedayarr.size(), tempp/threedayarr.size(), tempf/threedayarr.size()};

// calculate blocks of carbs, protein, and fat for the bar charts 
int[] block1 = {20, 10, 30}; //today
int[] block2 = {20, 10, 30};
int[] block3 = {20, 10, 30};
int[] block4 = {20, 10, 30};

// create a string that shows meal names, foods, and nutrition info for today 
String todayinfo = "";
for(int i=0; i<todayarr.size(); i++){
	todayinfo += "<h2>" + todayarr.get(i).getName() + "</h2>";
	Food.List foods[] = todayarr.get(i).getFoodList();
	for(int j=0; j < foods.length; j++){
		todayinfo += (foods[j].getName() + "<br />");
	}
	Nutrition nuts = todayarr.get(i).getNutrition();
	todayinfo += "<p class=\"total\">Carbs: " + nuts.getCarbs() + "g ";
	todayinfo += "Protein: " + nuts.getProtein() + "g Fat: " + nuts.getFat() + "g</p>";
}

db.close();
*/

 %>
 <%!
	/* 0 = today, 1 = yesterday, 2 = two days ago, 3 = three days ago, -1 = more than three days ago */
/*	int findDay(Meal.List m){
		Calendar c = new Calendar();
		int year = c.get(Calendar.YEAR);
		int month = c.get(Calendar.MONTH);
		int day = c.get(Calendar.DAY_OF_MONTH);
		c.set(year, month, day, 0, 0);
		Timestamp today = new Timestamp(c.getTimeInMillis());
		Timestamp yesterday = new Timestamp(c.getTimeInMillis() - 86400000);
		Timestamp twoday = new Timestamp(c.getTimeInMillis() - (86400000 * 2));
		Timestamp threeday = new Timestamp(c.getTimeInMillis() - (86400000 * 3));
		
		if(m.getOccurrence.after(today)){
			return 0;
		}else if(m.getOccurrence.after(yesterday)){
			return 1;
		}else if(m.getOccurrence.after(twoday)){
			return 2;
		}else if(m.getOccurrence.after(threeday)){
			return 3;
		}else{
			return -1;
		}
	}*/
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
          ['Protein',     <%= pct1[1] %>],
          ['Fat',  <%= pct1[2] %>],
	]);
	data2.addColumn('string', 'Nutrient');
        data2.addColumn('number', 'Grams');
        data2.addRows([
          ['Carbs',    <%= pct2[0] %>],
          ['Protein',     <%= pct2[1] %>],
          ['Fat',  <%= pct2[2] %>],
	]);
	data3.addColumn('string', 'Nutrient');
        data3.addColumn('number', 'Grams');
        data3.addRows([
          ['Carbs',    <%= pct3[0] %>],
          ['Protein',     <%= pct3[1] %>],
          ['Fat',  <%= pct3[2] %>],
	]);
	data4.addColumn('string', 'Nutrient');
        data4.addColumn('number', 'Grams');
        data4.addRows([
          ['Carbs',    <%= pct4[0] %>],
          ['Protein',     <%= pct4[1] %>],
          ['Fat',  <%= pct4[2] %>],
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
        data1.addColumn('number', 'Protein');
	data1.addColumn('number', 'Fat');
        data1.addRows([
          ['<%= day1 %>', <%= block1[0] %>, <%= block1[1] %>, <%= block1[2] %>]
        ]);
	data2.addColumn('string', 'Year');
        data2.addColumn('number', 'Carbs');
        data2.addColumn('number', 'Protein');
	data2.addColumn('number', 'Fat');
        data2.addRows([
          ['<%= day2 %>', <%= block2[0] %>, <%= block2[1] %>, <%= block2[2] %>]
        ]);
	data3.addColumn('string', 'Year');
        data3.addColumn('number', 'Carbs');
        data3.addColumn('number', 'Protein');
	data3.addColumn('number', 'Fat');
        data3.addRows([
          ['<%= day3 %>', <%= block3[0] %>, <%= block3[1] %>, <%= block3[2] %>]
        ]);
	data4.addColumn('string', 'Year');
        data4.addColumn('number', 'Carbs');
        data4.addColumn('number', 'Protein');
	data4.addColumn('number', 'Fat');
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
        <img src="images/h1.png"><a href="Profile.html"><img src="images/h2.png"></a><img src="images/h3.png"><a href="Logout.html"><img src="images/h4.png"></a><img src="images/h5.png">
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
		ret += "<p class=\"total\">Carbs: " + mealNuts[i][0] + "g ";
		ret += "Protein: " + mealNuts[i][1] + "g Fat: " + mealNuts[i][2] + "g</p>";
	}
	out.print(ret);
	
	//this will be replaced with s as calculated at the top
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
