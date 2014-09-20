  req = {
	required: true
  }

  reqNum = {
	required: true,
	number: true
  }

  msg = {
	required: "שדה חובה"
  }

  msgNum = {
	required: "שדה חובה",
	number: "השדה חייב להיות מספר"
  }

  approveTruckValidationOptions = {
			rules: {
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
			}
	};
	
