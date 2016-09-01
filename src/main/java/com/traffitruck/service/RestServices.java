package com.traffitruck.service;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

@Service
public class RestServices {

    private static final Logger logger = Logger.getLogger(UserDetailsServiceImpl.class);

	RestTemplate restTemplate = new RestTemplate();

	public String getGoogleJavascriptAPI() {
		String apiKey = System.getenv("GOOGLE_API_KEY");
		if ( apiKey == null ) {
			throw new RuntimeException("Missing env variable value for GOOGLE_API_KEY. Did you use sudo GOOGLE_API_KEY=value?");
		}
		String url = "https://maps.googleapis.com/maps/api/js?libraries=places&language=iw&region=IL&key=" + apiKey;
		String result = restTemplate.postForObject(url, null, String.class);
		return result;
	}
}