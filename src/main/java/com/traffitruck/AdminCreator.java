package com.traffitruck;

import static com.traffitruck.domain.Role.ADMIN;

import java.util.Arrays;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;

import com.traffitruck.domain.LoadsUser;
import com.traffitruck.service.MongoDAO;

@EnableAutoConfiguration
@ComponentScan
@Configuration
@Profile("adminCreator")
public class AdminCreator implements CommandLineRunner {

    private static final Log logger = LogFactory.getLog(AdminCreator.class);

    @Autowired
    private MongoDAO dao;

    public static void main(String[] args) throws Exception {
	SpringApplication app = new SpringApplication(AdminCreator.class);
	app.setWebEnvironment(false);
	app.run(args);
    }

    @Override
    public void run(String... args) throws Exception {

	if (args.length != 3) {
	    logger.error("Usage: mvn spring-boot:run -P adminCreator -Drun.arguments=\"<username>,<password>\"");
	    System.exit(1);
	}

	// args[0] is the active Spring boot profile
	String username = args[1];
	String password = args[2];

	LoadsUser user = new LoadsUser();
	user.setRoles(Arrays.asList(ADMIN));
	user.setUsername(username);
	user.setPassword(password);

	dao.storeUser(user);
	logger.info("Created user " + username);
	System.exit(0);
    }

}
