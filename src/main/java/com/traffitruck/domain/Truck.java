package com.traffitruck.domain;

import java.util.Date;
import java.util.List;

import org.bson.types.Binary;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.index.Indexed;

public class Truck {

	@Id
	private String id;
	private Date creationDate;
	private TruckRegistrationStatus registrationStatus;
	
	//The truck owner
	private String username;
	
	//Information filled by the driver
	@Indexed(unique=true)
	private String licensePlateNumber;
	private Binary vehicleLicensePhoto;
	private Binary truckPhoto;
	
	//information added for validation
	private TruckType type;
	private Integer maxWeight;
	//owner as registered on the vehicle license
	private String ownerName;
	private String ownerId;
	private String ownerAddress;

	private Double maxVolume;
	private List<LoadType> acceptableLoadTypes;
	private List<LiftType> acceptableLiftTypes;

	public Integer getMaxWeight() {
	    return maxWeight;
	}

	public void setMaxWeight(Integer maxWeight) {
	    this.maxWeight = maxWeight;
	}

	public Double getMaxVolume() {
	    return maxVolume;
	}

	public void setMaxVolume(Double maxVolume) {
	    this.maxVolume = maxVolume;
	}

	public List<LoadType> getAcceptableLoadTypes() {
	    return acceptableLoadTypes;
	}

	public void setAcceptableLoadTypes(List<LoadType> acceptableLoadTypes) {
	    this.acceptableLoadTypes = acceptableLoadTypes;
	}

	public List<LiftType> getAcceptableLiftTypes() {
	    return acceptableLiftTypes;
	}

	public void setAcceptableLiftTypes(List<LiftType> acceptableLiftTypes) {
	    this.acceptableLiftTypes = acceptableLiftTypes;
	}

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


	public Binary getVehicleLicensePhoto() {
		return vehicleLicensePhoto;
	}


	public void setVehicleLicensePhoto(Binary vehicleLicensePhoto) {
		this.vehicleLicensePhoto = vehicleLicensePhoto;
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
	    return "Truck [id=" + id + ", creationDate=" + creationDate + ", registrationStatus=" + registrationStatus
		    + ", username=" + username + ", licensePlateNumber=" + licensePlateNumber + ", type=" + type
		    + ", maxWeight=" + maxWeight + ", ownerName=" + ownerName + ", ownerId="
		    + ownerId + ", ownerAddress=" + ownerAddress + ", maxVolume=" + maxVolume + ", acceptableLoadTypes="
		    + acceptableLoadTypes + ", acceptableLiftTypes=" + acceptableLiftTypes + "]";
	}

}
