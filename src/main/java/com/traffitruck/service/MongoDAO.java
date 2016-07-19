package com.traffitruck.service;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import org.jasypt.util.password.StrongPasswordEncryptor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.index.GeoSpatialIndexType;
import org.springframework.data.mongodb.core.index.GeospatialIndex;
import org.springframework.data.mongodb.core.index.Index;
import org.springframework.data.mongodb.core.query.BasicQuery;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Component;

import com.traffitruck.domain.Load;
import com.traffitruck.domain.LoadsUser;
import com.traffitruck.domain.ResetPassword;
import com.traffitruck.domain.Truck;
import com.traffitruck.domain.TruckAvailability;
import com.traffitruck.domain.TruckRegistrationStatus;

@Component
public class MongoDAO {

    private final MongoTemplate mongoTemplate;

    @Autowired
    public MongoDAO(MongoTemplate mongoTemplate) {
	this.mongoTemplate = mongoTemplate;
	// Creates an index on the specified field if the index does not already exist
	mongoTemplate.indexOps(Load.class).ensureIndex(new GeospatialIndex("sourceLocation").typed(GeoSpatialIndexType.GEO_2DSPHERE));
	mongoTemplate.indexOps(Load.class).ensureIndex(new GeospatialIndex("destinationLocation").typed(GeoSpatialIndexType.GEO_2DSPHERE));
	mongoTemplate.indexOps(Truck.class).ensureIndex(new Index("licensePlateNumber", Direction.ASC).unique());
	mongoTemplate.indexOps(LoadsUser.class).ensureIndex(new Index("username", Direction.ASC).unique());
	mongoTemplate.indexOps(LoadsUser.class).ensureIndex(new Index("email", Direction.ASC).unique());
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
	Query q = new Query();
	q.addCriteria(Criteria.where("_id").is(loadId));
	q.fields().exclude("loadPhoto");
	List<Load> loadslist = mongoTemplate.find(q,Load.class);
	if (loadslist.isEmpty())
	    return null;
	return loadslist.get(0);
    }

    public byte[] getLoadPhoto( String loadId ) {
	Load load = mongoTemplate.findById(loadId, Load.class);
	return (load != null) ? load.getLoadPhoto().getData() : null;
    }

    public List<Load> getLoadsForUser(String username) {
	Query findByUsername = new Query()
		.addCriteria(Criteria.where("username").is(username));
	findByUsername.with(new Sort("driveDate"));
	return mongoTemplate.find(findByUsername,Load.class);
    }

    public List<Truck> getTrucksForUser(String username) {
	return getTrucksForUserAndRegistration(username, null);
    }

    public List<Truck> getTrucksForUserAndRegistration(String username, TruckRegistrationStatus registrationStatus) {
	Query query = new Query().addCriteria(Criteria.where("username").is(username));
	if (registrationStatus != null) {
	    query.addCriteria(Criteria.where("registrationStatus").is(registrationStatus));
	}
	query.fields().exclude("vehicleLicensePhoto");
	query.fields().exclude("truckPhoto");
	query.with(new Sort("creationDate"));
	return mongoTemplate.find(query,Truck.class);
    }

    public List<Truck> getTrucksWithoutImages() {
	Query findByUsername = new Query();
	findByUsername.fields().exclude("vehicleLicensePhoto");
	findByUsername.fields().exclude("truckPhoto");
	findByUsername.with(new Sort("creationDate"));
	return mongoTemplate.find(findByUsername,Truck.class);
    }

    public void deleteLoadById( String id, String username ){
	Query query = new Query()
		.addCriteria(Criteria.where("_id").is(id))
		.addCriteria(Criteria.where("username").is(username));
	mongoTemplate.remove(query,Load.class);
    }

    //User
    public void storeUser( LoadsUser user ) {
	StrongPasswordEncryptor passwordEncryptor = new StrongPasswordEncryptor();
	String encryptedPassword = passwordEncryptor.encryptPassword(user.getPassword());
	user.setPassword(encryptedPassword);
	try {
	    mongoTemplate.save(user);
	}
	catch (DuplicateKeyException e) {
	    if ( e.getMessage().contains("email") )
		throw new DuplicateEmailException(user.getEmail());
	    else
		throw new DuplicateException(user.getUsername());
	}
    }

    public List<LoadsUser> getUsers() {
	Query sortByName = new Query().with(new Sort("name"));
	return mongoTemplate.find(sortByName,LoadsUser.class);
    }

    ///Truck
    public void storeTruck( Truck truck ) {
	try {
	    mongoTemplate.insert(truck);
	}
	catch ( DuplicateKeyException e ) {
	    throw new DuplicateException(truck.getLicensePlateNumber());
	}
    }

    public List<Truck> getMyApprovedTrucksId(String username){
	Query findByUsername = new Query().addCriteria(Criteria.where("username").is(username));
	findByUsername.addCriteria(Criteria.where("registrationStatus").is(TruckRegistrationStatus.APPROVED));
	findByUsername.fields().include("id");
	findByUsername.fields().include("licensePlateNumber");
	findByUsername.with(new Sort("creationDate"));
	return mongoTemplate.find(findByUsername,Truck.class);
    }

    public void updateTruck( Truck truck ) {
	Query findtruckToUpdate = new Query().addCriteria(Criteria.where("_id").is(truck.getId()));
	Update update = new Update();
	update.set("registrationStatus", truck.getRegistrationStatus());
	update.set("type",truck.getType());
	update.set("ownerName", truck.getOwnerName());
	update.set("ownerId", truck.getOwnerId());
	update.set("ownerAddress", truck.getOwnerAddress());
	update.set("maxWeight", truck.getMaxWeight());
	update.set("maxVolume", truck.getMaxVolume());
	update.set("acceptableLoadTypes", truck.getAcceptableLoadTypes());
	update.set("acceptableLiftTypes", truck.getAcceptableLiftTypes());
	mongoTemplate.upsert(findtruckToUpdate,update, Truck.class);
    }

    public Truck getTruckByIdWithoutImages( String id ) {
	Query findTruckByIdQuery = new Query().addCriteria(Criteria.where("_id").is(id));
	findTruckByIdQuery.fields().exclude("vehicleLicensePhoto");
	findTruckByIdQuery.fields().exclude("truckPhoto");
	findTruckByIdQuery.with(new Sort("creationDate"));
	return mongoTemplate.findOne(findTruckByIdQuery, Truck.class);
    }

    public Truck getTruckById( String id ) {
	return mongoTemplate.findById(id, Truck.class);
    }

    public List<Truck> getNonApprovedTrucks() {
	Query findNonApprovedTrucks = new Query().addCriteria(Criteria.where("registrationStatus").is(TruckRegistrationStatus.REGISTERED));
	findNonApprovedTrucks.fields().exclude("vehicleLicensePhoto");
	findNonApprovedTrucks.fields().exclude("truckPhoto");
	findNonApprovedTrucks.with(new Sort("creationDate"));
	return mongoTemplate.find(findNonApprovedTrucks, Truck.class);
    }

    public Truck getTruckByUserAndLicensePlate(String username, String licensePlateNumber) {
	Query truckBelongsToUserQuery = new Query()
		.addCriteria(Criteria.where("licensePlateNumber").is(licensePlateNumber))
		.addCriteria(Criteria.where("username").is(username));
	return mongoTemplate.findOne(truckBelongsToUserQuery, Truck.class);
    }

    public List<Load> getLoadsForTruck(Truck truck) {
	Query loadsForTruckQuery = new Query();
	// match weight
	if (truck.getMaxWeight() != null) {
	    loadsForTruckQuery.addCriteria(Criteria.where("weight").exists(true).lte(truck.getMaxWeight()));
	    loadsForTruckQuery.addCriteria(Criteria.where("volume").exists(true).lte(truck.getMaxVolume()));
	    loadsForTruckQuery.addCriteria(Criteria.where("driveDate").exists(true).gte(new Date()));
	    loadsForTruckQuery.addCriteria(Criteria.where("loadingType").exists(true).in(convertToInClauseStringCollection(truck.getAcceptableLiftTypes())));
	    loadsForTruckQuery.addCriteria(Criteria.where("downloadingType").exists(true).in(convertToInClauseStringCollection(truck.getAcceptableLiftTypes())));
	    loadsForTruckQuery.addCriteria(Criteria.where("type").exists(true).in(convertToInClauseStringCollection(truck.getAcceptableLoadTypes())));
	}
	// sort results
	loadsForTruckQuery.with(new Sort("source"));

	return mongoTemplate.find(loadsForTruckQuery, Load.class);
    }

    public LoadsUser getUser(String username) {
	Query query = new Query().addCriteria(Criteria.where("username").is(username));
	query.fields().exclude("password");
	return mongoTemplate.findOne(query, LoadsUser.class);
    }


    //TruckAvailability
    public void storeTruckAvailability(TruckAvailability truckAvail){
	mongoTemplate.insert(truckAvail);
    }

    public List<Load> getLoadsForTruckByFilter(Truck truck, Double sourceLat, Double sourceLng, Integer source_radius,
	    Double destinationLat, Double destinationLng, Integer destination_radius, Date drivedate) {
	// The criteria API isn't good enough
	String query = "{";

	query += "weight: { $exists: true, $lte: " + truck.getMaxWeight() + " } ";
	query += ", volume: { $exists: true, $lte: " + truck.getMaxVolume() + " } ";
	query += ", type: { $exists: true, $in: [" + convertToInClause(truck.getAcceptableLoadTypes()) + "] } ";
	query += ", loadingType: { $exists: true, $in: [" + convertToInClause(truck.getAcceptableLiftTypes()) + "] } ";
	query += ", downloadingType: { $exists: true, $in: [" + convertToInClause(truck.getAcceptableLiftTypes()) + "] } ";
	if (sourceLat != null && sourceLng != null && source_radius != null) {
		query += ", sourceLocation : { $near : { $geometry : { type : \"Point\" , coordinates : [" + sourceLng + ", " + sourceLat + "] }, $maxDistance : "+ source_radius * 1000 + " } }";
	}
	if (destinationLat != null && destinationLng != null && destination_radius != null) {
		query += ", destinationLocation : { $near : { $geometry : { type : \"Point\" , coordinates : [" + destinationLng + ", " + destinationLat + "] }, $maxDistance : "+ destination_radius * 1000 + " } }";
	}
	// sort results
	query += "}";
	BasicQuery queryobj = new BasicQuery(query);
	List<Load> coll = mongoTemplate.find(queryobj, Load.class);

	if (drivedate != null) {
		return coll.stream().filter(load -> {
		    Calendar cal = Calendar.getInstance();
		    cal.setTime(drivedate);
		    cal.add(Calendar.DATE, 1);
		    Date drivedateNextDay = cal.getTime();
		    return load.getDriveDate() != null && load.getDriveDate().compareTo(drivedateNextDay) < 0 && load.getDriveDate().compareTo(drivedate) >= 0;
		    }).collect(Collectors.toList());

	}
	else {
	    return coll;
	}
    }

    private ArrayList<String> convertToInClauseStringCollection(List<?> list) {
	ArrayList<String> strings = new ArrayList<>(list.size());
	list.stream().forEach(item -> strings.add(item.toString()));
	return strings;
    }


    private String convertToInClause(List<?> list) {
	StringBuilder builder = new StringBuilder(128);
	list.stream().forEach(item -> builder.append("\"").append(item.toString()).append("\","));
	return builder.substring(0, builder.length() - 1).toString();
    }

    public Load getLoadForUserById(String loadId, String username) {
	Query query = new Query()
		.addCriteria(Criteria.where("_id").is(loadId))
		.addCriteria(Criteria.where("username").is(username));
	return mongoTemplate.findOne(query,Load.class);
    }
    
    public ResetPassword getResetPassword( String uuid ) {
	Query q = new Query();
	q.addCriteria(Criteria.where("uuid").is(uuid));
	ResetPassword rp = mongoTemplate.findOne(q,ResetPassword.class);
	return rp;
    }

    public void newResetPassword( ResetPassword rp ) {
	mongoTemplate.insert(rp);
    }

}
