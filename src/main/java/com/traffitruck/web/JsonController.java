package com.traffitruck.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.traffitruck.domain.Load;
import com.traffitruck.domain.Trucker;
import com.traffitruck.service.MongoDAO;

@RestController
public class JsonController {

	@Autowired
	private MongoDAO dao;

	 @RequestMapping(value="/load_details/{loadId}", method=RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	    public Load getUser(@PathVariable String loadId) {
	        return dao.getLoad(loadId);
	    }

    @RequestMapping(value = "/create", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE, consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE)
    @ResponseBody
    public Trucker createTrucker(@ModelAttribute("trucker") Trucker trucker) {
        dao.storeTrucker(trucker);
        return trucker;
    }
    

}
