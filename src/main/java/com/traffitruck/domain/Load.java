package com.traffitruck.domain;

import java.util.Date;

import org.springframework.data.annotation.Id;

public class Load {

	@Id
	private String id;
	
	private String username;
	private String source;
	private String destination;
	private Date creationDate;
	private Double suggestedQuote;
	private Double weight;
	private Double volume;
	private String comments;
	private LoadType type;
	private String loadingType;
	private String downloadingType;
	private String name;
	private Double waitingTime;
	
	
	public String getId() {
		return id;
	}
	
	public void setId(String id) {
		this.id = id;
	}
	
	public String getUsername() {
		return username;
	}
	
	public void setUsername(String username) {
		this.username = username;
	}
	
	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}

	public String getDestination() {
		return destination;
	}

	public void setDestination(String destination) {
		this.destination = destination;
	}

	public Date getCreationDate() {
		return creationDate;
	}

	public void setCreationDate(Date creationDate) {
		this.creationDate = creationDate;
	}

	public Double getSuggestedQuote() {
		return suggestedQuote;
	}

	public void setSuggestedQuote(double suggestedQuote) {
		this.suggestedQuote = suggestedQuote;
	}

	public String getSource() {
		return source;
	}

	public void setSource(String source) {
		this.source = source;
	}

	public Double getWeight() {
		return weight;
	}

	public void setWeight(double weight) {
		this.weight = weight;
	}

	public Double getVolume() {
		return volume;
	}

	public void setVolume(Double volume) {
		this.volume = volume;
	}

	public String getComments() {
		return comments;
	}

	public void setComments(String comments) {
		this.comments = comments;
	}

	public void setSuggestedQuote(Double suggestedQuote) {
		this.suggestedQuote = suggestedQuote;
	}

	public void setWeight(Double weight) {
		this.weight = weight;
	}

	public LoadType getType() {
		return type;
	}

	public void setType(LoadType type) {
		this.type = type;
	}

	public String getLoadingType() {
		return loadingType;
	}

	public void setLoadingType(String loadingType) {
		this.loadingType = loadingType;
	}

	public String getDownloadingType() {
		return downloadingType;
	}

	public void setDownloadingType(String downloadingType) {
		this.downloadingType = downloadingType;
	}

	
	public Double getWaitingTime() {
		return waitingTime;
	}

	public void setWaitingTime(Double waitingTime) {
		this.waitingTime = waitingTime;
	}

	@Override
	public String toString() {
		return "Load [id=" + id + ", username=" + username + ", source="
				+ source + ", destination=" + destination + ", creationDate="
				+ creationDate + ", suggestedQuote=" + suggestedQuote
				+ ", weight=" + weight + ", volume=" + volume + ", comments="
				+ comments + ", type=" + type + ", loadingType=" + loadingType
				+ ", downloadingType=" + downloadingType + ", name=" + name
				+ ", waitingTime=" + waitingTime + "]";
	}
	

}
