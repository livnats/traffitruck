<html dir="rtl">
	<head>
	    <title>TraffiTruck</title>
		<meta charset="UTF-8">
		<link rel="stylesheet" type="text/css" href="/css/traffitruck.css">
		<script type="text/javascript" src="js/jquery-1.11.1.min.js"></script>

<script type="text/javascript">
$(document).ready(function() {

		var selectedRow = null;
      $(".clickableRow").click(function() {
			if ( selectedRow != null ) {
				selectedRow.css('background-color', 'initial');
			}
			$(this).css('background-color', 'lightblue');
			selectedRow = $(this);
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
				<h2>מטענים לשילוח:</h2>
				<table border="0">
					<tr> 
						<td>
							<#if loads?has_content>
						
									<table border="1">
										<tr>
											<th>שם</th>
											<th>מוצא</th>
											<th>יעד</th>
											<th>מחיר</th>
											<th>תאריך</th>
										</tr>
										<#list loads as load>
										<tr class="clickableRow">
											<td><a href="#">${load.username!'---'}</td>
											<td>${load.source}</td>
											<td>${load.destination}</td>
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