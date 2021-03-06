package com.traffitruck.domain;

public class Location {

	private String type = "Point";// this is the only GeoJSON type we support, it has to be here to get into the DB as the "type" attribute of the GeoJSON member
	private double[] coordinates;// [lng, lat];

	public Location(double[] coordinates) {
		this.coordinates = coordinates;
	}

	public String getType() {
		return type;
	}

	public double[] getCoordinates() {
		return coordinates;
	}
	
	public double getLat() {
		return coordinates[1];
	}
	
	public double getLng() {
		return coordinates[0];
	}
}
