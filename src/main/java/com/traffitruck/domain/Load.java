package com.traffitruck.domain;

import java.util.Date;

public class Load {

	private String source;
	private String destination;
	private Date creationDate;
	private double suggestedQuote;
	private double weight;

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

	public double getSuggestedQuote() {
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

	public double getWeight() {
		return weight;
	}

	public void setWeight(double weight) {
		this.weight = weight;
	}

	@Override
	public String toString() {
		return "Load [source=" + source + ", destination=" + destination
				+ ", creationDate=" + creationDate + ", suggestedQuote="
				+ suggestedQuote + ", weight=" + weight + "]";
	}

}
