<%@ page import = "hygeia.*,java.util.*,java.sql.Timestamp,java.text.*" %>
<%
/* Check to see if a session exists */
if (session.getAttribute("uid") == null){ 
    /* Send away non-logged in users */
    response.sendRedirect("index.jsp");
    return;
}

/*
   Retrieve whatever data is needed and do any processing here. Try to do all
   database interactions and processing before any HTML, so that the page 
   can be redirected to an error page if soemthing should go wrong. Remember
   to close the database when you are done with it!  Please remember!
   
   Some common tasks:
   Get user id: int uid = session.getAttribute("uid");
   Get username: String username = session.getAttribute("username");
   Connect to the database: Database db = new Database();
   Create a user object: User u = new User(db, uid);
   Close the database: db.close();
   Redirect to another page: response.sendRedirect("url"); return;
 */
 
Database db = new Database();
int uid = (Integer)session.getAttribute("uid");
User u = new User(db, uid);
Inventory inv = new Inventory(u);

if( session.getAttribute("suggestedMid") == null){
	session.setAttribute("suggestedMid", 0); }
//if( session.getAttribute("suggestedArray") == null){
//	session.setAttribute("suggestedArray", new Food.Update[0]); }
//if( session.getAttribute("suggestedNameArray") == null){
//	session.setAttribute("suggestedNameArray", String[0]); }

//Food.Update[] f = (Food.Update[])session.getAttribute("suggestedArray");
//String[] fNames = (String[])session.getAttribute("suggestedNameArray");

String suggestedMealName = "";

if (request.getParameter("addToHistory") != null) {
	History hist = new History(u);
//	f = (Food.Update[])session.getAttribute("suggestedArray"); // get most current array
	if(session.getAttribute("suggestedMealType") == null){
		response.sendRedirect("error.jsp?code=3&echo=Could not get meal type");
		db.close();
		return;
	}
	String suggMealType = (String)session.getAttribute("suggestedMealType");
	int mealType = Integer.parseInt(suggMealType);
	int mid = (Integer)session.getAttribute("suggestedMid");
	Meal histMeal = new Meal(db, mid);
	Food.Update[] f = histMeal.getMeal(); //get array of current meal
//	int mid = Meal.createMeal(db, u, f, request.getParameter("name"), mealType);
	
	// create Timestamp
	Calendar c = Calendar.getInstance();
	c.set(Calendar.YEAR, Integer.parseInt(request.getParameter("yeardropdown")));
	int month = Integer.parseInt(request.getParameter("monthdropdown"));
	switch(month){
		case 0: c.set(Calendar.MONTH, Calendar.JANUARY); break;
		case 1: c.set(Calendar.MONTH, Calendar.FEBRUARY); break;
		case 2: c.set(Calendar.MONTH, Calendar.MARCH); break;
		case 3: c.set(Calendar.MONTH, Calendar.APRIL); break;
		case 4: c.set(Calendar.MONTH, Calendar.MAY); break;
		case 5: c.set(Calendar.MONTH, Calendar.JUNE); break;
		case 6: c.set(Calendar.MONTH, Calendar.JULY); break;
		case 7: c.set(Calendar.MONTH, Calendar.AUGUST); break;
		case 8: c.set(Calendar.MONTH, Calendar.SEPTEMBER); break;
		case 9: c.set(Calendar.MONTH, Calendar.OCTOBER); break;
		case 10: c.set(Calendar.MONTH, Calendar.NOVEMBER); break;
		case 11: c.set(Calendar.MONTH, Calendar.DECEMBER); break;
		default: 
			response.sendRedirect("error.jsp?code=3&echo=Could not parse date");
			db.close();
			return;
	}

	c.set(Calendar.DAY_OF_MONTH, Integer.parseInt(request.getParameter("daydropdown")));
	c.set(Calendar.HOUR_OF_DAY, Integer.parseInt(request.getParameter("timedropdown")));
	Timestamp today = new Timestamp(c.getTimeInMillis());
	
	if ( histMeal == null )
	{
		response.sendRedirect("error.jsp?code=1&echo=Could not add" +
				" meal to favorites");
			db.close();
			return;
	} 
	
	hist.addMeal(histMeal, today);
//	session.setAttribute("suggestedArray", new Food.Update[0]);
	session.setAttribute("suggestedMid", 0);
	
	if( (request.getParameterValues("favs") != null) && 
	    (request.getParameterValues("favs").length > 0) ){
		Favorites fav = new Favorites (u);
		boolean r = fav.addMeal(histMeal);
		if (r == false) {
			response.sendRedirect("error.jsp?code=1&echo=Could not add" +
				" meal to favorites");
			db.close();
			return;
		}
	}
}

Algorithm alg = new Algorithm(db, u);
Meal suggested = null;
String mealDisp = "";

if (request.getParameter("suggestNewMeal") != null) {
	if( request.getParameter("mealType") == null ){
		mealDisp = "<center>Select a meal type in order to receive a suggestion.</center>";
	}else{
		suggested = alg.suggestMeal(u, Integer.parseInt(request.getParameter("mealType")));
	}
	if( request.getParameter("mealType") != null && suggested == null ){
		mealDisp = "<center>No meals available for suggestion at this time.</center>";
	}
	else if(request.getParameter("mealType") != null ){
		suggestedMealName = suggested.getName();
		session.setAttribute("suggestedMid", suggested.getMid());
	
		/* add the food items of the old meal to the inventory */
		Food.Update[] mealToAdd = new Meal(db, suggested.getMid()).getMeal();
		for( Food.Update food : mealToAdd ){
			Food.Update foodToAdd = new Food.Update(food.getFid(), food.getCount());
			Food.Update[] arr = inv.getInventory();
			if (arr == null) {
				response.sendRedirect("error.jsp?code=4&echo=Could not fetch inventory");
				db.close();
				return;
			}
			for( Food.Update up : arr ){
				if(up.getFid() == food.getFid()){
					foodToAdd = up;
					break;
				}
			}
			boolean r = inv.updateFood(new Food.Update(food.getFid(), foodToAdd.getCount() + food.getCount()));
			if (r == false) {
				response.sendRedirect("error.jsp?code=1&echo=Could not update" +
					" inventory");
				db.close();
				return;
			}
		}

		/* remove the food items of the new meal from the inventory */
		int mid = suggested.getMid();
		Meal m = new Meal(db, mid);
		Food.Update[] foods = m.getMeal();
		for( Food.Update food : foods ){
			boolean r = inv.removeFood(food);
			if (r == false) {
				response.sendRedirect("error.jsp?code=1&echo=Could not update" +
					" inventory");
				db.close();
				return;
			}
		}
//		session.setAttribute("suggestedArray", suggested.getMeal());
		session.setAttribute("suggestedMealType", (String)request.getParameter("mealType"));

		mealDisp = "<center>Meal added successfully!</center>";
	}
}

Food.Update[] sf = null;

if( suggested == null ){
	sf = new Food.Update[0];
}else{
	sf = suggested.getMeal();
}

/* Produce table of foods already in meal, with remove from meal forms */
//f = (Food.Update[])session.getAttribute("suggestedArray"); // get most current array
mealDisp += "<table style='margin:auto auto;'>\n";
for (Food.Update up : sf) {
	String s = "<tr><td>" + up.getName(db) + "</td><td>Amount: " +up.getCount() +
        "</td></tr>\n";
	mealDisp += s;
}
mealDisp += "</table>\n";

db.close();

%>
<html>
  <head>
    <link type="text/css" rel="stylesheet" href="popup.css" />
<script type='text/javascript' src='http://code.jquery.com/jquery-1.4.4.min.js'></script>
	<link rel="stylesheet" type="text/css" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.4/themes/ui-lightness/jquery-ui.css"/>
			<script type="text/javascript">

/***********************************************
* Drop Down Date select script- by JavaScriptKit.com
* This notice MUST stay intact for use
* Visit JavaScript Kit at http://www.javascriptkit.com/ for this script and more
***********************************************/

var monthtext=['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sept','Oct','Nov','Dec'];

function populatedropdown(dayfield, monthfield, yearfield, timefield){
var today=new Date()
var dayfield=document.getElementById(dayfield)
var monthfield=document.getElementById(monthfield)
var yearfield=document.getElementById(yearfield)
var timefield=document.getElementById(timefield)
for (var i=1; i<32; i++)
dayfield.options[i]=new Option(i, i)
dayfield.options[today.getDate()]=new Option(today.getDate(), today.getDate(), true, true) //select today's day
for (var m=0; m<12; m++)
monthfield.options[m]=new Option(monthtext[m], monthtext[m])
monthfield.options[today.getMonth()]=new Option(monthtext[today.getMonth()], today.getMonth(), true, true) //select today's month
var thisyear=today.getFullYear()
for (var y=0; y<20; y++){
yearfield.options[y]=new Option(thisyear, thisyear)
thisyear+=1
}
yearfield.options[0]=new Option(today.getFullYear(), today.getFullYear(), true, true) //select today's year
for (var d=0; d<24; d++)
timefield.options[d]=new Option(d + ":00", d)
timefield.options[today.getHours()]=new Option(today.getHours() + ":00" , today.getHours(), true, true) //select current time
}

</script>
<script type='text/javascript'>//<![CDATA[ 
$(function(){
var cbox = $('#myHiddenCheckbox')[0];

$('#myImage').click(function() {
    cbox.checked = !cbox.checked;
        this.src = (cbox.checked)?"images/starBright.png":"images/starDull.png";
});
});//]]>  
</script>
  </head>
  <body>
  <div id="page">
    <div id="content">
	<div id="green">
	<a href="mealChoice.jsp"><img src="images/back.png" style="float:left" width=50px height=50px/></a>
    <p class="suggestMeal">Add A Suggested Meal</p<br />
	<center><h2 class="new">Meal</h2></center><br /><%= mealDisp %>
	<br /><center>
	<form action="suggestMeal.jsp" method="post">
		<input type="hidden" name="suggestNewMeal" value="suggestNewMeal"/>
		<input type="radio" name="mealType" value=1000 />Breakfast<br />
		<input type="radio" name="mealType" value=100 />Lunch<br />
		<input type="radio" name="mealType" value=10 />Dinner<br />
		<input type="radio" name="mealType" value=1 />Snack<br />
		<input type="submit" value="Give Me a Suggestion" />
	</form>
	</center><br />
	<p>Once you're happy with your meal, enter a name and date to add it to your calendar!</p>
	<br />
	<form action="suggestMeal.jsp" method="post">
        <div id="left">Name: <input type="hidden" name="name" value="<%= suggestedMealName %>"><%= suggestedMealName %></div>
        <div id="right">Date: <select id="daydropdown" name="daydropdown"></select> 
			<select id="monthdropdown" name="monthdropdown"></select> 
			<select id="yeardropdown" name="yeardropdown"></select>
		Time: <select id="timedropdown" name="timedropdown"></select>
		</div>
		<br /><br /><input type="hidden" name="addToHistory" value="addToHistory">
        <div id="right">
		<img id='myImage' src = "images/starDull.png" style="float:right;"/>

    <input type="checkbox" name="favs" value="1" id='myHiddenCheckbox' style="display:none" /><p style="text-align:right;">Add to Favorites</p>
	 <input type="image" src="images/submit.png" value="submit">
		</div>
    </form>
	</div>
<script type="text/javascript">
//populatedropdown(id_of_day_select, id_of_month_select, id_of_year_select)
window.onload=function(){
populatedropdown("daydropdown", "monthdropdown", "yeardropdown", "timedropdown")
}
</script>
    </div>
  </div>
  </body>
</html>
