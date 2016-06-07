package com.traffitruck.service;

public class DuplicateEmailException extends DuplicateException {

    private static final long serialVersionUID = 8041840890944467552L;

    public DuplicateEmailException(String duplicateValue) {
	super(duplicateValue);
    }

}
