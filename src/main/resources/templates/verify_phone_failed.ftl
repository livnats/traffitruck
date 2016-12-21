<html dir="rtl">
<head>
<meta charset="utf-8">
<title>טראפי-טראק - אימות מספר טלפון</title>
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
   if (theForm.verificationCode.value == "")
   {
		mAlert("חובה לספק מספר לאימות");
        theForm.verificationCode.focus();
		return false;
   }
   return true;
}
</script>

<style>
label{
text-align: right;
}
</style>
</head>
<body dir="rtl">
<div data-role="page" data-theme="a" data-title="אימות מספר טלפון" id="verify_phone">

<div class="ui-content" role="main">
<div id="wb_Form1" style="">
אימות מספר הטלפון נכשל, לחצו <a href="/resendVerificationCode">כאן</a> כדי לשלוח שוב קוד אימות
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