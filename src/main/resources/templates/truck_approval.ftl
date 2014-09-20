<html dir="rtl">
<head>
    <title>TraffiTruck</title>
	<meta charset="UTF-8">
	<link rel="stylesheet" type="text/css" href="/css/traffitruck.css">
		<script type="text/javascript" src="js/jquery-1.11.1.min.js"></script>
		<script type="text/javascript" src="js/jquery.validate.min.js"></script>
		
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
			<h2>עדכן פרטי משאית</h2>
			<form id="approveTruck" method="post" action="approveTruck">
			    <table>
			    	<tr> 
						<td  colspan='2'>
							<a href="/">חזור לעמוד הראשי</a>
						</td>
					</tr>
				 	<tr>
				        <td  colspan='2'>
				        	<label >מספר לוחית זיהוי: ${truck.licensePlateNumber} </label>
			        	</td>
				    </tr>
				    <tr>
				        <td colspan='2'>
				        	<input type="checkbox" name="licensePlateNumberApproved"/> אני מאשר כי מספר לוחית הזיהוי תואם למספר המופיע ברשיון הרכב
			        	</td>
				    </tr>
				    <tr>
				    	<td><label for="type">סוג :</label></td> 
				        <td>
				        	<select name="type">
							  <option value="">-- בחר --</option>
							  <option value="${enums["com.traffitruck.domain.TruckType"].N1}">N1 פחות מ 3500 ק"ג</option>
							  <option value="${enums["com.traffitruck.domain.TruckType"].N2}">N2 בין 3500 ל 12000 ק"ג</option>
							  <option value="${enums["com.traffitruck.domain.TruckType"].N3}">N3 מעל 12000 ק"ג</option>
							</select>
						</td>
				    </tr>
				    <tr>
			      		<td><label for="ownerName">שם בעל הרכב:</label></td>
			        	<td><input name="ownerName"/></td> 
			    	</tr>
			    	<tr>
			      		<td><label for="ownerId">ת"ז בעל הרכב:</label></td>
			        	<td><input name="ownerId"/></td> 
			    	</tr>
			    	<tr>
			      		<td><label for="ownerAddress">כתובת בעל הרכב:</label></td>
			        	<td><input name="ownerAddress"/></td> 
			    	</tr>
				    <tr>
				    	<td><label for="manufactureYear">שנת ייצור:</label></td>
			        	<td><input name="manufactureYear"/></td> 
				    </tr>
					<tr>
				    	<td><label for="fuelType">סוג דלק</label></td>
				    	<td>
			        		<select name="fuelType">
							  <option value="">-- בחר --</option>
							  <option value="${enums["com.traffitruck.domain.FuelType"].DIESEL}">דיזל</option>
							  <option value="${enums["com.traffitruck.domain.FuelType"].GASOLINE_95}">בנזין 95</option>
							  <option value="${enums["com.traffitruck.domain.FuelType"].GASOLINE_98}">בנזין 98</option>
							</select>
						</td>
				    </tr>
				    <tr>
				    	<td><label for="tires">צמיגים:</label></td>
			        	<td><input name="tires"/></td> 
				    </tr>
				    <tr>
				    	<td><label for="overallweight">משקל כולל:</label></td>
			        	<td><input name="overallweight"/></td> 
				    </tr>
				    <tr>
				    	<td><label for="selfweight">משקל עצמי:</label></td>
			        	<td><input name="selfweight"/></td> 
				    </tr>
				    <tr>
				    	<td><label for="permittedweight">משקל מורשה:</label></td>
			        	<td><input name="permittedweight"/></td> 
				    </tr>
				    <tr>
				        <td colspan='2'>
				        	<input type="checkbox" name="hasHitch"/>יש וו גרירה
			        	</td>
				    </tr>
				    <tr>
				    	<td><label for="engineCapacity">נפח מנוע:</label></td>
			        	<td><input name="engineCapacity"/></td> 
				    </tr>  
				    <tr>
				    	<td><label for="engineOutput">תוצר מנוע:</label></td>
			        	<td><input name="engineOutput"/></td> 
				    </tr>  
				    <tr>
				    	<td><label for="color">צבע:</label></td>
			        	<td><input name="color"/></td> 
				    </tr>   
				    <tr>
				    	<td><label for="propulsion">הנעה:</label></td>
			        	<td>
			        		<select name="fuelType">
							  <option value="">-- בחר --</option>
							  <option value="${enums["com.traffitruck.domain.PropulsionType"]._4X2}">4X2</option>
							  <option value="${enums["com.traffitruck.domain.PropulsionType"]._4X4}">4X4</option>
							</select>
						</td>
				    </tr>
				    <tr>
			        <td colspan="2">
			            <input type="submit" value="עדכן פרטי משאית"/>
			        </td>
			    </tr>
			    </table>
			<!-- inlcude csrf token -->
		    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
			</form>
		</div>
		<div id="load_details">
			<img src="/approval/licenseimage/${truck.id}">
		</div>
	</div>
</div>
</body>
</html>