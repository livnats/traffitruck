package com.traffitruck.web;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.TimeZone;

import org.bson.types.Binary;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
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
import com.traffitruck.domain.Truck;
import com.traffitruck.domain.TruckAvailability;
import com.traffitruck.domain.TruckRegistrationStatus;
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
    
    @RequestMapping({"/"})
    ModelAndView showMain() {
        return new ModelAndView("main");
    }
    
    @RequestMapping(value = "/newload", method = RequestMethod.POST, consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE)
    ModelAndView newLoad(@ModelAttribute("load") Load load) {
    	load.setCreationDate(new Date());
    	Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
    	String username = authentication.getName();
    	load.setUsername(username);
        dao.storeLoad(load);
        return new ModelAndView("redirect:/myLoads");
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
        dao.storeUser(user);
        Collection<? extends GrantedAuthority> m = new ArrayList<>();
		SecurityContextHolder.getContext().setAuthentication(new UsernamePasswordAuthenticationToken(user.getUsername(), user.getPassword(), m ));
        return new ModelAndView("redirect:/");
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
        return new ModelAndView("redirect:/");
    }
    
    @RequestMapping("/newload")
    ModelAndView newLoad() {
        Map<String, Object> model = new HashMap<>();
        model.put("enums", BeansWrapper.getDefaultInstance().getEnumModels());
		return new ModelAndView("new_load", model );
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
    
   
    @RequestMapping("/newTruck")
    ModelAndView newTruck() {
        return new ModelAndView("new_truck");
    }
    
    @RequestMapping("/nonApprovedTrucks")
    ModelAndView showNonApprovedTrucks() {
    	Map<String, Object> model = new HashMap<>();
    	model.put("enums", BeansWrapper.getDefaultInstance().getEnumModels());
        model.put("trucks", dao.getNonApprovedTrucks());
        return new ModelAndView("show_non_approved_trucks", model);
    }
    
	@RequestMapping(value = "/approval/licenseimage/{truckId}", method = RequestMethod.GET, produces = MediaType.IMAGE_JPEG_VALUE)
	public byte[] getUser(@PathVariable String truckId) {
		return dao.getTruckById(truckId).getVehicleLicensePhoto().getData();
	}

    @RequestMapping("/truckApproval")
    ModelAndView approveTruck(@RequestParam("truckId") String id) {
    	Map<String, Object> model = new HashMap<>();
    	model.put("enums", BeansWrapper.getDefaultInstance().getEnumModels());
        model.put("truck", dao.getTruckByIdWithoutImages(id));
        return new ModelAndView("truck_approval", model);
    }
    

    
    @RequestMapping(value = "/newTruck", method = RequestMethod.POST, consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    ModelAndView newTruck(@RequestParam("licensePlateNumber") String licensePlateNumber,
    					  @RequestParam("truckPhoto") MultipartFile truckPhoto,
    		              @RequestParam("vehicleLicensePhoto") MultipartFile vehicleLicensePhoto) throws IOException{
        
    	Truck truck = new Truck();
    	truck.setLicensePlateNumber(licensePlateNumber);
    	truck.setVehicleLicensePhoto(new Binary(vehicleLicensePhoto.getBytes()));
    	truck.setTruckPhoto(new Binary(truckPhoto.getBytes()));
    	Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
    	String username = authentication.getName();
    	truck.setUsername(username);
    	truck.setCreationDate(new Date());
    	truck.setRegistrationStatus(TruckRegistrationStatus.REGISTERED);
    	dao.storeTruck(truck);
        return new ModelAndView("redirect:/myTrucks");
    }
    
}
