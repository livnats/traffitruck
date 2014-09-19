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
	$("#newloadForm").validate({
			rules: {
				name: {
					required: true,
					minlength: 1
				},
				source: {
					required: true,
					minlength: 1
				},
				destination: {
					required: true,
					minlength: 1
				},
				suggestedQuote: {
					required: false,
					number: true
				},
				weight: {
					required: false,
					number: true
				},
				volume: {
					required: false,
					number: true
				},
				waitingTime: {
					required: false,
					number: true
				}
			},
			messages: {
				name: {
					required: "אנא הכנס שם מטען",
					minlength: "שם המטען חייב להכיל לפחות תו אחד"
				},
				source: {
					required: "אנא הכנס מוצא",
					minlength: "היעד חייבת להכיל לפחות תו אחד"
				},
				destination: {
					required: "אנא הכנס יעד",
					minlength: "המוצא חייבת להכיל לפחות תו אחד"
				},
				suggestedQuote: {
					number: "המחיר חייב להכיל רק ספרות"
				},
				weight: {
					number: "המשקל חייב להכיל רק ספרות"
				},
				volume: {
					number: "הנפח חייב להכיל רק ספרות"
				},
				waitingTime: {
					number: "זמן ההמתנה חייב להיות מספר"
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
			<h2>הוסף מטען</h2>
			<form id="newloadForm" method="post" action="newload">
				<datalist id="loadingTypes">
				  <option value="ידני">
				  <option value="מלגזה">
				  <option value="מנוף">
				  <option value="רמפה">
				  <option value="עגלה">
				</datalist>
			    <table>
			    <tr>
			        <td><label for="name">שם המטען:</label></td>
			        <td><input name="name" /></td>
			    </tr>
			    <tr>
			        <td><label for="type">סוג המטען:</label></td> 
			        <td>
			        	<select name="type" id="type">
						  <option value="">-- בחר --</option>
						  <option value="${enums["com.traffitruck.domain.LoadType"].CONTAINER_20}">מכולה 20'</option>
						  <option value="${enums["com.traffitruck.domain.LoadType"].CONTAINER_40}">מכולה 40'</option>
						  <option value="${enums["com.traffitruck.domain.LoadType"].LIFTS}">משטחים</option>
						  <option value="${enums["com.traffitruck.domain.LoadType"].BAGS}">שקים (באלות)</option>
						  <option value="${enums["com.traffitruck.domain.LoadType"].ANIMALS}">בעלי חיים</option>
						  <option value="${enums["com.traffitruck.domain.LoadType"].SCATTERED}">תפזורת</option>
						  <option value="${enums["com.traffitruck.domain.LoadType"].HAZMAT}">חומ"ס</option>
						  <option value="${enums["com.traffitruck.domain.LoadType"].OTHER}">אחר</option>
						</select>
					</td>
			    </tr>
			    <tr id="other_type_tr">
			        <td></td>
			        <td><label for="other_type">פרטי סוג מטען:</label><input name="other_type" id="other_type"/></td>
			    </tr>
			    <tr>
			        <td><label for="weight">משקל (קילוגרם):</label></td>
			        <td><input name="weight" /></td>
			    </tr>
			    <tr>
			        <td><label for="volume">נפח (קוב):</label></td>
			        <td><input name="volume" /></td>
			    </tr>
			    <tr>
			        <td><label for="source">מוצא:</label></td>
			        <td><input name="source" /></td> 
			    </tr>
			    <tr>
			        <td><label for="loadingType">סוג טעינה:</label></td> 
			        <td><input list="loadingTypes" name="loadingType"/></td>
			    </tr>
			    <tr>
			        <td><label for="destination">יעד:</label></td>
			        <td><input name="destination" /></td>
			    </tr>
			    <tr>
			        <td><label for="downloadingType">סוג פריקה:</label></td>
			        <td><input list="loadingTypes" name="downloadingType"/></td> 
			    </tr>
			    <tr>
			        <td><label for="suggestedQuote">מחיר (שקלים):</label></td>
			        <td><input name="suggestedQuote" /></td>
			    </tr>
			    <tr>
			        <td><label for="waitingTime">זמן המתנה (שעות):</label></td> 
			        <td><input name="waitingTime" /></td>
			    </tr>
			    <tr>
			        <td><label for="comments">הערות:</label></td> 
			        <td><input name="comments" /></td>
			    </tr>
			    <tr>
			        <td colspan="2">
			            <input type="submit" value="הוסף מטען"/>
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
