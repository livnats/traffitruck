  req = {
	required: true
  };

  reqNum = {
	required: true,
	number: true
  };

  msg = {
	required: "שדה חובה"
  };

  msgNum = {
	required: "שדה חובה",
	number: "השדה חייב להיות מספר"
  };

  approveTruckValidationOptions = {
			rules: {
				licensePlateNumberApproved: req,
				type: req,
				ownerName: req,
				ownerId: req,
				ownerAddress: req,
				manufactureYear: reqNum,
				fuelType: req,
				tires: req,
				overallweight: reqNum,
				selfweight: reqNum,
				permittedweight: reqNum,
				engineCapacity: reqNum,
				engineOutput: req,
				color: req,
				fuelType: req
			},
			messages: {
				licensePlateNumberApproved: 'חובה לאשר',
				type: msg,
				ownerName: msg,
				ownerId: msg,
				ownerAddress: msg,
				manufactureYear: msgNum,
				fuelType: msg,
				tires: msg,
				overallweight: msgNum,
				selfweight: msgNum,
				permittedweight: msgNum,
				engineCapacity: msgNum,
				engineOutput: msg,
				color: msg,
				fuelType: msg
			},
			errorPlacement: function(error, element) {
				if (element.attr("name") == "licensePlateNumberApproved" ) {
					error.insertAfter("#licensePlateNumberApprovedLabel");
				} else {
				error.insertAfter(element);
 			}
 		}
	};
	
