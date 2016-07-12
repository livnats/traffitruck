package com.traffitruck.web;

public class TextFmt {

    public static String address( String address ) {
	if ( address == null )
		return null;
	int ind1 = address.indexOf(',');
	if ( ind1 > 0 && address.length() > ind1 ) {
	    int ind2 = address.indexOf(',', ind1 + 1);
	    if ( ind2 > 0 ) {
		return address.substring(0, ind2); 
	    }
	}
	return address;
    }
}
