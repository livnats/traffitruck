package com.traffitruck.service;

import org.apache.log4j.Logger;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
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

	public void pushNewAlert(String alertUrl, String registrationId) {
		String projectId = System.getenv("GOOGLE_PROJECT_ID");
		if ( projectId == null ) {
			throw new RuntimeException("Missing env variable value for GOOGLE_PROJECT_ID. Did you use sudo GOOGLE_PROJECT_ID=value?");
		}
		String url = "https://android.googleapis.com/gcm/send";
		HttpHeaders headers = new HttpHeaders();
		headers.set("Authorization", "key=" + projectId);
		headers.set("Content-Type", "application/json");

		String body = "{ \"to\" : \"" + registrationId + "\", "
				+ "\"priority\" : \"normal\", "
				+ "\"data\" : { "
				+ "\"title\" : \"TraffiTruck: New Load\", "
				+ "\"message\" : \"Open in app\", "
				+ "\"url\" : \"" + alertUrl + "\", "
				+ "\"content_available\" : 1 } "
				+ "}";
		HttpEntity<String> entity = new HttpEntity<String>(body, headers);
		String result = restTemplate.postForObject(url, entity, String.class);
		logger.info("Send notification to " + registrationId + " result " + result);
	}
}