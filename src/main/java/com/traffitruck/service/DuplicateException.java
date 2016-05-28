package com.traffitruck.service;

public class DuplicateException extends RuntimeException {

    private static final long serialVersionUID = 3743986968073323804L;

    public DuplicateException( String duplicateValue ) {
	super("Duplicate entity " + duplicateValue);
    }
}
