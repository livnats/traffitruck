<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>טראפי-טראק - משאיות</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="js/default/jquery.mobile.theme-1.4.5.css" rel="stylesheet">
<link href="js/default/jquery.mobile.icons-1.4.5.min.css" rel="stylesheet">
<link href="css/jquery.mobile.structure-1.4.5.min.css" rel="stylesheet">
<link href="css/mobile.css" rel="stylesheet">
<link href="css/trucks.css" rel="stylesheet">
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
		if ( type == "${enums["com.traffitruck.domain.TruckRegistrationStatus"].REGISTERED}" )
			return "ממתין לאישור";
		if ( type == "${enums["com.traffitruck.domain.TruckRegistrationStatus"].APPROVED}" )
			return "מאושר";
		return type;
	}
	
	$( ".typeConversion" ).each(function() {
	  $(this).html(convertType($(this).html()));
	});

});
</script>

<script src="js/jquery.mobile-1.4.5.min.js"></script>

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
	.ui-icon-bars { 50% 50% no-repeat; background-size: 18px 18px;}
	.ui-icon-loads {background:  url(/images/trolley.png) 50% 25% no-repeat; background-size: 18px 18px;}
	.ui-icon-notifications:hover {border-color:#DADADA !important;}
	.ui-icon-truck:hover {border-color:white !important;}
	.ui-icon-search:hover {border-color:#DADADA!important;}
	.ui-icon-bars:hover {border-color:#DADADA!important;}
	.ui-icon-loads:hover {border-color:#DADADA!important;}

	.ui-disabled {background-color:rgb(0,128,255) !important;}
</style>

</head>
<body>
<div data-role="page" data-theme="a" data-title="המטענים שלי" id="trucks">


<div data-role="header" id="Header1">
	<img src="/images/logo.jpg" width="20%" style="margin-bottom:15; margin-left:10"/>
	<img src="/images/truck-blue.jpg" width="15%"/>
	<div data-role="navbar">
	  <ul>
			<li><a href="#mypanel" class="ui-nodisc-icon" data-icon="bars"></a></li>
	  	<#if (registeredTrucks?? && registeredTrucks?size > 0)>
	   		<li><a href="/myAlerts" class="ui-nodisc-icon" data-icon="notifications"></a></li>
	  		<li><a href="/myTrucks" class="ui-nodisc-icon ui-btn-active ui-state-persist" data-icon="truck"></a></li>
	    	<li><a href="/findTrucksForLoad" class="ui-nodisc-icon" data-icon="search"></a></li>
	    <#else>
	    	<li><a href="#" class="ui-disabled ui-nodisc-icon" data-icon="notifications"></a></li>
	  		<li><a href="/myTrucks" class="ui-btn-active ui-state-persist ui-nodisc-icon" data-icon="truck"></a></li>
	    	<li><a href="#" class="ui-disabled ui-nodisc-icon" data-icon="search"></a></li>
	    </#if>
	    <#if (isLoadsOwner)>
	    	<li><a href="/myLoads" class="ui-nodisc-icon" data-icon="loads"></a></li>
		</#if>
	  </ul>
	</div> <!--/navbar-->
</div> <!--/header-->
	
<div class="ui-content" role="main">


							<#if trucks?has_content>
								<span style="color:#3388cc;" > <b> משאיות </b></span>
								<table data-role="table" class="table-stripe my-custom-breakpoint" style="direction:RTL">
								<thead>
									<tr>
										<th style="text-align:right">מספר לוחית זיהוי&nbsp;&nbsp;&nbsp;</th>
										<th style="text-align:right">סטטוס</th>
									</tr>
								</thead>
								<tbody>
									<#list trucks as truck>
									<tr id="${truck.id}">
										<td style="text-align:right">${truck.licensePlateNumber}</td>
										<td style="text-align:right" class="typeConversion">${truck.registrationStatus!'שגיאה'}</td>
									</tr>
									</#list>
								</tbody>
								</table>
						
							<#else>
								אין משאיות רשומות
							</#if>

							<div id="createNew" class="podbar">
								<a href="/newTruck"><i class="icono-plusCircle"></i></a>
							</div>
	<div data-role="panel" id="mypanel" data-display="overlay" data-position="left">
		<a href="/logout">התנתק</a>
	</div><!-- /panel -->
</div>
</div>
</body>
</html>