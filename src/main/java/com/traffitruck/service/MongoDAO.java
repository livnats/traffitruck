package com.traffitruck.service;

import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.TimeZone;
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

import com.traffitruck.domain.Alert;
import com.traffitruck.domain.Load;
import com.traffitruck.domain.LoadsUser;
import com.traffitruck.domain.ResetPassword;
import com.traffitruck.domain.Truck;
import com.traffitruck.domain.TruckAvailability;
import com.traffitruck.domain.TruckRegistrationStatus;

@Component
public class MongoDAO {

	private static final double EARTH_RADIUS_IN_RADIANS = 6378.1;
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
	public void storeAlert( Alert alert ) {
		mongoTemplate.insert(alert);
	}

	public List<Alert> getUserAlerts( String username ) {
		Query q = new Query()
				.addCriteria(Criteria.where("username").is(username));
		return mongoTemplate.find(q, Alert.class);
	}

	public List<Alert> getAllAlerts() {
		return mongoTemplate.findAll(Alert.class);
	}

	public List<Alert> getAlertsByFilter(Double sourceLat, Double sourceLng, Integer source_radius,
			Double destinationLat, Double destinationLng, Integer destination_radius, Date drivedate) {
		// The criteria API isn't good enough
		String query = "{";
		if (sourceLat != null && sourceLng != null && source_radius != null) {
			if ( query.length() > 1 ) {
				query += ", ";
			}
			query += "sourceLocation : { $geoWithin : { $centerSphere: [ [" + sourceLng + ", " + sourceLat + "], "+ source_radius / EARTH_RADIUS_IN_RADIANS + "] } }";
		}
		if (destinationLat != null && destinationLng != null && destination_radius != null) {
			if ( query.length() > 1 ) {
				query += ", ";
			}
			query += "destinationLocation : { $geoWithin : { $centerSphere: [ [" + destinationLng + ", " + destinationLat + "], "+ destination_radius / EARTH_RADIUS_IN_RADIANS + "] } }";
		}
		// sort results
		query += "}";
		BasicQuery queryobj = new BasicQuery(query);
		List<Alert> coll = mongoTemplate.find(queryobj, Alert.class);

		return coll.stream().filter(alert -> alert.getDriveDate() == null || datesEqual( alert.getDriveDate(), drivedate ) ).collect(Collectors.toList());
	}

	private boolean datesEqual( Date d1, Date d2 ) {
		Calendar c1 = Calendar.getInstance(TimeZone.getTimeZone("GMT"));
		Calendar c2 = Calendar.getInstance(TimeZone.getTimeZone("GMT"));
		c1.setTime(d1);
		c2.setTime(d2);
		return c1.get(Calendar.DATE) == c1.get(Calendar.DATE) && c1.get(Calendar.MONTH) == c1.get(Calendar.MONTH) && c1.get(Calendar.YEAR) == c1.get(Calendar.YEAR);
	}

	//Load
	public void storeLoad( Load load ) {
		mongoTemplate.insert(load);
	}

	public void updateLoad( Load load ) {
		Query q = new Query();
		q.addCriteria(Criteria.where("_id").is(load.getId()));
		Update update = new Update();
		update.set("source", load.getSource());
		update.set("sourceLocation", load.getSourceLocation());
		update.set("destinationLocation", load.getDestinationLocation());
		update.set("destination", load.getDestination());
		update.set("driveDate", load.getDriveDate());
		update.set("suggestedQuote", load.getSuggestedQuote());
		update.set("weight", load.getWeight());
		update.set("volume", load.getVolume());
		update.set("comments", load.getComments());
		update.set("type", load.getType());
		update.set("loadingType", load.getLoadingType());
		update.set("downloadingType", load.getDownloadingType());
		update.set("name", load.getName());
		update.set("waitingTime", load.getWaitingTime());
		if ( load.getHasPhoto() ) {
		    update.set("loadPhoto", load.getLoadPhoto());
		    update.set("hasPhoto", load.getHasPhoto());
		}
		mongoTemplate.updateFirst(q, update, Load.class);
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

	public void deleteLoadByAdmin( String id ){
		Query query = new Query()
				.addCriteria(Criteria.where("_id").is(id));
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
	
	public void addDevice( String username, String regid ) {
	    Query findByUsername = new Query().addCriteria(Criteria.where("username").is(username));
	    Update update = new Update();
	    update.addToSet("registrationIds", regid);
	    mongoTemplate.upsert(findByUsername, update, LoadsUser.class);
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
			query += ", sourceLocation : { $geoWithin : { $centerSphere: [ [" + sourceLng + ", " + sourceLat + "], "+ source_radius / EARTH_RADIUS_IN_RADIANS + "] } }";
		}
		if (destinationLat != null && destinationLng != null && destination_radius != null) {
			query += ", destinationLocation : { $geoWithin : { $centerSphere: [ [" + destinationLng + ", " + destinationLat + "], "+ destination_radius / EARTH_RADIUS_IN_RADIANS + "] } }";
		}
		query += "}";
		BasicQuery queryobj = new BasicQuery(query);
		// sort results
		queryobj.with(new Sort(Direction.DESC, "driveDate"));

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
			return coll.stream().filter(load -> {
				return load.getDriveDate().before(new Date());
			}).collect(Collectors.toList());
		}
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

	public ResetPassword getResetPassword( String uuid, String username ) {
		Query q = new Query();
		q.addCriteria(Criteria.where("uuid").is(uuid))
		.addCriteria(Criteria.where("username").is(username));
		ResetPassword rp = mongoTemplate.findOne(q,ResetPassword.class);
		return rp;
	}

	public void newResetPassword( ResetPassword rp ) {
		mongoTemplate.insert(rp);
	}

	public void deleteResetPassword( String uuid, String username ){
		Query query = new Query()
				.addCriteria(Criteria.where("uuid").is(uuid))
				.addCriteria(Criteria.where("username").is(username));
		mongoTemplate.remove(query,ResetPassword.class);
	}

	public void deleteAlert(String alertId, String username) {
		Query query = new Query()
				.addCriteria(Criteria.where("id").is(alertId))
				.addCriteria(Criteria.where("username").is(username));
		mongoTemplate.remove(query,Alert.class);
	}


}
