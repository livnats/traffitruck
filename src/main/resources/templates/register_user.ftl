<html dir="rtl">
<head>
<meta charset="utf-8">
<title>טראפי-טראק - רישום משתמש</title>
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
function ValidateForm1(theForm)
{
   var regexp;
   regexp = /^[א-תA-Za-zÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿ \t\r\n\f0-9-]*$/;
   if (!regexp.test(theForm.username.value))
   {
      alert("שם הלקוח יכול להכיל אותיות ספרות ורווחים");
      theForm.username.focus();
      return false;
   }
   if (theForm.username.value == "")
   {
      alert("אנא הכנס שם לקוח");
      theForm.username.focus();
      return false;
   }
   if (theForm.password.value == "")
   {
      alert("אנא הכנס סיסמה");
      theForm.password.focus();
      return false;
   }
   if (theForm.confirm_password.value == "")
   {
      alert("אנא הכנס וידוא סיסמה");
      theForm.confirm_password.focus();
      return false;
   }
   if (theForm.password.value != theForm.confirm_password.value)
   {
      alert("הסיסמאות חייבות להיות זהות");
      theForm.confirm_password.focus();
      return false;
   }
   regexp = /^[a-zA-Z0-9.@_-]*$/;
   if (!regexp.test(theForm.email.value))
   {
      alert("כתובת הדוא\"ל אינה תקנית");
      theForm.email.focus();
      return false;
   }
   if (theForm.email.value == "")
   {
      alert("אנא הכנס דוא\"ל");
      theForm.email.focus();
      return false;
   }
   regexp = /^\d*$/;
   if (!regexp.test(theForm.phoneNumber.value))
   {
      alert("מספר הטלפון חייב להכיל רק ספרות");
      theForm.phoneNumber.focus();
      return false;
   }
   if (!regexp.test(theForm.cellNumber.value))
   {
      alert("מספר הטלפון חייב להכיל רק ספרות");
      theForm.cellNumber.focus();
      return false;
   }
   if (theForm.cellNumber.value == "" && theForm.phoneNumber.value == "")
   {
      alert("חובה לספק מספר טלפון");
      theForm.phoneNumber.focus();
      return false;
   }
   return true;
}
</script>
</head>
<body>
<div data-role="page" data-theme="a" data-title="רישום משתמש" id="add_truck">
<div data-role="header" id="Header1">
<h1>רישום משתמש</h1>
<a href="/login" data-role="button" class="ui-btn-left">חזרה</a>
</div>
<div class="ui-content" role="main">
<div id="wb_Form1" style="">

<form name="registerForm" method="post" action="registerUser" data-ajax="false" data-transition="pop" id="registerForm" style="display:inline;" onsubmit="return ValidateForm1(this)">

<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
<input type="hidden" name="form_name" value="loginform">
<div class="ui-field-contain">
	<label for="username">* שם הלקוח</label>
	<input type="text" id="username" style="" name="username" value="" autocapitalize="off">
</div>
<div class="ui-field-contain">
	<label for="password">* בחר סיסמה</label>
	<input type="password" id="password" style="" name="password" value="" autocapitalize="off">
</div>
<div class="ui-field-contain">
	<label for="confirm_password">* וידוא סיסמה</label>
	<input type="password" id="confirm_password" style="" name="confirm_password" value="" autocapitalize="off">
</div>
<div class="ui-field-contain">
	<label for="email">* דוא"ל</label>
	<input type="email" id="email" style="" name="email" value="" autocapitalize="off">
</div>
<div class="ui-field-contain">
	<label for="phoneNumber">* טלפון</label>
	<input type="tel" id="phoneNumber" style="" name="phoneNumber" value="" autocapitalize="off">
</div>
<div class="ui-field-contain">
	<label for="cellNumber">נייד</label>
	<input type="tel" id="cellNumber" style="" name="cellNumber" value="" autocapitalize="off">
</div>
<div class="ui-field-contain">
	<label for="address">כתובת</label>
	<input type="text" id="address" style="" name="address" value="" autocapitalize="off">
</div>
<div class="ui-field-contain">
	<label for="contactPerson">איש קשר</label>
	<input type="text" id="contactPerson" style="" name="contactPerson" value="" autocapitalize="off">
</div>
<div class="ui-field-contain">
    <fieldset data-role="controlgroup" data-type="horizontal">
        <legend></legend>
        <input type="radio" name="role" value="TRUCK_OWNER" id="trole" checked="checked">
        <label for="trole">בעל משאית</label>
        <input type="radio" name="role" value="LOAD_OWNER" id="lrole">
        <label for="lrole">בעל מטען</label>
    </fieldset>
</div>
<input type="submit" id="login" name="login" value="הרשם">
</form>

</div>
</div>
</div>
</body>
</html>