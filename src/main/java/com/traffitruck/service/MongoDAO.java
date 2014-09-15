package com.traffitruck.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Component;

import com.traffitruck.domain.Load;
import com.traffitruck.domain.LoadsUser;
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
    	Query sortByName = new Query().with(new Sort("name"));
    	return mongoTemplate.find(sortByName,Trucker.class);
    }
    
    
    //Load
    public void storeLoad( Load load ) {
    	mongoTemplate.insert(load);
    }
    
    public List<Load> getLoads() {
    	Query sortBySource = new Query().with(new Sort("source"));
    	return mongoTemplate.find(sortBySource,Load.class);
    }
    
    public Load getLoad( String loadId ) {
    	return mongoTemplate.findById(loadId, Load.class);
    }
    
    public List<Load> getLoadsForUser(String username) {
    	Query findByUsername = new Query().addCriteria(Criteria.where("username").is(username));
    	findByUsername.with(new Sort("name"));
    	return mongoTemplate.find(findByUsername,Load.class);
    }
    
    //User
    public void storeUser( LoadsUser user ) {
    	mongoTemplate.insert(user);
    }
    
    public List<LoadsUser> getUsers() {
    	Query sortByName = new Query().with(new Sort("name"));
    	return mongoTemplate.find(sortByName,LoadsUser.class);
    }
    

    
}
