<html dir="rtl">
<head>
    <title>TraffiTruck</title>
	<meta charset="UTF-8">
	<link rel="stylesheet" type="text/css" href="/css/traffitruck.css">
		<script type="text/javascript" src="js/jquery-1.11.1.min.js"></script>
		
<script type="text/javascript">
	
$(document).ready(function() {

	function convertLoadType(typesStr) {
		types = typesStr.split(" ");
		res = "";
		for (var i = 0; i < types.length; i++) {
			type = types[i];
	   		if ( type == "${enums["com.traffitruck.domain.LoadType"].CONTAINER_20}" )
				res += "מכולה 20', ";
			if ( type == "${enums["com.traffitruck.domain.LoadType"].CONTAINER_40}" )
				res += "מכולה 40', ";
			if ( type == "${enums["com.traffitruck.domain.LoadType"].LIFTS}" )
				res += "משטחים, ";
			if ( type == "${enums["com.traffitruck.domain.LoadType"].BAGS}" )
				res += "שקים (באלות), ";
			if ( type == "${enums["com.traffitruck.domain.LoadType"].ANIMALS}" )
				res += "בעלי חיים, ";
			if ( type == "${enums["com.traffitruck.domain.LoadType"].SCATTERED}" )
				res += "תפזורת, ";
			if ( type == "${enums["com.traffitruck.domain.LoadType"].HAZMAT}" )
				res += 'חומ"ס, ';
			if ( type == "${enums["com.traffitruck.domain.LoadType"].OTHER}" )
				res += "אחר, ";
		}
		return res.slice(0, -2);
	}

	function convertLiftType(typesStr) {
		types = typesStr.split(" ");
		res = "";
		for (var i = 0; i < types.length; i++) {
			type = types[i];
			if ( type == "${enums["com.traffitruck.domain.LiftType"].MANUAL}" )
				res += "ידני, ";
			if ( type == "${enums["com.traffitruck.domain.LiftType"].FORKLIFT}" )
				res += "מלגזה, ";
			if ( type == "${enums["com.traffitruck.domain.LiftType"].CRANE}" )
				res += "מנוף, ";
			if ( type == "${enums["com.traffitruck.domain.LiftType"].RAMP}" )
				res += "רמפה, ";
			if ( type == "${enums["com.traffitruck.domain.LiftType"].TROLLY}" )
				res += "עגלה, ";
		}
		return res.slice(0, -2);
	}

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

	$( ".loadConversion" ).each(function() {
	  $(this).html(convertLoadType($(this).html()));
	});

	$( ".liftConversion" ).each(function() {
	  $(this).html(convertLiftType($(this).html()));
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
			<h2>כל המשאיות</h2>
			<table>
				<tr> 
					<td>
						<a href="/adminMenu">חזור לעמוד הראשי</a>
					</td>
				</tr>
				<tr> 
					<td>
						<#if trucks?has_content>
					
								<table border="1">
									<tr>
										<th>מספר לוחית זיהוי</th>
										<th>משתמש</th>
										<th>סטטוס</th>
										<th>משקל מירבי</th>
										<th>נפח מירבי</th>
										<th>סוגי מטען</th>
										<th>סוגי טעינה</th>
									</tr>
									<#list trucks as truck>
									<tr id="${truck.id}">
										<td>${truck.licensePlateNumber}</td>
										<td>${truck.username}</td>
										<td class="typeConversion">${truck.registrationStatus!'שגיאה'}</td>
										<td>${truck.maxWeight!''}</td>
										<td>${truck.maxVolume!''}</td>
										<#if truck.acceptableLoadTypes??>
											<td class="loadConversion">${truck.acceptableLoadTypes?join(" ")!''}</td>
										<#else>
											<td></td>
										</#if>
										<#if truck.acceptableLiftTypes??>
											<td class="liftConversion">${truck.acceptableLiftTypes?join(" ")!''}</td>
										<#else>
											<td></td>
										</#if>
									</tr>
									</#list>
								</table>
					
						<#else>
							אין משאיות 
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