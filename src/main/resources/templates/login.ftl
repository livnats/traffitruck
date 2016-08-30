<html dir="rtl">
<head>
<meta charset="utf-8">
<title>טראפי-טראק - כניסה</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="js/default/jquery.mobile.theme-1.4.5.css" rel="stylesheet">
<link href="js/default/jquery.mobile.icons-1.4.5.min.css" rel="stylesheet">
<link href="css/jquery.mobile.structure-1.4.5.min.css" rel="stylesheet">
<link href="css/mobile.css" rel="stylesheet">
<link href="css/login.css" rel="stylesheet">
<script src="js/jquery-1.11.3.min.js" type="text/javascript"></script>
<script>
$(document).on("mobileinit", function()
{
   $.mobile.ajaxEnabled = false;
});
</script>
<script src="js/jquery.mobile-1.4.5.min.js" type="text/javascript"></script>

<script>
function mAlert(text1) {
  $("#sure .sure-1").text(text1);
  $("#sure .sure-do").on("click.sure", function() {
    $(this).off("click.sure");
  });
  $.mobile.changePage("#sure");
}

function ValidateForm(theForm)
{
   if (theForm.username.value == "")
   {
      mAlert("חובה לספק שם משתמש");
      theForm.username.focus();
      return false;
   }
   if (theForm.password.value == "")
   {
      mAlert("חובה לספק סיסמה");
      theForm.password.focus();
      return false;
   }
	return true;
}
</script>
</head>
<body>
<div data-role="page" data-theme="a" data-title="טראפי-טראק כניסה" id="page1">
	<div data-role="header" id="Header1">
		<img src="/images/logo.jpg" width="20%" style="margin-bottom:15; margin-left:10"/>
		<img src="/images/truck-blue.jpg" width="15%"/>
	</div>
	<div class="ui-content" role="main">

			<#if RequestParameters.error??>
				<div id="wb_Text1">
					<span style="color:#FF0000;font-family:Arial;font-size:13px;">שם משתמש וסיסמה אינם מתאימים</span>
				</div>
	    	</#if>
			<#if RequestParameters.logout??>
				<div id="wb_Text1">
					<span style="color:#000000;font-family:Arial;font-size:13px;">יצאת מהמערכת</span>
				</div>
		    </#if>

		<form name="loginform" method="post" action="/login" id="loginform" onsubmit="return ValidateForm(this)">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
			<input type="hidden" name="form_name" value="loginform">
				<input type="text" id="username" name="username" value="" style="text-align:right" autocapitalize="off" placeholder='שם משתמש'>
				<input type="password" id="password" name="password" value="" style="text-align:right" placeholder='סיסמה'>
			<div id="rememberme">
				<!--
				<fieldset data-role="controlgroup" data-shadow="true">
				<input type="checkbox" id="rememberme-0" name="rememberme" value="on" checked>
				<label for="rememberme-0">זכור אותי</label>
				</fieldset>
				-->
			</div>
			<input type="submit" id="login" name="login" value="התחבר">
		</form>
		<a href="/registerUser" data-role="button" data-inline="true" data-theme="b">רישום משתמש חדש</a>
		<div><a href="/forgotPassword" data-role="none" style="font-weight:normal; font-size:0.8em;">שכחתי סיסמה</a></div>
	</div>
</div>

<div data-role="dialog" id="sure">
  <div data-role="content">
    <h3 class="sure-1">???</h3>
    <a href="#" class="sure-do" data-role="button" data-theme="b" data-rel="back">סגור</a>
  </div>
</div>

</body>
</html>