package com.traffitruck.web;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;
import java.util.TimeZone;

import org.bson.types.Binary;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.traffitruck.domain.Alert;
import com.traffitruck.domain.Load;
import com.traffitruck.domain.LoadsUser;
import com.traffitruck.domain.Location;
import com.traffitruck.domain.ResetPassword;
import com.traffitruck.domain.Role;
import com.traffitruck.domain.Truck;
import com.traffitruck.domain.TruckAvailability;
import com.traffitruck.domain.TruckRegistrationStatus;
import com.traffitruck.service.AsyncServices;
import com.traffitruck.service.DuplicateEmailException;
import com.traffitruck.service.DuplicateException;
import com.traffitruck.service.MongoDAO;
import com.traffitruck.service.RestServices;

import freemarker.ext.beans.BeansWrapper;
import freemarker.template.TemplateHashModel;
import freemarker.template.TemplateModelException;

@RestController
public class HtmlController {

	@Autowired
	private MongoDAO dao;

	@Autowired
	private AsyncServices asyncServices;

	@Autowired
	private JavaMailSender mailSender;

	@Autowired
	private RestServices restServices;

	private String cachedGoogleMapsResponse;
	private long googleMapscachingTimestamp;
	@RequestMapping(path="/mapsapis", produces="application/javascript;charset=UTF-8")
	ModelAndView googleMapsProxy() {
		long now = System.currentTimeMillis();
		if ( cachedGoogleMapsResponse == null || ( now - googleMapscachingTimestamp > 3600_000 ) ) {
			cachedGoogleMapsResponse = restServices.getGoogleJavascriptAPI();
			googleMapscachingTimestamp = now;
		}
		Map<String, Object> model = new HashMap<>();
		model.put("content", cachedGoogleMapsResponse);
		return new ModelAndView("proxy", model);
	}
	
	@RequestMapping("/login")
	ModelAndView login() {
		return new ModelAndView("login");
	}

	@RequestMapping({"/loads"})
	ModelAndView showLoads() {
		Map<String, Object> model = new HashMap<>();
		model.put("Format", getFormatStatics());
		model.put("enums", BeansWrapper.getDefaultInstance().getEnumModels());
		model.put("loads", dao.getLoads());
		return new ModelAndView("show_loads", model);
	}

	@RequestMapping({"/trucks"})
	ModelAndView showTrucks() {
		Map<String, Object> model = new HashMap<>();
		model.put("enums", BeansWrapper.getDefaultInstance().getEnumModels());
		model.put("trucks", dao.getTrucksWithoutImages());
		return new ModelAndView("show_trucks", model);
	}

	@RequestMapping({"/findTrucksForLoad"})
	ModelAndView findTrucksForLoad() {
		Map<String, Object> model = new HashMap<>();
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String username = authentication.getName();
		model.put("enums", BeansWrapper.getDefaultInstance().getEnumModels());
		model.put("trucks", dao.getTrucksForUserAndRegistration(username, TruckRegistrationStatus.APPROVED));
		return new ModelAndView("find_load_for_trucks", model);
	}

	@RequestMapping(value = "/newload", method = RequestMethod.POST, consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
	ModelAndView newLoad(@ModelAttribute("load") Load load, BindingResult br1,
			@RequestParam("loadPhoto") byte[] loadPhoto, BindingResult br2,
			@RequestParam("drivedate") String drivedate, BindingResult br3,
			@RequestParam("sourceLat") Double sourceLat, BindingResult br4,
			@RequestParam("sourceLng") Double sourceLng, BindingResult br5,
			@RequestParam("destinationLat") Double destinationLat, BindingResult br6,
			@RequestParam("destinationLng") Double destinationLng, BindingResult br7
			) throws IOException {
		SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yy");
		sdf.setTimeZone(TimeZone.getTimeZone("GMT"));
		load.setCreationDate(new Date());
		try {
			load.setDriveDate(sdf.parse(drivedate));
		} catch (ParseException e) {
			throw new RuntimeException(e);
		}
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String username = authentication.getName();
		load.setUsername(username);
		if (loadPhoto != null && loadPhoto.length > 0) {
			load.setLoadPhoto(new Binary(loadPhoto));
		}
		if (sourceLat != null && sourceLng != null) {
			load.setSourceLocation(new Location(new double[] { sourceLng, sourceLat}));
		}
		if (destinationLat != null && destinationLng != null) {
			load.setDestinationLocation(new Location(new double[] { destinationLng, destinationLat}));
		}
		dao.storeLoad(load);
		asyncServices.triggerAlerts(load);
		return new ModelAndView("redirect:/myLoads");
	}

	@RequestMapping(value = "/truckerMenu")
	ModelAndView truckerMenu() {
		Map<String, Object> model = new HashMap<>();
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String username = authentication.getName();
		model.put("trucks", dao.getTrucksForUserAndRegistration(username, TruckRegistrationStatus.APPROVED));
		return new ModelAndView("trucker_menu", model);
	}

	@RequestMapping(value = "/menu")
	ModelAndView menu() {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		boolean isLoadsOwner = false;
		boolean isTruckOwner = false;
		for ( GrantedAuthority auth : authentication.getAuthorities() ) {
			if ( Role.LOAD_OWNER.toString().equals(auth.getAuthority()) ) {
				isLoadsOwner = true;
			}
			if ( Role.TRUCK_OWNER.toString().equals(auth.getAuthority()) ) {
				isTruckOwner = true;
			}
		}
		Map<String, Object> model = new HashMap<>();
		String username = authentication.getName();
		if ( isLoadsOwner && ! isTruckOwner ) {
			model.put("isTruckOwner", Boolean.FALSE);
			return new ModelAndView("redirect:/myLoads", model);
		}
		model.put("trucks", dao.getTrucksForUserAndRegistration(username, TruckRegistrationStatus.APPROVED));
		if ( isLoadsOwner ) {
			model.put("isLoadsOwner", Boolean.TRUE);
		}
		return new ModelAndView("trucker_menu", model);
	}

	@RequestMapping("/newload")
	ModelAndView newLoad() {
		Map<String, Object> model = new HashMap<>();
		model.put("enums", BeansWrapper.getDefaultInstance().getEnumModels());
		return new ModelAndView("new_load", model );
	}

	@RequestMapping(value = "/myLoads")
	ModelAndView myLoads() {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String username = authentication.getName();

		Map<String, Object> model = new HashMap<>();

		for ( GrantedAuthority auth : authentication.getAuthorities() ) {
			if ( Role.TRUCK_OWNER.toString().equals(auth.getAuthority()) ) {
				model.put("isTruckOwner", Boolean.TRUE);
			}
		}
		model.put("Format", getFormatStatics());
		model.put("enums", BeansWrapper.getDefaultInstance().getEnumModels());
		model.put("loads", dao.getLoadsForUser(username));
		return new ModelAndView("my_loads", model);
	}

	@RequestMapping(value = "/registerUser", method = RequestMethod.GET)
	ModelAndView registerUser() {
		return new ModelAndView("register_user");
	}

	@RequestMapping(value = "/forgotPassword", method = RequestMethod.GET)
	ModelAndView forgotPassword() {
		return new ModelAndView("forgot_password");
	}

	@RequestMapping(value = "/forgotPassword", method = RequestMethod.POST, consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE)
	ModelAndView forgotPassword(@RequestParam("username") String username) {
		if ( username != null ) {
			LoadsUser loadsUser = dao.getUser(username);
			if ( loadsUser != null ) {
				Random random = new Random();
				StringBuilder newPassword = new StringBuilder();
				for (int i = 0 ; i < 8 ; ++i )
					newPassword.append(random.nextInt(10));
				Map<String, Object> model = new HashMap<>();
				model.put("email", loadsUser.getEmail());
				ResetPassword rp = new ResetPassword();
				rp.setCreationDate(new Date());
				rp.setUsername(username);
				rp.setUuid(String.valueOf(newPassword));
				dao.newResetPassword(rp);
				SimpleMailMessage msg = new SimpleMailMessage();
				msg.setTo(loadsUser.getEmail());
				msg.setSubject("forgot password");
				msg.setFrom("no-reply@traffitruck.com");
				String message = "התקבלה בקשה במערכת לאיפוס הסיסמה לשירות טראפי-טרק\n"
						+ "אם לא ביקשת לאפס את הסיסמה נא התעלם מהודעה זו\n"
						+ "הסיסמה חדשה לשירות טראפי-טרק היא " + newPassword + "\n"
						+ "הסיסמה הזמנית תקפה ל15 דקות\n" 
						+ "בכניסה הבאה למערכת תתבקש לבחור סיסמה חדשה\n";

				msg.setText(message);
				mailSender.send(msg);
				return new ModelAndView("forgot_password_explain", model);
			}
		}
		Map<String, Object> model = new HashMap<>();
		model.put("error", "notfound");
		return new ModelAndView("forgot_password", model);
	}

	@RequestMapping(value = "/resetPassword", method = RequestMethod.GET)
	ModelAndView resetPassword() {
		return new ModelAndView("reset_password_intro");
	}

	@RequestMapping(value = "/resetPassword", method = RequestMethod.POST, consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE)
	ModelAndView resetPassword(@RequestParam("password") String password, @RequestParam("confirm_password") String confirm_password) {
		if (password == null || ! password.equals(confirm_password)) {
			throw new RuntimeException("Failed resetting the password");
		}
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String username = authentication.getName();
		LoadsUser user = dao.getUser(username);
		user.setPassword(password);
		dao.storeUser(user);

		String resetPasswordId = null;
		for (GrantedAuthority grantedAuthority : authentication.getAuthorities()) {
			if (grantedAuthority.getAuthority().startsWith("resetPassword-"))
				resetPasswordId = grantedAuthority.getAuthority().substring("resetPassword-".length());
			dao.deleteResetPassword(resetPasswordId, username);
		}
		return new ModelAndView("redirect:" + user.getRoles().get(0).getLandingUrl());
	}

	@RequestMapping(value = "/addAvailability", method = RequestMethod.GET)
	ModelAndView addAvailability() {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String username = authentication.getName();
		Map<String, Object> model = new HashMap<>();
		model.put("enums", BeansWrapper.getDefaultInstance().getEnumModels());
		model.put("trucks", dao.getMyApprovedTrucksId(username));
		return new ModelAndView("add_availability", model);
	}

	@RequestMapping(value = "/addAvailability", method = RequestMethod.POST, consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE)
	ModelAndView addAvailability(@RequestParam("truckId") String truckId,
			@RequestParam("source") String source,
			@RequestParam("destination") String destination,
			@RequestParam("availTime") String availTime,
			@RequestParam("dateAvail") String dateAvail,
			@RequestParam("hourAvail") String hourAvail) throws IOException, ParseException{

		TruckAvailability truckAvail = new TruckAvailability();
		truckAvail.setTruckId(truckId);
		truckAvail.setSource(source);
		truckAvail.setDestination(destination);
		Date now = new Date();
		truckAvail.setCreationDate(now);
		if("now".equals(availTime)){
			truckAvail.setAvailableStart(now);
		}
		else{
			SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyyHHmm");
			sdf.setTimeZone(TimeZone.getTimeZone("GMT"));
			Date requestedTime = sdf.parse(dateAvail+hourAvail);
			truckAvail.setAvailableStart(requestedTime);
		}
		dao.storeTruckAvailability(truckAvail);
		return new ModelAndView("redirect:/addAvailability");
	}

	@RequestMapping(value = "/registerUser", method = RequestMethod.POST, consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE)
	ModelAndView registerUser(@ModelAttribute("user") LoadsUser user) {
		user.setUsername(user.getUsername().toLowerCase());

		boolean isLoadsOwner = false;
		boolean isTruckOwner = false;
		for ( Role role : user.getRoles() ) {
			if ( Role.LOAD_OWNER.equals(role) ) {
				isLoadsOwner = true;
			}
			if ( Role.TRUCK_OWNER.equals(role) ) {
				isTruckOwner = true;
			}
		}

		try {
			dao.storeUser(user);
		}
		catch (DuplicateEmailException e) {
			Map<String, Object> model = new HashMap<>();
			model.put("erroremail", "dup");
			model.put("username", user.getUsername());
			model.put("address", user.getAddress());
			model.put("cellNumber", user.getCellNumber());
			model.put("email", user.getEmail());
			model.put("phoneNumber", user.getPhoneNumber());
			if ( isTruckOwner )
				model.put("trole", Boolean.TRUE);
			if ( isLoadsOwner )
				model.put("lrole", Boolean.TRUE);
			model.put("contactPerson", user.getContactPerson());
			return new ModelAndView("register_user", model);
		}
		catch (DuplicateException e) {
			Map<String, Object> model = new HashMap<>();
			model.put("error", "dup");
			model.put("username", user.getUsername());
			model.put("address", user.getAddress());
			model.put("cellNumber", user.getCellNumber());
			model.put("email", user.getEmail());
			model.put("phoneNumber", user.getPhoneNumber());
			if ( isTruckOwner )
				model.put("trole", Boolean.TRUE);
			if ( isLoadsOwner )
				model.put("lrole", Boolean.TRUE);
			model.put("contactPerson", user.getContactPerson());
			return new ModelAndView("register_user", model);
		}
		Collection<SimpleGrantedAuthority> authorities = new ArrayList<>();
		user.getRoles().stream().forEach(role -> authorities.add(new SimpleGrantedAuthority(role.toString())));

		SecurityContextHolder.getContext().setAuthentication(
				new UsernamePasswordAuthenticationToken(
						user.getUsername(),
						"",
						authorities));
		return new ModelAndView("redirect:" + user.getRoles().get(0).getLandingUrl());
	}

	@RequestMapping(value = "/deleteLoad", method = RequestMethod.POST, consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE)
	ModelAndView deleteLoad(String loadId) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String username = authentication.getName();
		dao.deleteLoadById(loadId, username);
		return new ModelAndView("redirect:/myLoads");
	}

	//    @RequestMapping(value = "/updateLoad", method = RequestMethod.POST, consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE)
	//    ModelAndView updateLoad(String loadId) {
	//	Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	//	String username = authentication.getName();
	//	Load load = dao.getLoadForUserById(loadId, username);
	//	Map<String, Object> model = new HashMap<>();
	//	model.put("load", load);
	//	model.put("enums", BeansWrapper.getDefaultInstance().getEnumModels());
	//	return new ModelAndView("update_load_details", model);
	//    }

	@RequestMapping(value = "/truckApproval", method = RequestMethod.POST, consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE)
	ModelAndView approveTruck(@ModelAttribute("truck") Truck truck) {
		truck.setRegistrationStatus(TruckRegistrationStatus.APPROVED);
		dao.updateTruck(truck);
		return new ModelAndView("redirect:/adminMenu");
	}

	@RequestMapping(value = "/myTrucks")
	ModelAndView myTrucks() {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String username = authentication.getName();
		Map<String, Object> model = new HashMap<>();
		model.put("enums", BeansWrapper.getDefaultInstance().getEnumModels());
		model.put("trucks", dao.getTrucksForUser(username));
		return new ModelAndView("my_trucks", model);
	}

	@RequestMapping(value = "/myAlerts")
	ModelAndView myAlerts() {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String username = authentication.getName();
		Map<String, Object> model = new HashMap<>();
		model.put("alerts", dao.getUserAlerts(username));
		return new ModelAndView("my_alerts", model);
	}

	@RequestMapping(value = "/adminMenu")
	ModelAndView adminMenu() {
		return new ModelAndView("admin_menu");
	}

	@RequestMapping("/nonApprovedTrucks")
	ModelAndView showNonApprovedTrucks() {
		Map<String, Object> model = new HashMap<>();
		model.put("enums", BeansWrapper.getDefaultInstance().getEnumModels());
		model.put("trucks", dao.getNonApprovedTrucks());
		return new ModelAndView("show_non_approved_trucks", model);
	}

	@RequestMapping(value = "/approval/licenseimage/{truckId}", method = RequestMethod.GET, produces = MediaType.IMAGE_PNG_VALUE)
	public byte[] getTruckLicenseImage(@PathVariable String truckId) {
		String b64dataUrl = new String(dao.getTruckById(truckId).getVehicleLicensePhoto().getData());
		byte[] bytes = b64dataUrl.substring(b64dataUrl.indexOf(',') + 1).getBytes();
		return Base64.getDecoder().decode(bytes);
	}

	@RequestMapping(value = "/approval/driverlicenseimage/{truckId}", method = RequestMethod.GET, produces = MediaType.IMAGE_PNG_VALUE)
	public byte[] getDriverLicenseImage(@PathVariable String truckId) {
		Binary photo = dao.getTruckById(truckId).getDriverLicensePhoto();
		if ( photo == null ) {
			return null;
		}
		String b64dataUrl = new String(photo.getData());
		byte[] bytes = b64dataUrl.substring(b64dataUrl.indexOf(',') + 1).getBytes();
		return Base64.getDecoder().decode(bytes);
	}

	@RequestMapping(value = "/approval/truckimage/{truckId}", method = RequestMethod.GET, produces = MediaType.IMAGE_PNG_VALUE)
	public byte[] getTruckImage(@PathVariable String truckId) {
		String b64dataUrl = new String(dao.getTruckById(truckId).getTruckPhoto().getData());
		byte[] bytes = b64dataUrl.substring(b64dataUrl.indexOf(',') + 1).getBytes();
		return Base64.getDecoder().decode(bytes);
	}

	@RequestMapping(value = "/load/image/{loadId}", method = RequestMethod.GET, produces = MediaType.IMAGE_PNG_VALUE)
	public byte[] getLoadImage(@PathVariable String loadId) {
		String b64dataUrl = new String(dao.getLoadPhoto(loadId));
		byte[] bytes = b64dataUrl.substring(b64dataUrl.indexOf(',') + 1).getBytes();
		return Base64.getDecoder().decode(bytes);
	}

	@RequestMapping("/truckApproval")
	ModelAndView approveTruck(@RequestParam("truckId") String id) {
		Map<String, Object> model = new HashMap<>();
		model.put("enums", BeansWrapper.getDefaultInstance().getEnumModels());
		model.put("truck", dao.getTruckByIdWithoutImages(id));
		return new ModelAndView("truck_approval", model);
	}

	@RequestMapping("/newAlert")
	ModelAndView newAlert() {
		return new ModelAndView("new_alert");
	}
	
	@RequestMapping(value = "/newAlert", method = RequestMethod.POST, consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE)
	ModelAndView newAlert(@ModelAttribute("alert") Alert alert, BindingResult br1,
			@RequestParam("drivedate") String drivedate, BindingResult br3,
			@RequestParam("sourceLat") Double sourceLat, BindingResult br4,
			@RequestParam("sourceLng") Double sourceLng, BindingResult br5,
			@RequestParam("destinationLat") Double destinationLat, BindingResult br6,
			@RequestParam("destinationLng") Double destinationLng, BindingResult br7
			) throws IOException {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String username = authentication.getName();
		alert.setUsername(username);
		if (sourceLat != null && sourceLng != null) {
			alert.setSourceLocation(new Location(new double[] { sourceLng, sourceLat}));
		}
		if (destinationLat != null && destinationLng != null) {
			alert.setDestinationLocation(new Location(new double[] { destinationLng, destinationLat}));
		}
		alert.setDriveDate(JsonController.convertDriveDate(drivedate));
		dao.storeAlert(alert);
		return new ModelAndView("redirect:/myAlerts");
	}

	@RequestMapping("/newTruck")
	ModelAndView newTruck() {
		return new ModelAndView("new_truck");
	}

	@RequestMapping(value = "/newTruck", method = RequestMethod.POST, consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
	ModelAndView newTruck(@RequestParam("licensePlateNumber") String licensePlateNumber,
			@RequestParam("truckPhoto") byte[] truckPhoto,
			@RequestParam("vehicleLicensePhoto") byte[] vehicleLicensePhoto,
			@RequestParam("driverLicensePhoto") byte[] driverLicensePhoto) throws IOException{

		Truck truck = new Truck();
		truck.setLicensePlateNumber(licensePlateNumber);
		truck.setVehicleLicensePhoto(new Binary(vehicleLicensePhoto));
		truck.setDriverLicensePhoto(new Binary(driverLicensePhoto));
		truck.setTruckPhoto(new Binary(truckPhoto));
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String username = authentication.getName();
		truck.setUsername(username);
		truck.setCreationDate(new Date());
		truck.setRegistrationStatus(TruckRegistrationStatus.REGISTERED);
		try {
			dao.storeTruck(truck);
		}
		catch ( DuplicateException e) {
			Map<String, Object> model = new HashMap<>();
			model.put("error", "dup");
			return new ModelAndView("new_truck", model);
		}
		return new ModelAndView("redirect:/myTrucks");
	}

	@RequestMapping(value="/load_details/{loadId}", method=RequestMethod.GET)
	ModelAndView getLoad(@PathVariable String loadId) throws TemplateModelException {
		Load load = dao.getLoad(loadId);
		Map<String, Object> model = new HashMap<>();
		model.put("Format", getFormatStatics());
		model.put("load", load);
		model.put("enums", BeansWrapper.getDefaultInstance().getEnumModels());
		return new ModelAndView("load_details", model);
	}

	private Object getFormatStatics() {
		BeansWrapper wrapper = BeansWrapper.getDefaultInstance();
		TemplateHashModel staticModels = wrapper.getStaticModels();
		TemplateHashModel formatStatics;
		try {
			formatStatics = (TemplateHashModel) staticModels.get("com.traffitruck.web.TextFmt");
		} catch (TemplateModelException e) {
			throw new RuntimeException(e);
		}
		return formatStatics;
	}

	@RequestMapping(value="/load_details_for_trucker/{loadId}", method=RequestMethod.GET)
	ModelAndView getLoadForTrucker(@PathVariable String loadId) {
		Load load = dao.getLoad(loadId);
		LoadsUser loadsUser = dao.getUser(load.getUsername());
		Map<String, Object> model = new HashMap<>();
		model.put("Format", getFormatStatics());
		model.put("load", load);
		model.put("loadsUser", loadsUser);
		model.put("enums", BeansWrapper.getDefaultInstance().getEnumModels());
		return new ModelAndView("load_details_for_trucker", model);
	}
}
