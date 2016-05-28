package com.traffitruck.service;

import java.util.List;

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
	Query findByUsername = new Query().addCriteria(Criteria.where("username").is(username));
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

    public void deleteLoadById( String id ){
	mongoTemplate.remove(new Query().addCriteria(Criteria.where("_id").is(id)),Load.class);
    }

    //User
    public void storeUser( LoadsUser user ) {
	StrongPasswordEncryptor passwordEncryptor = new StrongPasswordEncryptor();
	String encryptedPassword = passwordEncryptor.encryptPassword(user.getPassword());
	user.setPassword(encryptedPassword);
	try {
	    mongoTemplate.insert(user);
	}
	catch (DuplicateKeyException e) {
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
	update.set("fuelType", truck.getFuelType());
	update.set("engineOutput", truck.getEngineOutput());
	update.set("color", truck.getColor());
	update.set("overallweight", truck.getOverallweight());
	update.set("selfweight", truck.getSelfweight());
	update.set("permittedweight", truck.getPermittedweight());
	update.set("tires", truck.getTires());
	update.set("manufactureYear", truck.getManufactureYear());
	update.set("engineCapacity", truck.getEngineCapacity());
	update.set("propulsion", truck.getPropulsion());
	update.set("hasHitch", truck.isHasHitch());
	update.set("ownerName", truck.getOwnerName());
	update.set("ownerId", truck.getOwnerId());
	update.set("ownerAddress", truck.getOwnerAddress());
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
	if (truck.getPermittedweight() != null) {
	    loadsForTruckQuery.addCriteria(Criteria.where("weight").exists(true).lte(truck.getPermittedweight()));
	}
	// TODO match load type

	// TODO match loading type

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

    public List<Load> getLoadsForTruckByDistance(Truck truck, Double sourceLat, Double sourceLng, Integer source_radius,
	    Double destinationLat, Double destinationLng, Integer destination_radius) {
	// The criteria API isn't good enough
	String query = "{";
	// match weight	
	query += "weight: { $exists: true, $lte: " + truck.getPermittedweight() + " } ";
	if (sourceLat != null && sourceLng != null && source_radius != null) {
		query += ", sourceLocation : { $near : { $geometry : { type : \"Point\" , coordinates : [" + sourceLng + ", " + sourceLat + "] }, $maxDistance : "+ source_radius * 1000 + " } }";
	}
	if (destinationLat != null && destinationLng != null && destination_radius != null) {
		query += ", destinationLocation : { $near : { $geometry : { type : \"Point\" , coordinates : [" + destinationLng + ", " + destinationLat + "] }, $maxDistance : "+ destination_radius * 1000 + " } }";
	}
	// TODO match load type

	// TODO match loading type

	// sort results
//	query += "}, $orderby: { source: 1 } }";
	query += "}";
	BasicQuery queryobj = new BasicQuery(query);

	return mongoTemplate.find(queryobj, Load.class);
    }
}
