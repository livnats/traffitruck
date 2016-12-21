package com.traffitruck.service;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.twilio.Twilio;
import com.twilio.rest.api.v2010.account.Message;
import com.twilio.type.PhoneNumber;

@Service
public class SmsVerificationService {

    private static final Logger logger = Logger.getLogger(SmsVerificationService.class);

    public static final String ACCOUNT_SID = "ACd363c2356b45b3504e1d7e395a6ec4dd";

    private static final String NUMBER = "+12018006287";

    private static final String ISRAEL_PREFIX = "+972";

    public SmsVerificationService() {
        String authToken = System.getenv("TWILIO_AUTH_TOKEN");
        if ( authToken == null ) {
            throw new RuntimeException("Missing env variable value for TWILIO_AUTH_TOKEN. Did you use sudo TWILIO_AUTH_TOKEN=value?");
        }
        Twilio.init(ACCOUNT_SID, authToken);        
    }
    
    public void sendSmsVerification(String number, String verificationCode) {
        Message message = Message
                .creator(new PhoneNumber(ISRAEL_PREFIX + number), new PhoneNumber(NUMBER), verificationCode + " סיסמתך החד פעמית לשירות טראפי-טראק").create();
        String sid = message.getSid();
        logger.info("sent SMS to " + number + " with verification code " + verificationCode + ", sid " + sid);
    }
}