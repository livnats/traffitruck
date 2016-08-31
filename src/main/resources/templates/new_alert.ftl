<html dir="rtl">
<head>
<meta charset="utf-8">
<title>טראפי-טראק - צור התראה</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="js/default/jquery.mobile.theme-1.4.5.css" rel="stylesheet">
<link href="js/default/jquery.mobile.icons-1.4.5.min.css" rel="stylesheet">
<link href="css/jquery.mobile.structure-1.4.5.min.css" rel="stylesheet">
<link href="css/mobile.css" rel="stylesheet">
<link href="css/add_truck.css" rel="stylesheet">
<script src="js/jquery-1.11.3.min.js"></script>
<link rel="stylesheet" href="css/jquery-ui-1.11.1.css">
<script type="text/javascript" src="js/jquery-ui-1.11.1.js"></script>

<script>
$(document).on("mobileinit", function()
{
   $.mobile.ajaxEnabled = false;
});

$(document).ready(function() {
	$( "#drivedate" ).datepicker();
	$( "#drivedate" ).datepicker( "option", "dateFormat", 'dd-mm-yy' );       
	$( "#drivedate" ).datepicker( "option", "minDate", 0);
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
   regexp = /^\d*$/;
   if (!regexp.test(theForm.licensePlateNumber.value))
   {
      mAlert("לוחית רישוי יכולה להכיל רק ספרות");
      theForm.licensePlateNumber.focus();
      return false;
   }
   if (theForm.licensePlateNumber.value == "")
   {
      mAlert("חובה לספק מספר לוחית רישוי");
      theForm.licensePlateNumber.focus();
      return false;
   }
   
   $('#vehicleLicensePhoto1').val("");
   $('#driverLicensePhoto1').val("");
   $('#truckPhoto1').val("");
   
   return true;
}

    function initialize() {

		if ( sessionStorage['filter'] == "true" ) {
		    $("#truckSelection option[value='" + sessionStorage['licensePlateNumber'] + "']").prop("selected", "selected").change();
			$("#source").val(sessionStorage['source']);
			$("#sourceLat").val(sessionStorage['sourceLat']);
			$("#sourceLng").val(sessionStorage['sourceLng']);
			$("#destination").val(sessionStorage['destination']);
			$("#destinationLat").val(sessionStorage['destinationLat']);
			$("#destinationLng").val(sessionStorage['destinationLng']);
			$("#drivedate").val(sessionStorage['drivedate']);
			$( "#radiusFilter" ).click();
		}

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
               mAlert('Geocode was not successful for the following reason: ' + status);
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
               mAlert('Geocode was not successful for the following reason: ' + status);
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
               mAlert('Geocode was not successful for the following reason: ' + status);
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
               mAlert('Geocode was not successful for the following reason: ' + status);
            }
          })
      });
    }

</script>
</head>
<body onload="initialize()">
<div data-role="page" data-theme="a" data-title="צור התראה" id="add_alert">
	<div data-role="header" id="Header1">
		<h1>צור התראה</h1>
		<a href="/myAlerts" data-role="button" class="ui-btn-left">חזרה</a>
		<a href="/logout" data-role="button" class="ui-btn-right">יציאה</a>
	</div>
	<div class="ui-content" role="main">
		<div id="wb_Form1" style="">
			
			<form name="newAlertForm" method="post" action="newAlert" data-ajax="false" data-transition="pop" id="newAlertForm" style="display:inline;" onsubmit="return ValidateForm1(this)">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
			<div class="ui-field-contain">
				<label for="source">מטענים שיוצאים מאיזור</label>
				<input type="text" id="source" name="source" value="" placeholder="הכנס כתובת" style="text-align:right">
				<input type="hidden" id="sourceLat" name="sourceLat" value="">
				<input type="hidden" id="sourceLng" name="sourceLng" value="">
			</div>
			<div class="ui-field-contain">
				<label for="source">מטענים שמגיעים לאיזור</label>
				<input type="text" id="destination" name="destination" value="" placeholder="הכנס כתובת" style="text-align:right">
				<input type="hidden" id="destinationLat" name="destinationLat" value="">
				<input type="hidden" id="destinationLng" name="destinationLng" value="">
			</div>
			<div class="ui-field-contain">
				<label for="drivedate">תאריך הובלה</label>
				<input type="text" id="drivedate" name="drivedate" value="" onfocus="blur();" style="text-align:right">
			</div>
			<input type="submit" id="Button1" name="" value="צור התראה">
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

<script src="https://maps.googleapis.com/maps/api/js?libraries=places&language=iw&region=IL"></script>

</body>
</html>