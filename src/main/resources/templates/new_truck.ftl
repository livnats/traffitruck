<html dir="rtl">
<head>
<meta charset="utf-8">
<title>טראפי-טראק - הוסף משאית</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="js/default/jquery.mobile.theme-1.4.5.css" rel="stylesheet">
<link href="js/default/jquery.mobile.icons-1.4.5.min.css" rel="stylesheet">
<link href="css/jquery.mobile.structure-1.4.5.min.css" rel="stylesheet">
<link href="css/mobile.css" rel="stylesheet">
<link href="css/add_truck.css" rel="stylesheet">
<script src="js/jquery-1.11.3.min.js"></script>
<script>
$(document).on("mobileinit", function()
{
   $.mobile.ajaxEnabled = false;
});

$(document).ready(function() {
	$('#vehicleLicensePhoto1').change(function(){
	    var file = this.files[0];
	    var name = file.name;
	    var size = file.size;
	    var type = file.type;

        if ( file != "" && ! type.startsWith("image/") ) {
           mAlert("חובה לספק רשיון רכב");
           this.val("");
           this.focus();
           return false;
        }
        
        ratio = 1;
        if ( size > 1000000 ) {
            ratio = size / 400000;
        }

        oFReader = new FileReader(); 
		oFReader.onload = function (oFREvent) {
		  var img=new Image();
		  img.onload=function(){
              if ( ratio != 1 ) {
		         var canvas=document.createElement("canvas");
		         var ctx=canvas.getContext("2d");
		         canvas.width=img.width/ratio;
		         canvas.height=img.height/ratio;
		         ctx.drawImage(img,0,0,img.width,img.height,0,0,canvas.width,canvas.height);
		         var imageData = canvas.toDataURL();
                 $('#vehicleLicensePhoto').val(imageData);
              }
              else {
		         var imageData = oFReader.result;
                 $('#vehicleLicensePhoto').val(imageData);
              }
		  }
		  img.src=oFREvent.target.result;
		};
        oFReader.readAsDataURL(file);
	});

	$('#driverLicensePhoto1').change(function(){
	    var file = this.files[0];
	    var name = file.name;
	    var size = file.size;
	    var type = file.type;

        if ( file != "" && ! type.startsWith("image/") ) {
           mAlert("חובה לספק רשיון נהיגה");
           this.val("");
           this.focus();
           return false;
        }
        
        ratio = 1;
        if ( size > 1000000 ) {
            ratio = size / 400000;
        }

        oFReader = new FileReader(); 
		oFReader.onload = function (oFREvent) {
		  var img=new Image();
		  img.onload=function(){
              if ( ratio != 1 ) {
		         var canvas=document.createElement("canvas");
		         var ctx=canvas.getContext("2d");
		         canvas.width=img.width/ratio;
		         canvas.height=img.height/ratio;
		         ctx.drawImage(img,0,0,img.width,img.height,0,0,canvas.width,canvas.height);
		         var imageData = canvas.toDataURL();
                 $('#driverLicensePhoto').val(imageData);
              }
              else {
		         var imageData = oFReader.result;
                 $('#driverLicensePhoto').val(imageData);
              }
		  }
		  img.src=oFREvent.target.result;
		};
        oFReader.readAsDataURL(file);
	});

	$('#truckPhoto1').change(function(){
	    var file = this.files[0];
	    var name = file.name;
	    var size = file.size;
	    var type = file.type;

        if ( file != "" && ! type.startsWith("image/") ) {
           mAlert("חובה לספק תמונת משאית");
           this.val("");
           this.focus();
           return false;
        }
        
        ratio = 1;
        if ( size > 1000000 ) {
            ratio = size / 400000;
        }
        oFReader = new FileReader(); 
		oFReader.onload = function (oFREvent) {
		  var img=new Image();
		  img.onload=function(){
              if ( ratio != 1 ) {
			      var canvas=document.createElement("canvas");
			      var ctx=canvas.getContext("2d");
			      canvas.width=img.width/ratio;
			      canvas.height=img.height/ratio;
			      ctx.drawImage(img,0,0,img.width,img.height,0,0,canvas.width,canvas.height);
			      var imageData = canvas.toDataURL();
       	          $('#truckPhoto').val(imageData);
              }
              else {
		         var imageData = oFReader.result;
                 $('#truckPhoto').val(imageData);
              }
		  }
		  img.src=oFREvent.target.result;
		};
        oFReader.readAsDataURL(file);
	});
});

</script>
<script src="js/jquery.mobile-1.4.5.min.js"></script>
<script>

function mAlert(text1) {
  $("#sure .sure-1").text(text1);
  $("#sure .sure-do").on("click.sure", function() {
    $(this).off("click.sure");
  });
  $.mobile.changePage("#sure");
}

function ValidateForm1(theForm)
{
   var regexp;
   regexp = /^\d*$/;
   if (!regexp.test(theForm.licensePlateNumber.value))
   {
      mAlert("לוחית רישוי יכולה להכיל רק ספרות");
      theForm.licensePlateNumber.focus();
      return false;
   }
   if (theForm.licensePlateNumber.value == "")
   {
      mAlert("חובה לספק מספר לוחית רישוי");
      theForm.licensePlateNumber.focus();
      return false;
   }
   if (theForm.vehicleLicensePhoto.value == "")
   {
      mAlert("חובה לספק צילום של רשיון הרכב");
      theForm.vehicleLicensePhoto.focus();
      return false;
   }
   if (theForm.truckPhoto.value == "")
   {
      mAlert("חובה לספק צילום של המשאית");
      theForm.truckPhoto.focus();
      return false;
   }
   
   $('#vehicleLicensePhoto1').val("");
   $('#driverLicensePhoto1').val("");
   $('#truckPhoto1').val("");
   
   return true;
}
</script>

<style>

label{
text-align: right;
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
<div data-role="page" data-theme="a" data-title="הוסף משאית" id="add_truck">

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
		<span style="color:#3388cc;" > <b> הוספת משאית </b></span>
		<div id="wb_Form1" style="">
			<#if error??>
				<div id="wb_Text1">
					<span style="color:#FF0000;font-family:serif;font-size:13px;">מספר לוחית רישוי קיים במערכת</span>
				</div>
			</#if>
			
			<form name="newTruckForm" method="post" action="newTruck" enctype="multipart/form-data" data-ajax="false" data-transition="pop" id="newTruckForm" style="display:inline;" onsubmit="return ValidateForm1(this)">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
			<div class="ui-field-contain">
				<label for="licensePlateNumber">* מספר לוחית רישוי</label>
				<input type="number" id="licensePlateNumber" style="" name="licensePlateNumber" value="" maxlength="7">
			</div>
			<div class="ui-field-contain">
				<label for="vehicleLicensePhoto1">* צילום רשיון רכב</label>
				<input type="file" id="vehicleLicensePhoto1" style="" name="vehicleLicensePhoto1">
                <input type="hidden" id="vehicleLicensePhoto" name="vehicleLicensePhoto">
			</div>
			<div class="ui-field-contain">
				<label for="driverLicensePhoto1">* צילום רשיון נהיגה</label>
				<input type="file" id="driverLicensePhoto1" style="" name="driverLicensePhoto1">
                <input type="hidden" id="driverLicensePhoto" name="driverLicensePhoto">
			</div>
			<div class="ui-field-contain">
				<label for="truckPhoto1">* צילום משאית</label>
				<input type="file" id="truckPhoto1" style="" name="truckPhoto1">
                <input type="hidden" id="truckPhoto" name="truckPhoto">
			</div>
			<input type="submit" id="Button1" name="" value="הוסף משאית">
			</form>
		</div>
	
	</div>
	
	<div data-role="panel" id="mypanel" data-display="overlay" data-position="left">
		<ul data-role="listview" style='text-align:right;'>
			<li data-icon="power"><a href="/logout" style="text-align:right; font-size:0.8em;"> התנתק</a></li>
		</ul>
	</div><!-- /panel -->	
	
</div>  <!-- page -->

<div data-role="dialog" id="sure">
  <div data-role="content">
    <h3 class="sure-1">???</h3>
    <a href="#" class="sure-do" data-role="button" data-theme="b" data-rel="back">סגור</a>
  </div>
</div>

</body>
</html>