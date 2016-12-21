package com.traffitruck.domain;

import java.util.List;
import java.util.Set;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.index.Indexed;

public class LoadsUser{
	
	@Id
	private String id;

	private String email;
	private String address;
	private String contactPerson;
	private String phoneNumber;
	private String cellNumber;
	@Indexed(unique=true)
	private String username;
	private String password;
	private List<Role> roles;
	private Set<String> registrationIds;
	private Boolean allowLoadDetails;

	public void setAllowLoadDetails(Boolean allowLoadDetails) {
        this.allowLoadDetails = allowLoadDetails;
    }
	public Boolean getAllowLoadDetails() {
        return allowLoadDetails;
    }
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
	public List<Role> getRoles() {
	    return roles;
	}
	public void setRoles(List<Role> roles) {
	    this.roles = roles;
	}
	public Set<String> getRegistrationIds() {
	    return registrationIds;
	}
	public void setRegistrationIds(Set<String> registrationIds) {
	    this.registrationIds = registrationIds;
	}
	@Override
	public String toString() {
		return "LoadsUser [email=" + email + ", address=" + address
				+ ", contactPerson=" + contactPerson + ", phoneNumber="
				+ phoneNumber + ", cellNumber=" + cellNumber + ", username="
				+ username + ", Roles=" + roles + "]";
	}

	
}
