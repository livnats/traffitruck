<html dir="rtl">
<head>
<meta charset="utf-8">
<title>טראפי-טראק - מטען חדש</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="js/default/jquery.mobile.theme-1.4.5.css" rel="stylesheet">
<link href="js/default/jquery.mobile.icons-1.4.5.min.css" rel="stylesheet">
<link href="css/jquery.mobile.structure-1.4.5.min.css" rel="stylesheet">
<link href="css/mobile.css" rel="stylesheet">
<link href="css/add_load.css" rel="stylesheet">
<script src="js/jquery-1.11.3.min.js"></script>

     <link rel="stylesheet" href="css/jquery-ui-1.11.1.css">
	<script type="text/javascript" src="js/jquery-ui-1.11.1.js"></script>

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
   if (!regexp.test(theForm.name.value))
   {
      alert("שם המטען יכול להכיל אותיות ספרות ורווחים");
      theForm.name.focus();
      return false;
   }
   if (theForm.name.value == "")
   {
      alert("שם המטען יכול להכיל אותיות ספרות ורווחים");
      theForm.name.focus();
      return false;
   }
   if (theForm.type.selectedIndex < 0)
   {
      alert("שדה חובה");
      theForm.type.focus();
      return false;
   }
   if (theForm.type.selectedIndex == 0)
   {
      alert("שדה חובה");
      theForm.type.focus();
      return false;
   }
   regexp = /^[-+]?\d*\.?\d*$/;
   if (!regexp.test(theForm.weight.value))
   {
      alert("המשקל חייב להכיל רק ספרות");
      theForm.weight.focus();
      return false;
   }
   if (theForm.weight.value != "" && !(theForm.weight.value > 0))
   {
      alert("המשקל חייב להכיל רק ספרות");
      theForm.weight.focus();
      return false;
   }
   regexp = /^[-+]?\d*\.?\d*$/;
   if (!regexp.test(theForm.volume.value))
   {
      alert("הנפח חייב להכיל רק ספרות");
      theForm.volume.focus();
      return false;
   }
   if (theForm.volume.value != "" && !(theForm.volume.value > 0))
   {
      alert("הנפח חייב להכיל רק ספרות");
      theForm.volume.focus();
      return false;
   }
   regexp = /^[א-תA-Za-zÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿ \t\r\n\f0-9-,"]*$/;
   if (!regexp.test(theForm.source.value))
   {
      alert("המוצא יכול להכיל אותיות ספרות ורווחים");
      theForm.source.focus();
      return false;
   }
   if (theForm.source.value == "")
   {
      alert("המוצא יכול להכיל אותיות ספרות ורווחים");
      theForm.source.focus();
      return false;
   }
   if (theForm.loadingType.selectedIndex < 0)
   {
      alert("שדה חובה");
      theForm.loadingType.focus();
      return false;
   }
   if (theForm.loadingType.selectedIndex == 0)
   {
      alert("שדה חובה");
      theForm.loadingType.focus();
      return false;
   }
   if (theForm.downloadingType.selectedIndex < 0)
   {
      alert("שדה חובה");
      theForm.downloadingType.focus();
      return false;
   }
   if (theForm.downloadingType.selectedIndex == 0)
   {
      alert("שדה חובה");
      theForm.downloadingType.focus();
      return false;
   }
   regexp = /^[א-תA-Za-zÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿ \t\r\n\f0-9-,"]*$/;
   if (!regexp.test(theForm.destination.value))
   {
      alert("היעד יכול להכיל אותיות ספרות ורווחים");
      theForm.destination.focus();
      return false;
   }
   if (theForm.destination.value == "")
   {
      alert("היעד יכול להכיל אותיות ספרות ורווחים");
      theForm.destination.focus();
      return false;
   }
   regexp = /^[-+]?\d*\.?\d*$/;
   if (!regexp.test(theForm.suggestedQuote.value))
   {
      alert("המחיר חייב להכיל רק ספרות");
      theForm.suggestedQuote.focus();
      return false;
   }
   if (theForm.suggestedQuote.value == "")
   {
      alert("המחיר חייב להכיל רק ספרות");
      theForm.suggestedQuote.focus();
      return false;
   }
   if (theForm.suggestedQuote.value != "" && !(theForm.suggestedQuote.value > 0))
   {
      alert("המחיר חייב להכיל רק ספרות");
      theForm.suggestedQuote.focus();
      return false;
   }
   regexp = /^[-+]?\d*\.?\d*$/;
   if (!regexp.test(theForm.waitingTime.value))
   {
      alert("זמן המתנה חייב להכיל רק ספרות");
      theForm.waitingTime.focus();
      return false;
   }
   if (theForm.waitingTime.value != "" && !(theForm.waitingTime.value >= 0))
   {
      alert("זמן המתנה חייב להכיל רק ספרות");
      theForm.waitingTime.focus();
      return false;
   }
   regexp = /^[א-תA-Za-zÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿ \t\r\n\f0-9-]*$/;
   if (!regexp.test(theForm.comments.value))
   {
      alert("ההערות יכולות להכיל אותיות ספרות ורווחים");
      theForm.comments.focus();
      return false;
   }
   return true;
}
</script>

 <script type="text/javascript">
 $(function() {
       $( "#drivedate" ).datepicker();
       $( "#drivedate" ).datepicker( "option", "dateFormat", 'dd-mm-yy' );       
 });
 </script>

        <link type="text/css" rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500">
        <script src="https://maps.googleapis.com/maps/api/js?libraries=places"></script>
        <script>
            var autocomplete;
            function initialize() {
              
              var geocoder = new google.maps.Geocoder();
              
              autocomplete_src = new google.maps.places.Autocomplete(
                  /** @type {HTMLInputElement} */(document.getElementById('source')),
                  { types: ['address'] });
              google.maps.event.addListener(autocomplete_src, 'place_changed', function() {
                 var address = document.getElementById('source').value;
                 geocoder.geocode({'address': address}, function(results, status) {
                   if (status === google.maps.GeocoderStatus.OK) {
	                   $("#sourceLat").val( results[0].geometry.location.lat() );
	                   $("#sourceLng").val( results[0].geometry.location.lng() );
                    } else {
                       alert('Geocode was not successful for the following reason: ' + status);
                    }
                 })
              });

              autocomplete_dest = new google.maps.places.Autocomplete(
                  /** @type {HTMLInputElement} */(document.getElementById('destination')),
                  { types: ['address'] });
              google.maps.event.addListener(autocomplete_dest, 'place_changed', function() {
                 var address = document.getElementById('destination').value;
                 geocoder.geocode({'address': address}, function(results, status) {
                   if (status === google.maps.GeocoderStatus.OK) {
	                   $("#destinationLat").val( results[0].geometry.location.lat() );
	                   $("#destinationLng").val( results[0].geometry.location.lng() );
                    } else {
                       alert('Geocode was not successful for the following reason: ' + status);
                    }
                  })
              });
            }
        </script>

</head>
<body onload="initialize()" dir="rtl">
<div data-role="page" data-theme="a" data-title="הוספת מטען" id="add_load">
<div data-role="header" id="Header1">
<h1>הוסף מטען</h1>
<a href="/myLoads" data-role="button" class="ui-btn-left">חזרה</a>
<a href="/logout" data-role="button" class="ui-btn-right">יציאה</a>
</div>
<div class="ui-content" role="main">
<div id="wb_Form1" style="">
<form name="newloadForm" method="post" action="newload" enctype="multipart/form-data" data-ajax="false" data-transition="pop" id="newloadForm" style="display:inline;" onsubmit="return ValidateForm1(this)">
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
<label for="name">שם המטען</label>
<input type="text" id="name" style="" name="name" value="">
<label for="type">סוג המטען</label>
<select name="type" size="1" id="type">
<option>-- בחר --</option>
<option value="CONTAINER_20">מכולה 20'</option>
<option value="CONTAINER_40">מכולה 40'</option>
<option value="LIFTS">משטחים</option>
<option value="BAGS">שקים (באלות)</option>
<option value="ANIMALS">בעלי חיים</option>
<option value="SCATTERED">תפזורת</option>
<option value="HAZMAT">חומ"ס</option>
<option value="OTHER">אחר</option>
</select>
<label for="weight">משקל (ק"ג)</label>
<input type="number" id="weight" style="" name="weight" value="">
<label for="volume">נפח (קוב)</label>
<input type="number" id="volume" style="" name="volume" value="">
<label for="source">מוצא</label>
<input type="text" id="source" style="" name="source" value="" placeholder="הכנס כתובת">
<input type="hidden" id="sourceLat" name="sourceLat" value="">
<input type="hidden" id="sourceLng" name="sourceLng" value="">
<label for="loadingType">סוג טעינה</label>
<select name="loadingType" size="1" id="loadingType">
<option>-- בחר --</option>
<option value="MANUAL">ידני</option>
<option value="FORKLIFT">מלגזה</option>
<option value="CRANE">מנוף</option>
<option value="RAMP">רמפה</option>
<option value="TROLLY">עגלה</option>
</select>
<label for="destination">יעד</label>
<input type="text" id="destination" style="" name="destination" value="" placeholder="הכנס כתובת">
<input type="hidden" id="destinationLat" name="destinationLat" value="">
<input type="hidden" id="destinationLng" name="destinationLng" value="">

<label for="downloadingType">סוג פריקה</label>
<select name="downloadingType" size="1" id="downloadingType">
<option>-- בחר --</option>
<option value="MANUAL">ידני</option>
<option value="FORKLIFT">מלגזה</option>
<option value="CRANE">מנוף</option>
<option value="RAMP">רמפה</option>
<option value="TROLLY">עגלה</option>
</select>

<label for="drivedate">תאריך הובלה</label>
<input type="text" id="drivedate" style="" name="drivedate" value="" onfocus="blur();">

<label for="suggestedQuote">מחיר (שקלים)</label>
<input type="number" id="suggestedQuote" style="" name="suggestedQuote" value="">
<label for="waitingTime">זמן המתנה (שעות)</label>
<input type="number" id="waitingTime" style="" name="waitingTime" value="">
<label for="comments">הערות</label>
<input type="text" id="comments" style="" name="comments" value="">
<label for="loadImage">צילום המטען</label>
<input type="file" id="loadPhoto" style="" name="loadPhoto">
<input type="submit" id="Button1" name="" value="הוסף מטען">
</form>
</div>
</div>
</div>
</body>
</html>