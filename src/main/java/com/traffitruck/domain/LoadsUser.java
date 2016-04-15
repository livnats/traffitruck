package com.traffitruck.domain;


public class LoadsUser{
	
	private String email;
	private String address;
	private String contactPerson;
	private String phoneNumber;
	private String cellNumber;
	private String username;
	private String password;
	private String role;
	//TODO add id and unique constraint on email
	

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
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	@Override
	public String toString() {
		return "LoadsUser [email=" + email + ", address=" + address
				+ ", contactPerson=" + contactPerson + ", phoneNumber="
				+ phoneNumber + ", cellNumber=" + cellNumber + ", username="
				+ username + ", Role=" + role + "]";
	}
	
}
