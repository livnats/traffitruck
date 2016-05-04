<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>טראפי-טראק - מטענים</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="js/default/jquery.mobile.theme-1.4.5.css" rel="stylesheet">
<link href="js/default/jquery.mobile.icons-1.4.5.min.css" rel="stylesheet">
<link href="css/jquery.mobile.structure-1.4.5.min.css" rel="stylesheet">
<link href="css/mobile.css" rel="stylesheet">
<link href="css/loads.css" rel="stylesheet">
<script src="js/jquery-1.11.3.min.js"></script>
<script>
$(document).on("mobileinit", function()
{
   $.mobile.ajaxEnabled = false;
});
</script>
<script type="text/javascript">
$(document).ready(function() {

	function convertType(type) {
		if ( type == "${enums["com.traffitruck.domain.LoadType"].CONTAINER_20}" )
			return "מכולה 20'";
		if ( type == "${enums["com.traffitruck.domain.LoadType"].CONTAINER_40}" )
			return "מכולה 40'";
		if ( type == "${enums["com.traffitruck.domain.LoadType"].LIFTS}" )
			return "משטחים";
		if ( type == "${enums["com.traffitruck.domain.LoadType"].BAGS}" )
			return "שקים (באלות)";
		if ( type == "${enums["com.traffitruck.domain.LoadType"].ANIMALS}" )
			return "בעלי חיים";
		if ( type == "${enums["com.traffitruck.domain.LoadType"].SCATTERED}" )
			return "תפזורת";
		if ( type == "${enums["com.traffitruck.domain.LoadType"].HAZMAT}" )
			return 'חומ"ס';
		if ( type == "${enums["com.traffitruck.domain.LoadType"].OTHER}" )
			return "אחר";
		return type;
	}

	function convertLiftType(type) {
		if ( type == "${enums["com.traffitruck.domain.LiftType"].MANUAL}" )
			return "ידני";
		if ( type == "${enums["com.traffitruck.domain.LiftType"].FORKLIFT}" )
			return "מלגזה";
		if ( type == "${enums["com.traffitruck.domain.LiftType"].CRANE}" )
			return "מנוף";
		if ( type == "${enums["com.traffitruck.domain.LiftType"].RAMP}" )
			return "רמפה";
		if ( type == "${enums["com.traffitruck.domain.LiftType"].TROLLY}" )
			return "עגלה";
		return type;
	}

	$( ".typeConversion" ).each(function() {
	  $(this).html(convertType($(this).html()));
	});
});
</script>

<script src="js/jquery.mobile-1.4.5.min.js"></script>
<script>
$(document).on("pagecreate", "#loads", function(event)
{
   var ListView1Options =
   {
      inset: false
   };
   $("#ListView1").listview(ListView1Options);
});
</script>
</head>
<body>
<div data-role="page" data-theme="a" data-title="המטענים שלי" id="loads">
<div data-role="header" id="Header1">
<h1>המטענים שלי</h1>
<a href="/login" data-role="button" class="ui-btn-left">חזרה</a>
<a href="/logout" data-role="button" class="ui-btn-right">יציאה</a>
</div>
<div class="ui-content" role="main">
<a href="/newload" data-role="button" class="ui-btn">הוספת מטען חדש</a>

							<#if loads?has_content>
						
									<table border="1">
										<tr>
											<th>שם</th>
											<th>מוצא</th>
											<th>יעד</th>
											<th>סוג מטען</th>
											<th>מחיר</th>
											<th>תאריך</th>
										</tr>
										<#list loads as load>
										<tr id="${load.id}" class="clickableRow">
											<td><a href="#">${load.name!'---'}</a></td>
											<td>${load.source}</td>
											<td>${load.destination}</td>
											<td class="typeConversion">${load.type!'לא נמסר'}</td>
											<td>${load.suggestedQuote!'לא נמסר'}</td>
											<td>${load.creationDate?string("HH:mm dd-MM-yyyy")!''}</td>
										</tr>
										</#list>
									</table>
						
							<#else>
								אין מטענים להציג :(
							</#if>

</div>
</div>
</body>
</html>