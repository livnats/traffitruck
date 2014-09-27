package com.traffitruck.domain;

public class LoadAndUser {

	private Load load;
	private LoadsUser user;
	
	public LoadAndUser(Load load, LoadsUser user) {
		super();
		this.load = load;
		this.user = user;
	}

	public Load getLoad() {
		return load;
	}

	public LoadsUser getUser() {
		return user;
	}
}
