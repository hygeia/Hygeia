<html>
  <head>
    <link type="text/css" rel="stylesheet" href="popup.css" />
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
	  <div id="leftChoice">
	  <a href="selectFavorites.jsp"><img src="images/favorites.png" ></a><br /><br />
	  <p class="choice">Pick a meal from your list of favorites</p>
	  </div>
	  <div id="middleChoice">
	  <a href="suggestMeal.jsp"><img src="images/getSuggestion.png" ></a><br /><br />
	  <p class="choice">Get a suggested meal from our suggestion algorithm</p>
	  </div>
	  <div id="rightChoice">
	  <a href="addMeal.jsp"><img src="images/input.png" ></a><br /><br />
	  <p class="choice">Input a custom meal from the food you have available in your inventory</p>
	  </div>
  </div>
  </body>
</html>
