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

$(document).ready(function() {
	<#if trole??>
		$("#trole").prop("checked", true);
	</#if>
	<#if lrole??>
		$("#lrole").prop("checked", true);
	</#if>
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
   if ( ! $('#trole').is(":checked") && ! $('#lrole').is(":checked") )
   {
		mAlert("חובה לבחור סוג משתמש");
		return false;
   }
   var regexp;
   regexp = /^[א-תA-Za-zÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿ \t\r\n\f0-9-]*$/;
   if (!regexp.test(theForm.username.value))
   {
      mAlert("שם הלקוח יכול להכיל אותיות ספרות ורווחים");
      theForm.username.focus();
      return false;
   }
   if (theForm.username.value == "")
   {
		mAlert("חובה לספק שם לקוח");
        theForm.username.focus();
		return false;
   }
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
   regexp = /^[a-zA-Z0-9.@_-]*$/;
   if (!regexp.test(theForm.email.value))
   {
      mAlert("כתובת הדוא\"ל אינה תקנית");
      theForm.email.focus();
      return false;
   }
   if (theForm.email.value == "")
   {
      mAlert("אנא הכנס דוא\"ל");
      theForm.email.focus();
      return false;
   }
   regexp = /^\d*$/;
   if (!regexp.test(theForm.phoneNumber.value))
   {
      mAlert("מספר הטלפון חייב להכיל רק ספרות");
      theForm.phoneNumber.focus();
      return false;
   }
   if (!regexp.test(theForm.cellNumber.value))
   {
      mAlert("מספר הטלפון חייב להכיל רק ספרות");
      theForm.cellNumber.focus();
      return false;
   }
   if (theForm.cellNumber.value == "" && theForm.phoneNumber.value == "")
   {
      mAlert("חובה לספק מספר טלפון");
      theForm.phoneNumber.focus();
      return false;
   }
   return true;
}
</script>

        <link type="text/css" rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500">
        <script src="https://maps.googleapis.com/maps/api/js?libraries=places"></script>
        <script>
            var autocomplete;
            function initialize() {
              
              var geocoder = new google.maps.Geocoder();
              
              autocomplete_src = new google.maps.places.Autocomplete(
                  /** @type {HTMLInputElement} */(document.getElementById('address')),
                  { types: ['address'] });
              google.maps.event.addListener(autocomplete_src, 'place_changed', function() {
                 var address = document.getElementById('address').value;
                 geocoder.geocode({'address': address}, function(results, status) {
                   if (status === google.maps.GeocoderStatus.OK) {
                      // nothing to do
                    } else {
                       alert('Geocode was not successful for the following reason: ' + status);
                    }
                 })
              });

              autocomplete_cities_src = new google.maps.places.Autocomplete(
                  /** @type {HTMLInputElement} */(document.getElementById('address')),
                  { types: ['(cities)'] });
              google.maps.event.addListener(autocomplete_cities_src, 'place_changed', function() {
                 var address = document.getElementById('address').value;
                 geocoder.geocode({'address': address}, function(results, status) {
                   if (status === google.maps.GeocoderStatus.OK) {
                      // nothing to do
                    } else {
                       alert('Geocode was not successful for the following reason: ' + status);
                    }
                 })
              });
            }
        </script>

</head>
<body onload="initialize()" dir="rtl">
<div data-role="page" data-theme="a" data-title="רישום משתמש" id="add_truck">
<div data-role="header" id="Header1">
<h1>רישום משתמש</h1>
<a href="/login" data-role="button" class="ui-btn-left">חזרה</a>
</div>
<div class="ui-content" role="main">
<div id="wb_Form1" style="">

	<#if error??>
		<div id="wb_Text1">
			<span style="color:#FF0000;font-family:Arial;font-size:13px;">שם משתמש תפוס</span>
		</div>
	</#if>
	<#if erroremail??>
		<div id="wb_Text1">
			<span style="color:#FF0000;font-family:Arial;font-size:13px;">כתובת דוא"ל בשימוש</span>
		</div>
	</#if>

<form name="registerForm" method="post" action="registerUser" data-ajax="false" data-transition="pop" id="registerForm" style="display:inline;" onsubmit="return ValidateForm1(this)">

<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
<input type="hidden" name="form_name" value="loginform">
<div class="ui-field-contain">
    <fieldset data-role="controlgroup" data-iconpos="right">
        <legend></legend>
        <input type="checkbox" name="roles" value="TRUCK_OWNER" id="trole" <#if (role?? && role == "TRUCK_OWNER")>checked="checked"</#if>>
        <label for="trole" style="text-align:right; background-color:white; color: #333333; text-shadow: 0 1px 0 #ffffff; border:0 none;">בעל משאית</label>
        <input type="checkbox" name="roles" value="LOAD_OWNER" id="lrole" <#if role?? && role == "LOAD_OWNER">checked="checked"</#if>>
        <label for="lrole" style="text-align:right; background-color:white; color: #333333; text-shadow: 0 1px 0 #ffffff; border:0 none;">בעל מטען</label>
    </fieldset>
</div>
<div class="ui-field-contain">
	<label for="username">* שם משתמש</label>
	<input type="text" id="username" style="direction:LTR" name="username" autocapitalize="off" value="<#if username??>${username}</#if>">
</div>
<div class="ui-field-contain">
	<label for="password">* בחר סיסמה</label>
	<input type="password" id="password" style="direction:LTR" name="password" autocapitalize="off">
</div>
<div class="ui-field-contain">
	<label for="confirm_password">* וידוא סיסמה</label>
	<input type="password" id="confirm_password" style="direction:LTR" name="confirm_password" autocapitalize="off">
</div>
<div class="ui-field-contain">
	<label for="email">* דוא"ל</label>
	<input type="email" id="email" style="direction:LTR" name="email" autocapitalize="off" value="<#if email??>${email}</#if>">
</div>
<div class="ui-field-contain">
	<label for="phoneNumber">* טלפון</label>
	<input type="tel" id="phoneNumber" style="direction:LTR" name="phoneNumber" autocapitalize="off" value="<#if phoneNumber??>${phoneNumber}</#if>">
</div>
<div class="ui-field-contain">
	<label for="cellNumber">נייד</label>
	<input type="tel" id="cellNumber" style="direction:LTR" name="cellNumber" autocapitalize="off" value="<#if cellNumber??>${cellNumber}</#if>">
</div>
<div class="ui-field-contain">
	<label for="address">כתובת</label>
	<input type="text" id="address" style="" name="address" autocapitalize="off" value="<#if address??>${address}</#if>" placeholder="הכנס כתובת">
</div>
<div class="ui-field-contain">
	<label for="contactPerson">איש קשר</label>
	<input type="text" id="contactPerson" style="" name="contactPerson" autocapitalize="off" value="<#if contactPerson??>${contactPerson}</#if>">
</div>
<input type="submit" id="login" name="login" value="הרשם">
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