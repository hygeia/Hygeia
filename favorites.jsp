<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">

<head>
<link type="text/css" rel="stylesheet" href="style.css" />

<style type="text/css">
body{background-color: fbffcc}

#searchwrapper {
width:310px; /*follow your image's size*/
height:40px;/*follow your image's size*/
background-image:url(THE_SEARCH_BOX_IMAGE);
background-repeat:no-repeat; /*important*/
padding:0px;
margin:0px;
position:relative; /*important*/
}
 
#searchwrapper form { display:inline ; }
 
.searchbox {
border-style:outset;
border-width:2px;
border-color:b2b48c;
border-radius:7px;
background-color:fbffcc; /*important*/
position:absolute; /*important*/
top:4px;
left:9px;
width:256px;
height:28px;
font-size:18px;
font-family:verdana;
}
 
.searchbox_submit {
border:0px; /*important*/
background-color:transparent; /*important*/
position:absolute; /*important*/
top:4px;
left:265px;
width:32px;
height:28px;
}
</style>
</head>

<!-- Navigation Bar -->

<table cellpadding="0" cellspacing="0">
<tr>
<td> <a href="index.jsp"><img src="images/lightICON1.png"></a></td>
<td> <a href="inventory.jsp"><img src="images/lightICON2.png" style="margin-left: -10px;" href="index.jsp"></a></td>
<td> <a href="favorites.jsp"><img src="images/lightICON3.png" style="margin-left: -5px;"></a></td>
<td> <a href="history.jsp"><img src="images/lightICON4.png" style="margin-left: -10px;"></a></td>
<td> <a href="recipes.jsp"><img src="images/lightICON5.png" style="margin-left: -10px;"></a></td>
<td> <img src="images/lightICON6.png" style="margin-left: -10px;"></td>
</tr>
</table>

<br />

<body>
<div id="searchwrapper"><form action="">
<input type="text" class="searchbox" name="s" value="" />
<input type="image" src="images/searchBarICON.png" class="searchbox_submit" value="" />
</form>
</div>

<img src="images/breakfastFavoritesICON.png">
<br />

<br />
<img src="images/defaultFavoritesICON.png" style="margin-left: 10px; margin-right:10px;">
<img src="images/defaultFavoritesICON.png" style="margin-left: 10px; margin-right:10px;">
<img src="images/defaultFavoritesICON.png" style="margin-left: 10px; margin-right:10px;">
<img src="images/defaultFavoritesICON.png" style="margin-left: 10px; margin-right:10px;">
<br />
<br />
<img src="images/defaultFavoritesICON.png" style="margin-left: 10px; margin-right:10px;">
<img src="images/defaultFavoritesICON.png" style="margin-left: 10px; margin-right:10px;">
<img src="images/defaultFavoritesICON.png" style="margin-left: 10px; margin-right:10px;">
<img src="images/addItemICON.png" style="margin-left: 10px; margin-right:10px;">
<br />
<br />

<img src="images/lunchFavoritesICON.png">
<br />

<br />
<img src="images/defaultFavoritesICON.png" style="margin-left: 10px; margin-right:10px;">
<img src="images/defaultFavoritesICON.png" style="margin-left: 10px; margin-right:10px;">
<img src="images/defaultFavoritesICON.png" style="margin-left: 10px; margin-right:10px;">
<img src="images/addItemICON.png" style="margin-left: 10px; margin-right:10px;">

</body>
</html>
