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
   if ((theForm.source.value == "") && (theForm.destination.value == ""))
   {
      mAlert("חובה למלא שדה אחד לפחות כדי לצור התראה");
      return false;
   }
   
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

	<style>
		.ui-btn {
			border-bottom-width: 2px !important; 
			border-left-width: 0px !important; 
			border-right-width: 0px !important; 
			border-color:rgb(0,128,255) !important;
		}
		
		.ui-btn-active{
			background-color:rgb(0,128,255) !important;
			border-color:white !important;
		}
	
		.ui-icon-notifications {background:  url(/images/Bell.png) 50% 25% no-repeat; background-size: 18px 18px;}
		.ui-icon-truck {background:  url(/images/truck-navbar.png) 50% 25% no-repeat; background-size: 18px 18px;}
		.ui-icon-search { 50% 50% no-repeat; background-size: 18px 18px;}
		.ui-icon-loads {background:  url(/images/trolley.png) 50% 25% no-repeat; background-size: 18px 18px;}
		.ui-icon-notifications:hover {border-color:white !important;}
		.ui-icon-truck:hover {border-color:#DADADA !important;}
		.ui-icon-search:hover {border-color:#DADADA!important;}
		.ui-icon-loads:hover {border-color:#DADADA!important;}
		.ui-icon-bars:hover {border-color:#DADADA!important;}
		
	</style>
	
</head>
<body onload="initialize()">
<div data-role="page" data-theme="a" data-title="צור התראה" id="add_alert">

<div data-role="header" id="Header1">
	<img src="/images/logo.jpg" width="20%" style="margin-bottom:15; margin-left:10"/>
	<img src="/images/truck-blue.jpg" width="15%"/>
	<div data-role="navbar">
	  <ul>
	    <li><a href="#mypanel" class="ui-nodisc-icon" data-icon="bars"></a></li>
   		<li><a href="/myAlerts" class="ui-nodisc-icon ui-btn-active ui-state-persist" data-icon="notifications" ></a></li>
  		<li><a href="/myTrucks" class="ui-nodisc-icon" data-icon="truck"></a></li>
    	<li><a href="/findTrucksForLoad" class="ui-nodisc-icon" data-icon="search"></a></li>
	  	<#if (isLoadsOwner)>
	    	<li><a href="/myLoads" class="ui-nodisc-icon" data-icon="loads"></a></li>
		</#if>
	  </ul>
	</div> <!--/navbar-->
</div> <!--/header-->

	<div class="ui-content" role="main">
		<span style="color:#3388cc;" > <b> צור התראה </b></span></br> &nbsp
		<div id="wb_Form1" style="">
			
			<form name="newAlertForm" method="post" action="newAlert" data-ajax="false" data-transition="pop" id="newAlertForm" style="display:inline;" onsubmit="return ValidateForm1(this)">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
			<span style="font-size:0.8em;">התראה מתקבלת לטלפון כאשר יש מטען חדש העונה להגדרות מוצא, יעד ותאריך, כפי שהוגדרו בהתראה. </span><br/><br/>
			<span style="font-size:0.8em; font-weight:bold; color:#005599"> אף שדה אינו חובה אך צריך למלא לפחות שדה אחד</span>
			<div class="ui-field-contain">
				<label for="source">מטענים שיוצאים מאיזור</label>
				<input type="text" id="source" name="source" value="" placeholder="הכנס כתובת" style="text-align:right; direction:rtl">
				<input type="hidden" id="sourceLat" name="sourceLat" value="">
				<input type="hidden" id="sourceLng" name="sourceLng" value="">
			</div>
			<div class="ui-field-contain">
				<label for="source">מטענים שמגיעים לאיזור</label>
				<input type="text" id="destination" name="destination" value="" placeholder="הכנס כתובת" style="text-align:right; direction:rtl">
				<input type="hidden" id="destinationLat" name="destinationLat" value="">
				<input type="hidden" id="destinationLng" name="destinationLng" value="">
			</div>
			<input type="submit" id="Button1" name="" value="צור התראה">
			</form>
		</div>
	</div>
	
	<div data-role="panel" id="mypanel" data-display="overlay" data-position="left">
		<ul data-role="listview" style='text-align:right;'>
			<li data-icon="power"><a href="/logout" style="text-align:right; font-size:0.8em;"> התנתק</a></li>
		</ul>
	</div><!-- /panel -->	
	
</div> <!-- page -->

<div data-role="dialog" id="sure">
  <div data-role="content">
    <h3 class="sure-1">???</h3>
    <a href="#" class="sure-do" data-role="button" data-theme="b" data-rel="back">סגור</a>
  </div>
</div>

<script src="/mapsapis"></script>

</body>
</html>