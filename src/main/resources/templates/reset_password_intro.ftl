<html dir="rtl">
<head>
<meta charset="utf-8">
<title>טראפי-טראק - סיסמה חדשה</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="js/default/jquery.mobile.theme-1.4.5.css" rel="stylesheet">
<link href="js/default/jquery.mobile.icons-1.4.5.min.css" rel="stylesheet">
<link href="css/jquery.mobile.structure-1.4.5.min.css" rel="stylesheet">
<link href="css/mobile.css" rel="stylesheet">
<link href="css/add_truck.css" rel="stylesheet">
<script src="js/jquery-1.11.3.min.js"></script>
<script>
$(document).on("mobileinit", function()
{
   $.mobile.ajaxEnabled = false;
});

</script>
<script src="js/jquery.mobile-1.4.5.min.js"></script>
<script>

function mAlert(text1) {
  $("#sure .sure-1").text(text1);
  $("#sure .sure-do").on("click.sure", function() {
    $(this).off("click.sure");
  });
  $.mobile.changePage("#sure");
}

function ValidateForm1(theForm)
{
   if (theForm.password.value == "")
   {
      mAlert("אנא הכנס סיסמה");
      theForm.password.focus();
      return false;
   }
   if (theForm.confirm_password.value == "")
   {
      mAlert("אנא הכנס וידוא סיסמה");
      theForm.confirm_password.focus();
      return false;
   }
   if (theForm.password.value != theForm.confirm_password.value)
   {
      theForm.password.value = '';
      theForm.confirm_password.value = '';
      mAlert("וידוא סיסמה נכשל. אנא ודא שהסיסמה ווידוא הסיסמה זהים");
      theForm.password.focus();
      return false;
   }
   return true;
}
</script>

</head>
<body dir="rtl">
<div data-role="page" data-theme="a" data-title="סיסמה חדשה" id="add_truck">
<div data-role="header" id="Header1">
<h1>סיסמה חדשה</h1>
</div>
<div class="ui-content" role="main">
<div id="wb_Form1" style="">

	<#if abort??>
		<div id="wb_Text1">
			<span style="color:#FF0000;font-family:Arial;font-size:13px;">בקשה לא בתוקף</span>
		</div>
	<#else>

<form name="resetPasswordForm" method="post" action="resetPassword" data-ajax="false" data-transition="pop" id="resetPasswordForm" style="display:inline;" onsubmit="return ValidateForm1(this)">

<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
<div class="ui-field-contain">
	<label for="password">* בחר סיסמה חדשה</label>
	<input type="password" id="password" style="direction:LTR" name="password" autocapitalize="off">
</div>
<div class="ui-field-contain">
	<label for="confirm_password">* וידוא סיסמה</label>
	<input type="password" id="confirm_password" style="direction:LTR" name="confirm_password" autocapitalize="off">
</div>
<input type="submit" id="login" name="login" value="עדכן סיסמה">
</form>

	</#if>

</div>
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