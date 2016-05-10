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

<table border='1'>
<tr>
    <td>בעל המטען:</td>
    <td>${load.username!''}</td>
</tr>
<tr>
    <td>שם המטען:</td>
    <td>${load.name!''}</td>
</tr>
<tr>
    <td>סוג המטען:</td>
    <td class="typeConversion">${load.type!''}</td>
</tr>
<tr>
    <td>משקל (ק\"ג):</td>
    <td>${load.weight!''}</td>
</tr>
<tr>
    <td>נפח (קוב):</td>
    <td>${load.volume!''}</td>
</tr>
<tr>
    <td>מוצא:</td>
    <td>${load.source!''}</td>
</tr>
<tr>
    <td>סוג טעינה:</td>
	<#if load.loadingType??>
		<td><script>document.write(convertLiftType(${load.loadingType}))</script></td>
	<#else>
		<td></td>
	</#if>
</tr>
<tr>
    <td>יעד:</td>
    <td>${load.destination!''}</td>
</tr>
<tr>
    <td>סוג פריקה:</td>
	<#if load.downloadingType??>
		<td><script>document.write(convertLiftType(${load.downloadingType}))</script></td>
	<#else>
		<td></td>
	</#if>
</tr>
<tr>
    <td>מחיר:</td>
    <td>${load.suggestedQuote!''}</td>
</tr>
<tr>
    <td>זמן המתנה (שעות):</td>
    <td>${load.waitingTime!''}</td>
</tr>
<tr>
    <td>הערות:</td>
    <td>${load.comments!''}</td>
</tr>
<#if load.hasPhoto>
<tr>
	<td>תמונה:</td>
	<td><img src="/load/image/${load.id}" class="ui-li-thumb" style="width:100%; max-width:200px;"></td>
</tr>
</#if>
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