package com.traffitruck.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.stereotype.Component;

import com.traffitruck.domain.Load;
import com.traffitruck.domain.Trucker;

@Component
public class MongoDAO {

	private final MongoTemplate mongoTemplate;

    @Autowired
    public MongoDAO(MongoTemplate mongoTemplate) {
        this.mongoTemplate = mongoTemplate;
    }
    
    
    //Trucker
    public void storeTrucker( Trucker trucker ) {
    	mongoTemplate.insert(trucker);
    }
     
    public List<Trucker> getTruckers() {
    	return mongoTemplate.findAll(Trucker.class);
    }
    
    
    //Load
    public void storeLoad( Load load ) {
    	mongoTemplate.insert(load);
    }
    
    public List<Load> getLoads() {
    	return mongoTemplate.findAll(Load.class);
    }
    
    
}