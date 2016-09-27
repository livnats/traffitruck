<html dir="rtl">
<head>
<meta charset="utf-8">
<title>טראפי-טראק - מטען חדש</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="js/default/jquery.mobile.theme-1.4.5.css" rel="stylesheet">
<link href="js/default/jquery.mobile.icons-1.4.5.min.css" rel="stylesheet">
<link href="css/jquery.mobile.structure-1.4.5.min.css" rel="stylesheet">
<link href="css/mobile.css" rel="stylesheet">
<link href="css/add_load.css" rel="stylesheet">
<script src="js/jquery-1.11.3.min.js"></script>

     <link rel="stylesheet" href="css/jquery-ui-1.11.1.css">
	<script type="text/javascript" src="js/jquery-ui-1.11.1.js"></script>

<script>
$(document).on("mobileinit", function()
{
   $.mobile.ajaxEnabled = false;
});

$(document).ready(function() {
	function calculateRatio(size) {
		ratio = 1;
	    if ( size > 1000000 ) {
	        ratio = 0.8;
	    }
	    if ( size > 2000000 ) {
	        ratio = 0.7;
	    }
	    if ( size > 3000000 ) {
	        ratio = 0.5;
	    }
	    if ( size > 4000000 ) {
	        ratio = 0.3;
	    }
	    if ( size > 6000000 ) {
	        ratio = 0.2;
	    }
	    return ratio;
	}

	$('#loadPhoto1').change(function(){
	    var file = this.files[0];
	    var name = file.name;
	    var size = file.size;
	    var type = file.type;

        if ( file != "" && ! type.startsWith("image/") ) {
           mAlert("חובה לבחור תמונה");
           this.val("");
           this.focus();
           return false;
        }

		ratio = calculateRatio(size);
		
        oFReader = new FileReader(); 
		oFReader.onload = function (oFREvent) {
		  var img=new Image();
		  img.onload=function(){
              if ( ratio != 1 ) {
			      var canvas=document.createElement("canvas");
			      var ctx=canvas.getContext("2d");
		         canvas.width=img.width/(1/ratio);
		         canvas.height=img.height/(1/ratio);
		         ctx.drawImage(img,0,0,img.width,img.height,0,0,canvas.width,canvas.height);
		         var imageData = canvas.toDataURL("image/jpeg", 0.5);
       	          $('#loadPhoto').val(imageData);
              }
              else {
		         var imageData = oFReader.result;
                 $('#loadPhoto').val(imageData);
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
   regexp = /^[א-תA-Za-zÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿ \t\r\n\f0-9-]*$/;
   if (!regexp.test(theForm.name.value))
   {
      mAlert("שם המטען יכול להכיל אותיות ספרות ורווחים");
      theForm.name.focus();
      return false;
   }
   if (theForm.name.value == "")
   {
      mAlert("שם המטען יכול להכיל אותיות ספרות ורווחים");
      theForm.name.focus();
      return false;
   }
   if (theForm.type.selectedIndex < 0)
   {
      mAlert("שדה חובה");
      theForm.type.focus();
      return false;
   }
   if (theForm.type.selectedIndex == 0)
   {
      mAlert("חובה לספק את סוג המטען");
      theForm.type.focus();
      return false;
   }
   regexp = /^[-+]?\d*\.?\d*$/;
   if (!regexp.test(theForm.weight.value))
   {
      mAlert("המשקל חייב להכיל רק ספרות");
      theForm.weight.focus();
      return false;
   }
   if (theForm.weight.value != "" && !(theForm.weight.value > 0))
   {
      mAlert("המשקל חייב להכיל רק ספרות");
      theForm.weight.focus();
      return false;
   }
   regexp = /^[-+]?\d*\.?\d*$/;
   if (!regexp.test(theForm.volume.value))
   {
      mAlert("הנפח חייב להכיל רק ספרות");
      theForm.volume.focus();
      return false;
   }
   if (theForm.volume.value != "" && !(theForm.volume.value > 0))
   {
      mAlert("הנפח חייב להכיל רק ספרות");
      theForm.volume.focus();
      return false;
   }
   if (theForm.source.value == "")
   {
      mAlert("חובה לספק מוצא");
      theForm.source.focus();
      return false;
   }
   regexp = /^[א-תA-Za-zÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿ '\t\r\n\f0-9-,"]*$/;
   if (!regexp.test(theForm.source.value))
   {
      mAlert("המוצא יכול להכיל אותיות ספרות ורווחים");
      theForm.source.focus();
      return false;
   }
   if (theForm.sourceLat.value == "")
   {
      mAlert("חובה לבחור מוצא מוכר מהרשימה הנפתחת בשדה");
      theForm.source.focus();
      return false;
   }
   if (theForm.loadingType.selectedIndex < 0)
   {
      mAlert("חובה לספק את סוג הטעינה");
      theForm.loadingType.focus();
      return false;
   }
   if (theForm.loadingType.selectedIndex == 0)
   {
      mAlert("חובה לספק את סוג הטעינה");
      theForm.loadingType.focus();
      return false;
   }
   if (theForm.downloadingType.selectedIndex < 0)
   {
      mAlert("חובה לספק את סוג הפריקה");
      theForm.downloadingType.focus();
      return false;
   }
   if (theForm.downloadingType.selectedIndex == 0)
   {
      mAlert("חובה לספק את סוג הפריקה");
      theForm.downloadingType.focus();
      return false;
   }
   regexp = /^[א-תA-Za-zÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿ '\t\r\n\f0-9-,"]*$/;
   if (theForm.destination.value == "")
   {
      mAlert("חובה לספק יעד");
      theForm.destination.focus();
      return false;
   }
   if (!regexp.test(theForm.destination.value))
   {
      mAlert("היעד יכול להכיל אותיות ספרות ורווחים");
      theForm.destination.focus();
      return false;
   }
   if (theForm.destinationLat.value == "")
   {
      mAlert("חובה לבחור יעד מוכר מהרשימה הנפתחת בשדה");
      theForm.source.focus();
      return false;
   }
   regexp = /^[-+]?\d*\.?\d*$/;
   if (!regexp.test(theForm.suggestedQuote.value))
   {
      mAlert("המחיר חייב להכיל רק ספרות");
      theForm.suggestedQuote.focus();
      return false;
   }
   if (theForm.suggestedQuote.value == "")
   {
      mAlert("המחיר חייב להכיל רק ספרות");
      theForm.suggestedQuote.focus();
      return false;
   }
   if (theForm.suggestedQuote.value != "" && !(theForm.suggestedQuote.value > 0))
   {
      mAlert("המחיר חייב להכיל רק ספרות");
      theForm.suggestedQuote.focus();
      return false;
   }
   if (theForm.drivedate.value == "")
   {
      mAlert("חובה לספק תאריך");
      theForm.suggestedQuote.focus();
      return false;
   }
   regexp = /^[-+]?\d*\.?\d*$/;
   if (!regexp.test(theForm.waitingTime.value))
   {
      mAlert("זמן המתנה חייב להכיל רק ספרות");
      theForm.waitingTime.focus();
      return false;
   }
   if (theForm.waitingTime.value != "" && !(theForm.waitingTime.value >= 0))
   {
      mAlert("זמן המתנה חייב להכיל רק ספרות");
      theForm.waitingTime.focus();
      return false;
   }
   regexp = /^[א-תA-Za-zÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿ \t\r\n\f0-9-]*$/;
   if (!regexp.test(theForm.comments.value))
   {
      mAlert("ההערות יכולות להכיל אותיות ספרות ורווחים");
      theForm.comments.focus();
      return false;
   }
   
   $('#loadPhoto1').val("");
   return true;
}
</script>

 <script type="text/javascript">
 $(function() {
       $( "#drivedate" ).datepicker();
       $( "#drivedate" ).datepicker( "option", "dateFormat", 'dd-mm-yy' );
       $( "#drivedate" ).datepicker( "option", "minDate", 0);
 });
 </script>

        <link type="text/css" rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500">
        <script src="/mapsapis"></script>
        <script>
            var autocomplete;
            function initialize() {
              
              var geocoder = new google.maps.Geocoder();
              
              autocomplete_src = new google.maps.places.Autocomplete(
                  /** @type {HTMLInputElement} */(document.getElementById('source')),
                  { types: ['address'] });
              google.maps.event.addListener(autocomplete_src, 'place_changed', function() {
                 var address = document.getElementById('source').value;
                 geocoder.geocode({'address': address}, function(results, status) {
                   if (status === google.maps.GeocoderStatus.OK) {
	                   $("#sourceLat").val( results[0].geometry.location.lat() );
	                   $("#sourceLng").val( results[0].geometry.location.lng() );
                    } else {
                       alert('Geocode was not successful for the following reason: ' + status);
                    }
                 })
              });

              autocomplete_cities_src = new google.maps.places.Autocomplete(
                  /** @type {HTMLInputElement} */(document.getElementById('source')),
                  { types: ['(cities)'] });
              google.maps.event.addListener(autocomplete_cities_src, 'place_changed', function() {
                 var address = document.getElementById('source').value;
                 geocoder.geocode({'address': address}, function(results, status) {
                   if (status === google.maps.GeocoderStatus.OK) {
	                   $("#sourceLat").val( results[0].geometry.location.lat() );
	                   $("#sourceLng").val( results[0].geometry.location.lng() );
                    } else {
                       alert('Geocode was not successful for the following reason: ' + status);
                    }
                 })
              });

              autocomplete_dest = new google.maps.places.Autocomplete(
                  /** @type {HTMLInputElement} */(document.getElementById('destination')),
                  { types: ['address'] });
              google.maps.event.addListener(autocomplete_dest, 'place_changed', function() {
                 var address = document.getElementById('destination').value;
                 geocoder.geocode({'address': address}, function(results, status) {
                   if (status === google.maps.GeocoderStatus.OK) {
	                   $("#destinationLat").val( results[0].geometry.location.lat() );
	                   $("#destinationLng").val( results[0].geometry.location.lng() );
                    } else {
                       alert('Geocode was not successful for the following reason: ' + status);
                    }
                  })
              });

              autocomplete_cities_dest = new google.maps.places.Autocomplete(
                  /** @type {HTMLInputElement} */(document.getElementById('destination')),
                  { types: ['(cities)'] });
              google.maps.event.addListener(autocomplete_cities_dest, 'place_changed', function() {
                 var address = document.getElementById('destination').value;
                 geocoder.geocode({'address': address}, function(results, status) {
                   if (status === google.maps.GeocoderStatus.OK) {
	                   $("#destinationLat").val( results[0].geometry.location.lat() );
	                   $("#destinationLng").val( results[0].geometry.location.lng() );
                    } else {
                       alert('Geocode was not successful for the following reason: ' + status);
                    }
                  })
              });

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
	.ui-icon-loads {background:  url(/images/trolley.png) 50% 25% no-repeat; background-size: 18px 18px;}
	.ui-icon-notifications:hover {border-color:#DADADA !important;}
	.ui-icon-truck:hover {border-color:#DADADA !important;}
	.ui-icon-search:hover {border-color:#DADADA !important;}
	.ui-icon-loads:hover {border-color:white !important;}
	.ui-icon-bars:hover {border-color:#DADADA!important;}
	
</style>

</head>
<body onload="initialize()" dir="rtl">
<div data-role="page" data-theme="a" data-title="הוספת מטען" id="add_load">

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
		    	<li><a href="#" class="ui-disabled ui-nodisc-icon" data-icon="search"></a></li>
		    </#if>
		    <li><a href="/myLoads" class="ui-btn-active ui-state-persist ui-nodisc-icon" data-icon="loads"></a></li>
		<#else>
		  <li><a href="#" class="ui-btn-active ui-state-persist ui-nodisc-icon" data-icon="loads"></a></li>
		</#if>
	  </ul>
	</div> <!--/navbar-->
	
</div> <!--/header-->

<div class="ui-content" role="main">
	
	<span style="color:#3388cc;" > <b> הוספת מטען </b></span>

<div id="wb_Form1" style="">
<form name="newloadForm" method="post" action="newload" enctype="multipart/form-data" data-ajax="false" data-transition="pop" id="newloadForm" style="display:inline;" onsubmit="return ValidateForm1(this)">
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
<div class="ui-field-contain">
	<label for="name">* שם המטען</label>
	<input type="text" id="name" style="" name="name" value="">
</div><div class="ui-field-contain">
	<label for="type">* סוג המטען</label>
	<select name="type" size="1" id="type">
	<option>-- בחר --</option>
	<option value="CONTAINER_20">מכולה 20'</option>
	<option value="CONTAINER_40">מכולה 40'</option>
	<option value="LIFTS">משטחים</option>
	<option value="BAGS">שקים (באלות)</option>
	<option value="ANIMALS">בעלי חיים</option>
	<option value="SCATTERED">תפזורת</option>
	<option value="HAZMAT">חומ"ס</option>
	<option value="OTHER">אחר</option>
	</select>
</div><div class="ui-field-contain">
	<label for="weight">* משקל (ק"ג)</label>
	<input type="number" id="weight" style="" name="weight" value="">
</div><div class="ui-field-contain">
	<label for="volume">* נפח (קוב)</label>
	<input type="number" id="volume" style="" name="volume" value="">
</div><div class="ui-field-contain">
	<label for="source">* מוצא</label>
	<input type="text" id="source" style="" name="source" value="" placeholder="הכנס כתובת">
	<input type="hidden" id="sourceLat" name="sourceLat" value="">
	<input type="hidden" id="sourceLng" name="sourceLng" value="">
</div><div class="ui-field-contain">
	<label for="loadingType">* סוג טעינה</label>
	<select name="loadingType" size="1" id="loadingType">
	<option>-- בחר --</option>
	<option value="MANUAL">ידני</option>
	<option value="FORKLIFT">מלגזה</option>
	<option value="CRANE">מנוף</option>
	<option value="RAMP">רמפה</option>
	<option value="TROLLY">עגלה</option>
	</select>
</div><div class="ui-field-contain">
	<label for="destination">* יעד</label>
	<input type="text" id="destination" style="" name="destination" value="" placeholder="הכנס כתובת">
	<input type="hidden" id="destinationLat" name="destinationLat" value="">
	<input type="hidden" id="destinationLng" name="destinationLng" value="">
</div><div class="ui-field-contain">
	<label for="downloadingType">* סוג פריקה</label>
	<select name="downloadingType" size="1" id="downloadingType">
	<option>-- בחר --</option>
	<option value="MANUAL">ידני</option>
	<option value="FORKLIFT">מלגזה</option>
	<option value="CRANE">מנוף</option>
	<option value="RAMP">רמפה</option>
	<option value="TROLLY">עגלה</option>
	</select>
</div><div class="ui-field-contain">
	<label for="drivedate">* זמינות להובלה מתאריך</label>
	<input type="text" id="drivedate" style="" name="drivedate" value="" onfocus="blur();">
</div><div class="ui-field-contain">
	<label for="suggestedQuote">* מחיר (שקלים)</label>
	<input type="number" id="suggestedQuote" style="" name="suggestedQuote" value="">
</div><div class="ui-field-contain">
	<label for="waitingTime">זמן המתנה (שעות)</label>
	<input type="number" id="waitingTime" style="" name="waitingTime" value="">
</div><div class="ui-field-contain">
	<label for="comments">הערות</label>
	<input type="text" id="comments" style="" name="comments" value="">
</div><div class="ui-field-contain">
	<label for="loadPhoto1">צילום המטען</label>
	<input type="file" id="loadPhoto1" style="" name="loadPhoto1">
	<input type="hidden" id="loadPhoto" name="loadPhoto">
</div>
<input type="submit" id="Button1" name="" value="הוסף מטען">
</form>
</div>
</div>
	
	<div data-role="panel" id="mypanel" data-display="overlay" data-position="left">
		<ul data-role="listview" style='text-align:right;'>
			<li data-icon="power"><a href="/logout" style="text-align:right; font-size:0.8em;"> התנתק</a></li>
		</ul>
	</div><!-- /panel -->	
	
</div> <!--page -->

<div data-role="dialog" id="sure">
  <div data-role="content">
    <h3 class="sure-1">???</h3>
    <a href="#" class="sure-do" data-role="button" data-theme="b" data-rel="back">סגור</a>
  </div>
</div>

</body>
</html>