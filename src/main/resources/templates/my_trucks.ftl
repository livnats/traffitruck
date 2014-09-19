<html dir="rtl">
<head>
    <title>TraffiTruck</title>
	<meta charset="UTF-8">
	<link rel="stylesheet" type="text/css" href="/css/traffitruck.css">
		<script type="text/javascript" src="js/jquery-1.11.1.min.js"></script>
		<script type="text/javascript" src="js/jquery.validate.min.js"></script>
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
						<a href="/newTruck">הוספת משאית חדשה</a>
					</td>
				</tr>
				<tr> 
					<td>
						<#if trucks?has_content>
					
								<table border="1">
									<tr>
										<th>מספר לוחית זיהוי</th>
									</tr>
									<#list trucks as truck>
									<tr id="${truck.id}">
										<td>${truck.licensePlateNumber}</td>
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