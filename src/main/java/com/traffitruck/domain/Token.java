package com.traffitruck.domain;

import java.util.Date;

import org.springframework.data.annotation.Id;
import org.springframework.data.annotation.PersistenceConstructor;
import org.springframework.data.mongodb.core.index.CompoundIndex;
import org.springframework.data.mongodb.core.index.CompoundIndexes;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.security.web.authentication.rememberme.PersistentRememberMeToken;

@Document
@CompoundIndexes({
        @CompoundIndex(name = "i_username", def = "{'username': 1}"),
        @CompoundIndex(name = "i_series", def = "{'series': 1}")
})
public class Token extends PersistentRememberMeToken {

    @Id
    private final String id;

    // All fields declared as final, that’s why we have to use @PersistenceConstructor annotaion otherwise a class should have default constructor
    @PersistenceConstructor
    public Token(String id, String username, String series, String tokenValue, Date date) {
        super(username, series, tokenValue, date);
        this.id = id;
    }

    public String getId() {
        return id;
    }
}
