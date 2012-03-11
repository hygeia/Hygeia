<html>
  <head>
    <link type="text/css" rel="stylesheet" href="mealChoice.css" />
	<link rel="stylesheet" href="colorbox.css" />
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
		<script src="javascript/jquery.colorbox.js"></script>
		<script>
			$(document).ready(function(){
				//Examples of how to assign the ColorBox event to elements
				$(".ajax").colorbox({innerWidth:"925px", innerHeight:"600px", iframe:true});
			});
		</script>
  </head>
  <body>
  <div id="page">
    <div id="content">
	  <h1>How Would You Like to Enter Your Meal?</h1>
	  <div id="left">
	  <a href="addMeal.jsp"><img src="images/addMeal.png" width=100px height=33px></a><br /><br />
	  Pick a meal from your list of favorites
	  </div>
	  <div id="left">
	  <a href="addMeal.jsp"><img src="images/addMeal.png" width=100px height=33px></a><br /><br />
	  Get a suggested meal from our suggestion algorithm
	  </div>
	  <div id="left">
	  <a href="addMeal.jsp"><img src="images/addMeal.png" width=100px height=33px></a><br /><br />
	  Input a custom meal from the food you have available in your inventory
	  </div>
  </div>
  </body>
</html>
