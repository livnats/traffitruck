<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>טראפי-טראק - פרטי מטען</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="/js/default/jquery.mobile.theme-1.4.5.css" rel="stylesheet">
<link href="/js/default/jquery.mobile.icons-1.4.5.min.css" rel="stylesheet">
<link href="/css/jquery.mobile.structure-1.4.5.min.css" rel="stylesheet">
<link href="/css/mobile.css" rel="stylesheet">
<link href="/css/load_details.css" rel="stylesheet">
<script src="/js/jquery-1.11.3.min.js"></script>
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
		if ( type == "${enums["com.traffitruck.domain.LiftType"].CONTAINER}" )
			return "מכולה";
		return type;
	}

	$( ".typeConversion" ).each(function() {
	  $(this).html(convertType($(this).html()));
	});
	$( ".liftTypeConversion" ).each(function() {
	  $(this).html(convertLiftType($(this).html()));
	});
});
</script>

<script src="/js/jquery.mobile-1.4.5.min.js"></script>

<style>
@media ( min-width: 10em ) {
    /* Show the table header rows and set all cells to display: table-cell */
    .my-custom-breakpoint td,
    .my-custom-breakpoint th,
    .my-custom-breakpoint tbody th,
    .my-custom-breakpoint tbody td,
    .my-custom-breakpoint thead td,
    .my-custom-breakpoint thead th {
        display: table-cell;
        margin: 0;
    }
    /* Hide the labels in each cell */
    .my-custom-breakpoint td .ui-table-cell-label,
    .my-custom-breakpoint th .ui-table-cell-label {
        display: none;
    }
}
</style>

</head>
<body dir="rtl">
<div data-role="page" data-theme="a" data-title="פרטי מטען" id="load_details">
<div data-role="header" id="Header1">
<h1>פרטי מטען</h1>
<a href="/findTrucksForLoad" data-role="button" class="ui-btn-left">חזרה</a>
</div>
<div class="ui-content" role="main">

<table data-role="table" class="table-stroke my-custom-breakpoint" style="direction:RTL">
      <thead>
        <tr>
          <th></th>
          <th></th>
        </tr>
      </thead>
<tbody>
<#if loadsUser.contactPerson??>
	<tr>
	    <th style="text-align:right">איש קשר:</th>
	<#if allowedLoadDetails>
	    <td style="text-align:right">${loadsUser.contactPerson!''}</td>
	<#else>
		<td style="text-align:right; font-weight:bold">נא לרשום משאית לשירות כדי לקבל פרטי איש קשר</td>
	</#if>	
	</tr>
</#if>
<tr>
    <th style="text-align:right">מספר ליצירת קשר:</th>
	<#if allowedLoadDetails>
		<#if loadsUser.phoneNumber??>
		    <td style="text-align:right"><a href="tel:${loadsUser.phoneNumber}">${loadsUser.phoneNumber}</a></td>
		<#else>
		    <td></td>
		</#if>
	<#else>
		<td style="text-align:right; font-weight:bold">נא לרשום משאית לשירות כדי לקבל פרטי התקשרות</td>
	</#if>	
</tr>
<tr>
    <th style="text-align:right">שם המטען:</th>
    <td style="text-align:right">${load.name!''}</td>
</tr>
<tr>
    <th style="text-align:right">סוג המטען:</th>
    <td style="text-align:right" class="typeConversion">${load.type!''}</td>
</tr>
<#if load.quantity??>
<tr>
    <th style="text-align:right">כמות:</th>
    <td style="text-align:right" class="typeConversion">${load.quantity!''}</td>
</tr>
</#if>
<tr>
    <th style="text-align:right">משקל (ק"ג):</th>
    <td style="text-align:right">${load.weight!''}</td>
</tr>
<tr>
    <th style="text-align:right">נפח (קוב):</th>
    <td style="text-align:right">${load.volume!''}</td>
</tr>
<tr>
    <th style="text-align:right">מוצא:</th>
    <td style="text-align:right">
		<#if load.sourceLocation??>
			${Format.address(load.source)!''}
			<#if allowedLoadDetails>
				<a href="waze://?ll=${load.sourceLocation.coordinates[1]},${load.sourceLocation.coordinates[0]}" target="_blank"><img src="/images/waze_app_icon_small.png" width="30px"></a>
				<a href="http://maps.google.com/maps?q=loc:${load.sourceLocation.coordinates[1]},${load.sourceLocation.coordinates[0]}" target="_blank"><img src="/images/bottomIcon_google_map.png"></a>
			</#if>
		<#else>
		    ${load.source!''}
		</#if>
    </td>
</tr>
<tr>
    <th style="text-align:right">סוג טעינה:</th>
	<td style="text-align:right" class="liftTypeConversion">${load.loadingType!''}</td>
</tr>
<tr>
    <th style="text-align:right">יעד:</th>
    <td style="text-align:right">
		<#if load.destinationLocation??>
			${Format.address(load.destination)!''}
			<#if allowedLoadDetails>
				<a href="waze://?ll=${load.destinationLocation.coordinates[1]},${load.destinationLocation.coordinates[0]}" target="_blank"><img src="/images/waze_app_icon_small.png" width="30px"></a>
				<a href="http://maps.google.com/maps?q=loc:${load.destinationLocation.coordinates[1]},${load.destinationLocation.coordinates[0]}" target="_blank"><img src="/images/bottomIcon_google_map.png"></a>
			</#if>
		<#else>
		    ${load.destination!''}
		</#if>
    </td>
</tr>
<tr>
    <th style="text-align:right">סוג פריקה:</th>
	<#if load.downloadingType??>
		<td style="text-align:right" class="liftTypeConversion">${load.downloadingType!''}</td>
	<#else>
		<td></td>
	</#if>
</tr>
<tr>
    <th style="text-align:right">מחיר:</th>
    <td style="text-align:right">${load.suggestedQuote!''}</td>
</tr>
<tr>
    <th style="text-align:right">זמן המתנה (שעות):</th>
    <td style="text-align:right">${load.waitingTime!''}</td>
</tr>
<tr>
    <th>הערות:</th>
    <td style="text-align:right">${load.comments!''}</td>
</tr>
<#if load.hasPhoto>
<tr>
	<th style="text-align:right">תמונה:</th>
	<td style="text-align:right"><img src="/load/image/${load.id}" class="ui-li-thumb" style="width:100%; max-width:200px;"></td>
</tr>
</#if>

</tbody>
</table>

</div>
</div>
</body>
</html>