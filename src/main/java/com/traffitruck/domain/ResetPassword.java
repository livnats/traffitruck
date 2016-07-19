package com.traffitruck.domain;

import java.util.Date;

import org.springframework.data.annotation.Id;

public class ResetPassword {

    @Id
    private String id;
    private Date creationDate;
    private String uuid;
    private String username;
    
    public Date getCreationDate() {
        return creationDate;
    }
    public void setCreationDate(Date creationDate) {
        this.creationDate = creationDate;
    }
    public String getUuid() {
        return uuid;
    }
    public void setUuid(String uuid) {
        this.uuid = uuid;
    }
    public String getUsername() {
        return username;
    }
    public void setUsername(String username) {
        this.username = username;
    }

    
	
}
