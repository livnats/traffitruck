<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>טראפי-טראק - מטענים</title>
<meta name="viewport" content="width=device-width, initial-scale=	1.0">
<link href="js/default/jquery.mobile.theme-1.4.5.css" rel="stylesheet">
<link href="js/default/jquery.mobile.icons-1.4.5.min.css" rel="stylesheet">
<link href="css/jquery.mobile.structure-1.4.5.min.css" rel="stylesheet">
<link href="css/mobile.css" rel="stylesheet">
<link href="css/loads.css" rel="stylesheet">
<link rel="stylesheet" href="css/icono.min.css">
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
		if ( type == "${enums["com.traffitruck.domain.LiftType"].CONTAINER}" )
			return "מכולה";
		return type;
	}

	$( ".typeConversion" ).each(function() {
	  $(this).html(convertType($(this).html()));
	});
});
</script>

<script src="js/jquery.mobile-1.4.5.min.js"></script>

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
	.ui-icon-notifications:hover {border-color:#DADADA !important;}
	.ui-icon-truck:hover {border-color:#DADADA !important;}
	.ui-icon-search:hover {border-color:#DADADA !important;}
	.ui-icon-loads:hover {border-color:white !important;}
	.ui-icon-bars:hover {border-color:#DADADA!important;}
	
</style>

</head>
<body>
<div data-role="page" data-theme="a" data-title="המטענים שלי" id="loads">

<div data-role="header" id="Header1">
	<img src="/images/logo.jpg" width="20%" style="margin-bottom:15; margin-left:10"/>
	<img src="/images/truck-blue.jpg" width="15%"/>
	<div data-role="navbar">
	  <ul>
	  		<li><a href="#mypanel" class="ui-nodisc-icon" data-icon="bars"></a></li>
	  	<#if (isTruckOwner)>
	  	  	<#if (trucks?? && trucks?size > 0)>
		   		<li><a href="/myAlerts" class="ui-nodisc-icon" data-icon="notifications" ></a></li>
		  		<li><a href="/myTrucks" class="ui-nodisc-icon" data-icon="truck" ></a></li>
		    	<li><a href="/findTrucksForLoad" class="ui-nodisc-icon" data-icon="search"></a></li>
		    <#else>
		    	<li><a href="#" class="ui-disabled ui-nodisc-icon" data-icon="notifications" ></a></li>
		  		<li><a href="/myTrucks" class="ui-nodisc-icon" data-icon="truck" ></a></li>
		    	<li><a href="/findTrucksForLoad" class="ui-nodisc-icon" data-icon="search"></a></li>
		    </#if>
		    <li><a href="/myLoads" class="ui-btn-active ui-state-persist ui-nodisc-icon" data-icon="loads"></a></li>
		<#else>
		  <li><a href="#" class="ui-btn-active ui-state-persist ui-nodisc-icon" data-icon="loads"></a></li>
		</#if>
	  </ul>
	</div> <!--/navbar-->
</div> <!--/header-->

<div class="ui-content" role="main">

							<#if loads?has_content>
									<span style="color:#3388cc; float:right;" > <b> מטענים </b></span>
									<table data-role="table" class="table-stripe my-custom-breakpoint" style="direction:RTL">
									<thead>
										<tr>
											<th style="text-align:right">שם</th>
											<th style="text-align:right">מוצא</th>
											<th style="text-align:right">יעד</th>
											<th style="text-align:right">סוג מטען</th>
											<th style="text-align:right">מחיר</th>
											<th style="text-align:right">תאריך</th>
										</tr>
									</thead>
									<tbody>
										<#list loads as load>
										<tr id="${load.id}" class="clickableRow">
											<td style="text-align:right"><a href="/load_details/${load.id}">${load.name!'---'}</a></td>
											<td style="text-align:right">${Format.address(load.source)!''}</td>
											<td style="text-align:right">${Format.address(load.destination)!''}</td>
											<td style="text-align:right" class="typeConversion">${load.type!'לא נמסר'}</td>
											<td style="text-align:right">${load.suggestedQuote!'לא נמסר'}</td>
											<#if load.driveDate??>
												<td style="text-align:right">${load.driveDate?string("dd-MM-yyyy")!''}</td>
											<#else>
												<td></td>
											</#if>
										</tr>
										</#list>
									</tbody>
									</table>
						
							<#else>
								אין מטענים להציג :(
							</#if>


							<div id="createNew" class="podbar">
								<a href="/newload"><i class="icono-plusCircle"></i></a>
							</div>
</div> <!-- main -->
	
	<div data-role="panel" id="mypanel" data-display="overlay" data-position="left">
		<ul data-role="listview" style='text-align:right;'>
			<li data-icon="power"><a href="/logout" style="text-align:right; font-size:0.8em;"> התנתק</a></li>
		</ul>
	</div><!-- /panel -->	
	
</div> <!--page>
</body>
</html>