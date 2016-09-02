package com.traffitruck;

import java.io.IOException;
import java.util.Collection;
import java.util.Date;

import javax.servlet.MultipartConfigElement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.context.embedded.MultipartConfigFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.authentication.configurers.GlobalAuthenticationConfigurerAdapter;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.annotation.web.servlet.configuration.EnableWebMvcSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationSuccessHandler;
import org.springframework.security.web.authentication.rememberme.PersistentRememberMeToken;
import org.springframework.security.web.authentication.rememberme.PersistentTokenRepository;
import org.springframework.security.web.csrf.CsrfFilter;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;
import org.springframework.web.filter.CharacterEncodingFilter;

import com.traffitruck.domain.Role;
import com.traffitruck.service.UserDetailsServiceImpl;

@Configuration
@EnableWebMvcSecurity
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {

	@Autowired
	PersistentTokenRepository repository;

	@Autowired
	private UserDetailsServiceImpl userDetails;

	@Bean
	MultipartConfigElement multipartConfigElement() {
		MultipartConfigFactory factory = new MultipartConfigFactory();
		factory.setMaxFileSize("5MB");
		factory.setMaxRequestSize("10MB");
		return factory.createMultipartConfig();
	}

	@Override
	public void configure(WebSecurity web) throws Exception {
		super.configure(web);
		web.ignoring().antMatchers("/css/**", "/js/**", "/images/**", "/mapsapis");
	}

	@Override
	protected void configure(HttpSecurity http) throws Exception {
		// handle content encoding
		CharacterEncodingFilter filter = new CharacterEncodingFilter();
		filter.setEncoding("UTF-8");
		filter.setForceEncoding(true);
		http.addFilterBefore(filter,CsrfFilter.class);

		SimpleUrlAuthenticationSuccessHandler handler = new SimpleUrlAuthenticationSuccessHandler() {
			@Override
			protected void handle(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {
				if (resetPasswordFlow(authentication.getAuthorities())) {
					try {
						getRedirectStrategy().sendRedirect(request, response, "/resetPassword");
						return;
					} catch (Exception e) {
						throw new RuntimeException(e);
					}
				}

				String url = Role.valueOf(authentication.getAuthorities().iterator().next().getAuthority()).getLandingUrl();
				getRedirectStrategy().sendRedirect(request, response, url);
			}

			private boolean resetPasswordFlow(Collection<? extends GrantedAuthority> authorities) {
				for (GrantedAuthority grantedAuthority : authorities) {
					if (grantedAuthority.getAuthority().startsWith("resetPassword-"))
						return true;
				}
				return false;
			}
		};

		http
		.authorizeRequests()
		.antMatchers("/css/**", "/js/**", "/images/**", "/registerUser","/registrationConfirmation","/forgotPassword", "/resetPassword").permitAll()
		.antMatchers("/newload", "/myLoads", "/deleteLoad", "/load_details/**").hasAuthority(Role.LOAD_OWNER.name())
		.antMatchers("/truckerMenu", "/findTrucksForLoad", "/addAvailability", "/myTrucks", "/newTruck", "/load_details_for_trucker/**", "/load_for_truck_by_radius").hasAuthority(Role.TRUCK_OWNER.name())
		.antMatchers("/loads", "/trucks", "/truckApproval", "/nonApprovedTrucks", "/approval/licenseimage/**",
				"/truckApproval").hasAuthority(Role.ADMIN.name())
				.anyRequest().authenticated();
		http
		.formLogin()
		.loginPage("/login")
		.successHandler(handler)
		.permitAll()
		.and()
		.logout()
		.permitAll()
		.deleteCookies("remember-me")
		.logoutRequestMatcher(new AntPathRequestMatcher("/logout")).logoutSuccessUrl("/login?logout");
		http.rememberMe().tokenRepository(repository).userDetailsService(userDetails);

		http.sessionManagement()
		.maximumSessions(9999)
		.expiredUrl("/login?logout")
		.maxSessionsPreventsLogin(false)
		.and()
		.sessionCreationPolicy(SessionCreationPolicy.IF_REQUIRED)
		.invalidSessionUrl("/login");
	}

	@Configuration
	protected static class AuthenticationConfiguration extends
	GlobalAuthenticationConfigurerAdapter {

		@Autowired
		private UserDetailsServiceImpl userDetails;

		@Override
		public void init(AuthenticationManagerBuilder auth) throws Exception {
			auth.authenticationProvider(userDetails);
		}


	}

}
