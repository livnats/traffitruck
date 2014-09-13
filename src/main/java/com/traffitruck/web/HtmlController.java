package com.traffitruck.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RestController;

import com.traffitruck.service.MongoDAO;

@RestController
public class HtmlController {

	@Autowired
	private MongoDAO dao;
}
