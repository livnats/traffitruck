<html dir="rtl">
<head>
    <title>TraffiTruck</title>
	<meta charset="UTF-8">
	<link rel="stylesheet" type="text/css" href="/css/traffitruck.css">
		<script type="text/javascript" src="js/jquery-1.11.1.min.js"></script>
		<script type="text/javascript" src="js/jquery.validate.min.js"></script>

<script type="text/javascript">
$(document).ready(function() {
	// validate the comment form when it is submitted
	$("#registerForm").validate({
			rules: {
				username: {
					required: true,
					minlength: 1
				},
				password: {
					required: true,
					minlength: 1
				},
				confirm_password: {
					required: true,
					minlength: 5,
					equalTo: "#password"
				},
				phoneNumber: {
					required: false,
					number: true
				},
				cellNumber: {
					required: false,
					number: true
				}
			},
			messages: {
				username: {
					required: "אנא הכנס שם לקוח",
					minlength: "שם הלקוח חייב להכיל לפחות תו אחד"
				},
				password: {
					required: "אנא הכנס סיסמה",
					minlength: "הסיסמה חייבת להכיל לפחות תו אחד"
				},
				confirm_password: {
					required: "אנא הכנס סיסמה",
					minlength: "הסיסמה חייבת להכיל לפחות תו אחד",
					equalTo: "הסיסמה חייבת להתאים לסיסמה מעל"
				},
				phoneNumber: {
					number: "מספר הטלפון חייב להכיל רק ספרות"
				},
				cellNumber: {
					number: "מספר הטלפון חייב להכיל רק ספרות"
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
			<h2>רישום משתמש חדש</h2>
			<form id="registerForm" method="post" action="registerUser">
			    <table>
			    <tr>
			        <td><label for="username">שם הלקוח:</label></td>
			        <td><input name="username" /></td>
			    </tr>
	            <tr>
	            	<td><label for="password">בחר סיסמה:</label></td>
		        	<td><input name="password" type="password"/></td> 
	            </tr>
	            <tr>
	            	<td><label for="password">וידוא סיסמה:</label></td>
		        	<td><input name="confirm_password" type="password"/></td> 
	            </tr>
			    <tr>
			        <td><label for="address">כתובת:</label></td>
			        <td><input name="address" /></td>
			    </tr>
			    <tr>
			        <td><label for="contactPerson">איש קשר:</label></td>
			        <td><input name="contactPerson" /></td> 
			    </tr>
			    <tr>
			        <td><label for="phoneNumber">טלפון:</label></td> 
			        <td><input name="phoneNumber"/></td>
			    </tr>
			    <tr>
			        <td><label for="cellNumber">נייד:</label></td>
			        <td><input name="cellNumber" /></td>
			    </tr>
			    <tr>
			        <td colspan="2">
			            <input type="submit" value="הרשם"/>
			        </td>
			    </tr>
			</table>
			<!-- include csrf token -->
		    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
			</form>
		</div>
	</div>
</div>
</body>
</html>