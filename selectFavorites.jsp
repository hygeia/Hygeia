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
Favorites favs = new Favorites(u);

if( session.getAttribute("selectedMealName") == null){
	session.setAttribute("selectedMealName",  ""); }
if( session.getAttribute("selectedMid") == null){
	session.setAttribute("selectedMid",  0); }
//if( session.getAttribute("favArray") == null){
//	session.setAttribute("favArray", new Food.Update[0]); }
//if( session.getAttribute("favNameArray") == null){
//	session.setAttribute("favNameArray", String[0]); }

String selectedMealName = (String)session.getAttribute("selectedMealName");
//Food.Update[] f = (Food.Update[])session.getAttribute("favArray");
//String[] fNames = (String[])session.getAttribute("favNameArray");

if (request.getParameter("selectAsMeal") != null) {
	/* add the food items of the old meal to the inventory */
	Food.Update[] mealToAdd = new Meal(db, Integer.parseInt(request.getParameter("mid"))).getMeal();
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
    int mid = Integer.parseInt(request.getParameter("mid"));
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
//	session.setAttribute("favArray", foods);
	session.setAttribute("selectedMid", mid);
	session.setAttribute("selectedMealName", m.getName());
}

if (request.getParameter("removeSelectedMeal") != null) {
	/* add the food items of the old meal to the inventory */
	int mid = Integer.parseInt(request.getParameter("mid"));
	Meal mToAdd = new Meal(db, mid);
	Food.Update[] mealToAdd = mToAdd.getMeal();
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

//	session.setAttribute("favArray", new Food.Update[0]);
	session.setAttribute("selectedMid", 0);
	session.setAttribute("selectedMealName", "");
}

if (request.getParameter("addToHistory") != null) {
	History hist = new History(u);
//	f = (Food.Update[])session.getAttribute("favArray"); // get most current array
	int mid = (Integer)session.getAttribute("selectedMid");
	Meal histMeal = new Meal(db, mid);
//	Food.Update[] f = histMeal.getMeal(); //get array of current meal
	
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
	
	hist.addMeal(histMeal, today);
//	session.setAttribute("favArray", new Food.Update[0]);
	session.setAttribute("selectedMid", 0);
	session.setAttribute("selectedMealName", "");
}

Meal.List[] arr = favs.getFavorites();
if (arr == null) {
    response.sendRedirect("error.jsp?code=4&echo=Could not fetch favorites");
    db.close();
    return;
}
selectedMealName = (String)session.getAttribute("selectedMealName");

/* Produce table of foods in chosen meal */
//f = (Food.Update[])session.getAttribute("favArray"); // get most current array
Food.Update[] f = new Meal(db, (Integer)session.getAttribute("selectedMid")).getMeal();
String mealDisp = "<table style='margin:auto auto;'>\n";
if((Integer)session.getAttribute("selectedMid") > 0){
	for (Food.Update up : f) {
			String s = "<tr><td>" + up.getName(db) + "</td><td>Amount: " + 
			up.getCount() + "</td></tr>\n";
			mealDisp += s;
	}
	mealDisp += "<br /><form action='selectFavorites.jsp' method='post'>" +
		"<input type='hidden' name='mid' value=" + session.getAttribute("selectedMid") + ">" +
		"<input type='hidden' name='removeSelectedMeal' value=1>" +
		"<input type='submit' value='Remove'></form>";
	mealDisp += "</table>\n";
}

/* Produce table of meals, with select as meal forms */
String favDisp = "<table style='margin:auto auto;'>\n";
for (Meal.List ml : arr) {
	if( ml != null ){
		String disabled = "";
		Meal me = new Meal(db, ml.getMid());
		Food.List[] mefl = me.getFoodList();
		Food.List[] infl = inv.getInventoryList();
		for( Food.List fl : mefl ){
			for( Food.List il : infl ){
				if(il.getFid() == fl.getFid()){
					if(il.getCount() < fl.getCount()){
						disabled = "disabled='disabled'";
						break;
					}
				}
			}
			if( disabled.equals("disabled='disabled'") ){
				break;
			}
		}
		String s = "<tr><form action='selectFavorites.jsp' method='post'>" +
			"<input type='hidden' name='mid' value=" + ml.getMid() + ">" +
			"<td>" + ml.getName() + "</td><td><input type='hidden' name='" +
			"selectAsMeal' value=1><input type='submit' value='Select As Meal' " + 
			disabled + "></td></form></tr>\n";
		favDisp += s;
	}else{
		favDisp += "<tr><td>You have no favorite meals.</td></tr>";
	}
}
favDisp += "</table>\n";
db.close();

%>
<html>
  <head>
    <link type="text/css" rel="stylesheet" href="popup.css" />
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
  </head>
  <body>
  <div id="page">
    <div id="content">
    <a href="mealChoice.jsp"><img src="images/back.png" style="float:left" width=50px height=50px/></a>
	<p class="selectFav">Select From Your Favorite Meals</p><br />
	<center><h2 class="new">Meal</h2></center><br /><%= mealDisp %>
	<br /><center><h2>Favorites</h2></center><br /><%= favDisp %>
	<p>Once you've finished adding food, enter a name and date to add it to your calendar!</p>
	<br />
	<form action="selectFavorites.jsp" method="post">
        <div id="left">Name: <input type="hidden" name="name" value="<%= selectedMealName %>"><%= selectedMealName %></div>
		<input type="hidden" name="mid">
        <div id="right">Date: <select id="daydropdown" name="daydropdown"></select> 
			<select id="monthdropdown" name="monthdropdown"></select> 
			<select id="yeardropdown" name="yeardropdown"></select>
		Time: <select id="timedropdown" name="timedropdown"></select>
		</div>
		<br /><br />
		<div id="right">
		<input type="hidden" name="addToHistory2" value="addToHistory">
		<br /><br /><input type="submit" value="Add Meal">
		</div>
         </form>
	
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
