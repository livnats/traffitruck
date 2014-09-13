<html dir="rtl">
	<head>
	    <title>TraffiTruck</title>
		<meta charset="UTF-8">
		<link rel="stylesheet" type="text/css" href="/css/traffitruck.css">
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
				<h2>מטענים לשילוח:</h2>
				<table border="0">
					<tr> 
						<td>
							<#if loads?has_content>
						
									<table border="1">
										<tr>
											<th>מוצא</th>
											<th>יעד</th>
											<th>משקל</th>
											<th>מחיר</th>
											<th>תאריך</th>
										</tr>
										<#list loads as load>
										<tr>
											<td>${load.source}</td>
											<td>${load.destination}</td>
											<td>${load.weight!'לא נמסר'}</td>
											<td>${load.suggestedQuote!'לא נמסר'}</td>
											<td>${load.creationDate?string("HH:mm dd-MM-yyyy")!''}</td>
										</tr>
										</#list>
									</table>
						
							<#else>
								אין מטענים להציג :(
							</#if>
						</td>
					</tr>
					<tr>
					<td>&nbsp;</td>
					</tr>
					<tr> 
						<td>
							<a href="/newload">הוספת מטען חדש</a>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	</body>
</html>