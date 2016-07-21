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

</head>
<body dir="rtl">
<div data-role="page" data-theme="a" data-title="שחזור סיסמה" id="add_truck">
<div data-role="header" id="Header1">
<h1>שחזור סיסמה</h1>
<a href="/login" data-role="button" class="ui-btn-left">חזרה</a>
</div>
<div class="ui-content" role="main">
<div id="wb_Form1" style="">

בקשת איפוס הסיסמה נקלטה במערכת<br>
נשלח מייל לכתובת<br>
${email}
עם  סיסמה זמנית<br>
הסיסמה הזמנית תקפה ל15 דקות<br>
בכניסה למערכת תתבקש לבחור סיסמה חדשה<br>

<a href="/login" data-role="button">חזרה לדף הכניסה</a>

</body>
</html>