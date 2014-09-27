<html dir="rtl">
<head>
    <title>TraffiTruck</title>
	<meta charset="UTF-8">
	<link rel="stylesheet" type="text/css" href="/css/traffitruck.css">
	<script type="text/javascript" src="js/jquery-1.11.1.min.js"></script>
	<script type="text/javascript" src="js/jquery.validate.min.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
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
			<h2>עדכן פנוי</h2>
			<form id="addAvailabilityForm" method="post" action="addAvailability">
			    <table>
				    <tr> 
						<td>
							<a href="/">חזור לעמוד הראשי</a>
						</td>
					</tr>
					<#if trucks?has_content>
					    <tr>
					        <td><label for="truckId">בחר משאית:</label></td>
					        <td>
				        	<select name="truckId" id="truckId">
				        	<#list trucks as truck>
				        		<option value="${truck.id}">${truck.licensePlateNumber}</option>
				        	</#list>
					        </td>
					    </tr>
					    <tr>
					        <td><label for="source">מוצא:</label></td>
					        <td><input name="source" /></td>
					    </tr>
					    <tr>
					        <td><label for="destination">יעד:</label></td>
					        <td><input name="destination" /></td>
					    </tr>
					    <tr>
					        <td><label for="availTime">תזמון:</label></td>
					        <td>
					        <table>
						        <tr>
						        	<td><input type="radio" name="availTime" VALUE="now" checked>עכשיו</td>
						        </tr>
						        <tr>
						        	<td><input type="radio" name="availTime" VALUE="custom" selected>הכנס זמן</td>	
						        </tr>
					         </table>
					        </td>
					    </tr>
					    <tr>
			        		<td>
			           			 <input type="submit" value="עדכן פנוי"/>
			        		</td>
			    		</tr>
				    <#else>
							אין לך משאיות מאושרות במערכת :(
					</#if>	
			    </table>
			<!-- inlcude csrf token -->
		    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
			</form>
		</div>
	</div>
</div>
</body>
</html>			    