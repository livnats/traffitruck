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
					<h2>משאיות לאישור</h2>
					<table border="0">
						<tr> 
							<td>
								<a href="/">חזור לעמוד ראשי </a>
							</td>
						</tr>
						<tr> 
							<td>
								<#if trucks?has_content>
									<table border="1">
										<tr>
											<th>אשר רכב</th>
											<th>מספר רכב</th>
											<th>שם משתמש</th>
											<th>תאריך הרשמה</th>
											<th>סטטוס</th>
										</tr>
										<#list trucks as truck>
										<tr>
											<td><a href="/truckApproval?truckId=${truck.id}">אשר</a></td>
											<td>${truck.licensePlateNumber}</td>
											<td>${truck.username}</td>
											<td>${truck.creationDate?string("dd-MM-yyyy")!''}</td>
											<td class="typeConversion">${truck.registrationStatus}</td>
										</tr>
										</#list>
									</table>
							<#else>
								אין משאיות לאישור
							</#if>
						</td>
					</tr>
				</table>
				</div>
			</div>
		</div>
		</body>
	</html>
					