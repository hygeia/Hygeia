<html>
  <head>
    <link type="text/css" rel="stylesheet" href="addMeal.css" />
  </head>
  <body>
  <div id="page">
    <div id="content">
      <center><h2>Add a Meal</h2></center><br />
	<form action="history.jsp" method="post">
        <div id="left">Name: <input name="name"></div>
		<input type="hidden" name="mid">
        <div id="right">Date: <input name="occurrence"></div> <br />
        <input type="hidden" name="addToHistory" value="addToHistory">
        <input type="submit">
    </form>
    </div>
  </div>
  </body>
</html>
