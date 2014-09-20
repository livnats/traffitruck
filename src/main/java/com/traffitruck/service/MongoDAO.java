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
import com.traffitruck.domain.Truck;
import com.traffitruck.domain.TruckRegistrationStatus;

@Component
public class MongoDAO {

	private final MongoTemplate mongoTemplate;

    @Autowired
    public MongoDAO(MongoTemplate mongoTemplate) {
        this.mongoTemplate = mongoTemplate;
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
    public List<Truck> getTrucksForUser(String username) {
    	Query findByUsername = new Query().addCriteria(Criteria.where("username").is(username));
    	findByUsername.fields().exclude("licensePlatePhoto");
    	findByUsername.fields().exclude("truckPhoto");
    	findByUsername.with(new Sort("creationDate"));
    	return mongoTemplate.find(findByUsername,Truck.class);
    }
    
    public void deleteLoadById( String id ){
    	mongoTemplate.remove(new Query().addCriteria(Criteria.where("_id").is(id)),Load.class);
    }
    
    //User
    public void storeUser( LoadsUser user ) {
    	mongoTemplate.insert(user);
    }
    
    public List<LoadsUser> getUsers() {
    	Query sortByName = new Query().with(new Sort("name"));
    	return mongoTemplate.find(sortByName,LoadsUser.class);
    }
    
    ///Truck
    public void storeTruck( Truck truck ) {
    	mongoTemplate.insert(truck);
    }

    public Truck getTruckById( String id ) {
    	return mongoTemplate.findById(id, Truck.class);
    }
    
    public List<Truck> getNonApprovedTrucks() {
    	Query findNonApprovedTrucks = new Query().addCriteria(Criteria.where("registrationStatus").is(TruckRegistrationStatus.Registered));
    	findNonApprovedTrucks.fields().exclude("licensePlatePhoto");
    	findNonApprovedTrucks.fields().exclude("truckPhoto");
    	findNonApprovedTrucks.with(new Sort("creationDate"));
    	return mongoTemplate.find(findNonApprovedTrucks, Truck.class);
    }
    
}
