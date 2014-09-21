<html dir="rtl">
<head>
    <title>TraffiTruck</title>
	<meta charset="UTF-8">
	<link rel="stylesheet" type="text/css" href="/css/traffitruck.css">
		<script type="text/javascript" src="js/jquery-1.11.1.min.js"></script>
		<script type="text/javascript" src="js/jquery.validate.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {

    $("#other_type_tr").hide();

	$("#type").change(function () {
        if ( this.value == "other" ) {
        	$("#other_type_tr").show();
        }
        else {
        	$("#other_type_tr").hide();
        }
    });
    
	// validate the comment form when it is submitted
	$("#newTruckForm").validate({
			rules: {
				licensePlateNumber: {
					required: true,
					minlength: 1
				},
				vehicleLicensePhoto: {
					required: true
				}
			},
			messages: {
				licensePlateNumber: {
					required:"אנה הכנס מספר לוחית רישוי",
					minlength: "לוחית רישוי צריכה להכיל לפחות תו אחד"
				},
				vehicleLicensePhoto: {
					required: "עליך להעלות צילום של לוחית רישוי"
				}
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
			<h2>הוסף משאית</h2>
			<form id="newTruckForm" method="post" action="newTruck" enctype="multipart/form-data">
			    <table>
			    <tr>
			        <td><label for="licensePlateNumber">* מספר לוחית זיהוי:</label></td>
			        <td><input name="licensePlateNumber" /></td>
			    </tr>
			    <tr>
			        <td><label for="vehicleLicensePhoto">* צילום רשיון רכב:</label></td> 
			        <td>
				        <input type="file" accept="image/*" name="vehicleLicensePhoto"/>
					</td>
			    </tr>
			    <tr>
			        <td><label for="truckPhoto">צילום המשאית:</label></td> 
			        <td>
				        <input type="file" accept="image/*" name="truckPhoto"/>
					</td>
			    </tr>
			    <tr>
			        <td colspan="2">
			            <input type="submit" value="הוסף משאית"/>
			        </td>
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
