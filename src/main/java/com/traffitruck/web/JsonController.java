package com.traffitruck.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.traffitruck.domain.Load;
import com.traffitruck.service.MongoDAO;

@RestController
public class JsonController {

	@Autowired
	private MongoDAO dao;

	 @RequestMapping(value="/load_details/{loadId}", method=RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	    public Load getUser(@PathVariable String loadId) {
	        return dao.getLoad(loadId);
	    }
   

}
