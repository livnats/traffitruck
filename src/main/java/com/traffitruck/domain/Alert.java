package com.traffitruck.domain;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.data.annotation.Id;

public class Alert {

    @Id
    private String id;

    private String username;
    private String source;
    private Location sourceLocation;
    private String destination;
    private Location destinationLocation;
    private Date driveDate;
    
    public String getDriveDateStr() {
    	SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yy");
    	return sdf.format(driveDate);
    }

	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getSource() {
		return source;
	}
	public void setSource(String source) {
		this.source = source;
	}
	public Location getSourceLocation() {
		return sourceLocation;
	}
	public void setSourceLocation(Location sourceLocation) {
		this.sourceLocation = sourceLocation;
	}
	public String getDestination() {
		return destination;
	}
	public void setDestination(String destination) {
		this.destination = destination;
	}
	public Location getDestinationLocation() {
		return destinationLocation;
	}
	public void setDestinationLocation(Location destinationLocation) {
		this.destinationLocation = destinationLocation;
	}
	public Date getDriveDate() {
		return driveDate;
	}
	public void setDriveDate(Date driveDate) {
		this.driveDate = driveDate;
	}
	@Override
	public String toString() {
		return "Alert [id=" + id + ", username=" + username + ", source="
				+ source + ", sourceLocation=" + sourceLocation
				+ ", destination=" + destination + ", destinationLocation="
				+ destinationLocation + ", driveDate=" + driveDate + "]";
	}
    
    
}
