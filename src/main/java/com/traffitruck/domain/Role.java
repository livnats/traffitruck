package com.traffitruck.domain;

public enum Role {
	
	ADMIN("/adminMenu"),
	TRUCK_OWNER("/menu"),
	LOAD_OWNER("/menu");

	private String landingUrl;
	
	private Role(String landingUrl) {
		this.landingUrl = landingUrl;
	}
	
	public String getLandingUrl() {
		return landingUrl;
	}
}
