<html dir="rtl">
<head>
    <title>TraffiTruck</title>
	<meta charset="UTF-8">
	<link rel="stylesheet" type="text/css" href="/css/traffitruck.css">
		<script type="text/javascript" src="js/jquery-1.11.1.min.js"></script>
		
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

</head>
<body>
<div id="main">
	<div id="title">
		<img src="/images/truck-blue.jpg" width="15%"/>
		<img src="/images/logo.jpg" width="20%"/>
	</div>
	<div id="body">
		<div id="sidebar">
			<p>&nbsp;</p>
		</div>
		<div id="content">
			<h2>המשאיות שלי</h2>
			<table>
				<tr> 
					<td>
						<a href="/">חזור לעמוד הראשי</a>
					</td>
				</tr>
				<tr> 
					<td>
						<a href="/newTruck">הוספת משאית חדשה</a>
					</td>

				</tr>
				<tr> 
					<td>
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
					</td>
				</tr>
				<tr>
				<td>&nbsp;</td>
				</tr>
			</table>
		</div>
	</div>
</div>
</body>
</html>