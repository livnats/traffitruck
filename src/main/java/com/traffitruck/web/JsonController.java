package com.traffitruck.web;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.TimeZone;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
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

	@RequestMapping(value="/create_alert", method=RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
	public String createAlert(
			@RequestParam("licensePlateNumber") String licensePlateNumber,
			@RequestParam("sourceLat") Double sourceLat,
			@RequestParam("sourceLng") Double sourceLng,
			@RequestParam("destinationLat") Double destinationLat,
			@RequestParam("destinationLng") Double destinationLng,
			@RequestParam(value="source_radius", required=false) Integer source_radius,
			@RequestParam(value="destination_radius", required=false) Integer destination_radius,
			@RequestParam("drivedate") String drivedate
			) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String username = authentication.getName();
		return null;
	}

	@RequestMapping(value="/load_for_truck_by_radius", method=RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
	public List<Load> getLoadsForTruckByDistance(
			@RequestParam("licensePlateNumber") String licensePlateNumber,
			@RequestParam("sourceLat") Double sourceLat,
			@RequestParam("sourceLng") Double sourceLng,
			@RequestParam("destinationLat") Double destinationLat,
			@RequestParam("destinationLng") Double destinationLng,
			@RequestParam(value="source_radius", required=false) Integer source_radius,
			@RequestParam(value="destination_radius", required=false) Integer destination_radius,
			@RequestParam("drivedate") String drivedate
			) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String username = authentication.getName();
		// verify the truck belongs to the logged-in user
		Truck truck = dao.getTruckByUserAndLicensePlate(username, licensePlateNumber);
		if (truck == null) { // the logged in user does not have a truck with this license plate number
			return Collections.emptyList();
		}
		Date driveDateObj = null;
		if (drivedate != null && drivedate.length() > 0) {
			SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yy");
			sdf.setTimeZone(TimeZone.getTimeZone("GMT"));
			try {
				driveDateObj = sdf.parse(drivedate);
			} catch (ParseException e) {
				throw new RuntimeException(e);
			}
		}
		// set default value for radius if not set
		if ( sourceLat != null && sourceLng != null && source_radius == null ) {
			source_radius = 20;
		}
		if ( destinationLat != null && destinationLng != null && destination_radius == null ) {
			destination_radius = 20;
		}

		return dao.getLoadsForTruckByFilter(truck, sourceLat, sourceLng, source_radius, destinationLat, destinationLng, destination_radius, driveDateObj);
	}
}
