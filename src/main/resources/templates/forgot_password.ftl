<html dir="rtl">
<head>
<meta charset="utf-8">
<title>טראפי-טראק - שחזור סיסמה</title>
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
   var regexp;
   regexp = /^[א-תA-Za-zÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿ \t\r\n\f0-9-]+$/;
   if (!regexp.test(theForm.username.value))
   {
      mAlert("שם הלקוח יכול להכיל אותיות ספרות ורווחים");
      theForm.username.focus();
      return false;
   }
   return true;
}
</script>

</head>
<body dir="rtl">
<div data-role="page" data-theme="a" data-title="שחזור סיסמה" id="add_truck">
<div data-role="header" id="Header1">
<h1>שחזור סיסמה</h1>
<a href="/login" data-role="button" class="ui-btn-left">חזרה</a>
</div>
<div class="ui-content" role="main">
<div id="wb_Form1" style="">

	<#if error??>
		<div id="wb_Text1">
			<span style="color:#FF0000;font-family:Arial;font-size:13px;">שם משתמש לא קיים</span>
		</div>
	</#if>

<form name="forgetPasswordForm" method="post" action="forgotPassword" data-ajax="false" data-transition="pop" id="forgotPasswordForm" style="display:inline;" onsubmit="return ValidateForm1(this)">

<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

<div class="ui-field-contain">
	<label for="username">* שם משתמש</label>
	<input type="text" id="username" style="direction:LTR" name="username" autocapitalize="off" value="<#if username??>${username}</#if>">
</div>
<input type="submit" id="login" name="login" value="שחזר סיסמה">
</form>

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