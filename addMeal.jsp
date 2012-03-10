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

function populatedropdown(dayfield, monthfield, yearfield){
var today=new Date()
var dayfield=document.getElementById(dayfield)
var monthfield=document.getElementById(monthfield)
var yearfield=document.getElementById(yearfield)
for (var i=0; i<31; i++)
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
}

</script>
  </head>
  <body>
  <div id="page">
    <div id="content">
      <center><h1>Add a Meal</h1></center><br />
	<form action="history.jsp" method="post">
        <div id="left">Name: <input name="name"></div>
		<input type="hidden" name="mid">
        <div id="right">Date: <select id="daydropdown">
</select> 
<select id="monthdropdown">
</select> 
<select id="yeardropdown">
</select></div> <br /><br /><br />
        <input type="hidden" name="addToHistory" value="addToHistory">
        <div id="right"><input type="submit"></div>
    </form>
	<script type="text/javascript">

//populatedropdown(id_of_day_select, id_of_month_select, id_of_year_select)
window.onload=function(){
populatedropdown("daydropdown", "monthdropdown", "yeardropdown")
}
</script>
    </div>
  </div>
  </body>
</html>
