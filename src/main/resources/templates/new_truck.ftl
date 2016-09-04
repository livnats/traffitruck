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
</head>
<body>
<div data-role="page" data-theme="a" data-title="הוסף משאית" id="add_truck">

<div data-role="header" id="Header1">
	<img src="/images/logo.jpg" width="20%" style="margin-bottom:15; margin-left:10"/>
	<img src="/images/truck-blue.jpg" width="15%"/>
	<a href="/myTrucks" data-role="button" class="ui-btn-left">חזרה</a>
	<a href="/logout" data-role="button" class="ui-btn-right">יציאה</a>
	<div data-role="navbar">
	  <ul>
   		<li><a href="#" class="ui-btn-active ui-state-persist" style= "background-color:rgb(0,128,255);">הוספת משאית</a></li>
	  </ul>
	</div> <!--/navbar-->
</div> <!--/header-->

	<div class="ui-content" role="main">
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
</div>

<div data-role="dialog" id="sure">
  <div data-role="content">
    <h3 class="sure-1">???</h3>
    <a href="#" class="sure-do" data-role="button" data-theme="b" data-rel="back">סגור</a>
  </div>
</div>

</body>
</html>