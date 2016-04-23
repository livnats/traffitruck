package com.traffitruck.service;

import java.util.Collections;

import org.jasypt.util.password.StrongPasswordEncryptor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.stereotype.Component;

import com.traffitruck.domain.LoadsUser;


@Component
public class UserDetailsServiceImpl implements AuthenticationProvider {
	
	@Autowired
	private MongoTemplate mongoTemplate;
 

    @Override
	public Authentication authenticate(Authentication authentication)
			throws AuthenticationException {
   
    	String username = (String)authentication.getPrincipal();
    	String password = (String)authentication.getCredentials();
    	
    	Query findByUsername = new Query().addCriteria(Criteria.where("username").is(username));
    	LoadsUser user = mongoTemplate.findOne(findByUsername, LoadsUser.class);

    	String encryptedPassword = user.getPassword();
    	StrongPasswordEncryptor passwordEncryptor = new StrongPasswordEncryptor();

    	if(user!=null && passwordEncryptor.checkPassword(password, encryptedPassword) && user.getRole() != null)
    		return new UsernamePasswordAuthenticationToken(
    				authentication.getPrincipal(),
    				authentication.getCredentials(),
    				Collections.singletonList(new SimpleGrantedAuthority(user.getRole().toString())));
    	else
    		return null;
	}

	@Override
	public boolean supports(Class<?> authentication) {
		return true;
	}

}
