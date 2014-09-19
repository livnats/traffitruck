package com.traffitruck.web;

import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.bson.types.Binary;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.traffitruck.domain.Load;
import com.traffitruck.domain.LoadsUser;
import com.traffitruck.domain.Truck;
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

    @RequestMapping({"/","/loads"})
    ModelAndView showLoads() {
        Map<String, Object> model = new HashMap<>();
        model.put("enums", BeansWrapper.getDefaultInstance().getEnumModels());
        model.put("loads", dao.getLoads());
        return new ModelAndView("show_loads", model);
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

    @RequestMapping(value = "/registerUser", method = RequestMethod.POST, consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE)
    ModelAndView registerUser(@ModelAttribute("user") LoadsUser user) {
        dao.storeUser(user);
        return new ModelAndView("redirect:/registrationConfirmation");
    }
    
    @RequestMapping(value = "/deleteLoad", method = RequestMethod.POST, consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE)
    ModelAndView deleteLoad(String loadId) {
        dao.deleteLoadById(loadId);
        return new ModelAndView("redirect:/myLoads");
    }
    
    @RequestMapping("/newload")
    ModelAndView newLoad() {
        Map<String, Object> model = new HashMap<>();
        model.put("enums", BeansWrapper.getDefaultInstance().getEnumModels());
		return new ModelAndView("new_load", model );
    }

    @RequestMapping("/registrationConfirmation")
    ModelAndView registrationConfirmation() {
        return new ModelAndView("registration_confirmation");
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
    
    @RequestMapping(value = "/newTruck", method = RequestMethod.POST, consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    ModelAndView newTruck(@RequestParam("licensePlateNumber") String licensePlateNumber,
    					  @RequestParam("truckPhoto") MultipartFile truckPhoto,
    		              @RequestParam("licensePlatePhoto") MultipartFile licensePlatePhoto) throws IOException{
        
    	Truck truck = new Truck();
    	truck.setLicensePlateNumber(licensePlateNumber);
    	truck.setLicensePlatePhoto(new Binary(licensePlatePhoto.getBytes()));
    	truck.setTruckPhoto(new Binary(truckPhoto.getBytes()));
    	Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
    	String username = authentication.getName();
    	truck.setUsername(username);
    	truck.setCreationDate(new Date());
    	truck.setRegistrationStatus(TruckRegistrationStatus.Registered);
    	dao.storeTruck(truck);
        return new ModelAndView("redirect:/myTrucks");
    }
    
}
