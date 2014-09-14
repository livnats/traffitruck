package com.traffitruck.domain;


public class LoadsUser{
	
	private String address;
	private String contactPerson;
	private String phoneNumber;
	private String cellNumber;
	private String username;
	private String password;
	
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getContactPerson() {
		return contactPerson;
	}
	public void setContactPerson(String contactPerson) {
		this.contactPerson = contactPerson;
	}
	public String getPhoneNumber() {
		return phoneNumber;
	}
	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}
	public String getCellNumber() {
		return cellNumber;
	}
	public void setCellNumber(String cellNumber) {
		this.cellNumber = cellNumber;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	@Override
	public String toString() {
		return "LoadsUser [address=" + address + ", contactPerson="
				+ contactPerson + ", phoneNumber=" + phoneNumber
				+ ", cellNumber=" + cellNumber + ", username=" + username
				+ ", password=" + password + "]";
	}
	
}
