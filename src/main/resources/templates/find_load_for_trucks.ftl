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
<script src="js/jquery-1.11.3.min.js"></script>

     <link rel="stylesheet" href="css/jquery-ui-1.11.1.css">
	<script type="text/javascript" src="js/jquery-ui-1.11.1.js"></script>

<script>
$(document).on("mobileinit", function()
{
   $.mobile.ajaxEnabled = false;
});
</script>
<script type="text/javascript">
$(document).ready(function() {

function mAlert(text1) {
  $("#sure .sure-1").text(text1);
  $("#sure .sure-do").on("click.sure", function() {
    $(this).off("click.sure");
  });
  $.mobile.changePage("#sure");
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


	$("#truckSelection").change(function () {
			licensePlateNumber = $(this).val();
			$.getJSON( "/load_for_truck/" + licensePlateNumber, function( loads ) {

				if (loads.length == 0) {
				   $('#available_loads').html("אין מטענים להובלה שמתאימים למשאית");
				   return;
				}
				
			    table_html = '<table data-role="table" class="table-stripe ui-responsive">';
			    table_html += "<thead><tr><th>מוצא</th><th>יעד</th><th>סוג מטען</th><th>מחיר</th></tr></thead>";

				for (var i in loads) {
				    load = loads[i];

				    table_html += "<tr>";
				    table_html += "    <td><a href='/load_details_for_trucker/" + load.id + "'>" + load.source + "</a></td>";
				    table_html += "    <td>" + load.destination + "</td>";
				    table_html += "    <td>" + ((load.type != null) ? convertType(load.type) : "") + "</td>";
				    table_html += "    <td>" + ((load.suggestedQuote != null) ? load.suggestedQuote : "") + "</td>";
				    table_html += "</tr>";
			    }
			    
			    table_html += "</table>";

     		   $('#available_loads').html(table_html);
  			});
    });

	$("#truckSelection").trigger("change");

	$( "#radiusFilter" ).click(function() {
			licensePlateNumber = $("#truckSelection").val();
			sourceLat = $("#sourceLat").val();
			sourceLng = $("#sourceLng").val();
			destinationLat = $("#destinationLat").val();
			destinationLng = $("#destinationLng").val();
			source_radius = $("#source_radius").val();
			destination_radius = $("#destination_radius").val();

			$.post( "/load_for_truck_by_radius",
				{
					licensePlateNumber: licensePlateNumber,
					sourceLat: sourceLat,
					sourceLng: sourceLng,
					destinationLat: destinationLat,
					destinationLng: destinationLng,
					source_radius: source_radius, 
					destination_radius: destination_radius,
					${_csrf.parameterName}: "${_csrf.token}"
				} 
				, function( loads ) {

				if (loads.length == 0) {
				   $('#available_loads').html("אין מטענים להובלה שמתאימים למשאית");
				   return;
				}
				
			    table_html = '<table data-role="table" class="table-stripe ui-responsive">';
			    table_html += "<thead><tr><th>מוצא</th><th>יעד</th><th>סוג מטען</th><th>מחיר</th></tr></thead>";

				for (var i in loads) {
				    load = loads[i];

				    table_html += "<tr>";
				    table_html += "    <td><a href='/load_details_for_trucker/" + load.id + "'>" + load.source + "</a></td>";
				    table_html += "    <td>" + load.destination + "</td>";
				    table_html += "    <td>" + ((load.type != null) ? convertType(load.type) : "") + "</td>";
				    table_html += "    <td>" + ((load.suggestedQuote != null) ? load.suggestedQuote : "") + "</td>";
				    table_html += "</tr>";
			    }
			    
			    table_html += "</table>";

     		   $('#available_loads').html(table_html);
  			}, "json");
	});

});
</script>

<script src="js/jquery.mobile-1.4.5.min.js"></script>

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
            }
        </script>

</head>
<body onload="initialize()">
<div data-role="page" data-theme="a" data-title="המטענים שלי" id="loads">
<div data-role="header" id="Header1">
<h1>חיפוש מטען</h1>
<a href="/truckerMenu" data-role="button" class="ui-btn-left">חזרה</a>
<a href="/logout" data-role="button" class="ui-btn-right">יציאה</a>
</div>
<div class="ui-content" role="main">

						<#if trucks?has_content>
							<div class="ui-field-contain">
								<#if (trucks?size > 1)>
									<label for="truckSelection">בחר משאית</label>
						        	<select name="truckSelection" id="truckSelection">
									  <#list trucks as truck>
										  <option value="${truck.licensePlateNumber}">${truck.licensePlateNumber}</option>
									  </#list>
									</select>
								<#else>
									<input type="hidden" name="truckSelection" id="truckSelection" value="${trucks[0].licensePlateNumber}">
								</#if>
							</div>
							<div class="ui-field-contain">
								<label for="source">חפש ליד מוצא</label>
								<input type="text" id="source" style="" name="source" value="" placeholder="הכנס כתובת">
								<label for="source_radius">מרחק בק"מ</label>
								<input type="text" id="source_radius" style="" name="source_radius" value="">
								<input type="hidden" id="sourceLat" name="sourceLat" value="">
								<input type="hidden" id="sourceLng" name="sourceLng" value="">
							</div>
							<div class="ui-field-contain">
								<label for="source">חפש ליד יעד</label>
								<input type="text" id="destination" style="" name="destination" value="" placeholder="הכנס כתובת">
								<label for="destination_radius">מרחק בק"מ</label>
								<input type="text" id="destination_radius" style="" name="destination_radius" value="">
								<input type="hidden" id="destinationLat" name="destinationLat" value="">
								<input type="hidden" id="destinationLng" name="destinationLng" value="">
							</div>
							<button type="button" data-role="button" class="ui-btn" id="radiusFilter" name="radiusFilter">חפש לפי מרחק</button>
						<#else>
							אין משאיות מאושרות 
						</#if>
		<div id="available_loads">
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