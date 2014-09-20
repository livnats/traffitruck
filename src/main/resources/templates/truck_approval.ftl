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
			<h2>עדכן פרטי משאית</h2>
			<form id="approveTruck" method="post" action="approveTruck">
			    <table>
			    	<tr> 
						<td>
							<a href="/">חזור לעמוד הראשי</a>
						</td>
					</tr>
			 	<tr>
			        <td><label for="licensePlateNumber">מספר לוחית זיהוי: </label></td>
			        <td><label for="licensePlateNumber">${truck.licensePlateNumber}</label></td>
			    </tr>
			    </table>
			<!-- inlcude csrf token -->
		    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
			</form>
		</div>
	</div>
</div>
</body>
</html>