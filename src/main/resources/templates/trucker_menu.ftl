<html dir="rtl">
<head>
<meta charset="utf-8">
<title>טראפי-טראק - תפריט</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="js/default/jquery.mobile.theme-1.4.5.css" rel="stylesheet">
<link href="js/default/jquery.mobile.icons-1.4.5.min.css" rel="stylesheet">
<link href="css/jquery.mobile.structure-1.4.5.min.css" rel="stylesheet">
<link href="css/mobile.css" rel="stylesheet">
<link href="css/trucker_menu.css" rel="stylesheet">
<script src="js/jquery-1.11.3.min.js"></script>
<script>
$(document).on("mobileinit", function()
{
   $.mobile.ajaxEnabled = false;
});
</script>
<script src="js/jquery.mobile-1.4.5.min.js"></script>
<script>
localStorage['filter'] = "false";
</script>
</head>
<body>
<div data-role="page" data-theme="a" data-title="תפריט" id="trucker_menu">
<div data-role="header" id="Header1">
<h1>תפריט</h1>
<a href="/logout" data-role="button" class="ui-btn-right">יציאה</a>
</div>
<div class="ui-content" role="main">
<a href="/myTrucks" class="linkbutton"><input type="button" id="Button1" name="" value="המשאיות שלי"></a>
<#if (trucks?? && trucks?size > 0)>
	<a href="/findTrucksForLoad" class="linkbutton"><input type="button" id="Button2" name="" value="חפש מטענים להובלה"></a>
	<a href="/myAlerts" class="linkbutton"><input type="button" id="Button1" name="" value="ההתראות שלי"></a>
</#if>
<#if (isLoadsOwner??)>
	<a href="/myLoads" class="linkbutton"><input type="button" id="Button3" name="" value="המטענים שלי"></a>
</#if>
</div>
</div>
</body>
</html>