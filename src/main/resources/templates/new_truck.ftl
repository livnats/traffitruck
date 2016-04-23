<html dir="rtl">
<head>
<meta charset="utf-8">
<title>טראפי-טראק - הוסף משאית</title>
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
   regexp = /^\d*$/;
   if (!regexp.test(theForm.licensePlateNumber.value))
   {
      alert("שדה חובה");
      theForm.licensePlateNumber.focus();
      return false;
   }
   if (theForm.licensePlateNumber.value == "")
   {
      alert("שדה חובה");
      theForm.licensePlateNumber.focus();
      return false;
   }
   if (theForm.licensePlateNumber.value != "" && !(theForm.licensePlateNumber.value > 0))
   {
      alert("שדה חובה");
      theForm.licensePlateNumber.focus();
      return false;
   }
   if (theForm.vehicleLicensePhoto.value == "")
   {
      alert("שדה חובה");
      theForm.vehicleLicensePhoto.focus();
      return false;
   }
   if (theForm.truckPhoto.value == "")
   {
      alert("שדה חובה");
      theForm.truckPhoto.focus();
      return false;
   }
   return true;
}
</script>
</head>
<body>
<div data-role="page" data-theme="a" data-title="הוסף משאית" id="add_truck">
<div data-role="header" id="Header1">
<h1>הוסף משאית</h1>
<a href="/myTrucks" data-role="button" class="ui-btn-left">חזרה</a>
<a href="/logout" data-role="button" class="ui-btn-right">יציאה</a>
</div>
<div class="ui-content" role="main">
<div id="wb_Form1" style="">
<form name="newTruckForm" method="post" action="newTruck" enctype="multipart/form-data" data-ajax="false" data-transition="pop" id="newTruckForm" style="display:inline;" onsubmit="return ValidateForm1(this)">
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
<label for="licensePlateNumber">מספר לוחית רישוי</label>
<input type="number" id="licensePlateNumber" style="" name="licensePlateNumber" value="" maxlength="7">
<label for="vehicleLicensePhoto">צילום רשיון רכב</label>
<input type="file" id="vehicleLicensePhoto" style="" name="vehicleLicensePhoto">
<label for="truckPhoto">צילום משאית</label>
<input type="file" id="truckPhoto" style="" name="truckPhoto">
<input type="submit" id="Button1" name="" value="הוסף משאית">
</form>
</div>
</div>
</div>
</body>
</html>