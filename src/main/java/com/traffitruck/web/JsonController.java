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
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.traffitruck.domain.Alert;
import com.traffitruck.domain.Load;
import com.traffitruck.domain.LoadAndUser;
import com.traffitruck.domain.LoadsUser;
import com.traffitruck.domain.Location;
import com.traffitruck.domain.Role;
import com.traffitruck.domain.Truck;
import com.traffitruck.service.MongoDAO;

import freemarker.template.TemplateModelException;

@RestController
public class JsonController {

	public static final int DEFAULT_RADIUS_FOR_SEARCHES = 20;
	
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

	@RequestMapping(value="/load_for_truck_by_radius", method=RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
	public List<Load> getLoadsForTruckByDistance(
			@RequestParam("licensePlateNumber") String licensePlateNumber,
			@RequestParam("sourceLat") Double sourceLat,
			@RequestParam("sourceLng") Double sourceLng,
			@RequestParam("destinationLat") Double destinationLat,
			@RequestParam("destinationLng") Double destinationLng,
			@RequestParam(value="source_radius", required=false) Integer source_radius,
			@RequestParam(value="destination_radius", required=false) Integer destination_radius
			) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String username = authentication.getName();
		// verify the truck belongs to the logged-in user
		if (licensePlateNumber == null || licensePlateNumber.isEmpty() || licensePlateNumber.equals("NA")) {
            // set default value for radius if not set
            if ( sourceLat != null && sourceLng != null && source_radius == null ) {
                source_radius = DEFAULT_RADIUS_FOR_SEARCHES;
            }
            if ( destinationLat != null && destinationLng != null && destination_radius == null ) {
                destination_radius = DEFAULT_RADIUS_FOR_SEARCHES;
            }
		    return dao.getLoadsWithoutTruckByFilter(sourceLat, sourceLng, source_radius, destinationLat, destinationLng, destination_radius);
		}
		else {
    		Truck truck = dao.getTruckByUserAndLicensePlate(username, licensePlateNumber);
    		if (truck == null) { // the logged in user does not have a truck with this license plate number
    			return Collections.emptyList();
    		}
    		// set default value for radius if not set
    		if ( sourceLat != null && sourceLng != null && source_radius == null ) {
    			source_radius = DEFAULT_RADIUS_FOR_SEARCHES;
    		}
    		if ( destinationLat != null && destinationLng != null && destination_radius == null ) {
    			destination_radius = DEFAULT_RADIUS_FOR_SEARCHES;
    		}
    
    		return dao.getLoadsForTruckByFilter(truck, sourceLat, sourceLng, source_radius, destinationLat, destinationLng, destination_radius);
		}
	}

	@RequestMapping(value="/load_details_json/{loadId}", method=RequestMethod.GET)
	Load getLoad(@PathVariable String loadId) throws TemplateModelException {
		return dao.getLoad(loadId);
	}

	public static Date convertDriveDate(String drivedate) {
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
		return driveDateObj;
	}
	
	@RequestMapping(value = "/alertFromFilter", method = RequestMethod.POST)
	String newAlert(
			@RequestParam("source") String source,
			@RequestParam("sourceLat") Double sourceLat,
			@RequestParam("sourceLng") Double sourceLng,
			@RequestParam("destination") String destination,
			@RequestParam("destinationLat") Double destinationLat,
			@RequestParam("destinationLng") Double destinationLng
			) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String username = authentication.getName();
		Alert alert = new Alert();
		alert.setUsername(username);
		if (source != null && sourceLat != null && sourceLng != null) {
			alert.setSource(source);
			alert.setSourceLocation(new Location(new double[] { sourceLng, sourceLat}));
		}
		if (destination != null && destinationLat != null && destinationLng != null) {
			alert.setDestination(destination);
			alert.setDestinationLocation(new Location(new double[] { destinationLng, destinationLat}));
		}
		dao.storeAlert(alert);
		return "Success!";
	}
	
	@RequestMapping(value = "/deleteAlert", method = RequestMethod.POST)
	String deleteAlert(@RequestParam("alertId") String alertId) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String username = authentication.getName();
		dao.deleteAlert(alertId,username);
		return "Success!";
	}

	@RequestMapping(value = "/deleteLoadAdmin", method = RequestMethod.POST)
	String deleteLoad(@RequestParam("loadId") String loadId) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String username = authentication.getName();
		for ( GrantedAuthority auth : authentication.getAuthorities() ) {
			if ( Role.ADMIN.toString().equals(auth.getAuthority()) ) {
				dao.deleteLoadByAdmin(loadId);
			}
		}
		return "Success!";
	}
}
