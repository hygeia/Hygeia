<%
int[] pct1 = {30, 32, 40}; 
int[] block1 = {20, 10, 30};
String meal = "MEAL NAME HERE";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">

<head>
<link type="text/css" rel="stylesheet" href="favoritesStyle.css" />
    <link rel="shortcut icon" href="favicon.ico" mce_href="favicon.ico"/> 
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

#searchwrapper {
width:310px; /*follow your image's size*/
height:40px;/*follow your image's size*/
background-image:url(THE_SEARCH_BOX_IMAGE);
background-repeat:no-repeat; /*important*/
padding:0px;
margin:0px;
position:relative; /*important*/
}
 
#searchwrapper form { display:inline ; }
 
.searchbox {
border-style:outset;
border-width:2px;
border-color:b2b48c;
border-radius:7px;
background-color:fbffcc; /*important*/
position:absolute; /*important*/
top:4px;
left:9px;
width:256px;
height:28px;
font-size:18px;
font-family:verdana;
}
 
.searchbox_submit {
border:0px; /*important*/
background-color:transparent; /*important*/
position:absolute; /*important*/
top:4px;
left:265px;
width:32px;
height:28px;
}
</style>
</head>
<div id="page">
  <div id="header">
<!-- Navigation Bar -->

<table cellpadding="0" cellspacing="0">
<tr>
<td> <a href="index.jsp"><img src="images/lightICON1.png"></a></td>
<td> <a href="inventory.jsp"><img src="images/lightICON2.png" style="margin-left: -10px;" href="index.jsp"></a></td>
<td> <a href="favorites.jsp"><img src="images/lightICON3.png" style="margin-left: -5px;"></a></td>
<td> <a href="history.jsp"><img src="images/lightICON4.png" style="margin-left: -10px;"></a></td>
<td> <a href="recipes.jsp"><img src="images/lightICON5.png" style="margin-left: -10px;"></a></td>
<td> <img src="images/lightICON6.png" style="margin-left: -10px;"></td>
</tr>
</table>

  </div>
<br />

<body>
<div id="left">
<div id="searchwrapper"><form action="">
<input type="text" class="searchbox" name="s" value="" />
<input type="image" src="images/searchBarICON.png" class="searchbox_submit" value="" />
</form>
</div>

<img class="page" src="images/breakfastFavoritesICON.png">
<br />

<br />
<img class="page" src="images/DefaultFavoritesICON.png" style="margin-left: 10px; margin-right:10px;">
<img class="page" src="images/DefaultFavoritesICON.png" style="margin-left: 10px; margin-right:10px;">
<img class="page" src="images/DefaultFavoritesICON.png" style="margin-left: 10px; margin-right:10px;">
<img class="page" src="images/DefaultFavoritesICON.png" style="margin-left: 10px; margin-right:10px;">
<br />
<br />
<img class="page" src="images/DefaultFavoritesICON.png" style="margin-left: 10px; margin-right:10px;">
<img class="page" src="images/DefaultFavoritesICON.png" style="margin-left: 10px; margin-right:10px;">
<img class="page" src="images/DefaultFavoritesICON.png" style="margin-left: 10px; margin-right:10px;">
<br />
<br />

<img class="page" src="images/lunchFavoritesICON.png">
<br />

<br />
<img class="page" src="images/DefaultFavoritesICON.png" style="margin-left: 10px; margin-right:10px;">
<img class="page" src="images/DefaultFavoritesICON.png" style="margin-left: 10px; margin-right:10px;">
<img class="page" src="images/DefaultFavoritesICON.png" style="margin-left: 10px; margin-right:10px;">

</div>
<div id="right">
  <div id="today_pie"></div>
  <div id="today_bar"></div>
</div>
</div>
</body>
</html>
