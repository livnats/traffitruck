package com.traffitruck.domain;

import java.io.File;
import java.io.FileInputStream;
import java.util.Date;

import org.bson.types.Binary;
import org.springframework.data.annotation.Id;

import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.Mongo;

public class Truck {

	@Id
	private String id;
	private Date creationDate;
	private TruckRegistrationStatus registrationStatus;
	
	
	//The truck owner
	private String username;
	
	//Information filled by the driver
	private String licensePlateNumber;
	private Binary licensePlatePhoto;
	private Binary truckPhoto;
	
	//information added for validation
	private TruckType type;
	private FuelType fuelType;
	private String engineOutput;
	private String color;
	private Integer overallweight;
	private Integer selfweight;
	private Integer permittedweight;
	private String tires;
	private Integer manufactureYear;
	private String engineCapacity;
	private PropulsionType propulsion;
	private boolean hasHitch;
	//owner as registered on the vehicle license
	private String ownerName;
	private String ownerId;
	private String ownerAddress;
	
	

	public String getId() {
		return id;
	}


	public void setId(String id) {
		this.id = id;
	}


	public String getLicensePlateNumber() {
		return licensePlateNumber;
	}


	public void setLicensePlateNumber(String licensePlateNumber) {
		this.licensePlateNumber = licensePlateNumber;
	}


	public Binary getLicensePlatePhoto() {
		return licensePlatePhoto;
	}


	public void setLicensePlatePhoto(Binary licensePlatePhoto) {
		this.licensePlatePhoto = licensePlatePhoto;
	}


	public Binary getTruckPhoto() {
		return truckPhoto;
	}


	public void setTruckPhoto(Binary truckPhoto) {
		this.truckPhoto = truckPhoto;
	}
	
	
	public String getUsername() {
		return username;
	}


	public void setUsername(String username) {
		this.username = username;
	}


	public Date getCreationDate() {
		return creationDate;
	}


	public void setCreationDate(Date creationDate) {
		this.creationDate = creationDate;
	}

	public TruckRegistrationStatus getRegistrationStatus() {
		return registrationStatus;
	}


	public void setRegistrationStatus(TruckRegistrationStatus registrationStatus) {
		this.registrationStatus = registrationStatus;
	}

	public TruckType getType() {
		return type;
	}


	public void setType(TruckType type) {
		this.type = type;
	}


	public FuelType getFuelType() {
		return fuelType;
	}


	public void setFuelType(FuelType fuelType) {
		this.fuelType = fuelType;
	}


	public String getEngineOutput() {
		return engineOutput;
	}


	public void setEngineOutput(String engineOutput) {
		this.engineOutput = engineOutput;
	}


	public String getColor() {
		return color;
	}


	public void setColor(String color) {
		this.color = color;
	}


	public Integer getOverallweight() {
		return overallweight;
	}


	public void setOverallweight(Integer overallweight) {
		this.overallweight = overallweight;
	}


	public Integer getSelfweight() {
		return selfweight;
	}


	public void setSelfweight(Integer selfweight) {
		this.selfweight = selfweight;
	}


	public Integer getPermittedweight() {
		return permittedweight;
	}


	public void setPermittedweight(Integer permittedweight) {
		this.permittedweight = permittedweight;
	}


	public String getTires() {
		return tires;
	}


	public void setTires(String tires) {
		this.tires = tires;
	}


	public Integer getManufactureYear() {
		return manufactureYear;
	}


	public void setManufactureYear(Integer manufactureYear) {
		this.manufactureYear = manufactureYear;
	}


	public String getEngineCapacity() {
		return engineCapacity;
	}


	public void setEngineCapacity(String engineCapacity) {
		this.engineCapacity = engineCapacity;
	}


	public PropulsionType getPropulsion() {
		return propulsion;
	}


	public void setPropulsion(PropulsionType propulsion) {
		this.propulsion = propulsion;
	}


	public boolean isHasHitch() {
		return hasHitch;
	}


	public void setHasHitch(boolean hasHitch) {
		this.hasHitch = hasHitch;
	}


	public String getOwnerName() {
		return ownerName;
	}


	public void setOwnerName(String ownerName) {
		this.ownerName = ownerName;
	}


	public String getOwnerId() {
		return ownerId;
	}


	public void setOwnerId(String ownerId) {
		this.ownerId = ownerId;
	}


	public String getOwnerAddress() {
		return ownerAddress;
	}


	public void setOwnerAddress(String ownerAddress) {
		this.ownerAddress = ownerAddress;
	}


	
	
	@Override
	public String toString() {
		return "Truck [id=" + id + ", creationDate=" + creationDate
				+ ", registrationStatus=" + registrationStatus + ", username="
				+ username + ", licensePlateNumber=" + licensePlateNumber
				+ ", licensePlatePhoto=" + licensePlatePhoto + ", truckPhoto="
				+ truckPhoto + ", type=" + type + ", fuelType="
				+ fuelType + ", engineOutput=" + engineOutput + ", color="
				+ color + ", overallweight=" + overallweight + ", selfweight="
				+ selfweight + ", permittedweight=" + permittedweight
				+ ", tires=" + tires + ", manufactureYear=" + manufactureYear
				+ ", engineCapacity=" + engineCapacity + ", propulsion="
				+ propulsion + ", hasHitch=" + hasHitch + ", ownerName="
				+ ownerName + ", ownerId=" + ownerId + ", ownerAddress="
				+ ownerAddress + "]";
	}


	public static void main1(String[] args) {
		try {
			
			//creating the image
			File imageFile = new File("/home/lpeer/Documents/home-solar-panels.jpg");
			FileInputStream f = new FileInputStream(imageFile);
			byte b[] = new byte[f.available()];
			f.read(b);
			Binary data = new Binary(b);
			Truck t = new Truck();
			t.setLicensePlatePhoto(data);
			 
			//adding to DB
			 @SuppressWarnings("deprecation")
			Mongo mongo = new Mongo("localhost", 27017);
	         DB db = mongo.getDB("test");
	         DBCollection collection = db.getCollection("truckpic");
	         BasicDBObject o = new BasicDBObject();
	         o.append("name","pic").append("photo",data);
	         collection.insert(o);
	         System.out.println("Inserted record.");
	         f.close();
						
		} catch (Exception e) {
			System.out.println(e);
		}
	}
	
}
