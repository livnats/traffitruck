<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>טראפי-טראק - חיפוש מטענים</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="js/default/jquery.mobile.theme-1.4.5.css" rel="stylesheet">
<link href="js/default/jquery.mobile.icons-1.4.5.min.css" rel="stylesheet">
<link href="css/jquery.mobile.structure-1.4.5.min.css" rel="stylesheet">
<link href="css/mobile.css" rel="stylesheet">
<link href="css/loads.css" rel="stylesheet">
<link type="text/css" rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500">

<script src="js/jquery-1.11.3.min.js"></script>

     <link rel="stylesheet" href="css/jquery-ui-1.11.1.css">
	<script type="text/javascript" src="js/jquery-ui-1.11.1.js"></script>

<script>

// show on map markers
var markers;
var infoWindowContent;
var map;

$(document).on("mobileinit", function()
{
   $.mobile.ajaxEnabled = false;
});
</script>
<script type="text/javascript">
$(document).ready(function() {

$( "#drivedate" ).datepicker();
$( "#drivedate" ).datepicker( "option", "dateFormat", 'dd-mm-yy' );       
$( "#drivedate" ).datepicker( "option", "minDate", 0);

	$("#truckSelection").change(function() {
	    if ( $("#truckSelection").val() != "" ) {
	       $("#searchfilter").show();
	       $("#available_loads").show();
	       $("#map_canvas").show();
		   fetchLoads();
		}
		else {
	       $("#searchfilter").hide();
	       $("#available_loads").hide();
	       $("#map_canvas").hide();
		}
	});
	$("#radiusFilter").click(function() {
		fetchLoads();
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

	function createAlert() {
		source = $("#source").val();
		sourceLat = $("#sourceLat").val();
		sourceLng = $("#sourceLng").val();
		destination = $("#destination").val();
		destinationLat = $("#destinationLat").val();
		destinationLng = $("#destinationLng").val();
		drivedate = $("#drivedate").val();
		$.post(
			"/alertFromFilter",
			{
				source: source,
				sourceLat: sourceLat,
				sourceLng: sourceLng,
				destination: destination,
				destinationLat: destinationLat,
				destinationLng: destinationLng,
				drivedate: drivedate,
				${_csrf.parameterName}: "${_csrf.token}"
			}, 
			function() {
				mAlert("ההתראה נוצרה בהצלחה")
  			});
	}
	
	function convertType(type) {
		if ( type == "${enums["com.traffitruck.domain.LoadType"].CONTAINER_20}" )
			return "מכולה 20'";
		if ( type == "${enums["com.traffitruck.domain.LoadType"].CONTAINER_40}" )
			return "מכולה 40'";
		if ( type == "${enums["com.traffitruck.domain.LoadType"].LIFTS}" )
			return "משטחים";
		if ( type == "${enums["com.traffitruck.domain.LoadType"].BAGS}" )
			return "שקים (באלות)";
		if ( type == "${enums["com.traffitruck.domain.LoadType"].ANIMALS}" )
			return "בעלי חיים";
		if ( type == "${enums["com.traffitruck.domain.LoadType"].SCATTERED}" )
			return "תפזורת";
		if ( type == "${enums["com.traffitruck.domain.LoadType"].HAZMAT}" )
			return 'חומ"ס';
		if ( type == "${enums["com.traffitruck.domain.LoadType"].OTHER}" )
			return "אחר";
		return type;
	}

	function convertLiftType(type) {
		if ( type == "${enums["com.traffitruck.domain.LiftType"].MANUAL}" )
			return "ידני";
		if ( type == "${enums["com.traffitruck.domain.LiftType"].FORKLIFT}" )
			return "מלגזה";
		if ( type == "${enums["com.traffitruck.domain.LiftType"].CRANE}" )
			return "מנוף";
		if ( type == "${enums["com.traffitruck.domain.LiftType"].RAMP}" )
			return "רמפה";
		if ( type == "${enums["com.traffitruck.domain.LiftType"].TROLLY}" )
			return "עגלה";
		return type;
	}

	function fetchLoads() {
	
			$('#searchfilter').collapsible('collapse');
			licensePlateNumber = $("#truckSelection").val();
			sourceLat = $("#sourceLat").val();
			sourceLng = $("#sourceLng").val();
			destinationLat = $("#destinationLat").val();
			destinationLng = $("#destinationLng").val();
			drivedate = $("#drivedate").val();

			localStorage['filter'] = "true";
			localStorage['licensePlateNumber'] = licensePlateNumber;
			localStorage['source'] = $("#source").val();
			localStorage['destination'] = $("#destination").val();
			localStorage['sourceLat'] = sourceLat;
			localStorage['sourceLng'] = sourceLng;
			localStorage['destinationLat'] = destinationLat;
			localStorage['destinationLng'] = destinationLng;
			localStorage['drivedate'] = drivedate;

			$.post( "/load_for_truck_by_radius",
				{
					licensePlateNumber: licensePlateNumber,
					sourceLat: sourceLat,
					sourceLng: sourceLng,
					destinationLat: destinationLat,
					destinationLng: destinationLng,
					drivedate: drivedate,
					${_csrf.parameterName}: "${_csrf.token}"
				} 
				, function( loads ) {
	
				// Multiple Markers
				markers = [];
				infoWindowContent = [];
				if (loads.length == 0) {
				   $('#available_loads').html("אין מטענים להובלה שמתאימים למשאית");
				    showOnMap();
				   return;
				}
				
			    table_html = '<table data-role="table" class="table-stripe ui-responsive" style="direction:RTL">';
			    table_html += '<thead><tr><th style="text-align:right">מוצא</th><th style="text-align:right">יעד</th><th style="text-align:right">סוג מטען</th><th style="text-align:right">מחיר</th><th style="text-align:right">תאריך נסיעה</th></tr></thead>';

				for (var i in loads) {
				    load = loads[i];

				    table_html += "<tr>";
				    table_html += "    <td style=\"text-align:right\"><a href='/load_details_for_trucker/" + load.id + "'>" + load.source.split(",",2).join(", ") + "</a></td>";
				    table_html += "    <td style=\"text-align:right\">" + load.destination.split(",",2).join(", ") + "</td>";
				    table_html += "    <td style=\"text-align:right\">" + ((load.type != null) ? convertType(load.type) : "") + "</td>";
				    table_html += "    <td style=\"text-align:right\">" + ((load.suggestedQuote != null) ? load.suggestedQuote : "") + "</td>";
				    table_html += "    <td style=\"text-align:right\">" + ((load.driveDate != null) ? load.driveDateStr : "") + "</td>";
				    table_html += "</tr>";

					
					markers.push([load.name, load.sourceLocation.coordinates[1], load.sourceLocation.coordinates[0]]);
					infoWindowContent.push(
						['<div class="info_content" dir="rtl"><h5>יעד: ' + load.destination.split(",",2).join(", ") + '</h5>'
						+ '<h5>סוג מטען: ' + ((load.type != null) ? convertType(load.type) : "") + '</h5>'
						+ '<h5>מחיר: ' + ((load.suggestedQuote != null) ? load.suggestedQuote : "") + '</h5>'
						+ '<h5>תאריך נסיעה: ' + ((load.driveDate != null) ? load.driveDateStr : "") + '</h5>'
						+ '<h5><a href="/load_details_for_trucker/' + load.id + '">פרטים נוספים</a></h5>'
						+ '</div>']);
			    }
			    table_html += "</table>";
     		   $('#available_loads').html(table_html);
     		   showOnMap();
     		   
  			}, "json");
	}


	function showOnMap() {

		var bounds = new google.maps.LatLngBounds();
		var mapOptions = {
			mapTypeId: 'roadmap'
		};
		
		document.getElementById("map_canvas").style.height = ( $(document).height() / 2.5 ) + "px";

		// Display a map on the page
		var map = new google.maps.Map(document.getElementById("map_canvas"), mapOptions);
		map.setTilt(45);
			
		// Display multiple markers on a map
		var infoWindow = new google.maps.InfoWindow(), marker, i;
		
		// Loop through our array of markers & place each one on the map  
		for( i = 0; i < markers.length; i++ ) {
			var position = new google.maps.LatLng(markers[i][1], markers[i][2]);
			bounds.extend(position);
			marker = new google.maps.Marker({
				position: position,
				map: map,
				title: markers[i][0]
			});
			
			// Allow each marker to have an info window    
			google.maps.event.addListener(marker, 'click', (function(marker, i) {
				return function() {
					infoWindow.setContent(infoWindowContent[i][0]);
					infoWindow.open(map, marker);
				}
			})(marker, i));

			// Automatically center the map fitting all markers on the screen
			map.fitBounds(bounds);
		}

		// Override our map zoom level once our fitBounds function runs (Make sure it only runs once)
		var boundsListener = google.maps.event.addListener((map), 'bounds_changed', function(event) {
			google.maps.event.removeListener(boundsListener);
		});
		
	}

	function clearForm() {
		$("#source").val('');
		$("#sourceLat").val('');
		$("#sourceLng").val('');
		$("#destination").val('');
		$("#destinationLat").val('');
		$("#destinationLng").val('');
		$("#drivedate").val('');
	}
	
    var autocomplete;
    function initialize() {

		if ( localStorage['filter'] == "true" ) {
			$("#source").val(localStorage['source']);
			$("#sourceLat").val(localStorage['sourceLat']);
			$("#sourceLng").val(localStorage['sourceLng']);
			$("#destination").val(localStorage['destination']);
			$("#destinationLat").val(localStorage['destinationLat']);
			$("#destinationLng").val(localStorage['destinationLng']);
			$("#drivedate").val(localStorage['drivedate']);
		    $("#truckSelection option[value='" + localStorage['licensePlateNumber'] + "']").prop("selected", "selected").change();
			$( "#radiusFilter" ).click();
		}
		else if ( $("#truckSelection").val() != "" ) {
			$( "#radiusFilter" ).click();
		}
		else {
			$("#truckSelection").change();
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
<div data-role="page" data-theme="a" data-title="המטענים שלי" id="loads">
<div data-role="header" id="Header1">
	<img src="/images/logo.jpg" width="20%" style="margin-bottom:15; margin-left:10"/>
	<img src="/images/truck-blue.jpg" width="15%"/>
	<a href="/logout" data-role="button" class="ui-btn-right">יציאה</a>
	<div data-role="navbar">
	  <ul>
   		<li><a href="/myAlerts">ההתראות שלי</a></li>
  		<li><a href="/myTrucks">המשאיות שלי</a></li>
    	<li><a href="/findTrucksForLoad" class="ui-btn-active ui-state-persist"> חפש מטענים להובלה</a></li>
	  	<#if (isLoadsOwner??)>
	    	<li><a href="/myLoads">המטענים שלי</a></li>
		</#if>
	  </ul>
	</div> <!--/navbar-->
</div> <!--/header-->

<div class="ui-content" role="main">

		<div class="ui-field-contain">
			<#if (trucks?size > 1)>
	        	<select name="truckSelection" id="truckSelection">
	        	  <option value="">בחר משאית</option>
				  <#list trucks as truck>
					  <option value="${truck.licensePlateNumber}">${truck.licensePlateNumber}</option>
				  </#list>
				</select>
			<#else>
				<input type="hidden" name="truckSelection" id="truckSelection" value="${trucks[0].licensePlateNumber}">
			</#if>
		</div>
		<div id="searchfilter" data-role="collapsible" data-collapsed="true">
						<#if trucks?has_content>
							<h3>סנן תוצאות</h3>
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
							<div>
								<a href="#" onclick="clearForm()" data-role="none" style="font-weight:bold; font-size:0.8em; margin-left: 25px;">נקה פילטר</a>
								<span> |</span>
								<a href="#" onclick="return createAlert()" data-role="none" style="font-weight:bold; font-size:0.8em; margin-right: 25px;">צור התראה</a>
							</div>
							<button type="button" data-role="button" id="radiusFilter" name="radiusFilter">הצג תוצאות</button>
						<#else>
							אין משאיות מאושרות 
						</#if>
		</div>
		<div id="available_loads" style="direction:RTL">
		</div>
</div>

<div id="map_canvas" class="mapping"></div>

</div>

<div data-role="dialog" id="sure">
  <div data-role="content">
    <h3 class="sure-1">???</h3>
    <a href="#" class="sure-do" data-role="button" data-theme="b" data-rel="back">סגור</a>
  </div>
</div>

<script src="/mapsapis"></script>

</body>
</html>