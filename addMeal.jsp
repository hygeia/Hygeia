<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
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

if( session.getAttribute("mealArray") == null){
	session.setAttribute("mealArray", new ArrayList<Food.Update>()); }
//if( session.getAttribute("mealNameArray") == null){
//	session.setAttribute("mealNameArray", new ArrayList<String>()); }

ArrayList<Food.Update> f = (ArrayList<Food.Update>)session.getAttribute("mealArray");
//ArrayList<String> fNames = (ArrayList<String>)session.getAttribute("mealNameArray");

String mealDisp = "";

if (request.getParameter("addToMeal") != null) {
    int fid = Integer.parseInt(request.getParameter("fid"));
    double count=Double.parseDouble(request.getParameter("count"));
	Food.Update food = new Food.Update(fid, count);
    boolean r = inv.removeFood(food);
    if (r == false) {
        response.sendRedirect("error.jsp?code=1&echo=Could not update" +
            " inventory");
        db.close();
        return;
    }
	/* check if food already exists in meal. if so, update count */
	boolean exists = false;
	for(int i=0; i<f.size(); i++){
		if(f.get(i).getFid() == food.getFid()){
			f.set(i, new Food.Update(fid, f.get(i).getCount() + count));
			i=f.size(); //breaks from the loop
		}
	}
	if( !exists ){
		f.add(food);
	}
	session.setAttribute("mealArray", f);
}

if (request.getParameter("removeFromMeal") != null) {
    int fid = Integer.parseInt(request.getParameter("fid"));
    double count=Double.parseDouble(request.getParameter("count"));
	Food.Update[] arr = inv.getInventory();
	Food.Update food = new Food.Update(fid, count);
	if (arr == null) {
		response.sendRedirect("error.jsp?code=4&echo=Could not fetch inventory");
		db.close();
		return;
	}
	for( Food.Update up : arr ){
		if(up.getFid() == fid){
			food = up;
			break;
		}
	}
	
	boolean r = inv.updateFood(new Food.Update(fid, food.getCount() + count));
    if (r == false) {
        response.sendRedirect("error.jsp?code=1&echo=Could not update" +
            " inventory");
        db.close();
        return;
    }
	Food.Update removed = null;
	for(int i=0; i<f.size(); i++){
		if(f.get(i).getFid() == food.getFid()){
			f.set(i, new Food.Update(fid, f.get(i).getCount() - count));
			if(f.get(i).getCount() == 0){
				removed = f.remove(i);
			}
			else{
				removed = food; //to prevent error checking when not removed from array
			}
			i=f.size(); //breaks from the loop
		}
	}
	if(removed == null){
		response.sendRedirect("error.jsp?code=2&echo=Could not update" +
			" meal");
		db.close();
		return;
	}
	session.setAttribute("mealArray", f);
}

if (request.getParameter("addToHistory") != null) {
	History hist = new History(u);
	f = (ArrayList<Food.Update>)session.getAttribute("mealArray"); // get most current array
	int mealType = 0;
	String[] mealTypes = request.getParameterValues("mealType");
	for( int i=0; i<mealTypes.length; i++ ){
		mealType += Integer.parseInt(mealTypes[i]);
	}
	int mid = Meal.createMeal(db, u, f.toArray(new Food.Update[0]), 
		request.getParameter("name") , mealType );
	
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
	
	Meal newMeal = new Meal(db, mid);
	hist.addMeal(newMeal, today);
	session.setAttribute("mealArray", new ArrayList<Food.Update>());
	

	if( (request.getParameterValues("favs") != null) && 
	    (request.getParameterValues("favs").length > 0) ){
		Favorites fav = new Favorites (u);
		boolean r = fav.addMeal(newMeal);
		if (r == false) {
			response.sendRedirect("error.jsp?code=1&echo=Could not add" +
				" meal to favorites");
			db.close();
			return;
		}
	}
	mealDisp = "<center>Meal added successfully!</center>";
}

Food.List[] arr = inv.getInventoryList();
if (arr == null) {
    response.sendRedirect("error.jsp?code=4&echo=Could not fetch inventory");
    db.close();
    return;
}

/* Produce table of foods already in meal, with remove from meal forms */
f = (ArrayList<Food.Update>)session.getAttribute("mealArray"); // get most current array
mealDisp += "<table style='margin:auto auto;'>\n";
for (Food.Update up : f) {
	String s = "<tr><form action='addMeal.jsp' method='post'>" +
        "<input type='hidden' name='fid' value=" + up.getFid() + ">" +
        "<td>" + up.getName(db) + "</td><td>Amount: <input name='count' " +
        "value=" + up.getCount() + "><input type='hidden' name='" +
        "removeFromMeal' value=1><input type='image' src=\"images/X.png\" margin-top:2px width=20px height=20px value='Remove'>" +
        "</td></form></tr>\n";
	mealDisp += s;
}
mealDisp += "</table>\n";

/* Produce table of foods, with add to meal forms */
String invDisp = "<table style='margin:auto auto;'>\n";
for (Food.List fl : arr) {
    String s = "<tr><form action='addMeal.jsp' method='post'>" +
        "<input type='hidden' name='fid' value=" + fl.getFid() + ">" +
        "<td>" + fl.getName() + "</td><td>Amount: <input name='count' " +
        "value=" + fl.getCount() + "><input type='hidden' name='" +
        "addToMeal' value=1><input type='image' src=\"images/plus.png\" width=20px height=20px value='submit'>" +
        "</td></form></tr>\n";
    invDisp += s;
}
invDisp += "</table>\n";

db.close();

%>
<html xml:lang="en" xmlns="http://www.w3.org/1999/xhtml" lang="en">
  <head>
    <link type="text/css" rel="stylesheet" href="popup.css" />
	  <script type='text/javascript' src='http://code.jquery.com/jquery-1.4.4.min.js'></script>
	  <script type='text/javascript' src='javascript/validation.js'></script>
	  <script type='text/javascript' src='javascript/jquery.validate.min.js'></script>
    <link rel="stylesheet" type="text/css" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.4/themes/ui-lightness/jquery-ui.css"/>
    <link type="text/css" rel="stylesheet" href="forms.css" /> 
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
	<p class="addMeal">Input Your Own</p><br />
	<center><h2 class="new">Meal</h2></center><br /><%= mealDisp %>
	<br /><center><h2>Inventory</h2></center><br /><%= invDisp %>
	<p>Once you've finished adding food, enter a name and date to add it to your calendar!</p>
	<br />
	<form id='add_meal_form' action="addMeal.jsp" method="post">
    <div id="left">
      Name: <input name="name">
    </div>

    <div id="right">
      Date: 
      <select id="daydropdown" name="daydropdown"></select> 
      <select id="monthdropdown" name="monthdropdown"></select> 
      <select id="yeardropdown" name="yeardropdown"></select>

      Time: <select id="timedropdown" name="timedropdown"></select>
		</div>

		<br /><br />

		What type of meal is this? 
		<input type="checkbox" name="mealType" value="1000" /> Breakfast&nbsp;
		<input type="checkbox" name="mealType" value="0100" /> Lunch&nbsp;
		<input type="checkbox" name="mealType" value="0010" /> Dinner&nbsp;
		<input type="checkbox" name="mealType" value="0001" /> Snack&nbsp;
    <label for="mealType" class="error" style="display:none;">Please choose one</label> 

  <div id="right">
		<input type="hidden" name="addToHistory" value="addToHistory" />
    <img id='myImage' src = "images/starDull.png" style="float:right;"/>

    <input type="checkbox" name="favs" value="1" id='myHiddenCheckbox' style="display:none" /><p style="text-align:right;">Add to Favorites</p>
    <input type="image" src="images/submit.png" value="Submit">
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
