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
	session.setAttribute("mealArray", new ArrayList<Food.Update>());
}
ArrayList<Food.Update> f = (ArrayList<Food.Update>)session.getAttribute("mealArray");

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
	f.add(food);
	session.setAttribute("mealArray", f);
}

if (request.getParameter("addToHistory") != null) {
	String mealName = request.getParameter("name");
	//int mid = Integer.parseInt(request.getParameter("mid"));
	History hist = new History(u);
	f = (ArrayList<Food.Update>)session.getAttribute("mealArray"); // get most current array
	int mid2 = Meal.createMeal(db, u, f.toArray(new Food.Update[0]), mealName);
	
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
dayfield.options[today.getDate()]=new Option(today.getDate(), today.getDate(), true, true) //select today's day
for (var m=0; m<12; m++)
monthfield.options[m]=new Option(monthtext[m], monthtext[m])
monthfield.options[today.getMonth()]=new Option(monthtext[today.getMonth()], monthtext[today.getMonth()], true, true) //select today's month
var thisyear=today.getFullYear()
for (var y=0; y<20; y++){
yearfield.options[y]=new Option(thisyear, thisyear)
thisyear+=1
}
yearfield.options[0]=new Option(today.getFullYear(), today.getFullYear(), true, true) //select today's year
for (var d=0; d<24; d++)
timefield.options[d]=new Option(d, d+1)
timefield.options[today.getHours()]=new Option(today.getHours(), today.getHours(), true, true) //select current time
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
