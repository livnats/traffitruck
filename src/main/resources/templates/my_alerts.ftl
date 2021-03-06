<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>טראפי-טראק - התראות</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="js/default/jquery.mobile.theme-1.4.5.css" rel="stylesheet">
<link href="js/default/jquery.mobile.icons-1.4.5.min.css" rel="stylesheet">
<link href="css/jquery.mobile.structure-1.4.5.min.css" rel="stylesheet">
<link href="css/mobile.css" rel="stylesheet">
<link href="css/alerts.css" rel="stylesheet">
<link rel="stylesheet" href="css/icono.min.css">
<script src="js/jquery-1.11.3.min.js"></script>
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
	.ui-icon-loads {background:  url(/images/trolley.png) 50% 25% no-repeat; background-size: 18px 18px;}
	.ui-icon-notifications:hover {border-color:white !important;}
	.ui-icon-truck:hover {border-color:#DADADA !important;}
	.ui-icon-search:hover {border-color:#DADADA!important;}
	.ui-icon-loads:hover {border-color:#DADADA!important;}
	.ui-icon-bars:hover {border-color:#DADADA!important;}
	
</style>
<script>
$(document).on("mobileinit", function()
{
   $.mobile.ajaxEnabled = false;
});
</script>
<script>

	function deleteAlert(alertId){
		$.post(
			"/deleteAlert",
			{
				alertId: alertId,
				${_csrf.parameterName}: "${_csrf.token}"
			} 
		);
		$("#"+alertId).remove();
	}
	
</script>
<script src="js/jquery.mobile-1.4.5.min.js"></script>

</head>
<body>
<div data-role="page" data-theme="a" data-title="ההתראות שלי" id="alerts">
<div data-role="header" id="Header1">
	<img src="/images/logo.jpg" width="20%" style="margin-bottom:15; margin-left:10"/>
	<img src="/images/truck-blue.jpg" width="15%"/>	
	<div data-role="navbar">
	  <ul>
	    <li><a href="#mypanel" class="ui-nodisc-icon" data-icon="bars"></a></li>
   		<li><a href="/myAlerts" class="ui-nodisc-icon ui-btn-active ui-state-persist" data-icon="notifications" ></a></li>
  		<li><a href="/myTrucks" class="ui-nodisc-icon" data-icon="truck"></a></li>
    	<li><a href="/findTrucksForLoad" class="ui-nodisc-icon" data-icon="search"></a></li>
	  	<#if (isLoadsOwner)>
	    	<li><a href="/myLoads" class="ui-nodisc-icon" data-icon="loads"></a></li>
		</#if>
	  </ul>
	</div> <!--/navbar-->
</div> <!--/header-->

<div class="ui-content" role="main">

							<#if alerts?has_content>
								<span style="color:#3388cc;" > <b> התראות </b></span>
								<table data-role="table" class="table-stripe my-custom-breakpoint" style="direction:RTL">
								<thead>
									<tr>
										<th style="text-align:right">מוצא</th>
										<th style="text-align:right">יעד</th>
										<th style="text-align:right">מחק</th>
									</tr>
								</thead>
								<tbody>
									<#list alerts as alert>
									<tr id="${alert.id}">
										<#if (alert.source??)>
											<td style="text-align:right">${alert.source}</td>
										<#else>
											<td style="text-align:right"></td>
										</#if>
										<#if (alert.destination??)>
											<td style="text-align:right">${alert.destination}</td>
										<#else>
											<td style="text-align:right"></td>
										</#if>
										<td style="text-align:right">
											<a href="#" onclick="return deleteAlert('${alert.id}')" data-role="none"><img src="/images/remove-icon-png-26.png"  width="20px" ></a>
										</td>
									</tr>
									</#list>
								</tbody>
								</table>
						
							<#else>
								אין התראות
							</#if>

							<div id="createNew" class="podbar">
								<a href="/newAlert"><i class="icono-plusCircle"></i></a>
							</div>

</div>

	<div data-role="panel" id="mypanel" data-display="overlay" data-position="left">
		<ul data-role="listview" style='text-align:right;'>
			<li data-icon="power"><a href="/logout" style="text-align:right; font-size:0.8em;"> התנתק</a></li>
		</ul>
	</div><!-- /panel -->	
	
</div> <!-- page -->
</body>
</html>