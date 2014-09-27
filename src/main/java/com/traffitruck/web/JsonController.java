package com.traffitruck.web;

import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.traffitruck.domain.Load;
import com.traffitruck.domain.LoadAndUser;
import com.traffitruck.domain.LoadsUser;
import com.traffitruck.domain.Truck;
import com.traffitruck.service.MongoDAO;

@RestController
public class JsonController {

	@Autowired
	private MongoDAO dao;

	@RequestMapping(value="/load_details/{loadId}", method=RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	public Load getLoad(@PathVariable String loadId) {
		return dao.getLoad(loadId);
	}

	@RequestMapping(value="/load_user_details/{licensePlateNumber}/{loadId}", method=RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	public LoadAndUser getLoadAndUser(@PathVariable String licensePlateNumber, @PathVariable String loadId) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String username = authentication.getName();
		// verify the truck belongs to the logged-in user
		Truck truck = dao.getTruckByUserAndLicensePlate(username, licensePlateNumber);
		if (truck == null) { // the logged in user does not have a truck with this license plate number
			return null;
		}
		Load load = dao.getLoad(loadId);
		LoadsUser user = dao.getUser(username);
		return new LoadAndUser(load, user);
	}

	@RequestMapping(value="/load_for_truck/{licensePlateNumber}", method=RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	public List<Load> getLoadsForTruck(@PathVariable String licensePlateNumber) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String username = authentication.getName();
		// verify the truck belongs to the logged-in user
		Truck truck = dao.getTruckByUserAndLicensePlate(username, licensePlateNumber);
		if (truck == null) { // the logged in user does not have a truck with this license plate number
			return Collections.emptyList();
		}

		return dao.getLoadsForTruck(truck);
	}
}
