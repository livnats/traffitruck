<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>טראפי-טראק - משאיות</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="js/default/jquery.mobile.theme-1.4.5.css" rel="stylesheet">
<link href="js/default/jquery.mobile.icons-1.4.5.min.css" rel="stylesheet">
<link href="css/jquery.mobile.structure-1.4.5.min.css" rel="stylesheet">
<link href="css/mobile.css" rel="stylesheet">
<link href="css/trucks.css" rel="stylesheet">
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
		if ( type == "${enums["com.traffitruck.domain.TruckRegistrationStatus"].REGISTERED}" )
			return "ממתין לאישור";
		if ( type == "${enums["com.traffitruck.domain.TruckRegistrationStatus"].APPROVED}" )
			return "מאושר";
		return type;
	}
	
	$( ".typeConversion" ).each(function() {
	  $(this).html(convertType($(this).html()));
	});

});
</script>

<script src="js/jquery.mobile-1.4.5.min.js"></script>


</head>
<body>
<div data-role="page" data-theme="a" data-title="המטענים שלי" id="trucks">
<div data-role="header" id="Header1">
<h1>המשאיות שלי</h1>
<a href="/truckerMenu" data-role="button" class="ui-btn-left">חזרה</a>
<a href="/logout" data-role="button" class="ui-btn-right">יציאה</a>
</div>
<div class="ui-content" role="main">
<a href="/newTruck" data-role="button" class="ui-btn">הוספת משאית חדש</a>

							<#if trucks?has_content>
						
								<table border="1">
									<tr>
										<th>מספר לוחית זיהוי</th>
										<th>סטטוס</th>
									</tr>
									<#list trucks as truck>
									<tr id="${truck.id}">
										<td>${truck.licensePlateNumber}</td>
										<td class="typeConversion">${truck.registrationStatus!'שגיאה'}</td>
									</tr>
									</#list>
								</table>
						
							<#else>
								אין משאיות רשומות
							</#if>

</div>
</div>
</body>
</html>