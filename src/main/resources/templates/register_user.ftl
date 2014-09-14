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
			<h2>רישום משתמש חדש</h2>
			<form method="post" action="registerUser">
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