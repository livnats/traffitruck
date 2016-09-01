<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>טראפי-טראק - התראות</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="js/default/jquery.mobile.theme-1.4.5.css" rel="stylesheet">
<link href="js/default/jquery.mobile.icons-1.4.5.min.css" rel="stylesheet">
<link href="css/jquery.mobile.structure-1.4.5.min.css" rel="stylesheet">
<link href="css/mobile.css" rel="stylesheet">
<link href="css/alerts.css" rel="stylesheet">
<script src="js/jquery-1.11.3.min.js"></script>
<script>
$(document).on("mobileinit", function()
{
   $.mobile.ajaxEnabled = false;
});
</script>
<script src="js/jquery.mobile-1.4.5.min.js"></script>

</head>
<body>
<div data-role="page" data-theme="a" data-title="ההתראות שלי" id="alerts">
<div data-role="header" id="Header1">
<h1>ההתראות שלי</h1>
<a href="/menu" data-role="button" class="ui-btn-left">חזרה</a>
<a href="/logout" data-role="button" class="ui-btn-right">יציאה</a>
</div>
<div class="ui-content" role="main">
<a href="/newAlert" data-role="button">צור התראה חדש</a>

							<#if alerts?has_content>
						
								<table data-role="table" class="table-stripe my-custom-breakpoint" style="direction:RTL">
								<thead>
									<tr>
										<th style="text-align:right">מוצא</th>
										<th style="text-align:right">יעד</th>
										<th style="text-align:right">תאריך</th>
										<th style="text-align:right">מחק</th>
									</tr>
								</thead>
								<tbody>
									<#list alerts as alert>
									<tr id="${alert.id}">
										<td style="text-align:right">${alert.source}</td>
										<td style="text-align:right">${alert.destination}</td>
										<#if (alert.driveDate??)>
											<td style="text-align:right" class="typeConversion">${alert.driveDateStr}</td>
										<#else>
											<td style="text-align:right"></td>
										</#if>
										<td style="text-align:right">
											<a href="#" onclick="return deleteAlert()" data-role="none"><img src="/images/remove-icon-png-26.png"  width="20px" ></a>
										</td>
									</tr>
									</#list>
								</tbody>
								</table>
						
							<#else>
								אין התראות
							</#if>

</div>
</div>
</body>
</html>