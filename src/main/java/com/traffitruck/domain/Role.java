package com.traffitruck.domain;

public enum Role {
	
	ADMIN("/adminMenu"),
	TRUCK_OWNER("/truckerMenu"),
	LOAD_OWNER("/myLoads");

	private String landingUrl;
	
	private Role(String landingUrl) {
		this.landingUrl = landingUrl;
	}
	
	public String getLandingUrl() {
		return landingUrl;
	}
}
