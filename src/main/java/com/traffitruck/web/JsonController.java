package com.traffitruck.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.traffitruck.domain.Trucker;
import com.traffitruck.service.MongoDAO;

@RestController
public class JsonController {

	@Autowired
	private MongoDAO dao;
	
    @RequestMapping(value = "/", produces = MediaType.APPLICATION_JSON_VALUE)
    List<Trucker> home() {
        return dao.getTruckers();//.toString();
    }
    
    @RequestMapping("/greetings")
    ModelAndView greetings(@RequestParam(value="name", required=false) String name) {
        return new ModelAndView("oded", "mdl", name);
    }

    @RequestMapping(value = "/create", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE, consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE)
    @ResponseBody
    public Trucker createTrucker(@ModelAttribute("trucker") Trucker trucker) {
        dao.storeTrucker(trucker);
        return trucker;
    }
    

}
