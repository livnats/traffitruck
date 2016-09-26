<html dir="rtl">
<head>
    <title>TraffiTruck</title>
	<meta charset="UTF-8">
	<link rel="stylesheet" type="text/css" href="/css/traffitruck.css">
	<script type="text/javascript" src="js/jquery-1.11.1.min.js"></script>

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
			<h2>כל ההתראות</h2>
			<table>
				<tr> 
					<td>
						<a href="/adminMenu">חזור לעמוד הראשי</a>
					</td>
				</tr>
				<tr> 
					<td>
						<#if alerts?has_content>
					
								<table border="1">
									<tr>
										<th>שם משתמש</th>
										<th>מקור</th>
										<th>יעד</th>
										<th>תאריך</th>
									</tr>
									<#list alerts as alert>
									<tr id="${alert.id!''}">
										<td>${alert.username!''}</td>
										<td>${alert.source!''}</td>
										<td>${alert.destination!''}</td>
										<#if alert.driveDate??>
											<td>${alert.driveDateStr!''}</td>
										<#else>
											<td></td>
										</#if>
									</tr>
									</#list>
								</table>
					
						<#else>
							אין התראות 
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