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
				<#if RequestParameters.error??>
			        <div id="error">
			            שם משתמש וסיסמה אינם מתאימים
			        </div>
		    	</#if>
				<#if RequestParameters.logout??>
			        <div>
			            יצאת מהמערכת
			        </div>
			    </#if>
		        <form action="/login" method="post">
		        <table>
		        	<tr>
		        		<td><label for="username">שם משתמש</label></td>
			        	<td><input name="username" /></td> 
		            </tr>
		            <tr>
		            	<td><label for="password">סיסמה</label></td>
			        	<td><input name="password" type="password"/></td> 
		            </tr>
		            <tr>
		            <td colspan='2'>
		            	<input type="submit" value="כניסה"/>
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
