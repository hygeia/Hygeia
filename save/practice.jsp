<%
if(request.getParameter("addToHistory")!= null)
{
 out.print("Sweet!");
}

%>
<HTML>
<BODY>
<h1>Add to history</h1>

<form method="post">
<input type="hidden" name="mid">
<input name="occurrence">
<input type="hidden" name="addToHistory" value="addToHistory">
<input type="submit" value="Add">
</form>
</br>
<H1> Meal History </H1>


</BODY>
</HTML>
