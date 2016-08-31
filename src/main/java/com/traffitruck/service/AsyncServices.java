package com.traffitruck.service;

import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
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

	@Async
	public void triggerAlerts(Load load) {
		// get alerts
		List<Alert> alerts = dao.getAlertsByFilter(load.getSourceLocation().getLat(), load.getSourceLocation().getLng(), JsonController.DEFAULT_RADIUS_FOR_SEARCHES, 
				load.getDestinationLocation().getLat(), load.getDestinationLocation().getLng(), JsonController.DEFAULT_RADIUS_FOR_SEARCHES, 
				load.getDriveDate());
		
		// format email
		String message = "התקבל מטען חדש לשירות טראפי-טראק התואם את ההתראות שהגדרת\n"
				+ "המטען יוצא מ-" + load.getSource() + "\n"
				+ "ליעד-" + load.getDestination() + "\n"
				+ "בתאריך-" + load.getDriveDateStr() + "\n"
				+ "\n"
				+ "לקבלת פרטים נוספים לחץ על הקישור הבא " + "GENERATED-LINK" + "\n";
		
		// send email to all matching alerts
		alerts.stream().forEach(alert -> {
			LoadsUser user = dao.getUser(alert.getUsername());
			SimpleMailMessage msg = new SimpleMailMessage();
			msg.setTo(user.getEmail());
			msg.setSubject("התראת מטען חדש");
			msg.setFrom("no-reply@traffitruck.com");
			msg.setText(message);
			logger.info("Sending mail to " + user.getEmail());
			mailSender.send(msg);
		});
	}
}
