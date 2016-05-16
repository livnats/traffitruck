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
<script>
$(document).on("mobileinit", function()
{
   $.mobile.ajaxEnabled = false;
});
</script>
<script type="text/javascript">
$(document).ready(function() {

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

});
</script>

<script src="js/jquery.mobile-1.4.5.min.js"></script>

</head>
<body>
<div data-role="page" data-theme="a" data-title="המטענים שלי" id="loads">
<div data-role="header" id="Header1">
<h1>חיפוש מטען</h1>
<a href="/truckerMenu" data-role="button" class="ui-btn-left">חזרה</a>
<a href="/logout" data-role="button" class="ui-btn-right">יציאה</a>
</div>
<div class="ui-content" role="main">

						<#if trucks?has_content>
							<label for="truckSelection">בחר משאית</label>
				        	<select name="truckSelection" id="truckSelection">
							  <#list trucks as truck>
								  <option value="${truck.licensePlateNumber}">${truck.licensePlateNumber}</option>
							  </#list>
							</select>
						<#else>
							אין משאיות מאושרות 
						</#if>
		<div id="available_loads">
		</div>
</div>
</div>
</body>
</html>