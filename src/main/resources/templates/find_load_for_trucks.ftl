<html dir="rtl">
<head>
    <title>TraffiTruck</title>
	<meta charset="UTF-8">
	<link rel="stylesheet" type="text/css" href="/css/traffitruck.css">
		<script type="text/javascript" src="js/jquery-1.11.1.min.js"></script>
	
<script type="text/javascript">

		var selectedRow = null;
		
		function clickRowFunction(tr_id) {
      		
      		// revert the background color of the previously selected row
			if ( selectedRow != null ) {
				selectedRow.css('background-color', 'initial');
			}
			
			// change the background color of the newly selected row
			$("#"+tr_id).css('background-color', 'lightblue');
			selectedRow = $("#"+tr_id);
			
			// get the load details
			loadId = $("#"+tr_id).attr('id');
			licensePlateNumber = $("#truckSelection").val();
			$.getJSON( "/load_user_details/" + licensePlateNumber + "/" + loadId, function( loadAndUser ) {

				load = loadAndUser.load;
				user = loadAndUser.user;
			    table_html = "<table border='1'>";

			    table_html += "<tr>";
			    table_html += "    <td>איש קשר:</td>";
			    table_html += "    <td>" + ((user.contactPerson != null) ? user.contactPerson : "") + "</td>";
			    table_html += "</tr>";

			    table_html += "<tr>";
			    table_html += "    <td>מספר טלפון:</td>";
			    table_html += "    <td>" + ((user.phoneNumber != null) ? user.phoneNumber : "") + "</td>";
			    table_html += "</tr>";

			    table_html += "<tr>";
			    table_html += "    <td>מספר סלולרי:</td>";
			    table_html += "    <td>" + ((user.cellNumber != null) ? user.cellNumber : "") + "</td>";
			    table_html += "</tr>";

			    table_html += "<tr>";
			    table_html += "    <td>סוג המטען:</td>";
			    table_html += "    <td>" + ((load.type != null) ? convertType(load.type) : "") + "</td>";
			    table_html += "</tr>";

			    table_html += "<tr>";
			    table_html += "    <td>משקל (ק\"ג):</td>";
			    table_html += "    <td>" + ((load.weight != null) ? load.weight : "") + "</td>";
			    table_html += "</tr>";

			    table_html += "<tr>";
			    table_html += "    <td>נפח (קוב):</td>";
			    table_html += "    <td>" + ((load.volume) ? load.volume : "") + "</td>";
			    table_html += "</tr>";

			    table_html += "<tr>";
			    table_html += "    <td>מוצא:</td>";
			    table_html += "    <td>" + load.source + "</td>";
			    table_html += "</tr>";

			    table_html += "<tr>";
			    table_html += "    <td>סוג טעינה:</td>";
			    table_html += "    <td>" + ((load.loadingType != null) ? convertLiftType(load.loadingType) : "") + "</td>";
			    table_html += "</tr>";

			    table_html += "<tr>";
			    table_html += "    <td>יעד:</td>";
			    table_html += "    <td>" + load.destination + "</td>";
			    table_html += "</tr>";

			    table_html += "<tr>";
			    table_html += "    <td>סוג פריקה:</td>";
			    table_html += "    <td>" + ((load.downloadingType != null) ? convertLiftType(load.downloadingType) : "") + "</td>";
			    table_html += "</tr>";

			    table_html += "<tr>";
			    table_html += "    <td>מחיר:</td>";
			    table_html += "    <td>" + ((load.suggestedQuote != null) ? load.suggestedQuote : "") + "</td>";
			    table_html += "</tr>";

			    table_html += "<tr>";
			    table_html += "    <td>זמן המתנה (שעות):</td>";
			    table_html += "    <td>" + ((load.waitingTime != null) ? load.waitingTime : "") + "</td>";
			    table_html += "</tr>";
			    
			    table_html += "<tr>";
			    table_html += "    <td>הערות:</td>";
			    table_html += "    <td>" + ((load.comments != null) ? load.comments : "") + "</td>";
			    table_html += "</tr>";
			    
			    table_html += "</table>";
			    
     		   $('#load_details').html(table_html);
  			});

			// return false so the location won't change
			return false;
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

	
$(document).ready(function() {

	$("#truckSelection").change(function () {
			licensePlateNumber = $(this).val();
			$.getJSON( "/load_for_truck/" + licensePlateNumber, function( loads ) {

				if (loads.length == 0) {
				   $('#available_loads').html("אין מטענים להובלה שמתאימים למשאית");
				   return;
				}
				
			    table_html = "<table border='1'>";
			    table_html += "<tr><th>מוצא</th><th>יעד</th><th>סוג מטען</th><th>מחיר</th></tr>";

				for (var i in loads) {
				    load = loads[i];

				    table_html += "<tr id='" + load.id + "' onclick=\"return clickRowFunction('" + load.id + "')\">";
				    table_html += "    <td>" + load.source + "</td>";
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

</head>
<body>
<div id="main">
	<div id="title">
		<img src="/images/truck-blue.jpg" width="15%"/>
		<img src="/images/logo.jpg" width="20%"/>
	</div>
	<div id="body">
		<div id="sidebar">
			<p>&nbsp;</p>
		</div>
		<div id="content">
			<h2>חפש מטען</h2>
			<table>
				<tr> 
					<td>
						<a href="/">חזור לעמוד הראשי</a>
					</td>
				</tr>
				<tr> 
					<td>
						<#if trucks?has_content>
					
				        	<select name="truckSelection" id="truckSelection">
							  <#list trucks as truck>
								  <option value="${truck.licensePlateNumber}">${truck.licensePlateNumber}</option>
							  </#list>
							</select>
					
						<#else>
							אין משאיות מאושרות 
						</#if>
					</td>
				</tr>
				<tr>
				<td>&nbsp;</td>
				</tr>
			</table>
		</div>
		<div id="available_loads">
		</div>
		<div id="load_details">
		</div>
	</div>
</div>
</body>
</html>