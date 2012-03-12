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
if( session.getAttribute("mealName") == null){
	session.setAttribute("mealName", ""); }
if( session.getAttribute("mealDay") == null){
	session.setAttribute("mealDay", "today.getDate()");}
if( session.getAttribute("mealMonth") == null){
	session.setAttribute("mealMonth", "today.getMonth()"); }
if( session.getAttribute("mealYear") == null){
	session.setAttribute("mealYear", "today.getFullYear()");}
if( session.getAttribute("mealTime") == null){
	session.setAttribute("mealTime", "today.getHours()");}
ArrayList<Food.Update> f = (ArrayList<Food.Update>)session.getAttribute("mealArray");
//ArrayList<String> fNames = (ArrayList<String>)session.getAttribute("mealNameArray");

if (request.getParameter("addToMeal") != null) {
    int fid = Integer.parseInt(request.getParameter("fid"));
    double count=Double.parseDouble(request.getParameter("count"));
	Food.Update food = new Food.Update(fid, count);
    boolean r = inv.removeFood(food);
    if (r == false) {
        response.sendRedirect("error.jsp?code=2&echo=Could not update" +
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
	/* save the name, date, and time for the meal */
	session.setAttribute("mealName", request.getParameter("name"));
	session.setAttribute("mealDay", request.getParameter("daydropdown"));
	session.setAttribute("mealMonth", request.getParameter("monthdropdown"));
	session.setAttribute("mealYear", request.getParameter("yeardropdown"));
	session.setAttribute("mealTime", request.getParameter("timedropdown"));
}

if (request.getParameter("removeFromMeal") != null) {
    int fid = Integer.parseInt(request.getParameter("fid"));
    double count=Double.parseDouble(request.getParameter("count"));
	Food.Update food = new Food.Update(fid, count);
	Food.Update removed;
	for(int i=0; i<f.size(); i++){
		if(f.get(i).getFid() == food.getFid()){
			f.set(i, new Food.Update(fid, f.get(i).getCount() + count));
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
	/* save the name, date, and time for the meal */
	session.setAttribute("mealName", request.getParameter("name"));
	session.setAttribute("mealDay", request.getParameter("daydropdown"));
	session.setAttribute("mealMonth", request.getParameter("monthdropdown"));
	session.setAttribute("mealYear", request.getParameter("yeardropdown"));
	session.setAttribute("mealTime", request.getParameter("timedropdown"));
}

if (request.getParameter("addToHistory") != null) {
	//int mid = Integer.parseInt(request.getParameter("mid"));
	History hist = new History(u);
	f = (ArrayList<Food.Update>)session.getAttribute("mealArray"); // get most current array
	int mid2 = Meal.createMeal(db, u, f.toArray(new Food.Update[0]), request.getParameter("name"));
	
	// create Timestamp
	Calendar c = Calendar.getInstance();
	c.set(Calendar.YEAR, Integer.parseInt(request.getParameter("yeardropdown")));
	String month = request.getParameter("monthdropdown");
	if( month.equals("Jan")){
		c.set(Calendar.MONTH, Calendar.JANUARY);
	}else if( month.equals("Feb")){
		c.set(Calendar.MONTH, Calendar.FEBRUARY);
	}else if( month.equals("Mar")){
		c.set(Calendar.MONTH, Calendar.MARCH);
	}else if( month.equals("Apr")){
		c.set(Calendar.MONTH, Calendar.APRIL);
	}else if( month.equals("May")){
		c.set(Calendar.MONTH, Calendar.MAY);
	}else if( month.equals("Jun")){
		c.set(Calendar.MONTH, Calendar.JUNE);
	}else if( month.equals("Jul")){
		c.set(Calendar.MONTH, Calendar.JULY);
	}else if( month.equals("Aug")){
		c.set(Calendar.MONTH, Calendar.AUGUST);
	}else if( month.equals("Sept")){
		c.set(Calendar.MONTH, Calendar.SEPTEMBER);
	}else if( month.equals("Oct")){
		c.set(Calendar.MONTH, Calendar.OCTOBER);
	}else if( month.equals("Nov")){
		c.set(Calendar.MONTH, Calendar.NOVEMBER);
	}else if( month.equals("Dec")){
		c.set(Calendar.MONTH, Calendar.DECEMBER);
	}else{
		response.sendRedirect("error.jsp?code=2&echo=Could not parse date");
		db.close();
		return;
	}
	c.set(Calendar.DAY_OF_MONTH, Integer.parseInt(request.getParameter("daydropdown")));
	c.set(Calendar.HOUR_OF_DAY, Integer.parseInt(request.getParameter("timedropdown")));
	Timestamp today = new Timestamp(c.getTimeInMillis());
	
	hist.addMeal(new Meal(db, mid2), today);
	session.setAttribute("mealArray", new ArrayList<Food.Update>());
	session.setAttribute("mealName", "");
	session.setAttribute("mealDay", "today.getDate()");
	session.setAttribute("mealMonth", "today.getMonth()");
	session.setAttribute("mealYear", "today.getFullYear()");
	session.setAttribute("mealTime", "today.getHours()");
}

Food.List[] arr = inv.getInventoryList();
if (arr == null) {
    response.sendRedirect("error.jsp?code=1&echo=Could not fetch inventory");
    db.close();
    return;
}
String mealName = (String)session.getAttribute("mealName");
String mealDay = (String)session.getAttribute("mealDay");
String mealMonthStr = (String)session.getAttribute("mealMonth");
String mealMonthNum;
if( mealMonthStr.equals("Jan")){
		mealMonthNum = "0";
	}else if( mealMonthStr.equals("Feb")){
		mealMonthNum = "1";
	}else if( mealMonthStr.equals("Mar")){
		mealMonthNum = "2";
	}else if( mealMonthStr.equals("Apr")){
		mealMonthNum = "3";
	}else if( mealMonthStr.equals("May")){
		mealMonthNum = "4";
	}else if( mealMonthStr.equals("Jun")){
		mealMonthNum = "5";
	}else if( mealMonthStr.equals("Jul")){
		mealMonthNum = "6";
	}else if( mealMonthStr.equals("Aug")){
		mealMonthNum = "7";
	}else if( mealMonthStr.equals("Sept")){
		mealMonthNum = "8";
	}else if( mealMonthStr.equals("Oct")){
		mealMonthNum = "9";
	}else if( mealMonthStr.equals("Nov")){
		mealMonthNum = "10";
	}else if( mealMonthStr.equals("Dec")){
		mealMonthNum = "11";
	}else{
		response.sendRedirect("error.jsp?code=2&echo=Could not parse date");
		db.close();
		return;
	}
String mealYear = (String)session.getAttribute("mealYear");
String mealTime = (String)session.getAttribute("mealTime");

/* Produce table of foods already in meal, with remove from meal forms */
f = (ArrayList<Food.Update>)session.getAttribute("mealArray"); // get most current array
String mealDisp = "<table style='margin:auto auto;'>\n";
for (Food.Update up : f) {
	String s = "<tr><form action='addMeal.jsp' method='post'>" +
        "<input type='hidden' name='fid' value=" + up.getFid() + ">" +
        "<td>" + up.getName(db) + "</td><td>Amount: <input name='count' " +
        "value=" + up.getCount() + "><input type='hidden' name='" +
        "removeFromMeal' value=1><input type='submit' value='Remove'>" +
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
        "addToMeal' value=1><input type='submit' value='Add To Meal'>" +
        "</td></form></tr>\n";
    invDisp += s;
}
invDisp += "</table>\n";

db.close();

%>
<html>
  <head>
    <link type="text/css" rel="stylesheet" href="addMeal.css" />
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
dayfield.options[i]=new Option(i, i+1)
dayfield.options[<%= mealDay %>]=new Option(<%= mealDay %>, <%= mealDay %>, true, true) //select today's day
for (var m=0; m<12; m++)
monthfield.options[m]=new Option(monthtext[m], monthtext[m])
monthfield.options[<%= mealMonthNum %>]=new Option(monthtext[<%= mealMonthNum %>], monthtext[<%= mealMonthNum %>], true, true) //select today's month
var thisyear=today.getFullYear()
for (var y=0; y<20; y++){
yearfield.options[y]=new Option(thisyear, thisyear)
thisyear+=1
}
yearfield.options[<%= mealYear %> - today.getFullYear()]=new Option(<%= mealYear %>, <%= mealYear %>, true, true) //select today's year
for (var d=0; d<24; d++)
timefield.options[d]=new Option(d, d+1)
timefield.options[<%= mealTime %>]=new Option(<%= mealTime %>, <%= mealTime %>, true, true) //select current time
}

</script>
  </head>
  <body>
  <div id="page">
    <div id="content">
      <center><h1>Add a Meal</h1></center><br />
	<form action="addMeal.jsp" method="post">
        <div id="left">Name: <input name="name"></div>
		<input type="hidden" name="mid">
        <div id="right">Date: <select id="daydropdown" name="daydropdown"></select> 
			<select id="monthdropdown" name="monthdropdown"></select> 
			<select id="yeardropdown" name="yeardropdown"></select>
		<br />Time: <select id="timedropdown" name="timedropdown"></select>
		</div>
		<br /><br /><br /><input type="hidden" name="addToHistory" value="addToHistory">
        <div id="right"><input type="submit"></div>
    </form>
	<br /><%= mealDisp %>
	<br /><%= invDisp %>
	<br /><a href="mealChoice.jsp"> Select another method of adding a meal </a>
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
