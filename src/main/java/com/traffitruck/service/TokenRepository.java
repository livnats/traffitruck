package com.traffitruck.service;

import org.springframework.data.mongodb.repository.MongoRepository;

import com.traffitruck.domain.Token;

public interface TokenRepository extends MongoRepository<Token, String> {
	Token findBySeries(String series);

	Token findByUsername(String username);
}