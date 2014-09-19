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
	
	
	//The truck owner
	private String username;
	private String licensePlateNumber;
	private Binary licensePlatePhoto;
	private Binary truckPhoto;
	private Date creationDate;
	private TruckRegistrationStatus registrationStatus;

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


	@Override
	public String toString() {
		return "Truck [id=" + id + ", username=" + username
				+ ", licensePlateNumber=" + licensePlateNumber
				+ ", licensePlatePhoto=" + licensePlatePhoto + ", truckPhoto="
				+ truckPhoto + ", creationDate=" + creationDate
				+ ", registrationStatus=" + registrationStatus + "]";
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
