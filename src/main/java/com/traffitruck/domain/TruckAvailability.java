package com.traffitruck.domain;

import java.util.Date;

public class TruckAvailability {
	
	private String truckId;
	private String source;
	private String destination;
	private Date availableStart;
	private Date creationDate;
	
	
	public String getTruckId() {
		return truckId;
	}
	public void setTruckId(String truckId) {
		this.truckId = truckId;
	}
	public String getSource() {
		return source;
	}
	public void setSource(String source) {
		this.source = source;
	}
	public String getDestination() {
		return destination;
	}
	public void setDestination(String destination) {
		this.destination = destination;
	}
	public Date getAvailableStart() {
		return availableStart;
	}
	public void setAvailableStart(Date availableStart) {
		this.availableStart = availableStart;
	}
	public Date getCreationDate() {
		return creationDate;
	}
	public void setCreationDate(Date creationDate) {
		this.creationDate = creationDate;
	}
	
	@Override
	public String toString() {
		return "TruckAvailability [truckId=" + truckId + ", source=" + source
				+ ", destination=" + destination + ", availableStart="
				+ availableStart + ", creationDate=" + creationDate + "]";
	}
	

}
