package com.traffitruck.web;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Base64;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.TimeZone;

import org.bson.types.Binary;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.traffitruck.domain.Load;
import com.traffitruck.domain.LoadsUser;
import com.traffitruck.domain.Location;
import com.traffitruck.domain.Truck;
import com.traffitruck.domain.TruckAvailability;
import com.traffitruck.domain.TruckRegistrationStatus;
import com.traffitruck.service.DuplicateException;
import com.traffitruck.service.MongoDAO;

import freemarker.ext.beans.BeansWrapper;

@RestController
public class HtmlController {

    @Autowired
    private MongoDAO dao;

    @RequestMapping("/login")
    ModelAndView login() {
	return new ModelAndView("login");
    }

    @RequestMapping({"/loads"})
    ModelAndView showLoads() {
	Map<String, Object> model = new HashMap<>();
	model.put("enums", BeansWrapper.getDefaultInstance().getEnumModels());
	model.put("loads", dao.getLoads());
	return new ModelAndView("show_loads", model);
    }

    @RequestMapping({"/trucks"})
    ModelAndView showTrucks() {
	Map<String, Object> model = new HashMap<>();
	model.put("enums", BeansWrapper.getDefaultInstance().getEnumModels());
	model.put("trucks", dao.getTrucksWithoutImages());
	return new ModelAndView("show_trucks", model);
    }

    @RequestMapping({"/findTrucksForLoad"})
    ModelAndView findTrucksForLoad() {
	Map<String, Object> model = new HashMap<>();
	Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	String username = authentication.getName();
	model.put("enums", BeansWrapper.getDefaultInstance().getEnumModels());
	model.put("trucks", dao.getTrucksForUserAndRegistration(username, TruckRegistrationStatus.APPROVED));
	return new ModelAndView("find_load_for_trucks", model);
    }

    @RequestMapping(value = "/newload", method = RequestMethod.POST, consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    ModelAndView newLoad(@ModelAttribute("load") Load load, BindingResult br1,
	    @RequestParam("loadPhoto") byte[] loadPhoto, BindingResult br2,
	    @RequestParam("drivedate") String drivedate, BindingResult br3,
	    @RequestParam("sourceLat") Double sourceLat, BindingResult br4,
	    @RequestParam("sourceLng") Double sourceLng, BindingResult br5,
	    @RequestParam("destinationLat") Double destinationLat, BindingResult br6,
	    @RequestParam("destinationLng") Double destinationLng, BindingResult br7
	    ) throws IOException {
	SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yy");
	load.setCreationDate(new Date());
	try {
	    load.setDriveDate(sdf.parse(drivedate));
	} catch (ParseException e) {
	    throw new RuntimeException(e);
	}
	Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	String username = authentication.getName();
	load.setUsername(username);
	if (loadPhoto != null) {
	    load.setLoadPhoto(new Binary(loadPhoto));
	}
	if (sourceLat != null && sourceLng != null) {
	    load.setSourceLocation(new Location(new double[] { sourceLng, sourceLat}));
	}
	if (destinationLat != null && destinationLng != null) {
	    load.setDestinationLocation(new Location(new double[] { destinationLng, destinationLat}));
	}
	dao.storeLoad(load);
	return new ModelAndView("redirect:/myLoads");
    }

    @RequestMapping("/newload")
    ModelAndView newLoad() {
	Map<String, Object> model = new HashMap<>();
	model.put("enums", BeansWrapper.getDefaultInstance().getEnumModels());
	return new ModelAndView("new_load", model );
    }

    @RequestMapping(value = "/myLoads")
    ModelAndView myLoads() {
	Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	String username = authentication.getName();
	Map<String, Object> model = new HashMap<>();
	model.put("enums", BeansWrapper.getDefaultInstance().getEnumModels());
	model.put("loads", dao.getLoadsForUser(username));
	return new ModelAndView("my_loads", model);
    }

    @RequestMapping(value = "/registerUser", method = RequestMethod.GET)
    ModelAndView registerUser() {
	return new ModelAndView("register_user");
    }

    @RequestMapping(value = "/addAvailability", method = RequestMethod.GET)
    ModelAndView addAvailability() {
	Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	String username = authentication.getName();
	Map<String, Object> model = new HashMap<>();
	model.put("enums", BeansWrapper.getDefaultInstance().getEnumModels());
	model.put("trucks", dao.getMyApprovedTrucksId(username));
	return new ModelAndView("add_availability", model);
    }

    @RequestMapping(value = "/addAvailability", method = RequestMethod.POST, consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE)
    ModelAndView addAvailability(@RequestParam("truckId") String truckId,
	    @RequestParam("source") String source,
	    @RequestParam("destination") String destination,
	    @RequestParam("availTime") String availTime,
	    @RequestParam("dateAvail") String dateAvail,
	    @RequestParam("hourAvail") String hourAvail) throws IOException, ParseException{

	TruckAvailability truckAvail = new TruckAvailability();
	truckAvail.setTruckId(truckId);
	truckAvail.setSource(source);
	truckAvail.setDestination(destination);
	Date now = new Date();
	truckAvail.setCreationDate(now);
	if("now".equals(availTime)){
	    truckAvail.setAvailableStart(now);
	}
	else{
	    SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyyHHmm");
	    sdf.setTimeZone(TimeZone.getTimeZone("Asia/Jerusalem"));
	    Date requestedTime = sdf.parse(dateAvail+hourAvail);
	    truckAvail.setAvailableStart(requestedTime);
	}
	dao.storeTruckAvailability(truckAvail);
	return new ModelAndView("redirect:/addAvailability");
    }

    @RequestMapping(value = "/registerUser", method = RequestMethod.POST, consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE)
    ModelAndView registerUser(@ModelAttribute("user") LoadsUser user) {
	user.setUsername(user.getUsername().toLowerCase());
	try {
	    dao.storeUser(user);
	}
	catch ( DuplicateException e) {
		Map<String, Object> model = new HashMap<>();
		model.put("error", "dup");
		model.put("address", user.getAddress());
		model.put("cellNumber", user.getCellNumber());
		model.put("email", user.getEmail());
		model.put("phoneNumber", user.getPhoneNumber());
		model.put("role", user.getRole().toString());
		model.put("contactPerson", user.getContactPerson());
		return new ModelAndView("register_user", model);
	}
	SecurityContextHolder.getContext().setAuthentication(
		new UsernamePasswordAuthenticationToken(
			user.getUsername(),
			"",
			Collections.singletonList(new SimpleGrantedAuthority(user.getRole().toString()))));
	return new ModelAndView("redirect:" + user.getRole().getLandingUrl());
    }

    @RequestMapping(value = "/deleteLoad", method = RequestMethod.POST, consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE)
    ModelAndView deleteLoad(String loadId) {
	dao.deleteLoadById(loadId);
	return new ModelAndView("redirect:/myLoads");
    }

    @RequestMapping(value = "/truckApproval", method = RequestMethod.POST, consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE)
    ModelAndView approveTruck(@ModelAttribute("truck") Truck truck) {
	truck.setRegistrationStatus(TruckRegistrationStatus.APPROVED);
	dao.updateTruck(truck);
	return new ModelAndView("redirect:/adminMenu");
    }

    @RequestMapping(value = "/myTrucks")
    ModelAndView myTrucks() {
	Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	String username = authentication.getName();
	Map<String, Object> model = new HashMap<>();
	model.put("enums", BeansWrapper.getDefaultInstance().getEnumModels());
	model.put("trucks", dao.getTrucksForUser(username));
	return new ModelAndView("my_trucks", model);
    }

    @RequestMapping(value = "/truckerMenu")
    ModelAndView truckerMenu() {
	return new ModelAndView("trucker_menu");
    }

    @RequestMapping(value = "/adminMenu")
    ModelAndView adminMenu() {
	return new ModelAndView("admin_menu");
    }

    @RequestMapping("/nonApprovedTrucks")
    ModelAndView showNonApprovedTrucks() {
	Map<String, Object> model = new HashMap<>();
	model.put("enums", BeansWrapper.getDefaultInstance().getEnumModels());
	model.put("trucks", dao.getNonApprovedTrucks());
	return new ModelAndView("show_non_approved_trucks", model);
    }

    @RequestMapping(value = "/approval/licenseimage/{truckId}", method = RequestMethod.GET, produces = MediaType.IMAGE_PNG_VALUE)
    public byte[] getTruckLicenseImage(@PathVariable String truckId) {
	String b64dataUrl = new String(dao.getTruckById(truckId).getVehicleLicensePhoto().getData());
	byte[] bytes = b64dataUrl.substring(b64dataUrl.indexOf(',') + 1).getBytes();
	return Base64.getDecoder().decode(bytes);
    }

    @RequestMapping(value = "/load/image/{loadId}", method = RequestMethod.GET, produces = MediaType.IMAGE_PNG_VALUE)
    public byte[] getLoadImage(@PathVariable String loadId) {
	String b64dataUrl = new String(dao.getLoadPhoto(loadId));
	byte[] bytes = b64dataUrl.substring(b64dataUrl.indexOf(',') + 1).getBytes();
	return Base64.getDecoder().decode(bytes);
    }

    @RequestMapping("/truckApproval")
    ModelAndView approveTruck(@RequestParam("truckId") String id) {
	Map<String, Object> model = new HashMap<>();
	model.put("enums", BeansWrapper.getDefaultInstance().getEnumModels());
	model.put("truck", dao.getTruckByIdWithoutImages(id));
	return new ModelAndView("truck_approval", model);
    }

    @RequestMapping("/newTruck")
    ModelAndView newTruck() {
	return new ModelAndView("new_truck");
    }

    @RequestMapping(value = "/newTruck", method = RequestMethod.POST, consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    ModelAndView newTruck(@RequestParam("licensePlateNumber") String licensePlateNumber,
	    @RequestParam("truckPhoto") byte[] truckPhoto,
	    @RequestParam("vehicleLicensePhoto") byte[] vehicleLicensePhoto) throws IOException{

	Truck truck = new Truck();
	truck.setLicensePlateNumber(licensePlateNumber);
	truck.setVehicleLicensePhoto(new Binary(vehicleLicensePhoto));
	truck.setTruckPhoto(new Binary(truckPhoto));
	Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	String username = authentication.getName();
	truck.setUsername(username);
	truck.setCreationDate(new Date());
	truck.setRegistrationStatus(TruckRegistrationStatus.REGISTERED);
	try {
	    dao.storeTruck(truck);
	}
	catch ( DuplicateException e) {
		Map<String, Object> model = new HashMap<>();
		model.put("error", "dup");
		return new ModelAndView("new_truck", model);
	}
	return new ModelAndView("redirect:/myTrucks");
    }

    @RequestMapping(value="/load_details/{loadId}", method=RequestMethod.GET)
    ModelAndView getLoad(@PathVariable String loadId) {
	Load load = dao.getLoad(loadId);
	Map<String, Object> model = new HashMap<>();
	model.put("load", load);
	model.put("enums", BeansWrapper.getDefaultInstance().getEnumModels());
	return new ModelAndView("load_details", model);
    }

    @RequestMapping(value="/load_details_for_trucker/{loadId}", method=RequestMethod.GET)
    ModelAndView getLoadForTrucker(@PathVariable String loadId) {
	Load load = dao.getLoad(loadId);
	LoadsUser loadsUser = dao.getUser(load.getUsername());
	Map<String, Object> model = new HashMap<>();
	model.put("load", load);
	model.put("loadsUser", loadsUser);
	model.put("enums", BeansWrapper.getDefaultInstance().getEnumModels());
	return new ModelAndView("load_details_for_trucker", model);
    }
}
