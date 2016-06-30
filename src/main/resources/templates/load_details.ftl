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

</head>
<body dir="rtl">
<div data-role="page" data-theme="a" data-title="פרטי מטען" id="load_details">
<div data-role="header" id="Header1">
<h1>פרטי מטען</h1>
<a href="/myLoads" data-role="button" class="ui-btn-left">חזרה</a>
<a href="/logout" data-role="button" class="ui-btn-right">יציאה</a>
</div>
<div class="ui-content" role="main">

<table data-role="table" class="table-stroke ui-responsive" style="direction:RTL">
      <thead>
        <tr>
          <th></th>
          <th></th>
        </tr>
      </thead>
<tbody>
<#if load.hasPhoto>
<tr>
	<th style="text-align:right">תמונה:</th>
	<td style="text-align:right"><img src="/load/image/${load.id}" class="ui-li-thumb" style="width:100%; max-width:200px;"></td>
</tr>
</#if>
<tr>
    <th style="text-align:right">שם המטען:</th>
    <td style="text-align:right">${load.name!''}</td>
</tr>
<tr>
    <th style="text-align:right">סוג המטען:</th>
    <td style="text-align:right" class="typeConversion">${load.type!''}</td>
</tr>
<tr>
    <th style="text-align:right">משקל (ק\"ג):</th>
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
			<a href="http://maps.google.com/maps?q=loc:${load.sourceLocation.coordinates[1]},${load.sourceLocation.coordinates[0]}" target="_blank">${load.source!''}</a>
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
			<a href="http://maps.google.com/maps?q=loc:${load.destinationLocation.coordinates[1]},${load.destinationLocation.coordinates[0]}" target="_blank">${load.destination!''}</a>
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
    <th style="text-align:right">הערות:</th>
    <td style="text-align:right">${load.comments!''}</td>
</tr>

</tbody>
</table>
			    
<form action='/deleteLoad' method='post'>
	<input type="submit" value="הסר מטען"/>
	<input type="hidden" id="loadId" name="loadId" value="${load.id}"/>
	<input type='hidden' name='${_csrf.parameterName}' value='${_csrf.token}'/>
</form>

</div>
</div>
</body>
</html>