package com.traffitruck.web;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.traffitruck.domain.Load;
import com.traffitruck.domain.User;
import com.traffitruck.service.MongoDAO;

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
    	List<Load> loads = dao.getLoads();
        return new ModelAndView("show_loads", "loads", loads);
    }

    @RequestMapping(value = "/newload", method = RequestMethod.POST, consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE)
    ModelAndView newLoad(@ModelAttribute("load") Load load) {
    	load.setCreationDate(new Date());
    	Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
    	String username = authentication.getName();
    	load.setUsername(username);
        dao.storeLoad(load);
        return new ModelAndView("redirect:/loads");
    }

    @RequestMapping(value = "/registerUser", method = RequestMethod.GET)
    ModelAndView registerUser() {
        return new ModelAndView("register_user");
    }

    @RequestMapping(value = "/registerUser", method = RequestMethod.POST, consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE)
    ModelAndView registerUser(@ModelAttribute("user") User user) {
        dao.storeUser(user);
        return new ModelAndView("redirect:/registrationConfirmation");
    }
    
    @RequestMapping("/newload")
    ModelAndView newLoad() {
        return new ModelAndView("new_load");
    }

    @RequestMapping("/registrationConfirmation")
    ModelAndView registrationConfirmation() {
        return new ModelAndView("registration_confirmation");
    }
}
