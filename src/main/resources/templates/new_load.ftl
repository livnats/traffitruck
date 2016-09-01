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

$(document).ready(function() {
	$('#loadPhoto1').change(function(){
	    var file = this.files[0];
	    var name = file.name;
	    var size = file.size;
	    var type = file.type;

        if ( file != "" && ! type.startsWith("image/") ) {
           mAlert("חובה לבחור תמונה");
           this.val("");
           this.focus();
           return false;
        }

        ratio = 1;
        if ( size > 1000000 ) {
            ratio = size / 400000;
        }
        oFReader = new FileReader(); 
		oFReader.onload = function (oFREvent) {
		  var img=new Image();
		  img.onload=function(){
              if ( ratio != 1 ) {
			      var canvas=document.createElement("canvas");
			      var ctx=canvas.getContext("2d");
			      canvas.width=img.width/ratio;
			      canvas.height=img.height/ratio;
			      ctx.drawImage(img,0,0,img.width,img.height,0,0,canvas.width,canvas.height);
			      var imageData = canvas.toDataURL();
       	          $('#loadPhoto').val(imageData);
              }
              else {
		         var imageData = oFReader.result;
                 $('#loadPhoto').val(imageData);
              }
		  }
		  img.src=oFREvent.target.result;
		};
        oFReader.readAsDataURL(file);
	});
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
   regexp = /^[א-תA-Za-zÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿ \t\r\n\f0-9-]*$/;
   if (!regexp.test(theForm.name.value))
   {
      mAlert("שם המטען יכול להכיל אותיות ספרות ורווחים");
      theForm.name.focus();
      return false;
   }
   if (theForm.name.value == "")
   {
      mAlert("שם המטען יכול להכיל אותיות ספרות ורווחים");
      theForm.name.focus();
      return false;
   }
   if (theForm.type.selectedIndex < 0)
   {
      mAlert("שדה חובה");
      theForm.type.focus();
      return false;
   }
   if (theForm.type.selectedIndex == 0)
   {
      mAlert("חובה לספק את סוג המטען");
      theForm.type.focus();
      return false;
   }
   regexp = /^[-+]?\d*\.?\d*$/;
   if (!regexp.test(theForm.weight.value))
   {
      mAlert("המשקל חייב להכיל רק ספרות");
      theForm.weight.focus();
      return false;
   }
   if (theForm.weight.value != "" && !(theForm.weight.value > 0))
   {
      mAlert("המשקל חייב להכיל רק ספרות");
      theForm.weight.focus();
      return false;
   }
   regexp = /^[-+]?\d*\.?\d*$/;
   if (!regexp.test(theForm.volume.value))
   {
      mAlert("הנפח חייב להכיל רק ספרות");
      theForm.volume.focus();
      return false;
   }
   if (theForm.volume.value != "" && !(theForm.volume.value > 0))
   {
      mAlert("הנפח חייב להכיל רק ספרות");
      theForm.volume.focus();
      return false;
   }
   regexp = /^[א-תA-Za-zÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿ \t\r\n\f0-9-,"]*$/;
   if (!regexp.test(theForm.source.value))
   {
      mAlert("המוצא יכול להכיל אותיות ספרות ורווחים");
      theForm.source.focus();
      return false;
   }
   if (theForm.source.value == "")
   {
      mAlert("המוצא יכול להכיל אותיות ספרות ורווחים");
      theForm.source.focus();
      return false;
   }
   if (theForm.loadingType.selectedIndex < 0)
   {
      mAlert("חובה לספק את סוג הטעינה");
      theForm.loadingType.focus();
      return false;
   }
   if (theForm.loadingType.selectedIndex == 0)
   {
      mAlert("חובה לספק את סוג הטעינה");
      theForm.loadingType.focus();
      return false;
   }
   if (theForm.downloadingType.selectedIndex < 0)
   {
      mAlert("חובה לספק את סוג הפריקה");
      theForm.downloadingType.focus();
      return false;
   }
   if (theForm.downloadingType.selectedIndex == 0)
   {
      mAlert("חובה לספק את סוג הפריקה");
      theForm.downloadingType.focus();
      return false;
   }
   regexp = /^[א-תA-Za-zÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿ \t\r\n\f0-9-,"]*$/;
   if (!regexp.test(theForm.destination.value))
   {
      mAlert("היעד יכול להכיל אותיות ספרות ורווחים");
      theForm.destination.focus();
      return false;
   }
   if (theForm.destination.value == "")
   {
      mAlert("היעד יכול להכיל אותיות ספרות ורווחים");
      theForm.destination.focus();
      return false;
   }
   regexp = /^[-+]?\d*\.?\d*$/;
   if (!regexp.test(theForm.suggestedQuote.value))
   {
      mAlert("המחיר חייב להכיל רק ספרות");
      theForm.suggestedQuote.focus();
      return false;
   }
   if (theForm.suggestedQuote.value == "")
   {
      mAlert("המחיר חייב להכיל רק ספרות");
      theForm.suggestedQuote.focus();
      return false;
   }
   if (theForm.suggestedQuote.value != "" && !(theForm.suggestedQuote.value > 0))
   {
      mAlert("המחיר חייב להכיל רק ספרות");
      theForm.suggestedQuote.focus();
      return false;
   }
   regexp = /^[-+]?\d*\.?\d*$/;
   if (!regexp.test(theForm.waitingTime.value))
   {
      mAlert("זמן המתנה חייב להכיל רק ספרות");
      theForm.waitingTime.focus();
      return false;
   }
   if (theForm.waitingTime.value != "" && !(theForm.waitingTime.value >= 0))
   {
      mAlert("זמן המתנה חייב להכיל רק ספרות");
      theForm.waitingTime.focus();
      return false;
   }
   regexp = /^[א-תA-Za-zÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿ \t\r\n\f0-9-]*$/;
   if (!regexp.test(theForm.comments.value))
   {
      mAlert("ההערות יכולות להכיל אותיות ספרות ורווחים");
      theForm.comments.focus();
      return false;
   }
   
   $('#loadPhoto1').val("");
   return true;
}
</script>

 <script type="text/javascript">
 $(function() {
       $( "#drivedate" ).datepicker();
       $( "#drivedate" ).datepicker( "option", "dateFormat", 'dd-mm-yy' );
       $( "#drivedate" ).datepicker( "option", "minDate", 0);
 });
 </script>

        <link type="text/css" rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500">
        <script src="/mapsapis"></script>
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

              autocomplete_cities_src = new google.maps.places.Autocomplete(
                  /** @type {HTMLInputElement} */(document.getElementById('source')),
                  { types: ['(cities)'] });
              google.maps.event.addListener(autocomplete_cities_src, 'place_changed', function() {
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

              autocomplete_cities_dest = new google.maps.places.Autocomplete(
                  /** @type {HTMLInputElement} */(document.getElementById('destination')),
                  { types: ['(cities)'] });
              google.maps.event.addListener(autocomplete_cities_dest, 'place_changed', function() {
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
<a href="/menu" data-role="button" class="ui-btn-left">חזרה</a>
<a href="/logout" data-role="button" class="ui-btn-right">יציאה</a>
</div>
<div class="ui-content" role="main">
<div id="wb_Form1" style="">
<form name="newloadForm" method="post" action="newload" enctype="multipart/form-data" data-ajax="false" data-transition="pop" id="newloadForm" style="display:inline;" onsubmit="return ValidateForm1(this)">
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
<div class="ui-field-contain">
	<label for="name">שם המטען</label>
	<input type="text" id="name" style="" name="name" value="">
</div><div class="ui-field-contain">
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
</div><div class="ui-field-contain">
	<label for="weight">משקל (ק"ג)</label>
	<input type="number" id="weight" style="" name="weight" value="">
</div><div class="ui-field-contain">
	<label for="volume">נפח (קוב)</label>
	<input type="number" id="volume" style="" name="volume" value="">
</div><div class="ui-field-contain">
	<label for="source">מוצא</label>
	<input type="text" id="source" style="" name="source" value="" placeholder="הכנס כתובת">
	<input type="hidden" id="sourceLat" name="sourceLat" value="">
	<input type="hidden" id="sourceLng" name="sourceLng" value="">
</div><div class="ui-field-contain">
	<label for="loadingType">סוג טעינה</label>
	<select name="loadingType" size="1" id="loadingType">
	<option>-- בחר --</option>
	<option value="MANUAL">ידני</option>
	<option value="FORKLIFT">מלגזה</option>
	<option value="CRANE">מנוף</option>
	<option value="RAMP">רמפה</option>
	<option value="TROLLY">עגלה</option>
	</select>
</div><div class="ui-field-contain">
	<label for="destination">יעד</label>
	<input type="text" id="destination" style="" name="destination" value="" placeholder="הכנס כתובת">
	<input type="hidden" id="destinationLat" name="destinationLat" value="">
	<input type="hidden" id="destinationLng" name="destinationLng" value="">
</div><div class="ui-field-contain">
	<label for="downloadingType">סוג פריקה</label>
	<select name="downloadingType" size="1" id="downloadingType">
	<option>-- בחר --</option>
	<option value="MANUAL">ידני</option>
	<option value="FORKLIFT">מלגזה</option>
	<option value="CRANE">מנוף</option>
	<option value="RAMP">רמפה</option>
	<option value="TROLLY">עגלה</option>
	</select>
</div><div class="ui-field-contain">
	<label for="drivedate">תאריך הובלה</label>
	<input type="text" id="drivedate" style="" name="drivedate" value="" onfocus="blur();">
</div><div class="ui-field-contain">
	<label for="suggestedQuote">מחיר (שקלים)</label>
	<input type="number" id="suggestedQuote" style="" name="suggestedQuote" value="">
</div><div class="ui-field-contain">
	<label for="waitingTime">זמן המתנה (שעות)</label>
	<input type="number" id="waitingTime" style="" name="waitingTime" value="">
</div><div class="ui-field-contain">
	<label for="comments">הערות</label>
	<input type="text" id="comments" style="" name="comments" value="">
</div><div class="ui-field-contain">
	<label for="loadPhoto1">צילום המטען</label>
	<input type="file" id="loadPhoto1" style="" name="loadPhoto1">
	<input type="hidden" id="loadPhoto" name="loadPhoto">
</div>
<input type="submit" id="Button1" name="" value="הוסף מטען">
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