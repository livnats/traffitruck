<html dir="rtl">
<head>
    <title>TraffiTruck</title>
	<meta charset="UTF-8">
	<link rel="stylesheet" type="text/css" href="/css/traffitruck.css">
		<script type="text/javascript" src="js/jquery-1.11.1.min.js"></script>
		<script type="text/javascript" src="js/jquery.validate.min.js"></script>
		<script type="text/javascript" src="js/truck_approval.js"></script>
		
<script type="text/javascript">
$(document).ready(function() {

	// validate the comment form when it is submitted
	$("#approveTruck").validate( approveTruckValidationOptions );

});
</script>


        <link type="text/css" rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500">
        <script src="/mapsapis"></script>
        <script>
            var autocomplete;
            function initialize() {
              autocomplete_src = new google.maps.places.Autocomplete(
                  /** @type {HTMLInputElement} */(document.getElementById('ownerAddress')),
                  { types: ['address'] });

              autocomplete_cities_src = new google.maps.places.Autocomplete(
                  /** @type {HTMLInputElement} */(document.getElementById('ownerAddress')),
                  { types: ['(cities)'] });
            }
        </script>

</head>
<body onload="initialize()">
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
			<form id="approveTruck" method="post" action="truckApproval">
			    <table>
			    	<tr> 
						<td  colspan='2'>
							<a href="/nonApprovedTrucks">משאיות לאישור</a>
						</td>
					</tr>
				 	<tr>
				        <td  colspan='2'>
				        	<label >מספר לוחית זיהוי: ${truck.licensePlateNumber} </label>
			        	</td>
				    </tr>
				    <tr>
				        <td colspan='2'>
				        	<input type="checkbox" name="licensePlateNumberApproved"/>
				        	<laebl id="licensePlateNumberApprovedLabel" for="licensePlateNumberApproved"> אני מאשר כי מספר לוחית הזיהוי תואם למספר המופיע ברשיון הרכב</label>
			        	</td>
				    </tr>
				    <tr>
			      		<td><label for="ownerName">שם בעל הרכב:</label></td>
			        	<td><input name="ownerName"/></td> 
			    	</tr>
			    	<tr>
			      		<td><label for="ownerId">ת"ז בעל הרכב:</label></td>
			        	<td><input name="ownerId"/></td> 
			    	</tr>
			    	<tr>
			      		<td><label for="ownerAddress">כתובת בעל הרכב:</label></td>
			        	<td><input name="ownerAddress" id="ownerAddress"/></td> 
			    	</tr>
				    <tr>
				    	<td><label for="maxWeight">משקל מקסימלי להובלה (ק"ג):</label></td>
			        	<td><input name="maxWeight"/></td> 
				    </tr>
				    <tr>
				    	<td><label for="maxVolume">נפח מקסימלי להובלה (קוב):</label></td>
			        	<td><input name="maxVolume"/></td> 
				    </tr>
				    <tr>
				    	<td><label for="acceptableLiftTypes" valign="top">סוגי טעינה ופריקה אפשריים:</label></td>
			        	<td>
			        		<select multiple name="acceptableLiftTypes" size="5">
								<option value="MANUAL">ידני</option>
								<option value="FORKLIFT">מלגזה</option>
								<option value="CRANE">מנוף</option>
								<option value="RAMP">רמפה</option>
								<option value="TROLLY">עגלה</option>
								<option value="CONTAINER">מכולה</option>
			        		</select>
			            </td> 
				    </tr>
				    <tr>
				    	<td><label for="acceptableLoadTypes" valign="top">סוגי מטענים אפשריים:</label></td>
			        	<td>
							<select multiple name="acceptableLoadTypes" size="8">
								<option value="CONTAINER_20">מכולה 20'</option>
								<option value="CONTAINER_40">מכולה 40'</option>
								<option value="LIFTS">משטחים</option>
								<option value="BAGS">שקים (באלות)</option>
								<option value="ANIMALS">בעלי חיים</option>
								<option value="SCATTERED">תפזורת</option>
								<option value="HAZMAT">חומ"ס</option>
								<option value="OTHER">אחר</option>
							</select>
			            </td> 
				    </tr>
				    <tr>
			        <td colspan="2">
			            <input type="submit" value="אשר משאית"/>
			        </td>
			    </tr>
			    </table>
			<!-- inlcude csrf token -->
		    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
		    <input type="hidden" name="id" value="${truck.id}"/>
			</form>
		</div>
		<div id="load_details">
			<img src="/approval/licenseimage/${truck.id}"><br><br><br>
			<img src="/approval/truckimage/${truck.id}">
			<img src="/approval/driverlicenseimage/${truck.id}">
		</div>
	</div>
</div>
</body>
</html>
