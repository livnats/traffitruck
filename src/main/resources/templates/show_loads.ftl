<html dir="rtl">
	<head>
	    <title>TraffiTruck</title>
		<meta charset="UTF-8">
		<link rel="stylesheet" type="text/css" href="/css/traffitruck.css">
		<script type="text/javascript" src="js/jquery-1.11.1.min.js"></script>

<script>

	function deleteLoad(loadId){
		$.post(
			"/deleteLoadAdmin",
			{
				loadId: loadId,
				${_csrf.parameterName}: "${_csrf.token}"
			} 
		);
		$('#load_details').html("");
		$("#"+loadId).remove();
	}
	
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
		if ( type == "${enums["com.traffitruck.domain.LiftType"].CONTAINER}" )
			return "מכולה";
		return type;
	}

	$( ".typeConversion" ).each(function() {
	  $(this).html(convertType($(this).html()));
	});


		var selectedRow = null;
      $(".clickableRow").click(function() {
      		
      		// revert the background color of the previously selected row
			if ( selectedRow != null ) {
				selectedRow.css('background-color', 'initial');
			}
			
			// change the background color of the newly selected row
			$(this).css('background-color', 'lightblue');
			selectedRow = $(this);
			
			// get the load details
			loadId = $(this).attr('id');
			$.getJSON( "/load_details_json/" + loadId, function( load ) {

			    table_html = "<table border='1'>";

			    table_html += "<tr>";
			    table_html += "    <td>בעל המטען:</td>";
			    table_html += "    <td>" + ((load.username != null) ? load.username : "") + "</td>";
			    table_html += "</tr>";

			    table_html += "<tr>";
			    table_html += "    <td>שם המטען:</td>";
			    table_html += "    <td>" + ((load.name != null) ? load.name : "") + "</td>";
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
			    
			    if (load.hasPhoto) {
				    table_html += "<tr>";
				    table_html += "    <td>תמונה:</td>";
				    table_html += "    <td><img src='/load/image/" + load.id + "'></td>";
				    table_html += "</tr>";
			    }
			    
			    table_html += "<tr>";
			    table_html += "    <td>הסר</td>";
			    table_html += "    <td style='text-align:right'>";
			    table_html += "       <a href='#' onclick=\"return deleteLoad('" + load.id + "')\"><img src='/images/remove-icon-png-26.png' width='20px' ></a>";
			    table_html += "    </td>";
			    table_html += "</tr>";
   										
			    
			    table_html += "</table>";

     		   $('#load_details').html(table_html);
  			}, "json");

			// return false so the location won't change
			return false;
      });
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
				<h2>מטענים במערכת</h2>
				<table border="0">
					<tr> 
						<td>
							<a href="/adminMenu">חזור לעמוד הראשי</a>
						</td>
					</tr>
					<tr> 
						<td>
							<#if loads?has_content>
						
									<table border="1">
										<tr>
											<th>שם</th>
											<th>מוצא</th>
											<th>יעד</th>
											<th>סוג מטען</th>
											<th>מחיר</th>
											<th>תאריך יצירה</th>
											<th>תאריך זמינות להובלה</th>
										</tr>
										<#list loads as load>
										<tr id="${load.id}" class="clickableRow">
											<td><a href="#">${load.name!'---'}</a></td>
											<td>${Format.address(load.source)!''}</td>
											<td>${Format.address(load.destination)!''}</td>
											<td class="typeConversion">${load.type!'לא נמסר'}</td>
											<td>${load.suggestedQuote!'לא נמסר'}</td>
											<td>${load.creationDate?string("dd-MM-yyyy")!''}</td>
											<td>${load.driveDate?string("dd-MM-yyyy")!''}</td>
										</tr>
										</#list>
									</table>
						
							<#else>
								אין מטענים להציג :(
							</#if>
						</td>
					</tr>
					<tr>
					<td>&nbsp;</td>
					</tr>
				</table>
			</div>
			<div id="load_details">
			</div>
		</div>
	</div>
	</body>
</html>
