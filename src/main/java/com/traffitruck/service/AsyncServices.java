package com.traffitruck.service;

import java.util.Collection;
import java.util.HashSet;
import java.util.Set;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Component;

import com.traffitruck.domain.Alert;
import com.traffitruck.domain.Load;
import com.traffitruck.domain.LoadsUser;
import com.traffitruck.web.JsonController;

@Component
public class AsyncServices {

    private static final Logger logger = Logger.getLogger(AsyncServices.class);

	@Autowired
	private MongoDAO dao;

	@Autowired
	private JavaMailSender mailSender;

	@Value("${alertUrlPrefix}")
    private String alertUrlPrefix;
	
    @Autowired
    private RestServices restServices;

	@Async
	public void triggerAlerts(Load load) {
		// get alerts
		Collection<Alert> alerts = dao.getAlertsByFilter(load.getSourceLocation().getLat(), load.getSourceLocation().getLng(), JsonController.DEFAULT_RADIUS_FOR_SEARCHES, 
				load.getDestinationLocation().getLat(), load.getDestinationLocation().getLng(), JsonController.DEFAULT_RADIUS_FOR_SEARCHES);
		
		String alertUrl = alertUrlPrefix + "/load_details_for_trucker/" + load.getId();
		
		// format email
		String message = "התקבל מטען חדש לשירות טראפי-טראק התואם את ההתראות שהגדרת\n"
				+ "המטען יוצא מ-" + load.getSource() + "\n"
				+ "ליעד-" + load.getDestination() + "\n"
				+ "מחיר-" + load.getSuggestedQuote() + "\n";
		String emailMessage = message
				+ "\n"
				+ "לקבלת פרטים נוספים לחץ על הקישור הבא " + alertUrl + "\n";
		
		// don't flood users
		Set<String> notifiedUsers = new HashSet<>();
		// send email to all matching alerts
		alerts.stream().forEach(alert -> {
			LoadsUser user = dao.getUser(alert.getUsername());
			if ( ! notifiedUsers.contains(user.getUsername()) ) {
				notifiedUsers.add(user.getUsername());
				Set<String> registrationIds = user.getRegistrationIds();
				if ( registrationIds == null || registrationIds.isEmpty() ) {
					SimpleMailMessage msg = new SimpleMailMessage();
					msg.setTo(user.getEmail());
					msg.setSubject("התראת מטען חדש");
					msg.setFrom("no-reply@traffitruck.com");
					msg.setText(emailMessage);
					logger.info("Sending mail to " + user.getEmail());
					mailSender.send(msg);
				}
				else {
					registrationIds.stream().forEach(regid -> restServices.pushNewAlert(alertUrl, regid, message));
				}
			}
		});
	}
}
