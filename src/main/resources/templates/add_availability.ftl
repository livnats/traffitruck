<html dir="rtl">
<head>
    <title>TraffiTruck</title>
	<meta charset="UTF-8">
	<link rel="stylesheet" type="text/css" href="/css/traffitruck.css">
	<script type="text/javascript" src="js/jquery-1.11.1.min.js"></script>
	<script src="//code.jquery.com/ui/1.11.1/jquery-ui.js"></script>
	<script type="text/javascript" src="js/jquery.validate.min.js"></script>
<script>
  $(function() {
    $( "#datepicker" ).datepicker();
  });

$(document).ready(function() {
	$(".date_picker_ui").hide();

    $('input[type=radio][name=availTime]').change(function() {
        if (this.value == 'custom') {
            $(".date_picker_ui").show();
        }
        else if (this.value == 'now') {
            $(".date_picker_ui").hide();
        }
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
					        <td valign="top"><label for="availTime">תזמון:</label></td>
					        <td>
					        <table border='0'>
						        <tr>
						        	<td><input type="radio" name="availTime" VALUE="now" checked>עכשיו</td>
						        </tr>
						        <tr>
						        	<td>
							        	<table border='0'>
							        		<tr>
								        		<td>
								        			<input type="radio" name="availTime" VALUE="custom" selected>בחר זמן עתידי
								        		</td>
							        		</tr>
							        		<tr class="date_picker_ui">
								        		<td>
								        			<label for="dateAvail">תאריך:</label>
									        		<input name="dateAvail" type="text" id="datepicker">
									        	</td>
									        </tr>
									        <tr class="date_picker_ui">
									        	<td>
								        			<label for="hourAvail">שעה:</label>
								        			<select name="hour" id="hour">
				        								<option value="0600">06:00</option>
				        								<option value="0700">07:00</option>
				        								<option value="0800">08:00</option>
				        								<option value="0900">09:00</option>
				        								<option value="1000">10:00</option>
				        								<option value="1100">11:00</option>
				        								<option value="1200">12:00</option>
				        								<option value="1300">13:00</option>
				        								<option value="1400">14:00</option>
				        								<option value="1500">15:00</option>
				        								<option value="1600">16:00</option>
				        								<option value="1700">17:00</option>
				        								<option value="1800">18:00</option>
				        								<option value="1900">19:00</option>
				        								<option value="2000">20:00</option>
				        								<option value="2100">21:00</option>
				        								<option value="2200">22:00</option>
				        								<option value="2300">23:00</option>
				        								<option value="2400">24:00</option>
				        								<option value="0100">01:00</option>
				        								<option value="0200">02:00</option>
				        								<option value="0300">03:00</option>
				        								<option value="0400">04:00</option>
				        								<option value="0500">05:00</option>
				        						</td>
								        	</tr>
							        	</table>	
						        	</td>
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