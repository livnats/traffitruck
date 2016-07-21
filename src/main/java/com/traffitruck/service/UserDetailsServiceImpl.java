package com.traffitruck.service;

import java.util.Arrays;
import java.util.Collections;

import org.apache.log4j.Logger;
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
import com.traffitruck.domain.ResetPassword;

@Component
public class UserDetailsServiceImpl implements AuthenticationProvider {

    private static final Logger logger = Logger.getLogger(UserDetailsServiceImpl.class);

    @Autowired
    private MongoDAO dao;

    @Autowired
    private MongoTemplate mongoTemplate;

    @Override
    public Authentication authenticate(Authentication authentication) throws AuthenticationException {

	String username = (String) authentication.getPrincipal();
	String password = (String) authentication.getCredentials();

	Query findByUsername = new Query().addCriteria(Criteria.where("username").is(username.toLowerCase()));
	LoadsUser user = mongoTemplate.findOne(findByUsername, LoadsUser.class);

	if (user == null) {
	    return null;
	}

	logger.info(username + " login");
	
	String encryptedPassword = user.getPassword();
	StrongPasswordEncryptor passwordEncryptor = new StrongPasswordEncryptor();

	if (user != null && passwordEncryptor.checkPassword(password, encryptedPassword) && user.getRole() != null) {
	    return new UsernamePasswordAuthenticationToken(authentication.getPrincipal(),
		    authentication.getCredentials(),
		    Collections.singletonList(new SimpleGrantedAuthority(user.getRole().toString())));
	} else {
	    // check for reset password
	    ResetPassword rp = dao.getResetPassword(password, username);
	    long FIFTEEN_MINUTES_IN_MILLIS = 15 * 60 * 1000;
	    if (rp == null || (System.currentTimeMillis() - rp.getCreationDate().getTime()) > FIFTEEN_MINUTES_IN_MILLIS) {
		if ( rp != null )
		    logger.info("too much time for reset password " + (System.currentTimeMillis() - rp.getCreationDate().getTime()));
		return null;
	    }
	    UsernamePasswordAuthenticationToken token = new UsernamePasswordAuthenticationToken(authentication.getPrincipal(),
		    authentication.getCredentials(),
		    Arrays.asList(new SimpleGrantedAuthority(user.getRole().toString()), new SimpleGrantedAuthority("resetPassword-" + password))); // hack to retain the temp password
	    return token;
	}
    }

    @Override
    public boolean supports(Class<?> authentication) {
	return true;
    }

}
