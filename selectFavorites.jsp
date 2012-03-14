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
Favorites favs = new Favorites(u);

String favDisp = "";
String sectionTitle = "";
int selectedMid = 1;

/* Actually add meal to history */
if (request.getParameter("addToHistory2") != null) {

    int mid = Integer.parseInt(request.getParameter("mid"));
    
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

    History hist = new History(u);	
    Inventory inv = new Inventory(u);
    Meal m = new Meal(db, mid);
    Food.Update foods[] = m.getMeal();
    for (Food.Update f : foods) {
        inv.removeFood(f);
    }
	hist.addMeal(m, today);
	request.sendRedirect("home.jsp");
	return;
}

/* show meal name and request time */
if (request.getParameter("addToHistory") == null) {
    sectionTitle = "Favorites";
    Meal.List meals[] = favs.getFavorites();
    if (meals == null) {
        db.close();
        response.sendRedirect("error.jsp");
        return;
    }
    /* Produce table of meals */
    favDisp = "<table style='margin:auto auto;'>\n";
    String noFavs="";
    for (Meal.List m : meals) {
        if (m == null) {
            noFavs = "You currently have no meals saved in your favorites";
	    db.close();
            break;
        }
        String s = "<form action='selectFavorites.jsp' method='post'><tr><td>" + 
        m.getName() + "<input type='hidden' name='mid' value=" + m.getMid() +
        "><input type='hidden' name='addToHistory' value=1></td><td>" +
        "<input type='submit' value='Eat Me!'></td></tr></form>\n";
        favDisp += s;
    }
    favDisp += "</table>\n";
    if (!noFavs.equals("")) {
        favDisp = noFavs;
    }
} else {
    selectedMid = Integer.parseInt(request.getParameter("mid"));
    sectionTitle = new Meal(db, selectedMid).getName();
}

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
dayfield.options[i]=new Option(i, i+1)
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
timefield.options[d]=new Option(d + ":00", d+1)
timefield.options[today.getHours()]=new Option(today.getHours() + ":00" , today.getHours(), true, true) //select current time
}

</script>
  </head>
  <body>
  <div id="page">
    <div id="content">
    <a href="mealChoice.jsp"><img src="images/back.png" style="float:left" width=50px height=50px/></a>
	<p class="selectFav">Select From Your Favorite Meals</p><br />
	<br /><center><h2><%= sectionTitle %></h2></center><br />
	<%= favDisp %>
	<br>
        <% if (request.getParameter("addToHistory") != null) { %>
	<form action="selectFavorites.jsp" method="post">
		<input type="hidden" name="mid" value=<%= selectedMid %>>
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
         <% } %>
	
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
