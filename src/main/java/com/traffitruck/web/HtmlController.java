package com.traffitruck.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.traffitruck.domain.Load;
import com.traffitruck.service.MongoDAO;

@RestController
public class HtmlController {

	@Autowired
	private MongoDAO dao;
	
    @RequestMapping("/loads")
    ModelAndView greetings(@RequestParam(value="name", required=false) String name) {
    	List<Load> loads = dao.getLoads();
        return new ModelAndView("show_loads", "loads", loads);
    }

}
