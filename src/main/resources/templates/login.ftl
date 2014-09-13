<html dir="rtl">
	<head>
	    <title>TraffiTruck</title>
		<meta charset="UTF-8">
	</head>
	<body>
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
            <div><label>שם משתמש:<input type="text" name="username"/> </label></div>
            <div><label>סיסמה:<input type="password" name="password"/> </label></div>
            <div><input type="submit" value="כניסה"/></div>
		    <!-- inlcude csrf token -->
		    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        </form>
    </body>
</html>
